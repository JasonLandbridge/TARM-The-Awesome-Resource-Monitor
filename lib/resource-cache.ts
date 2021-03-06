import { positionToString } from './common';
import { TrackingData } from '../declarations/global-save-state';
import Global from '../data/global-save-data';
import { OnTick } from '../typings/IEvent';
import SettingsData from '../data/settings-data';
import GlobalTemp from '../data/global-temp-data';
import Log from './log';

export class ResourceCache implements OnTick {
	OnTick(event: OnTickEvent): void {
		let resourceCache = GlobalTemp.resourceCache;
		if (!resourceCache || resourceCache.positionKeysSet.size === 0) {
			return;
		}

		if (!resourceCache.iterationFunction) {
			resourceCache.iterationFunction = resourceCache.positionKeysSet.entries();
		}

		// Update all trackedEntities with the latest resource amount
		let key = resourceCache.iterationKey;
		let iterationFunc = resourceCache.iterationFunction;
		let entitiesPerTick = SettingsData.EntitiesPerTick;
		for (let i = 0; i < entitiesPerTick; i++) {
			if (!key) {
				let next = iterationFunc.next();
				if (next.done) {
					GlobalTemp.resourceCache.iterationKey = undefined;
					GlobalTemp.resourceCache.iterationFunction = undefined;
					return;
				}
				key = next.value[0];
			}

			let trackingData = Global.trackedResources[key];

			if (!trackingData.entity || !trackingData.entity.valid) {
				trackingData.resourceAmount = 0;
				trackingData.entity = undefined;
				trackingData.valid = false;
			} else {
				trackingData.resourceAmount = trackingData.entity.amount;
			}
		}
		resourceCache.iterationKey = key;
		resourceCache.iterationFunction = iterationFunc;
	}

	/**
	 * Add an entity to the resource cache
	 * Note: if the resource cache already had the entity,
	 * it will simply return the existing resource cache index rather than create a new one.
	 * @param entity
	 * @return Returns the positionKey
	 */
	addResourceEntityToCache(entity: LuaEntity): string | null {
		if (!entity || !entity.valid || entity.type !== 'resource') {
			Log.errorAll(`addResourceEntityToCache() => Failed to add entity ${entity.position}`);
			return null;
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

			return positionKey;
		}

		// Otherwise, create the tracking data and store it, including position_cache
		Global.setTrackedResources(positionKey, {
			entity: entity,
			valid: entity.valid,
			position: entity.position,
			resourceAmount: entity.amount,
		});
		GlobalTemp.addPositionKeyToCache(positionKey);
		return positionKey;
	}

	getEntity(positionKey: string): TrackingData | undefined {
		// TODO make the .size static to improve performance
		if (positionKey === '' || GlobalTemp.resources.size === 0) {
			return undefined;
		}
		return GlobalTemp.resources.get(positionKey);
	}
}

const resourceCache = new ResourceCache();
export default resourceCache;
