--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 3});
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
