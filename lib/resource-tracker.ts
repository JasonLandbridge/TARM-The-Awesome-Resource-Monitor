import { getPlayer } from './game';
import { getPlayerData } from '../data/player-data';
import { addResourceSiteToForce, getForceData } from '../data/force-data';
import Log from './log';
import { addEntity } from './resource-cache';
import { PlayerData } from '../declarations/global';
import SettingsData from '../data/settings-data';
import { Entity } from '../constants';

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

	addResourceSiteToForce(forceData?.name, resourceSite);
	clearCurrentSite(playerIndex);

	if (resourceSite.isSiteExpanding) {
		if (resourceSite.hasExpanded) {
			resourceSite.lastOreCheck = undefined;
			resourceSite.lastModifiedAmount = undefined;
			let amountAdded = resourceSite.amount - resourceSite.originalAmount;
			Log.info(playerIndex, `TARM Site expanded - ${resourceSite.name} - ${amountAdded}`);
		}
	} else {
		Log.info(playerIndex, `TARM site submitted - ${resourceSite.name}`);
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
			addedAt: game.tick,
			surface: entity.surface,
			force: player.force,
			oreType: entity.name,
			oreName: entity.prototype.localised_name,
			amount: 0,
			entityCount: 0,
			etdMinutes: 0,
			extends: {
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
			trackerIndices: [],
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
	let trackerCacheIndex = addEntity(entity);
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
	if (entity.position.x < resourceSite.extends.left) {
		resourceSite.extends.left = entity.position.x;
	} else if (entity.position.x > resourceSite.extends.right) {
		resourceSite.extends.right = entity.position.x;
	}

	if (entity.position.y < resourceSite.extends.top) {
		resourceSite.extends.top = entity.position.y;
	} else if (entity.position.x > resourceSite.extends.bottom) {
		resourceSite.extends.bottom = entity.position.y;
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
