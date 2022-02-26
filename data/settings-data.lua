--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
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
