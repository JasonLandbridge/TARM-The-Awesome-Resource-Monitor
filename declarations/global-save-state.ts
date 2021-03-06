export interface GlobalSaveState {
	playerData: PlayerData[];
	forceData: ForceData[];
	resourceTracker: ResourceTracker;
}

// region PlayerData

export interface PlayerData {
	index: number;
	guiUpdateTicks: number;
	draftResourceSite: DraftResourceSite | undefined;
}

export interface DraftResourceSite {
	playerIndex: number;
	resourceSite: ResourceSite;
	isSiteExpanding?: boolean;
	finalizing: boolean;
	isOverlayBeingCreated: boolean;
	hasExpanded?: boolean;
	resourceEntities: LuaEntity[];
	nextToScan: LuaEntity[];
	nextToOverlay: any;
	/**
	 * The (dark blue) overlay entities when a resource site is selected or "crawled" when searching for all ore.
	 */
	overlays: LuaEntity[];
	/**
	 * The game tick it has since been finalized on
	 */
	finalizingSince: number;
}

// endregion

// region ForceData

export interface ForceData {
	name: string;
	resourceSites: ResourceSite[];
}

// endregion
export interface ResourceTracker {
	/**
	 * Needs to be this format otherwise it won't be saved and loaded correctly
	 * OnLoad also doesn't allow for loading/saving Map<string, TrackingData> as global is read-only in OnLoad
	 */
	trackedResources: { [name: string]: TrackingData };
	cacheIteration: CacheIteration;
}

export interface TrackingData {
	entity?: LuaEntity;
	valid: boolean;
	position: MapPositionTable;
	resourceAmount: number;
}

export interface ResourceSite {
	guid: string;
	name: string;
	totalAmount: number;
	initialAmount: number;
	oreType: string;
	oreName: LocalisedString;
	orePerMinute: number;
	lastResourceCheckTick: number;
	lastModifiedAmount: number | undefined;
	addedAt: number;
	surface: LuaSurface;
	force: LuaForce;
	/**
	 * The [entities]{@link TrackingData} belonging to this [Resource Site]{@link ResourceSite} index by positionKey
	 */
	trackedPositionKeys: Record<string, boolean>;
	entityCount: number;
	extents: Extend;

	// used for ETD easing; initialized when needed,
	etdMinutes: number;
	remainingPerMille: number;
	center: PositionArray;
}

export interface Extend {
	left: number;
	right: number;
	top: number;
	bottom: number;
}

export interface CacheIteration {
	force: string;
	resourceSiteGuid: string;
	positionKeyIndex: number;
}
