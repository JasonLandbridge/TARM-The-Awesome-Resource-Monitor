import { getPlayer, getPlayers } from './game';
import { getPlayerData, initPlayer } from '../data/player-data';
import { addResourceSiteToForce, getForceData } from '../data/force-data';
import Log from './log';
import ResourceCache from './resource-cache';
import { PlayerData, ResourceSite } from '../declarations/global';
import SettingsData from '../data/settings-data';
import { Entity, General } from '../constants';
import { findCenter, findResourceAt, getOctantName, shiftPosition } from './common';
import { distance } from 'util';

/**
 *
 * Note: `resmon.submit_site(player_index)`
 * @param playerIndex
 */
export function createResourceSite(playerIndex: number) {
	let player = getPlayer(playerIndex);
	let playerData = getPlayerData(playerIndex);
	if (!(player && playerData)) {
		return;
	}
	let forceData = getForceData(player.force.name);
	let resourceSite = playerData.currentSite;

	if (!(forceData && resourceSite)) {
		Log.debug(playerIndex, `createResourceSite => Either forceData (${forceData}) or resourceSite (${resourceSite}) was invalid`);
		return;
	}

	addResourceSiteToForce(player.force.name, resourceSite);
	clearCurrentSite(playerIndex);

	if (resourceSite.isSiteExpanding) {
		if (resourceSite.hasExpanded) {
			resourceSite.lastOreCheck = undefined;
			resourceSite.lastModifiedAmount = undefined;
			let amountAdded = resourceSite.amount - (resourceSite.originalAmount ?? 0);
			Log.info(playerIndex, `TARM Site expanded - ${resourceSite.name} - ${amountAdded}`);
		}
	} else {
		Log.info(playerIndex, `TARM site submitted - ${resourceSite.name}`);
	}

	// TODO add `resmon.update_chart_tag(site)`

	if (resourceSite.isSiteExpanding) {
		resourceSite.isSiteExpanding = undefined;
		resourceSite.hasExpanded = undefined;
		resourceSite.originalAmount = undefined;
	}
}

export function clearCurrentSite(playerIndex: number) {
	let player = getPlayer(playerIndex);
	let playerData = getPlayerData(playerIndex);

	if (!(player && playerData)) {
		return;
	}

	playerData.currentSite = undefined;

	// Clean-up the overlay created on ores after it has been crawled
	while (playerData.overlays.length > 0) {
		playerData.overlays.pop()?.destroy();
	}
}

export function addResource(playerIndex: number, entity: LuaEntity) {
	let player = getPlayer(playerIndex);
	let playerData = getPlayerData(playerIndex);

	if (!(playerData && player)) {
		return;
	}

	if (playerData.currentSite && playerData.currentSite.oreType !== entity.name) {
		if (playerData.currentSite.finalizing) {
			createResourceSite(playerIndex);
		} else {
			clearCurrentSite(playerIndex);
		}
	}

	if (!playerData.currentSite) {
		playerData.currentSite = {
			isOverlayBeingCreated: false,
			center: [0, 0],
			finalizingSince: 0,
			iterating: undefined,
			orePerMinute: 0,
			remainingPerMille: 0,
			addedAt: game.tick,
			surface: entity.surface,
			force: player.force,
			oreType: entity.name,
			oreName: entity.prototype.localised_name,
			amount: 0,
			entityCount: 0,
			etdMinutes: 0,
			extents: {
				left: entity.position.x,
				right: entity.position.x,
				top: entity.position.y,
				bottom: entity.position.y,
			},
			nextToScan: [],
			entitiesToBeOverlaid: {},
			finalizing: false,
			hasExpanded: false,
			initialAmount: 0,
			isSiteExpanding: false,
			lastModifiedAmount: undefined,
			lastOreCheck: undefined,
			name: '',
			nextToOverlay: {},
			originalAmount: 0,
			trackerIndices: []
		};
	}

	if (playerData.currentSite.isSiteExpanding) {
		// relevant for the console output
		playerData.currentSite.hasExpanded = true;
		if (!playerData.currentSite.originalAmount) {
			playerData.currentSite.originalAmount = playerData.currentSite.amount;
		}
	}
	addSingleEntity(playerIndex, entity);
}

