import Log from './log';
import { getPlayer, getPlayers } from './game';
import { getPlayerData, initPlayer } from '../data/player-data';
import { addResourceSiteToForce, getForceData } from '../data/force-data';
import ResourceCache from './resource-cache';
import { PlayerData, ResourceSite, DraftResourceSite } from '../declarations/global-save-state';
import SettingsData from '../data/settings-data';
import { Entity, General } from '../constants';
import { findCenter, findResourceAt, getOctantName, shiftPosition } from './common';
import { distance } from 'util';
import Global from '../data/global-save-data';

/**
 *
 * Note: `resmon.submit_site(player_index)`
 * @param playerIndex
 */
// export function createResourceSite(playerIndex: number) {
// 	let player = getPlayer(playerIndex);
// 	let playerData = getPlayerData(playerIndex);
// 	if (!(player && playerData)) {
// 		return;
// 	}
// 	let forceData = getForceData(player.force.name);
// 	let resourceSite = playerData.draftResourceSite?.resourceSite;
//
// 	if (!(forceData && resourceSite)) {
// 		Log.debug(playerIndex, `createResourceSite => Either forceData (${forceData}) or resourceSite (${resourceSite}) was invalid`);
// 		return;
// 	}
//
// 	addResourceSiteToForce(player.force.name, resourceSite);
// 	clearCurrentSite(playerIndex);
//
// 	if (resourceSite.isSiteExpanding) {
// 		if (resourceSite.hasExpanded) {
// 			resourceSite.lastOreCheck = undefined;
// 			resourceSite.lastModifiedAmount = undefined;
// 			let amountAdded = resourceSite.amount - (resourceSite.originalAmount ?? 0);
// 			Log.info(playerIndex, `TARM Site expanded - ${resourceSite.name} - ${amountAdded}`);
// 		}
// 	} else {
// 		Log.info(playerIndex, `TARM site submitted - ${resourceSite.name}`);
// 	}
//
// 	// TODO add `resmon.update_chart_tag(site)`
//
// 	if (resourceSite.isSiteExpanding) {
// 		resourceSite.isSiteExpanding = undefined;
// 		resourceSite.hasExpanded = undefined;
// 		resourceSite.originalAmount = undefined;
// 	}
// }

export function clearCurrentSite(playerIndex: number) {
	let player = getPlayer(playerIndex);
	let playerData = getPlayerData(playerIndex);

	if (!(player && playerData)) {
		return;
	}

	playerData.draftResourceSite = undefined;

	// Clean-up the overlay created on ores after it has been crawled
	while (playerData.overlays.length > 0) {
		playerData.overlays.pop()?.destroy();
	}
}

function findMajorityResourceEntity(entities: LuaEntity[]): LuaEntity {
	// Count all occurrences of all resource types
	let results: Map<string, number> = new Map<string, number>();
	for (const entity of entities) {
		if (entity.type === 'resource') {
			let currentCount = results.get(entity.name) ?? 0;
			results.set(entity.name, currentCount + 1);
		}
	}

	// Determine the most common resource type in the entities
	let winnerType = [...results.entries()].reduce((a, e) => (e[1] > a[1] ? e : a))[0];

	// Hacky way to hide the possibility of undefined, but we're guaranteed to find something here
	return entities.find((x) => x.name === winnerType) ?? ({} as LuaEntity);
}

export function startResourceSiteCreation(event: OnPlayerSelectedAreaEvent) {
	let playerIndex = event.player_index;
	let player = getPlayer(playerIndex);
	let playerData = getPlayerData(playerIndex);
	if (!(playerData && player)) {
		Log.errorAll(`startResourceSiteCreation() => Could not find playerData and player for player index ${playerIndex}`);
		return;
	}

	let resourceEntities = event.entities;
	let sampleResource = findMajorityResourceEntity(resourceEntities);
	let sameResourceEntities = resourceEntities.filter((x) => x.name === sampleResource.name);

	let resourceSite: ResourceSite = {
		center: [0, 0],
		orePerMinute: 0,
		remainingPerMille: 0,
		addedAt: 0,
		surface: event.surface,
		force: player.force,
		oreType: sampleResource.name,
		oreName: sampleResource.prototype.localised_name,
		amount: 0,
		entityCount: 0,
		etdMinutes: 0,
		extents: {
			left: 0,
			right: 0,
			top: 0,
			bottom: 0,
		},
		initialAmount: 0,
		lastModifiedAmount: undefined,
		lastOreCheck: undefined,
		name: '',
		trackedPositionKeys: {},
	};

	// Sum all the amount from the resources
	let totalResources = 0;
	for (const resourceEntity of sameResourceEntities) {
		let amount = resourceEntity.amount;
		resourceSite.amount += amount;
		resourceSite.entityCount++;
		totalResources += amount;
	}

	resourceSite.entityCount = totalResources;

	let resourceSiteCreation: DraftResourceSite = {
		finalizingSince: 0,
		finalizing: false,
		isOverlayBeingCreated: false,
		isSiteExpanding: false,
		hasExpanded: false,
		nextToScan: [],
		nextToOverlay: {},
		resourceEntities: sameResourceEntities,
		resourceSite: resourceSite,
	};

	Global.setDraftResourceSite(playerIndex, resourceSiteCreation);
}

