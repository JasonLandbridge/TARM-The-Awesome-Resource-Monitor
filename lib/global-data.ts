import { initPlayer } from '../data/player-data';
import { getPlayers } from './game';

export function setupGlobalData() {
	GlobalData = {
		playerData: [],
		forceData: [],
		resourceTracker: {
			entities: [],
			positionCache: {},
		},
	};

	getPlayers().forEach((value, index) => {
		initPlayer(index);
	});
}
