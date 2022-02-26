--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____general = require("constants.general")
local General = ____general.default
____exports.default = __TS__Class()
local Settings = ____exports.default
Settings.name = "Settings"
function Settings.prototype.____constructor(self)
end
Settings.TickBetweenChecks = General.Prefix .. "-ticks-between-checks"
Settings.EntitiesPerTick = General.Prefix .. "-entities-per-tick"
Settings.MapMarkers = General.Prefix .. "-map-markers"
Settings.OverlayStep = General.Prefix .. "-overlay-step"
Settings.PrefixSiteWithSurface = General.Prefix .. "-site-prefix-with-surface"
Settings.DebugProfiling = General.Prefix .. "-debug-profiling"
Settings.WarnPercentage = General.Prefix .. "-warn-percent"
Settings.OrderBy = General.Prefix .. "-order-by"
____exports.default = Settings
return ____exports
