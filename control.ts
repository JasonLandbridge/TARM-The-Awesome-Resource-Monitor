import HUD from './constants/hud';
import Events from './constants/events';
import { toggleInterface } from './gui/main-hud';
import { Entity } from './constants';
import { setup_gvv } from './lib/debug';
import Global from './data/global-data';
import { getPlayerData, initPlayer, initPlayers } from './data/player-data';
import { addResource, clearCurrentSite, createResourceSite, updatePlayers } from './lib/resource-tracker';
import ResourceCache from './lib/resource-cache';
import GlobalTemp from './data/global-temp-data';

setup_gvv();

script.on_init(() => {
	Global.OnInit();
	GlobalTemp.OnInit();
	initPlayers();
});

script.on_configuration_changed(() => {
	Global.OnInit();
	initPlayers();
});

script.on_load(() => {
	GlobalTemp.OnLoad();
});

script.on_event(Events.OnTick, (event: OnTickEvent) => {
	ResourceCache.OnTick(event);
	updatePlayers(event);
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

	// if we have an expanding site, submit it. else, just drop the current site
	if (playerData.currentSite) {
		createResourceSite(event.player_index);
	} else {
		clearCurrentSite(event.player_index);
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
