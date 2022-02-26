import { positionToString } from './common';
import { TrackingData } from '../declarations/globalState';
import Global from '../data/global-data';
import { OnLoad, OnTick } from '../typings/IEvent';
import SettingsData from '../data/settings-data';
import Log from './log';

export class ResourceCache implements OnLoad, OnTick {
	OnLoad(): void {
		if (Global.trackedResources.size === 0) {
			return;
		}

		// Factorio saves the trackedResources as json,
		// which need to be converted to a valid Map<string, TrackingData> on load
		let x: Map<string, TrackingData> = new Map<string, TrackingData>();
		for (const [key, trackingData] of Global.trackedResources) {
			x.set(key, trackingData);
		}

		// Global.loadTrackedResources(x);
	}

	OnTick(event: OnTickEvent): void {
		let resourceTracker = Global.resourceTracker;
		if (!resourceTracker || resourceTracker.trackedResources.size === 0) {
			return;
		}

		if (!resourceTracker.iterationFunction) {
			resourceTracker.iterationFunction = resourceTracker.trackedResources.entries();
		}

		// Update all trackedEntities with the latest resource amount
		let key = resourceTracker.iterationKey;
		let iterationFunc = resourceTracker.iterationFunction;
		for (let i = 0; i < SettingsData.EntitiesPerTick; i++) {
			let pair = iterationFunc.next().value as [key: string, value: TrackingData];
			key = pair[0];
			let trackingData = pair[1];
			if (!key) {
				Global.resourceTracker.iterationKey = undefined;
				Global.resourceTracker.iterationFunction = undefined;
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
	 * @return Returns the positionKey
	 */
	addEntity(entity: LuaEntity): string | null {
		if (!entity || !entity.valid || entity.type !== 'resource') {
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
		return positionKey;
	}

	hasEntity(entity: LuaEntity): boolean {
		if (!entity || !entity.valid || entity.type !== 'resource') {
			return false;
		}
		let positionKey = positionToString(entity.position);
		return Global.trackedResources.has(positionKey);
	}

	getEntity(positionKey: string): TrackingData | undefined {
		if (positionKey === '' || Global.trackedResources.size === 0) {
			return undefined;
		}
		return Global.trackedResources.get(positionKey);
	}
}

const resourceCache = new ResourceCache();
export default resourceCache;
