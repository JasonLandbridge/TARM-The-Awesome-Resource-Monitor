import Settings from '../constants/settings';

export default class SettingsData {
	public static get TickBetweenChecks(): number {
		return Number(settings.global[Settings.TickBetweenChecks].value);
	}

	public static get OverlayStep(): number {
		return Number(settings.global[Settings.OverlayStep].value);
	}

	public static get PrefixSiteWithSurface(): boolean {
		return Boolean(settings.global[Settings.PrefixSiteWithSurface].value);
	}

	public static get EntitiesPerTick(): number {
		return Number(settings.global[Settings.EntitiesPerTick].value);
	}
}
