import Log from './log';
import { getPlayers } from './game';
import { getPlayerData, initPlayer } from '../data/player-data';
import Global from '../data/global-save-data';
import { clearDraftResourceSite, finalizeResourceSite, registerResourceSite, scanResourceSite } from './resource-site-creator';

export function updateResourceAmounts() {




}


export function updatePlayers(event: EventData) {
	if (!Global.valid || !Global.playerData) {
		Log.warnAll(`updatePlayers() => Either Global or Global.playerData was invalid`);
		return;
	}

	let players = getPlayers();
	for (const player of players) {
		let playerData = getPlayerData(player.index);
		if (!playerData) {
			initPlayer(player.index);
			playerData = getPlayerData(player.index);
		} else if (!player.connected && playerData.draftResourceSite) {
			clearDraftResourceSite(player.index);
		}

		if (playerData?.draftResourceSite) {
			let resourceSite = playerData.draftResourceSite;

			if (resourceSite.nextToScan.length > 0) {
				scanResourceSite(player.index);
			} else if (!resourceSite.finalizing) {
				finalizeResourceSite(player.index);
			} else if (resourceSite.finalizingSince + 120 === event.tick) {
				registerResourceSite(player.index);
			}

			if (resourceSite.isOverlayBeingCreated) {
				processOverlayForExistingResourceSite(player.index);
			}
		}

		if (playerData && event.tick % playerData.guiUpdateTicks === 15 + player.index) {
			updateUi(player.index);
		}
	}
}

export function updateUi(playerIndex: number) {}

export function processOverlayForExistingResourceSite(index: number) {}
