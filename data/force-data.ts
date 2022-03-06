import { ResourceSite } from '../declarations/global-save-state';
import Global from './global-save-data';

export function addResourceSiteToForce(forceName: string, site: ResourceSite) {
	let forceData = Global.getForceData(forceName);
	if (forceData) {
		forceData.resourceSites.push(site);
	}
}
