import { ForceData, ResourceSite } from '../declarations/global';

export function getForceData(forceName: string): ForceData | undefined {
	return GlobalData?.forceData[forceName] ?? undefined;
}

export function addResourceSiteToForce(forceName: string, site: ResourceSite) {
	let forceData = getForceData(forceName);
	if (forceData) {
		forceData.resourceSites.push(site);
	}
}

