--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____settings = require("constants.settings")
local Settings = ____settings.default
____exports.SettingsDataType = __TS__Class()
local SettingsDataType = ____exports.SettingsDataType
SettingsDataType.name = "SettingsDataType"
function SettingsDataType.prototype.____constructor(self)
    self._tickBetweenChecks = 0
    self._overlayStep = 0
    self._prefixWithSurface = false
    self._entitiesPerTick = 0
end
__TS__SetDescriptor(
    SettingsDataType.prototype,
    "TickBetweenChecks",
    {get = function(self)
        return self._tickBetweenChecks
    end},
    true
)
__TS__SetDescriptor(
    SettingsDataType.prototype,
    "OverlayStep",
    {get = function(self)
        return self._overlayStep
    end},
    true
)
__TS__SetDescriptor(
    SettingsDataType.prototype,
    "PrefixSiteWithSurface",
    {get = function(self)
        return self._prefixWithSurface
    end},
    true
)
__TS__SetDescriptor(
    SettingsDataType.prototype,
    "EntitiesPerTick",
    {get = function(self)
        return self._entitiesPerTick
    end},
    true
)
function SettingsDataType.prototype.OnInit(self)
    self:OnLoad()
end
function SettingsDataType.prototype.OnLoad(self)
    self._tickBetweenChecks = settings.global[Settings.TickBetweenChecks].value
    self._overlayStep = settings.global[Settings.OverlayStep].value
    self._prefixWithSurface = settings.global[Settings.PrefixSiteWithSurface].value
    self._entitiesPerTick = settings.global[Settings.EntitiesPerTick].value
end
local SettingsData = __TS__New(____exports.SettingsDataType)
____exports.default = SettingsData
return ____exports
