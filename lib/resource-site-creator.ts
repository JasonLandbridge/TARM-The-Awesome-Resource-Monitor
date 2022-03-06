import { getPlayer } from './game';
import { getPlayerData } from '../data/player-data';
import Global from '../data/global-save-data';
import Log from './log';
import { addResourceSiteToForce, getForceData } from '../data/force-data';
import { findCenter, findMajorityResourceEntity, findResourceAt, generateGuid, getOctantName, shiftPosition } from './common';
import SettingsData from '../data/settings-data';
import { distance } from 'util';
import { DraftResourceSite, ResourceSite } from '../declarations/global-save-state';
import { Entity, General } from '../constants';
import ResourceCache from './resource-cache';
import GlobalTemp from '../data/global-temp-data';

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
		guid: generateGuid(),
		center: [0, 0],
		orePerMinute: 0,
		remainingPerMille: 0,
		addedAt: 0,
		surface: event.surface,
		force: player.force,
		oreType: sampleResource.name,
		oreName: sampleResource.prototype.localised_name,
		totalAmount: 0,
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

	let draftResourceSite: DraftResourceSite = {
		playerIndex: playerIndex,
		overlays: [],
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

	// Sum all the amount from the resources
	for (const resourceEntity of sameResourceEntities) {
		addResourceEntityToDraftResourceSite(draftResourceSite, resourceEntity);
	}

	Global.setDraftResourceSite(playerIndex, draftResourceSite);
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

	for (const resourceEntity of sameResourceEntities) {
		addResourceEntityToDraftResourceSite(draftResourceSite, resourceEntity);
	}

	Global.setDraftResourceSite(playerIndex, draftResourceSite);
}

