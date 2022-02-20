import HUD from './constants/hud';
import Events from './constants/events';
import { toggleInterface } from './gui/main-hud';
import { Entity } from './constants';
import { setup_gvv } from './debug';
import { setupGlobalData } from './lib/global-data';
import { initPlayer } from './data/player-data';

setup_gvv();

// if (script.active_mods['gvv']) {
// 	/** @NoResolution **/
// 	let modString = '__gvv__.gvv';
// 	require(modString);
// }
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
});

script.on_event(defines.events.on_player_created, (event: OnPlayerCreatedEvent) => {
	initPlayer(event.player_index);
});
