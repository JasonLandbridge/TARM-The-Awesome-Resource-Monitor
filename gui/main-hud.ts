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
	// Main Frame
	let main_frame = screen_element.add({
		type: 'frame',
		name: HUD.MainFrame,
		direction: 'vertical',
	});
	main_frame.style.bottom_padding = 10;
	main_frame.auto_center = true;

	let mainTable = main_frame.add({
		type: 'table',
		name: 'main_table',
		column_count: 2,
		draw_horizontal_lines: false,
	});

	// Main Table
	mainTable.style.horizontally_stretchable = true;
	mainTable.style.column_alignments[1] = 'left'; //title, search, zone list table
	mainTable.style.column_alignments[2] = 'right'; //starmap, close, selected zone info

	let mainLeftFlow = mainTable.add({ type: 'flow', name: 'main_left_flow', direction: 'vertical' });
	let mainRightFlow = mainTable.add({ type: 'flow', name: 'main_right_flow', direction: 'vertical' });
	mainLeftFlow.style.right_margin = 10;

	let titleTable = mainLeftFlow.add({ type: 'table', name: 'title_table', column_count: 2, draw_horizontal_lines: false });
	titleTable.drag_target = main_frame;
	titleTable.style.horizontally_stretchable = true;
	titleTable.style.column_alignments[1] = 'left'; // name
	titleTable.style.column_alignments[2] = 'right'; // search

	// LEFT TOP
	let title_frame = titleTable.add({
		type: 'frame',
		name: 'title_frame',
		caption: 'space-exploration.zonelist-window-title',
		style: 'informatron_title_frame',
		ignored_by_interaction: true,
	});

	// LEFT TOP (right aligned)
	let filter_search_container = titleTable.add({ type: 'flow', name: 'filter_search_flow', direction: 'horizontal' });

	// Search box
	let zoneListSearch = filter_search_container.add({ type: 'textfield', name: 'Zonelist.name_zonelist_search' });
	zoneListSearch.style.width = 150;
	zoneListSearch.style.height = 30;
	zoneListSearch.style.top_margin = -4;
	zoneListSearch.style.left_margin = 30;
	let searchButton = filter_search_container.add({
		type: 'sprite-button',
		name: 'Zonelist.name_zonelist_search_clear',
		sprite: 'se-search-close-white',
		hovered_sprite: 'se-search-close-black',
		clicked_sprite: 'se-search-close-black',
		tooltip: 'space-exploration.clear-search',
		style: 'informatron_close_button',
	});
	searchButton.style.left_margin = 5;
	searchButton.style.height = 28;
	searchButton.style.width = 28;
	searchButton.style.top_margin = -2;

	// LEFT BOTTOM
	let zoneListFrame = mainLeftFlow.add({
		type: 'frame',
		name: 'zonelist_frame',
		style: 'informatron_inside_deep_frame',
		direction: 'vertical',
	});
	zoneListFrame.style.horizontally_stretchable = true;
	zoneListFrame.style.minimal_height = 300;
	let zoneListHeadingsRow = zoneListFrame.add({
		type: 'flow',
		name: 'Zonelist.name_zonelist_headings_row',
		direction: 'horizontal',
	});
	let zoneListScroll = zoneListFrame.add({
		type: 'scroll-pane',
		name: 'Zonelist.name_zonelist_scroll',
		// direction: 'vertical',
		style: 'zonelist_rows_pane',
	});

	// Set to player
	player.opened = main_frame;
}
