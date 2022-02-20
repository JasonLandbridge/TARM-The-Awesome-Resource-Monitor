declare let globalData: Global;

export interface Global {
	playerData: PlayerData[];
	forceData: ForceData[];
}

export interface PlayerData {
	index: number;
	guiUpdateTicks: number;
}
export interface ForceData {
	name: string;
	resourceSites: ResourceSites[];
}

export interface ResourceSites {
	name: string;
}
