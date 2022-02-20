import { Global } from '../declarations/global';
import { initPlayer } from '../data/player-data';
import { getPlayers } from './game';

export function setupGlobalData() {
	GlobalData = { playerData: [], forceData: [] } as Global;

	getPlayers().forEach((value, index) => {
		initPlayer(index);
	});
}

