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
    globalTempData = {resourceCache = {resources = __TS__New(Map)}}
end
function GlobalTemp.OnLoad(self)
    self:OnInit()
    local entries = __TS__ObjectEntries(Global.trackedResources)
    if #entries == 0 then
        return
    end
    for ____, ____value in ipairs(entries) do
        local key = ____value[1]
        local trackingData = ____value[2]
        globalTempData.resourceCache.resources:set(key, trackingData)
    end
end
____exports.default = GlobalTemp
return ____exports
