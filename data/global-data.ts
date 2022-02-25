import { initPlayer } from './player-data';
import { getPlayers } from '../lib/game';
import { Global, ResourceTracker, TrackingData } from '../declarations/global';
import Log from '../lib/log';

export function setupGlobalData() {
	if (!GlobalData) {
		Log.debugAll('setupGlobalData => Setting up GlobalData');
		GlobalData = {
			playerData: [],
			forceData: {},
			resourceTracker: {
				trackedEntities: [],
				positionCache: {},
			},
		};
	}

	if (!GlobalData['playerData']) {
		GlobalData['playerData'] = [];
	}

	if (!GlobalData['forceData']) {
		GlobalData['forceData'] = {};
		let forces = ['player', 'enemy', 'neutral', 'conquest', 'ignore', 'capture', 'friendly'];
		for (const force of forces) {
			GlobalData.forceData[force] = {
				resourceSites: [],
			};
		}
	}

	if (!GlobalData['resourceTracker']) {
		GlobalData['resourceTracker'] = { trackedEntities: [], positionCache: {} };
	}

	getPlayers().forEach((value, index) => {
		initPlayer(index);
	});
}

/*export function getGlobalData(): Global | undefined {
	if (!GlobalData) {
		Log.errorAll('GlobalData was invalid!');
	}
	return GlobalData;
}*/

export function getTrackingData(): TrackingData[] {
	return GlobalData?.resourceTracker?.trackedEntities ?? [];
}

export function getResourceTracker(): ResourceTracker | undefined {
	return GlobalData?.resourceTracker ?? undefined;
}
