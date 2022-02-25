declare let globalData: Global;

export interface Global {
	playerData: PlayerData[];
	forceData: { [name: string]: ForceData };
	resourceTracker: ResourceTracker;
}

export interface PlayerData {
	index: number;
	guiUpdateTicks: number;
	currentSite: ResourceSite | undefined;
	/**
	 * The (dark blue) overlay entities when a resource site is selected or "crawled" when searching for all ore.
	 */
	overlays: LuaEntity[];
}

export interface ForceData {
	resourceSites: ResourceSite[];
}

export interface ResourceTracker {
	trackedEntities: Map<string, TrackingData>;
	positionCache: Map<string, number>;
	iterationKey?: string;
	iterationFunction?: IterableIterator<[string, TrackingData]>;
}

export interface TrackingData {
	entity?: LuaEntity;
	valid: boolean;
	position: MapPositionTable;
	resourceAmount: number;
}

export interface ResourceSite {
	name: string;
	isSiteExpanding?: boolean;
	hasExpanded?: boolean;
	amount: number;
	initialAmount: number;
	originalAmount?: number;
	oreType: string;
	oreName: LocalisedString;
	orePerMinute: number;
	finalizing: boolean;
	/**
	 * The game tick it has since been finalized on
	 */
	finalizingSince: number;
	lastOreCheck: number | undefined;
	lastModifiedAmount: number | undefined;
	addedAt: number;
	surface: LuaSurface;
	force: LuaForce;
	/**
	 * The [entities]{@link TrackingData} belonging to this [Resource Site]{@link ResourceSite}
	 */
	trackedPositionKeys: string[];
	entityCount: number;
	extents: Extend;
	nextToScan: LuaEntity[];
	entitiesToBeOverlaid: any;
	nextToOverlay: any;
	// used for ETD easing; initialized when needed,
	etdMinutes: number;
	remainingPerMille: number;
	center: PositionArray;
	iterating?: Iteration;
	isOverlayBeingCreated: boolean;
}

export interface Extend {
	left: number;
	right: number;
	top: number;
	bottom: number;
}

export interface Iteration {
	running: boolean;
	state: boolean[];
}
