export interface YarmGlobalState {
	player_data: Record<int, YarmPlayerData>;
	force_data: Record<string, YarmForceData>;
	ore_tracker: YarmResourceTracker;
}

// region PlayerData

export interface YarmPlayerData {
	gui_update_ticks: number;
	current_site: YarmResourceSite | undefined;
	/**
	 * The (dark blue) overlay entities when a resource site is selected or "crawled" when searching for all ore.
	 */
	overlays: LuaEntity[];
	active_filter: 'all'
}

// endregion

// region ForceData

export interface YarmForceData {
	ore_sites: Record<string, YarmResourceSite>;
}

export interface YarmResourceSite {
	added_at: number;
	surface: LuaSurface;
	force: LuaForce;
	ore_type: string;
	ore_name: LocalisedString;
	tracker_indices: Record<number, boolean>;
	entity_count: number;
	initial_amount: number;
	amount: number;
	extents: YarmExtend;
	next_to_Scan: LuaEntity[];
	entities_to_be_overlaid: any;
	next_to_overlay: any;
	etd_minutes: number;
	finalizing: boolean;
	/**
	 * The game tick it has since been finalized on
	 */
	finalizing_since: number;
	ore_per_minute: number;
	remaining_permille: number;
	center: PositionArray;
	name: string;
	update_amount: number;
	chart_tag: LuaCustomChartTag;
	last_ore_check: number | undefined;
	last_modified_amount: number | undefined;
	last_modified_tick: number | undefined;
}

export interface YarmExtend {
	left: number;
	right: number;
	top: number;
	bottom: number;
}
// endregion

// region OreTracker

export interface YarmResourceTracker {
	entities: YarmTrackingData[];
}

export interface YarmTrackingData {
	entity?: LuaEntity;
	valid: boolean;
	position: MapPositionTable;
	resource_amount: number;
}

// endregion
