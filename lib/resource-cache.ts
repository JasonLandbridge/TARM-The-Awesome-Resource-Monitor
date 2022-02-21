import { positionToString } from './common';
import { TrackingData } from '../declarations/global';

/**
 * Add an entity to the resource tracker
 * Note: if the tracker already had the entity,
 * it will simply return the existing tracker index rather than create a new one.
 * @param entity
 * @return Returns the entity's tracker index
 */
export function addEntity(entity: LuaEntity): number {
	if (!entity || !entity.valid || entity.type !== 'resource') {
		return -1;
	}

	let positionKey = positionToString(entity.position);
	let trackingData = getEntity(positionKey);
	if (trackingData) {
		// We're accessing the entity.position anyway, let's also use this
		// opportunity to update the tracker values (and be 1000% certain
		// that it's tracking the right entity).
		trackingData.entity = entity;
		trackingData.valid = entity.valid;
		trackingData.position = entity.position;
		trackingData.resourceAmount = entity.amount;

		return getEntityIndexInCache(entity);
	}

	// Otherwise, create the tracking data and store it, including position_cache
	// TODO this should not all be in one huge array, can be split up
	GlobalData.resourceTracker.entities.push({
		entity: entity,
		valid: entity.valid,
		position: entity.position,
		resourceAmount: entity.amount,
	});

	let pushedIndex = GlobalData.resourceTracker.entities.length - 1;
	GlobalData.resourceTracker.positionCache[positionKey] = pushedIndex;
	return pushedIndex;
}

export function hasEntity(entity: LuaEntity): boolean {
	if (!entity || !entity.valid || entity.type !== 'resource') {
		return false;
	}
	let positionKey = positionToString(entity.position);
	return !!GlobalData.resourceTracker.positionCache[positionKey];
}

/**
 * Looks up the index of the entity in the
 * @param entity
 * @return -1 if it couldn't find it
 */
export function getEntityIndexInCache(entity: LuaEntity): number {
	if (!entity || !entity.valid || entity.type !== 'resource') {
		return -1;
	}
	let positionKey = positionToString(entity.position);
	let positionIndex = GlobalData.resourceTracker.positionCache[positionKey];
	if (!positionIndex) {
		return -1;
	}
	return positionIndex;
}

export function getEntity(positionKey: string): TrackingData | undefined {
	if (positionKey === '') {
		return undefined;
	}
	let positionIndex = GlobalData.resourceTracker.positionCache[positionKey];
	if (positionIndex && positionIndex > -1) {
		return GlobalData.resourceTracker.entities[positionIndex];
	}
	return undefined;
}
