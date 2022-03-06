import {
	ForceData,
	GlobalSaveState,
	PlayerData,
	ResourceTracker,
	DraftResourceSite,
	TrackingData,
} from '../declarations/global-save-state';
import Log from '../lib/log';
import { OnLoad } from '../typings/IEvent';

declare var global: GlobalSaveState;

export default class Global {
	// region Getters

	public static get GlobalData(): GlobalSaveState {
		if (!global) {
			Log.errorAll('GlobalData was invalid!');
		}
		return global;
	}

	public static get resourceTracker(): ResourceTracker {
		return global.resourceTracker;
	}

	public static get trackedResources(): Record<string, TrackingData> {
		return global.resourceTracker.trackedResources;
	}

	public static get forceData(): Record<string, ForceData> {
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
				trackedResources: {},
			};
		}
	}

	public static setTrackedResources(key: string, value: TrackingData) {
		global.resourceTracker.trackedResources[key] = value;
	}

	public static getDraftResourceSite(playerIndex: number): DraftResourceSite | undefined {
		let playerData = this.playerData.find((x) => x.index === playerIndex);
		if (playerData) {
			return playerData.draftResourceSite;
		}
		return undefined;
	}

	public static setDraftResourceSite(playerIndex: number, draftResourceSite: DraftResourceSite) {
		let index = global.playerData.findIndex((x) => x.index === playerIndex);
		if (index > -1) {
			global.playerData[index].draftResourceSite = draftResourceSite;
		}
	}

	public static setAllTrackedResources(trackedResources: Record<string, TrackingData>) {
		global.resourceTracker.trackedResources = trackedResources;
	}

	public static setAllPlayerData(playerData: PlayerData[]) {
		global.playerData = playerData;
	}

	// endregion
}
