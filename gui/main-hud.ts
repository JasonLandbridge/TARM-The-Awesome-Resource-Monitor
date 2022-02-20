import HUD from '../constants/hud';
import General from '../constants/general';

export function toggleInterface(player: LuaPlayer) {
	let main_frame = player.gui.screen[HUD.MainFrame] as LuaGuiElement;
	if (!main_frame) {
		buildInterface(player);
	} else {
		main_frame.destroy();
	}
}

export function buildInterface(player: LuaPlayer) {
	if (!player) {
		return;
	}
	let screen_element = player.gui.screen;
	let main_frame = screen_element.add({ type: 'frame', name: HUD.MainFrame, caption: General.Prefix + '.hello_world' });
	main_frame.style.size = [385, 165];
	main_frame.auto_center = true;

	// Add scroll-pane
	main_frame.add({
		type: 'scroll-pane',
		name: HUD.MainScrollFrame,
		vertical_scroll_policy: 'auto-and-reserve-space',
	});

	player.opened = main_frame;
}
