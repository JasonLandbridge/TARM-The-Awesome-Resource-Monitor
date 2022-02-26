import { getPlayer, getPlayers } from '../lib/game';
import { ForceData, PlayerData } from '../declarations/globalState';
import { getForceData } from './force-data';
import Log from '../lib/log';
import Global from './global-data';

export function initPlayer(playerIndex: number): void {
	let player = getPlayer(playerIndex);
	if (!player) {
		return;
	}
	initForce(player.force);
	if (!getPlayerData(playerIndex)) {
		Global.GlobalData.playerData.push({ overlays: [], index: playerIndex, guiUpdateTicks: 60, currentSite: undefined });
	}
}

export function initPlayers() {
	getPlayers().forEach((value, index) => {
		initPlayer(index);
	});
}

/**
 * Creates a new force, Player, Neutral or Enemy
 * @param force
 */
export function initForce(force: LuaForce): ForceData | undefined {
	let force_data = getForceData(force.name);
	if (!force_data) {
		if (!Global.valid) {
			Log.errorAll('initForce => Could not initForce due to GlobalData being invalid');
			return undefined;
		}
		Global.forceData[force.name] = { resourceSites: [] };
		return Global.forceData[force.name];
	}
	return force_data;
}

export function getPlayerData(playerIndex: number): PlayerData | undefined {
	return Global.playerData.find((x) => x.index === playerIndex) ?? undefined;
}
