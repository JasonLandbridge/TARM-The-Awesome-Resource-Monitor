import { getPlayer } from '../lib/game';
import { ForceData, PlayerData } from '../declarations/global';
import { getForceData } from './force-data';
import Log from '../lib/log';

export function initPlayer(playerIndex: number): void {
	let player = getPlayer(playerIndex);
	if (!player) {
		return;
	}
	initForce(player.force);
	if (!getPlayerData(playerIndex)) {
		GlobalData.playerData.push({ overlays: [], index: playerIndex, guiUpdateTicks: 60, currentSite: undefined });
	}
}

/**
 * Creates a new force, Player, Neutral or Enemy
 * @param force
 */
export function initForce(force: LuaForce) : ForceData | undefined {
	let force_data = getForceData(force.name);
	if (!force_data) {
		if (!GlobalData){
			Log.errorAll('initForce => Could not initForce due to GlobalData being invalid')
			return undefined;
		}
		GlobalData.forceData[force.name] = { resourceSites: [] };
		return GlobalData.forceData[force.name];
	}
	return force_data;
}

export function getPlayerData(playerIndex: number): PlayerData | undefined {
	return GlobalData?.playerData.find((x) => x.index === playerIndex) ?? undefined;
}


