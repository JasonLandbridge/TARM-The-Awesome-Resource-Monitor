import { getPlayer } from '../lib/game';
import { PlayerData } from '../declarations/global';

export function initPlayer(playerIndex: number): void {
	let player = getPlayer(playerIndex);
	if (!player) {
		return;
	}
	initForce(player.force);
	if (!getPlayerData(playerIndex)) {
		GlobalData.playerData.push({ overlays: undefined, index: playerIndex, guiUpdateTicks: 60, currentSite: undefined });
	}
}

/**
 * Creates a new force, Player, Neutral or Enemy
 * @param force
 */
export function initForce(force: LuaForce) {
	let force_data = GlobalData.forceData.find((x) => x.name === force.name);
	if (!force_data) {
		GlobalData.forceData.push({ name: force.name, resourceSites: [] });
		force_data = GlobalData.forceData[GlobalData.forceData.length - 1];
	}
	return force_data;
}

export function getPlayerData(playerIndex: number): PlayerData | undefined {
	return GlobalData.playerData.find((x) => x.index === playerIndex);
}
