import { getPlayer, getPlayers } from '../lib/game';
import { ForceData, PlayerData } from '../declarations/global-save-state';
import Log from '../lib/log';
import Global from './global-save-data';

export function initPlayer(playerIndex: number): void {
	let player = getPlayer(playerIndex);
	if (!player) {
		return;
	}
	initForce(player.force);
	if (!getPlayerData(playerIndex)) {
		Global.GlobalData.playerData.push({ index: playerIndex, guiUpdateTicks: 60, draftResourceSite: undefined });
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
	if (!Global.valid) {
		Log.errorAll('initForce => Could not initForce due to Global being invalid');
		return undefined;
	}

	Global.setForceData({
		name: force.name,
		resourceSites: [],
	});
	return Global.getForceData(force.name);
}

export function getPlayerData(playerIndex: number): PlayerData | undefined {
	return Global.playerData.find((x) => x.index === playerIndex) ?? undefined;
}
