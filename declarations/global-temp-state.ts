import { TrackingData } from './global-save-state';

export interface GlobalTempState {
	test: boolean;
	resourceCache: ResourceCache;
}

export interface ResourceCache {
	resources: Map<string, TrackingData>;
	iterationKey?: string;
	iterationFunction?: IterableIterator<[string, TrackingData]>;
}
