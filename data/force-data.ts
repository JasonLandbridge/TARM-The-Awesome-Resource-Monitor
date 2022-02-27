import { ForceData, ResourceSite } from '../declarations/global-save-state';
import Global from './global-save-data';

export function getForceData(forceName: string): ForceData | undefined {
	return Global.forceData[forceName] ?? undefined;
}

export function addResourceSiteToForce(forceName: string, site: ResourceSite) {
	let forceData = getForceData(forceName);
	if (forceData) {
		forceData.resourceSites.push(site);
	}
}

