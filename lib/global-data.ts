import Global from '../declarations/global';

declare let globalData: Global;
export function setupGlobalData() {
	globalData = { playerData: { test: true } };
}