export function addSingleEntity(playerIndex: number, entity: LuaEntity) {
	let playerData = getPlayerData(playerIndex);
	if (!playerData) {
		return;
	}
	let resourceSite = playerData.currentSite;
	if (!resourceSite) {
		Log.warn(playerIndex, `addSingleEntity() => \'playerData.currentSite\' was invalid`);
		return;
	}
	let trackerCacheIndex = ResourceCache.addEntity(entity);
	// Don't add multiple times
	if (resourceSite.trackerIndices[trackerCacheIndex]) {
		return;
	}

	if (resourceSite.finalizing) {
		resourceSite.finalizing = false;
	}

	// Memorize this entity
	resourceSite.trackerIndices[trackerCacheIndex] = true;
	resourceSite.entityCount++;
	resourceSite.nextToScan.push(entity);
	resourceSite.amount += entity.amount;

	// Resize the site bounds if necessary
	if (entity.position.x < resourceSite.extents.left) {
		resourceSite.extents.left = entity.position.x;
	} else if (entity.position.x > resourceSite.extents.right) {
		resourceSite.extents.right = entity.position.x;
	}

	if (entity.position.y < resourceSite.extents.top) {
		resourceSite.extents.top = entity.position.y;
	} else if (entity.position.x > resourceSite.extents.bottom) {
		resourceSite.extents.bottom = entity.position.y;
	}

	// Show blue overlay of resources selected
	addOverlayOnResource(entity, playerData);
}

export function addOverlayOnResource(entity: LuaEntity, playerData: PlayerData) {
	let pos = entity.position;
	let surface = entity.surface;

	if (Math.floor(pos.x) % SettingsData.OverlayStep !== 0 || Math.floor(pos.y) % SettingsData.OverlayStep !== 0) {
		return;
	}

	let overlay = surface.create_entity({ name: Entity.ResourceManagerOverlay, force: game.forces.neutral, position: pos });
	if (!overlay) {
		Log.error(
			playerData.index,
			`addOverlayOnResource() => Could not create resource overlay on position x: ${pos.x}, y: ${pos.y}`,
		);
		return;
	}
	overlay.minable = false;
	overlay.destructible = false;
	overlay.operable = false;

	playerData.overlays.push(overlay);
}

export function scanResourceSite(playerIndex: number) {
	let currentSite = getPlayerData(playerIndex)?.currentSite;
	if (!currentSite) {
		return;
	}

	let toScan = Math.min(30, currentSite.nextToScan.length);

	for (let i = 1; toScan; i++) {
		let entity = currentSite.nextToScan.pop();
		if (!entity) {
			continue;
		}
		let position = entity.position;
		let surface = entity.surface;

		for (const direction of General.Directions) {
			let resourceFound = findResourceAt(surface, shiftPosition(position, direction));
			if (resourceFound && resourceFound.name === currentSite.oreType) {
				addSingleEntity(playerIndex, resourceFound);
			}
		}
	}
}

export function finalizeResourceSite(playerIndex: number) {
	let player = getPlayer(playerIndex);
	let playerData = getPlayerData(playerIndex);
	if (!(player && playerData)) {
		return;
	}

	let resourceSite = playerData.currentSite;
	if (!resourceSite) {
		return;
	}

	resourceSite.finalizing = true;
	resourceSite.finalizingSince = game.tick;
	resourceSite.initialAmount = resourceSite.amount;
	resourceSite.orePerMinute = 0;
	resourceSite.remainingPerMille = 1000;
	resourceSite.center = findCenter(resourceSite.extents);

	// Don't rename a site we've expanded!
	// (if the site name changes it'll create a new site instead of replacing the existing one)
	if (!resourceSite.isSiteExpanding) {
		let surfaceName = '';
		if (SettingsData.PrefixSiteWithSurface) {
			surfaceName = resourceSite.surface.name + ' ';
		}
		resourceSite.name = `${surfaceName}${resourceSite.name} ${getOctantName(resourceSite.center)} ${distance(
			[0, 0],
			resourceSite.center,
		)}`;
	}

	let updateCycle = resourceSite.addedAt % SettingsData.TickBetweenChecks;
	countDeposits(resourceSite, updateCycle);
}

function countDeposits(resourceSite: ResourceSite, updateCycle: number) {}

export function updatePlayers(event: EventData) {
	if (!GlobalData || !GlobalData.playerData) {
		return;
	}

	for (const player of getPlayers()) {
		let playerData = getPlayerData(player.index);
		if (!playerData) {
			initPlayer(player.index);
			playerData = getPlayerData(player.index);
		} else if (!player.connected && playerData.currentSite) {
			clearCurrentSite(player.index);
		}

		if (playerData?.currentSite) {
			let resourceSite = playerData.currentSite;

			if (resourceSite.nextToScan.length > 0) {
				scanResourceSite(player.index);
			} else if (!resourceSite.finalizing) {
				finalizeResourceSite(player.index);
			} else if (resourceSite.finalizingSince + 120 === event.tick) {
				createResourceSite(player.index);
			}

			if (resourceSite.isOverlayBeingCreated) {
				processOverlayForExistingResourceSite(player.index);
			}
		}

		if (playerData && event.tick % playerData.guiUpdateTicks === 15 + player.index) {
			updateUi(player.index);
		}
	}
}

export function updateUi(playerIndex: number) {}

export function processOverlayForExistingResourceSite(index: number) {}
