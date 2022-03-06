import Log from './log';
import { getPlayers } from './game';
import { getPlayerData, initPlayer } from '../data/player-data';
import Global from '../data/global-save-data';
import { clearDraftResourceSite, finalizeResourceSite, registerResourceSite, scanResourceSite } from './resource-site-creator';
import { OnTick } from '../typings/IEvent';
import SettingsData from '../data/settings-data';

export class ResourceTracker implements OnTick {
	OnTick(event: OnTickEvent): void {
		let ticksBetweenChecks = SettingsData.TickBetweenChecks;
		let currentTick = event.tick;

		for (const forceData of Global.forceData) {
			let resourceSites = forceData.resourceSites;
			for (const resourceSite of resourceSites) {
				if (currentTick - resourceSite.lastResourceCheckTick > ticksBetweenChecks) {
					let totalAmount = 0;
					for (const [key, value] of Object.entries(resourceSite.trackedPositionKeys)) {

						totalAmount += Global.trackedResources[key].resourceAmount;
					}
					resourceSite.totalAmount = totalAmount;
				}
			}
		}
	}

	public updateResourceAmounts() {
		let cacheIteration = Global.cacheIteration;
		if (!cacheIteration) {
			return;
		}

		if (!cacheIteration.force) {
		}

		for (let i = 0; i < 50; i++) {}
	}

	public updatePlayers(event: EventData) {
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
					this.processOverlayForExistingResourceSite(player.index);
				}
			}

			if (playerData && event.tick % playerData.guiUpdateTicks === 15 + player.index) {
				this.updateUi(player.index);
			}
		}
	}

	public updateUi(playerIndex: number) {}
	public processOverlayForExistingResourceSite(index: number) {}
}

const resourceCache = new ResourceTracker();
export default resourceCache;
