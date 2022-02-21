import General from './general';

export default class Settings {
	public static TickBetweenChecks = General.Prefix + '-ticks-between-checks';
	public static EntitiesPerTick = General.Prefix + '-entities-per-tick';
	public static MapMarkers = General.Prefix + '-map-markers';
	public static OverlayStep = General.Prefix + '-overlay-step';
	public static PrefixSiteWithSurface = General.Prefix + '-site-prefix-with-surface';
	public static DebugProfiling = General.Prefix + '-debug-profiling';
	public static WarnPercentage = General.Prefix + '-warn-percent';
	public static OrderBy = General.Prefix + '-order-by';
}
