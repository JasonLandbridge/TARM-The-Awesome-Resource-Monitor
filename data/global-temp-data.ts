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
			test: true,
			resourceCache: {
				resources: new Map<string, TrackingData>(),
			},
		};
	}

	public static OnLoad() {
		// Ensure that _G has the correct properties set, these are not loaded from a save game
		this.OnInit();

		let entries = Object.entries(Global.trackedResources);
		if (entries.length === 0) {
			return;
		}

		// Factorio saves the trackedResources as json,
		// which need to be converted to a valid Map<string, TrackingData> on load
		for (const [key, trackingData] of entries) {
			globalTempData.resourceCache.resources.set(key, trackingData);
		}
	}
	// endregion
}
