import { ForceData, ResourceSite } from '../declarations/globalState';
import Global from './global-data';

export function getForceData(forceName: string): ForceData | undefined {
	return Global.forceData[forceName] ?? undefined;
}

export function addResourceSiteToForce(forceName: string, site: ResourceSite) {
	let forceData = getForceData(forceName);
	if (forceData) {
		forceData.resourceSites.push(site);
	}
}

