import Settings from '../constants/settings';

export default class SettingsData {
	public static get TickBetweenChecks(): number {
		return settings.global[Settings.TickBetweenChecks].value as number;
	}

	public static get OverlayStep(): number {
		return settings.global[Settings.OverlayStep].value as number;
	}

	public static get PrefixSiteWithSurface(): boolean {
		return settings.global[Settings.PrefixSiteWithSurface].value as boolean;
	}

	public static get EntitiesPerTick(): number {
		return settings.global[Settings.EntitiesPerTick].value as number;
	}
}
