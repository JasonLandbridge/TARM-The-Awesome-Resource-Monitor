import { TrackingData } from './global-save-state';

export interface GlobalTempState {
	resourceCache: ResourceCache;
}

export interface ResourceCache {
	resources: Map<string, TrackingData>;
	positionKeysSet: Set<string>;
	iterationKey?: string;
	iterationFunction?: IterableIterator<[string, string]>;
}