export function finalizeResourceSite(playerIndex: number) {
	let draftResourceSite = Global.getDraftResourceSite(playerIndex);
	if (!draftResourceSite) {
		return;
	}

	draftResourceSite.finalizing = true;
	draftResourceSite.finalizingSince = game.tick;

	let resourceSite = draftResourceSite.resourceSite;
	resourceSite.entityCount = Object.keys(resourceSite.trackedPositionKeys).length;
	resourceSite.totalAmount = resourceSite.initialAmount;
	resourceSite.orePerMinute = 0;
	resourceSite.remainingPerMille = 1000;
	resourceSite.center = findCenter(resourceSite.extents);

	// Don't rename a site we've expanded!
	// (if the site name changes it'll create a new site instead of replacing the existing one)
	if (!draftResourceSite.isSiteExpanding) {
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

export function registerResourceSite(playerIndex: number) {
	let player = getPlayer(playerIndex);
	if (!player) {
		return;
	}

	let draftResourceSite = Global.getDraftResourceSite(playerIndex);
	if (!draftResourceSite) {
		Log.error(playerIndex, `registerResourceSite() => Could not retrieve the draftResourceSite for registration.`);
		return;
	}
	let forceData = getForceData(player.force.name);
	let resourceSite = draftResourceSite.resourceSite;
	resourceSite.addedAt = game.tick;

	if (!(forceData && resourceSite)) {
		Log.debug(playerIndex, `createResourceSite => Either forceData (${forceData}) or resourceSite (${resourceSite}) was invalid`);
		return;
	}

	addResourceSiteToForce(player.force.name, resourceSite);

	if (draftResourceSite.isSiteExpanding) {
		if (draftResourceSite.hasExpanded) {
			resourceSite.lastOreCheck = undefined;
			resourceSite.lastModifiedAmount = undefined;
			//TODO let amountAdded = resourceSite.amount - (resourceSite.initialAmount ?? 0);
			Log.info(playerIndex, `TARM Site expanded - ${resourceSite.name} - ${0}`);
		}
	} else {
		Log.info(playerIndex, `TARM site submitted - ${resourceSite.name}`);
	}

	// TODO add `resmon.update_chart_tag(site)`

	if (draftResourceSite.isSiteExpanding) {
		draftResourceSite.isSiteExpanding = undefined;
		draftResourceSite.hasExpanded = undefined;
		// draftResourceSite.originalAmount = undefined;
	}

	clearDraftResourceSite(playerIndex);
}

function countDeposits(resourceSite: ResourceSite, updateCycle: number) {}

export function scanResourceSite(playerIndex: number) {
	let draftResourceSite = Global.getDraftResourceSite(playerIndex);
	if (!draftResourceSite) {
		Log.errorAll(`scanResourceSite() => Could not retrieve the draftResourceSite with playerIndex: ${playerIndex}`);
		return;
	}

	let toScan = Math.min(10, draftResourceSite.nextToScan.length);

	for (let i = 0; i < toScan; i++) {
		let entity = draftResourceSite.nextToScan.shift();
		if (!entity) {
			Log.debugAll(`scanResourceSite() => No more resources to scan for draftResourceSite!`);
			break;
		}
		let position = entity.position;
		let surface = entity.surface;

		for (const direction of General.Directions) {
			let resourceFound = findResourceAt(surface, shiftPosition(position, direction));
			if (resourceFound && resourceFound.name === draftResourceSite.resourceSite.oreType) {
				addResourceEntityToDraftResourceSite(draftResourceSite, resourceFound);
			}
		}
	}
}

export function addResourceEntityToDraftResourceSite(draftResourceSite: DraftResourceSite, resourceEntity: LuaEntity) {
	// Add new entity to the ResourceCache, will also return key if it already exists
	let positionKey = ResourceCache.addResourceEntityToCache(resourceEntity);
	// Don't add if it is already added
	if (positionKey && !draftResourceSite.resourceSite.trackedPositionKeys[positionKey]) {
		draftResourceSite.resourceSite.trackedPositionKeys[positionKey] = true;
		addOverlayOnResource(resourceEntity, draftResourceSite);
		checkResourceSiteExtents(draftResourceSite.resourceSite, resourceEntity);
		draftResourceSite.nextToScan.push(resourceEntity);
		// Count the initial amount
		draftResourceSite.resourceSite.initialAmount += resourceEntity.amount;
	}
}

export function checkResourceSiteExtents(resourceSite: ResourceSite, resourceEntity: LuaEntity) {
	// Resize the site bounds if necessary
	if (resourceEntity.position.x < resourceSite.extents.left) {
		resourceSite.extents.left = resourceEntity.position.x;
	} else if (resourceEntity.position.x > resourceSite.extents.right) {
		resourceSite.extents.right = resourceEntity.position.x;
	}

	if (resourceEntity.position.y < resourceSite.extents.top) {
		resourceSite.extents.top = resourceEntity.position.y;
	} else if (resourceEntity.position.x > resourceSite.extents.bottom) {
		resourceSite.extents.bottom = resourceEntity.position.y;
	}
}

export function addOverlayOnResource(entity: LuaEntity, draftResourceSite: DraftResourceSite) {
	let pos = entity.position;
	let surface = entity.surface;

	let overlayStep = SettingsData.OverlayStep;
	if (Math.floor(pos.x) % overlayStep !== 0 || Math.floor(pos.y) % overlayStep !== 0) {
		return;
	}

	let overlay = surface.create_entity({ name: Entity.ResourceManagerOverlay, force: game.forces.neutral, position: pos });
	if (!overlay) {
		Log.error(
			draftResourceSite.playerIndex,
			`addOverlayOnResource() => Could not create resource overlay on position x: ${pos.x}, y: ${pos.y}`,
		);
		return;
	}
	overlay.minable = false;
	overlay.destructible = false;
	overlay.operable = false;

	draftResourceSite.overlays.push(overlay);
}

export function clearDraftResourceSite(playerIndex: number) {
	let player = getPlayer(playerIndex);
	let playerData = getPlayerData(playerIndex);

	if (!(player && playerData)) {
		return;
	}
	let draftResourceSite = Global.getDraftResourceSite(playerIndex);
	if (!draftResourceSite) {
		Log.error(playerIndex, `clearDraftResourceSite() => Could not clear DraftResourceSite as it is undefined already`);
		return;
	}
	playerData.draftResourceSite = undefined;

	// Clean-up the overlay created on ores after it has been crawled
	while (draftResourceSite.overlays.length > 0) {
		draftResourceSite.overlays.pop()?.destroy();
	}
}
