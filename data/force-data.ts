import { ForceData, ResourceSite } from '../declarations/global';

export function getForceData(forceName: string): ForceData | undefined {
	return GlobalData.forceData.find((x) => x.name === forceName);
}

export function addResourceSiteToForce(forceName: string, site: ResourceSite) {
	let forceData = getForceData(forceName);
	if (forceData) {
		forceData.resourceSites.push(site);
	}
}
