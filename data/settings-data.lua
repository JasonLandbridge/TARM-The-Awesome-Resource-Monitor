--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["11"] = 3,["16"] = 5,["23"] = 9,["30"] = 13,["37"] = 17,["40"] = 3});
local ____exports = {}
local ____settings = require("constants.settings")
local Settings = ____settings.default
____exports.default = __TS__Class()
local SettingsData = ____exports.default
SettingsData.name = "SettingsData"
function SettingsData.prototype.____constructor(self)
end
__TS__ObjectDefineProperty(
    SettingsData,
    "TickBetweenChecks",
    {get = function(self)
        return settings.global[Settings.TickBetweenChecks].value
    end}
)
__TS__ObjectDefineProperty(
    SettingsData,
    "OverlayStep",
    {get = function(self)
        return settings.global[Settings.OverlayStep].value
    end}
)
__TS__ObjectDefineProperty(
    SettingsData,
    "PrefixSiteWithSurface",
    {get = function(self)
        return settings.global[Settings.PrefixSiteWithSurface].value
    end}
)
__TS__ObjectDefineProperty(
    SettingsData,
    "EntitiesPerTick",
    {get = function(self)
        return settings.global[Settings.EntitiesPerTick].value
    end}
)
____exports.default = SettingsData
return ____exports