export function addResourcesToDraftResourceSite(playerIndex: number, resources: LuaEntity[]) {
	let playerData = getPlayerData(playerIndex);
	if (!playerData) {
		Log.errorAll(`addResourcesToDraftResourceSite() => Could not find playerData and player for player index ${playerIndex}`);
		return;
	}

	let draftResourceSite = Global.getDraftResourceSite(playerIndex);
	if (!draftResourceSite) {
		Log.error(
			playerIndex,
			`addResourcesToDraftResourceSite() => No draftResourceSite set for playerIndex ${playerIndex}, could not add resources`,
		);
		return;
	}
	let sameResourceEntities = resources.filter((x) => x.name === draftResourceSite?.resourceSite.oreType);
	draftResourceSite.resourceEntities = draftResourceSite.resourceEntities.concat(sameResourceEntities);

	for (const resource of sameResourceEntities) {
		draftResourceSite.resourceSite.amount += resource.amount;
		draftResourceSite.resourceSite.entityCount++;
	}

	Global.setDraftResourceSite(playerIndex, draftResourceSite);

}

export function registerResourceSite(resourceSite: ResourceSite) {}

// export function addSingleEntity(playerIndex: number, entity: LuaEntity) {
// 	let playerData = getPlayerData(playerIndex);
// 	if (!playerData) {
// 		return;
// 	}
//
// 	let resourceSite = playerData.draftResourceSite;
// 	if (!resourceSite) {
// 		Log.warn(playerIndex, `addSingleEntity() => \'playerData.currentSite\' was invalid`);
// 		return;
// 	}
//
// 	let positionKey = ResourceCache.addEntity(entity);
// 	if (!positionKey) {
// 		Log.errorAll(`addSingleEntity() => Failed to add entity ${entity.position}`);
// 		return;
// 	}
//
// 	// Don't add multiple times
// 	if (resourceSite.trackedPositionKeys.find((x) => x === positionKey)) {
// 		return;
// 	}
//
// 	if (resourceSite.finalizing) {
// 		resourceSite.finalizing = false;
// 	}
//
// 	// Memorize this entity
// 	resourceSite.trackedPositionKeys.push(positionKey);
// 	resourceSite.entityCount++;
// 	resourceSite.nextToScan.push(entity);
// 	resourceSite.amount += entity.amount;
//
// 	// Resize the site bounds if necessary
// 	if (entity.position.x < resourceSite.extents.left) {
// 		resourceSite.extents.left = entity.position.x;
// 	} else if (entity.position.x > resourceSite.extents.right) {
// 		resourceSite.extents.right = entity.position.x;
// 	}
//
// 	if (entity.position.y < resourceSite.extents.top) {
// 		resourceSite.extents.top = entity.position.y;
// 	} else if (entity.position.x > resourceSite.extents.bottom) {
// 		resourceSite.extents.bottom = entity.position.y;
// 	}
//
// 	// Show blue overlay of resources selected
// 	addOverlayOnResource(entity, playerData);
// }

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
	let currentSite = getPlayerData(playerIndex)?.draftResourceSite;
	if (!currentSite) {
		Log.errorAll(`scanResourceSite() => Could not retrieve the currentSite with playerIndex: ${playerIndex}`);
		return;
	}

	let toScan = Math.min(30, currentSite.nextToScan.length);

	for (let i = 1; toScan; i++) {
		let entity = currentSite.nextToScan.pop();
		if (!entity) {
			Log.debugAll(`scanResourceSite() => No more resources to scan for draftResourceSite!`);
			break;
		}
		let position = entity.position;
		let surface = entity.surface;

		for (const direction of General.Directions) {
			let resourceFound = findResourceAt(surface, shiftPosition(position, direction));
			if (resourceFound && resourceFound.name === currentSite.resourceSite.oreType) {
				// addSingleEntity(playerIndex, resourceFound);
			}
		}
	}
}

// export function finalizeResourceSite(playerIndex: number) {
// 	let player = getPlayer(playerIndex);
// 	let playerData = getPlayerData(playerIndex);
// 	if (!(player && playerData)) {
// 		return;
// 	}
//
// 	let resourceSite = playerData.draftResourceSite;
// 	if (!resourceSite) {
// 		return;
// 	}
//
// 	resourceSite.finalizing = true;
// 	resourceSite.finalizingSince = game.tick;
// 	resourceSite.initialAmount = resourceSite.amount;
// 	resourceSite.orePerMinute = 0;
// 	resourceSite.remainingPerMille = 1000;
// 	resourceSite.center = findCenter(resourceSite.extents);
//
// 	// Don't rename a site we've expanded!
// 	// (if the site name changes it'll create a new site instead of replacing the existing one)
// 	if (!resourceSite.isSiteExpanding) {
// 		let surfaceName = '';
// 		if (SettingsData.PrefixSiteWithSurface) {
// 			surfaceName = resourceSite.surface.name + ' ';
// 		}
// 		resourceSite.name = `${surfaceName}${resourceSite.name} ${getOctantName(resourceSite.center)} ${distance(
// 			[0, 0],
// 			resourceSite.center,
// 		)}`;
// 	}
//
// 	let updateCycle = resourceSite.addedAt % SettingsData.TickBetweenChecks;
// 	countDeposits(resourceSite, updateCycle);
// }

function countDeposits(resourceSite: ResourceSite, updateCycle: number) {}

export function updatePlayers(event: EventData) {
	if (!Global.valid || !Global.playerData) {
		Log.warnAll(`updatePlayers() => Either Global or Global.playerData was invalid`);
		return;
	}

	let players = getPlayers();
	for (const player of players) {
		let playerData = getPlayerData(player.index);
		if (!playerData) {
			initPlayer(player.index);
			playerData = getPlayerData(player.index);
		} else if (!player.connected && playerData.draftResourceSite) {
			clearCurrentSite(player.index);
		}

		if (playerData?.draftResourceSite) {
			let resourceSite = playerData.draftResourceSite;

			if (resourceSite.nextToScan.length > 0) {
				scanResourceSite(player.index);
			} else if (!resourceSite.finalizing) {
				//finalizeResourceSite(player.index);
			} else if (resourceSite.finalizingSince + 120 === event.tick) {
			//	createResourceSite(player.index);
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
