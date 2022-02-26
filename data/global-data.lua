--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 6,["8"] = 6,["9"] = 6,["11"] = 6,["16"] = 10,["17"] = 11,["19"] = 13,["26"] = 17,["33"] = 21,["40"] = 25,["47"] = 29,["54"] = 33,["57"] = 39,["58"] = 40,["59"] = 41,["62"] = 45,["63"] = 46,["65"] = 49,["66"] = 50,["67"] = 51,["68"] = 51,["69"] = 51,["70"] = 51,["71"] = 51,["72"] = 51,["73"] = 51,["74"] = 51,["75"] = 51,["76"] = 52,["77"] = 53,["80"] = 59,["81"] = 60,["83"] = 39,["84"] = 6});
local ____exports = {}
local ____log = require("lib.log")
local Log = ____log.default
____exports.default = __TS__Class()
local Global = ____exports.default
Global.name = "Global"
function Global.prototype.____constructor(self)
end
__TS__ObjectDefineProperty(
    Global,
    "GlobalData",
    {get = function(self)
        if not global then
            Log:errorAll("GlobalData was invalid!")
        end
        return global
    end}
)
__TS__ObjectDefineProperty(
    Global,
    "resourceTracker",
    {get = function(self)
        return global.resourceTracker
    end}
)
__TS__ObjectDefineProperty(
    Global,
    "trackedEntities",
    {get = function(self)
        return self.resourceTracker.trackedResources
    end}
)
__TS__ObjectDefineProperty(
    Global,
    "forceData",
    {get = function(self)
        return global.forceData
    end}
)
__TS__ObjectDefineProperty(
    Global,
    "playerData",
    {get = function(self)
        return global.playerData
    end}
)
__TS__ObjectDefineProperty(
    Global,
    "valid",
    {get = function(self)
        return not not global
    end}
)
function Global.OnInit(self)
    if not ____exports.default.valid then
        Log:errorAll("Global.OnInit() => Global was invalid and could not be filled with data")
        return
    end
    if not global.playerData then
        global.playerData = {}
    end
    if not global.forceData then
        global.forceData = {}
        local forces = {
            "player",
            "enemy",
            "neutral",
            "conquest",
            "ignore",
            "capture",
            "friendly"
        }
        for ____, force in ipairs(forces) do
            global.forceData[force] = {resourceSites = {}}
        end
    end
    if not global.resourceTracker then
        global.resourceTracker = {trackedResources = __TS__New(Map)}
    end
end
____exports.default = Global
return ____exports
