import HUD from './constants/hud';
import Events from './constants/events';
import { toggleInterface } from './gui/main-hud';
import { Entity } from './constants';
import { setup_gvv } from './lib/debug';
import { setupGlobalData } from './lib/global-data';
import { getPlayerData, initPlayer } from './data/player-data';
import { addResource, clearCurrentSite, createResourceSite } from './lib/resource-tracker';

setup_gvv();

script.on_init(() => {
	setupGlobalData();
});

script.on_event(defines.events.on_gui_closed, (event: OnGuiClosedEvent) => {
	if (event.element && event.element.name === HUD.MainFrame) {
		let player = game.get_player(event.player_index);
		if (player) {
			toggleInterface(player);
		}
	}
});

script.on_event(Events.Toggle_Interface, (event: any) => {
	let player = game.get_player(event.player_index);
	if (player) {
		toggleInterface(player);
	}
});

script.on_event(defines.events.on_player_selected_area, (event: OnPlayerSelectedAreaEvent) => {
	if (event.item !== Entity.SelectorTool) {
		return;
	}

	let playerData = getPlayerData(event.player_index);
	if (!playerData) {
		return;
	}
	if (event.entities.length < 1) {
		// if we have an expanding site, submit it. else, just drop the current site
		if (playerData.currentSite && playerData.currentSite.isSiteExpanding) {
			createResourceSite(event.player_index);
		} else {
			clearCurrentSite(event.player_index);
		}
	}

	for (const entity of event.entities) {
		if (entity.type === 'resource') {
			addResource(event.player_index, entity);
		}
	}
});

script.on_event(defines.events.on_player_created, (event: OnPlayerCreatedEvent) => {
	initPlayer(event.player_index);
});
