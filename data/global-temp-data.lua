--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____global_2Dsave_2Ddata = require("data.global-save-data")
local Global = ____global_2Dsave_2Ddata.default
____exports.default = __TS__Class()
local GlobalTemp = ____exports.default
GlobalTemp.name = "GlobalTemp"
function GlobalTemp.prototype.____constructor(self)
end
__TS__ObjectDefineProperty(
    GlobalTemp,
    "resourceCache",
    {get = function(self)
        return globalTempData.resourceCache
    end}
)
__TS__ObjectDefineProperty(
    GlobalTemp,
    "resources",
    {get = function(self)
        return globalTempData.resourceCache.resources
    end}
)
function GlobalTemp.OnInit(self)
    globalTempData = {resourceCache = {
        resources = __TS__New(Map),
        positionKeysSet = __TS__New(Set)
    }}
end
function GlobalTemp.OnLoad(self)
    self:OnInit()
    local keys = __TS__ObjectKeys(Global.trackedResources)
    if #keys == 0 then
        return
    end
    for ____, key in ipairs(keys) do
        globalTempData.resourceCache.positionKeysSet:add(key)
    end
end
function GlobalTemp.addPositionKeyToCache(self, key)
    if not globalTempData.resourceCache.positionKeysSet:has(key) then
        globalTempData.resourceCache.positionKeysSet:add(key)
    end
end
____exports.default = GlobalTemp
return ____exports
