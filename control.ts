import HUD from './constants/hud';
import Events from './constants/events';
import { toggleInterface } from './gui/main-hud';
import { Entity } from './constants';
import { setup_gvv } from './lib/debug';
import Global from './data/global-save-data';
import { getPlayerData, initPlayer, initPlayers } from './data/player-data';
import {
	addResourcesToDraftResourceSite,
	startResourceSiteCreation,
	updatePlayers,
} from './lib/resource-tracker';
import ResourceCache from './lib/resource-cache';
import GlobalTemp from './data/global-temp-data';
import SettingsData from './data/settings-data';
import { importYarmData } from './lib/yarm-import';

setup_gvv();

script.on_init(() => {
	SettingsData.OnInit();
	Global.OnInit();
	GlobalTemp.OnInit();
	initPlayers();
	importYarmData();
});

script.on_configuration_changed(() => {
	Global.OnInit();
	SettingsData.OnLoad();
	initPlayers();
});

script.on_load(() => {
	SettingsData.OnLoad();
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

	// Start with ensuring there is a resource site in which we can add the selected resources
	if (!playerData.draftResourceSite) {
		startResourceSiteCreation(event);
	} else {
		addResourcesToDraftResourceSite(playerData.index, event.entities);
	}

	// if (playerData.resourceSiteCreation) {
	// 	createResourceSite(event.player_index);
	// } else {
	// 	clearCurrentSite(event.player_index);
	// }
});

script.on_event(defines.events.on_player_created, (event: OnPlayerCreatedEvent) => {
	initPlayer(event.player_index);
});
