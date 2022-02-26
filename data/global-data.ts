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

	public static get trackedResources(): Map<string, TrackingData> {
		return global.resourceTracker.trackedResources;
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
			Log.errorAll('Global.OnInit() => Global was invalid and could not be filled with mod data');
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
			};
		}
	}

	public static setTrackedResources(key: string, value: TrackingData) {
		global.resourceTracker.trackedResources.set(key, value);
	}

	public static loadTrackedResources(resources: Map<string, TrackingData>) {
		global.resourceTracker.trackedResources = resources;
	}

	// endregion
}
