import { initPlayer } from './player-data';
import { getPlayers } from '../lib/game';

export function setupGlobalData() {
	GlobalData = {
		playerData: [],
		forceData: {},
		resourceTracker: {
			entities: [],
			positionCache: {},
		},
	};

	let forces = ['player', 'enemy', 'neutral', 'conquest', 'ignore', 'capture', 'friendly'];
	for (const force of forces) {
		GlobalData.forceData[force] = {
			resourceSites: [],
		};
	}

	getPlayers().forEach((value, index) => {
		initPlayer(index);
	});
}
