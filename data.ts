import { Data } from 'typed-factorio/data/types';
import { Events, General, Paths } from 'constants';
import { Entity } from './constants';
import Graphics from './constants/graphics';
import applyStyles from './prototypes/style';
declare const data: Data;
data.extend([
	{
		type: 'custom-input',
		name: Events.Toggle_Interface,
		key_sequence: 'F',
		order: 'a',
	},

	// Resource Selector Shortcut
	{
		type: 'shortcut',
		name: General.Prefix + '-selector',
		order: `a[${General.Prefix}]`,
		action: 'spawn-item',
		item_to_spawn: Entity.SelectorTool,
		style: 'red',
		icon: {
			filename: Paths.Graphics('resource-monitor-x32-white.png'),
			priority: 'extra-high-no-scale',
			size: 32,
			scale: 1,
			flags: ['icon'],
		},
		small_icon: {
			filename: Paths.Graphics('resource-monitor-x24.png'),
			priority: 'extra-high-no-scale',
			size: 24,
			scale: 1,
			flags: ['icon'],
		},
		disabled_small_icon: {
			filename: Paths.Graphics('resource-monitor-x24-white.png'),
			priority: 'extra-high-no-scale',
			size: 24,
			scale: 1,
			flags: ['icon'],
		},
	},
	// Resource Selector Tool
	{
		type: 'selection-tool',
		name: Entity.SelectorTool,
		icon: Paths.Graphics('resource-monitor.png'),
		icon_size: 32,
		flags: ['only-in-cursor', 'hidden', 'spawnable'],
		stack_size: 1,
		stackable: false,
		selection_color: { g: 1 },
		selection_mode: 'any-entity',
		alt_selection_color: { g: 1, b: 1 },
		alt_selection_mode: ['nothing'],
		selection_cursor_box_type: 'copy',
		alt_selection_cursor_box_type: 'copy',
		entity_filter_mode: 'whitelist',
		entity_type_filters: ['resource'],
	},
	// Resource Drag Selection Container
	{
		type: 'container',
		name: Entity.ResourceManagerOverlay,
		flags: ['placeable-neutral', 'player-creation', 'not-repairable'],
		icon: Paths.Graphics('rm_Overlay.png'),
		icon_size: 32,

		max_health: 1,
		order: 'z[resource-monitor]',

		collision_mask: ['resource-layer'],
		collision_box: [
			[-0.35, -0.35],
			[0.35, 0.35],
		],

		selection_box: [
			[-0.5, -0.5],
			[0.5, 0.5],
		],
		inventory_size: 1,
		picture: {
			filename: Paths.Graphics('rm_Overlay.png'),
			priority: 'extra-high',
			width: 32,
			height: 32,
			shift: [0.0, 0.0],
		},
	},
	{
		type: 'sprite',
		name: Graphics.SearchBlack,
		filename: Paths.IconGraphics('search-black.png'),
		priority: 'extra-high',
		width: 64,
		height: 64,
		shift: [0, 0],
	},
	{
		type: 'sprite',
		name: Graphics.SearchWhite,
		filename: Paths.IconGraphics('search-white.png'),
		priority: 'extra-high',
		width: 64,
		height: 64,
		shift: [0, 0],
	},
	{
		type: 'sprite',
		name: Graphics.SearchCloseBlack,
		filename: Paths.IconGraphics('search-close-black.png'),
		priority: 'extra-high',
		width: 64,
		height: 64,
		shift: [0, 0],
	},
	{
		type: 'sprite',
		name: Graphics.SearchCloseWhite,
		filename: Paths.IconGraphics('search-close-white.png'),
		priority: 'extra-high',
		width: 64,
		height: 64,
		shift: [0, 0],
	},
]);

// region Apply Styles
let default_gui = data.raw['gui-style'].default;
default_gui = applyStyles(default_gui);
// endregion
