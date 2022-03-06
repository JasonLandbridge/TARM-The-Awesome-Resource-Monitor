import {
	ForceData,
	GlobalSaveState,
	PlayerData,
	ResourceTracker,
	DraftResourceSite,
	TrackingData,
	CacheIteration,
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

	public static get cacheIteration(): CacheIteration {
		return global.resourceTracker.cacheIteration;
	}

	public static get trackedResources(): Record<string, TrackingData> {
		return global.resourceTracker.trackedResources;
	}

	public static get forceData(): ForceData[] {
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
			let forces = ['player', 'enemy', 'neutral', 'conquest', 'ignore', 'capture', 'friendly'];
			global['forceData'] = forces.map((name) => {
				return {
					name,
					resourceSites: [],
				};
			});
		}

		if (!global['resourceTracker']) {
			global['resourceTracker'] = {
				trackedResources: {},
				cacheIteration: {
					positionKeyIndex: 0,
					force: '',
					resourceSiteGuid: '',
				},
			};
		}
	}

	// region Get
	public static getDraftResourceSite(playerIndex: number): DraftResourceSite | undefined {
		let playerData = this.playerData.find((x) => x.index === playerIndex);
		if (playerData) {
			return playerData.draftResourceSite;
		}
		return undefined;
	}

	public static getForceData(forceName: string): ForceData | undefined {
		return Global.forceData.find((x) => x.name === forceName) ?? undefined;
	}
	// endregion

	// region Set

	public static setTrackedResources(key: string, value: TrackingData) {
		global.resourceTracker.trackedResources[key] = value;
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

	/**
	 * Will add a new ForceData if no same name force exists
	 * @param forceData
	 */
	public static setForceData(forceData: ForceData) {
		if (!this.getForceData(forceData.name)) {
			Global.forceData.push(forceData);
		}
	}

	// endregion
	// endregion
}
