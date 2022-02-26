import { ForceData, GlobalState, PlayerData, ResourceTracker, TrackingData } from '../declarations/globalState';
import Log from '../lib/log';

declare var global: GlobalState;

export default class Global {
	// region Getters

	public static get GlobalData(): GlobalState {
		if (!global) {
			Log.errorAll('GlobalData was invalid!');
		}
		return global;
	}

	public static get resourceTracker(): ResourceTracker {
		return global.resourceTracker;
	}

	public static get trackedEntities(): Map<string, TrackingData> {
		return this.resourceTracker.trackedResources;
	}

	public static get forceData(): { [name: string]: ForceData } {
		return global.forceData;
	}

	public static get playerData(): PlayerData[] {
		return global.playerData;
	}

	public static get valid(): Boolean {
		return !!global;
	}

	// endregion
	// region Methods

	public static OnInit(): void {
		if (!Global.valid) {
			Log.errorAll('Global.OnInit() => Global was invalid and could not be filled with data');
			return;
		}

		if (!global['playerData']) {
			global['playerData'] = [];
		}

		if (!global['forceData']) {
			global['forceData'] = {};
			let forces = ['player', 'enemy', 'neutral', 'conquest', 'ignore', 'capture', 'friendly'];
			for (const force of forces) {
				global.forceData[force] = {
					resourceSites: [],
				};
			}
		}

		if (!global['resourceTracker']) {
			global['resourceTracker'] = {
				trackedResources: new Map<string, TrackingData>(),
				positionCache: new Map<string, number>(),
			};
		}
	}

	public static setPositionCache(key: string, value: number): void {
		Global.resourceTracker.positionCache.set(key, value);
	}

	// endregion
}
