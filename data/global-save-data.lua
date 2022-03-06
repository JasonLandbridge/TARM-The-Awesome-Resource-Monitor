--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
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
    "cacheIteration",
    {get = function(self)
        return global.resourceTracker.cacheIteration
    end}
)
__TS__ObjectDefineProperty(
    Global,
    "trackedResources",
    {get = function(self)
        return global.resourceTracker.trackedResources
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
        Log:errorAll("Global.OnInit() => Global was invalid and could not be filled with mod data")
        return
    end
    if not global.playerData then
        global.playerData = {}
    end
    if not global.forceData then
        local forces = {
            "player",
            "enemy",
            "neutral",
            "conquest",
            "ignore",
            "capture",
            "friendly"
        }
        global.forceData = __TS__ArrayMap(
            forces,
            function(____, name)
                return {name = name, resourceSites = {}}
            end
        )
    end
    if not global.resourceTracker then
        global.resourceTracker = {trackedResources = {}, cacheIteration = {positionKeyIndex = 0, force = "", resourceSiteGuid = ""}}
    end
end
function Global.getDraftResourceSite(self, playerIndex)
    local playerData = __TS__ArrayFind(
        self.playerData,
        function(____, x) return x.index == playerIndex end
    )
    if playerData then
        return playerData.draftResourceSite
    end
    return nil
end
function Global.getForceData(self, forceName)
    return __TS__ArrayFind(
        ____exports.default.forceData,
        function(____, x) return x.name == forceName end
    ) or nil
end
function Global.setTrackedResources(self, key, value)
    global.resourceTracker.trackedResources[key] = value
end
function Global.setDraftResourceSite(self, playerIndex, draftResourceSite)
    local index = __TS__ArrayFindIndex(
        global.playerData,
        function(____, x) return x.index == playerIndex end
    )
    if index > -1 then
        global.playerData[index + 1].draftResourceSite = draftResourceSite
    end
end
function Global.setAllTrackedResources(self, trackedResources)
    global.resourceTracker.trackedResources = trackedResources
end
function Global.setAllPlayerData(self, playerData)
    global.playerData = playerData
end
____exports.default = Global
return ____exports
