import { positionToString } from './common';
import { TrackingData } from '../declarations/global';
import { getResourceTracker, getTrackingData } from '../data/global-data';
import IEvent from '../typings/base-class';
import SettingsData from '../data/settings-data';

export class ResourceCache implements IEvent {
	OnLoad(): void {
		let resourceTracker = getResourceTracker();
		let entities = getTrackingData();
		if (!resourceTracker || entities.length === 0) {
			return;
		}

		for (let trackerIndex = 0; trackerIndex < entities.length; trackerIndex++) {
			let key = positionToString(entities[trackerIndex].position);
			resourceTracker.positionCache[key] = trackerIndex;
		}
	}

	OnTick(event: OnTickEvent): void {
		let resourceTracker = getResourceTracker();
		if (!resourceTracker || resourceTracker.trackedEntities.length === 0) {
			return;
		}

		if (!resourceTracker.iterationFunction) {
			resourceTracker.iterationFunction = resourceTracker.trackedEntities.entries();
		}

		// Update all trackedEntities with the latest resource amount
		let key = resourceTracker.iterationKey;
		let iterationFunc = resourceTracker.iterationFunction;
		for (let i = 0; i < SettingsData.EntitiesPerTick; i++) {
			let pair = iterationFunc.next().value as [key: string, value: TrackingData];
			key = pair[0];
			let trackingData = pair[1];
			if (!key) {
				GlobalData.resourceTracker.iterationKey = undefined;
				GlobalData.resourceTracker.iterationFunction = undefined;
				return;
			}

			if (!trackingData.entity || !trackingData.entity.valid) {
				trackingData.resourceAmount = 0;
				trackingData.entity = undefined;
				trackingData.valid = false;
			} else {
				trackingData.resourceAmount = trackingData.entity.amount;
			}
		}
		resourceTracker.iterationKey = key;
		resourceTracker.iterationFunction = iterationFunc;
	}

	/**
	 * Add an entity to the resource tracker
	 * Note: if the tracker already had the entity,
	 * it will simply return the existing tracker index rather than create a new one.
	 * @param entity
	 * @return Returns the entity's tracker index
	 */
	addEntity(entity: LuaEntity): number {
		if (!entity || !entity.valid || entity.type !== 'resource') {
			return -1;
		}

		let positionKey = positionToString(entity.position);
		let trackingData = this.getEntity(positionKey);
		if (trackingData) {
			// We're accessing the entity.position anyway, let's also use this
			// opportunity to update the tracker values (and be 1000% certain
			// that it's tracking the right entity).
			trackingData.entity = entity;
			trackingData.valid = entity.valid;
			trackingData.position = entity.position;
			trackingData.resourceAmount = entity.amount;

			return this.getEntityIndexInCache(entity);
		}

		// Otherwise, create the tracking data and store it, including position_cache
		// TODO this should not all be in one huge array, can be split up
		GlobalData.resourceTracker.trackedEntities.push({
			entity: entity,
			valid: entity.valid,
			position: entity.position,
			resourceAmount: entity.amount,
		});

		let pushedIndex = GlobalData.resourceTracker.trackedEntities.length - 1;
		GlobalData.resourceTracker.positionCache[positionKey] = pushedIndex;
		return pushedIndex;
	}

	hasEntity(entity: LuaEntity): boolean {
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
	getEntityIndexInCache(entity: LuaEntity): number {
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

	getEntity(positionKey: string): TrackingData | undefined {
		if (positionKey === '') {
			return undefined;
		}
		let positionIndex = GlobalData.resourceTracker.positionCache[positionKey];
		if (positionIndex && positionIndex > -1) {
			return GlobalData.resourceTracker.trackedEntities[positionIndex];
		}
		return undefined;
	}
}

const resourceCache = new ResourceCache();
export default resourceCache;
