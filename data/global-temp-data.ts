import { GlobalTempState, ResourceCache } from '../declarations/global-temp-state';
import { TrackingData } from '../declarations/global-save-state';
import Global from './global-save-data';

declare let globalTempData: GlobalTempState;

export default class GlobalTemp {
	public static get resourceCache(): ResourceCache {
		return globalTempData.resourceCache;
	}

	public static get resources(): Map<string, TrackingData> {
		return globalTempData.resourceCache.resources;
	}

	// region Methods
	public static OnInit() {
		globalTempData = {
			resourceCache: {
				resources: new Map<string, TrackingData>(),
				positionKeysSet: new Set<string>(),
			},
		};
	}

	public static OnLoad() {
		// Ensure that _G has the correct properties set, these are not loaded from a save game
		this.OnInit();

		let keys = Object.keys(Global.trackedResources);
		if (keys.length === 0) {
			return;
		}

		// Factorio saves the trackedResources as json,
		// which need to be converted to a valid Map<string, TrackingData> on load
		for (const key of keys) {
			globalTempData.resourceCache.positionKeysSet.add(key);
		}
	}

	public static addPositionKeyToCache(key: string) {
		if (!globalTempData.resourceCache.positionKeysSet.has(key)) {
			globalTempData.resourceCache.positionKeysSet.add(key);
		}
	}
	// endregion
}
