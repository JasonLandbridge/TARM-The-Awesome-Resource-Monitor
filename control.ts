import HUD from './constants/hud';
import Events from './constants/events';
import { toggleInterface } from './gui/main-hud';

script.on_event(defines.events.on_tick, (_evt: any) => {
	game.print(
		serpent.block({
			hello: 'world',
			its_nice: 'to see you',
		}),
	);
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
