declare let globalData: Global;

export interface Global {
	playerData: PlayerData[];
	forceData: ForceData[];
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
	name: string;
	resourceSites: ResourceSite[];
}

export interface ResourceTracker {
	entities: TrackingData[];
	positionCache: { [name: string]: number };
}

export interface TrackingData {
	entity: LuaEntity;
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
	finalizing: boolean;
	lastOreCheck: number | undefined;
	lastModifiedAmount: number | undefined;
	addedAt: number;
	surface: LuaSurface;
	force: LuaForce;
	trackerIndices: any[];
	entityCount: number;
	extends: Extend;
	nextToScan: any[];
	entitiesToBeOverlaid: any;
	nextToOverlay: any;
	// used for ETD easing; initialized when needed,
	etdMinutes: number;
}

export interface Extend {
	left: number;
	right: number;
	top: number;
	bottom: number;
}
