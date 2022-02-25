--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 5,["11"] = 5,["12"] = 7,["13"] = 7,["14"] = 7,["16"] = 7,["17"] = 8,["18"] = 9,["19"] = 10,["20"] = 11,["24"] = 15,["25"] = 15,["26"] = 16,["27"] = 17,["28"] = 15,["31"] = 8,["32"] = 21,["33"] = 22,["34"] = 23,["37"] = 27,["38"] = 28,["40"] = 32,["41"] = 33,["43"] = 34,["44"] = 34,["45"] = 35,["46"] = 36,["47"] = 37,["48"] = 38,["49"] = 39,["50"] = 40,["53"] = 44,["54"] = 45,["55"] = 46,["56"] = 47,["58"] = 49,["60"] = 34,["63"] = 52,["64"] = 53,["65"] = 21,["66"] = 63,["67"] = 64,["68"] = 65,["70"] = 68,["71"] = 69,["72"] = 70,["73"] = 74,["74"] = 75,["75"] = 76,["76"] = 77,["77"] = 79,["79"] = 84,["80"] = 91,["81"] = 92,["82"] = 93,["83"] = 63,["84"] = 96,["85"] = 97,["86"] = 98,["88"] = 100,["89"] = 101,["90"] = 96,["91"] = 109,["92"] = 110,["93"] = 111,["95"] = 113,["96"] = 114,["97"] = 115,["98"] = 116,["100"] = 118,["101"] = 109,["102"] = 121,["103"] = 122,["104"] = 123,["106"] = 125,["107"] = 126,["108"] = 127,["110"] = 129,["111"] = 121,["112"] = 133,["113"] = 134});
local ____exports = {}
local ____common = require("lib.common")
local positionToString = ____common.positionToString
local ____global_2Ddata = require("data.global-data")
local getResourceTracker = ____global_2Ddata.getResourceTracker
local getTrackingData = ____global_2Ddata.getTrackingData
local ____settings_2Ddata = require("data.settings-data")
local SettingsData = ____settings_2Ddata.default
____exports.ResourceCache = __TS__Class()
local ResourceCache = ____exports.ResourceCache
ResourceCache.name = "ResourceCache"
function ResourceCache.prototype.____constructor(self)
end
function ResourceCache.prototype.OnLoad(self)
    local resourceTracker = getResourceTracker(nil)
    local entities = getTrackingData(nil)
    if not resourceTracker or #entities == 0 then
        return
    end
    do
        local trackerIndex = 0
        while trackerIndex < #entities do
            local key = positionToString(nil, entities[trackerIndex + 1].position)
            resourceTracker.positionCache[key] = trackerIndex
            trackerIndex = trackerIndex + 1
        end
    end
end
function ResourceCache.prototype.OnTick(self, event)
    local resourceTracker = getResourceTracker(nil)
    if not resourceTracker or #resourceTracker.trackedEntities == 0 then
        return
    end
    if not resourceTracker.iterationFunction then
        resourceTracker.iterationFunction = __TS__ArrayEntries(resourceTracker.trackedEntities)
    end
    local key = resourceTracker.iterationKey
    local iterationFunc = resourceTracker.iterationFunction
    do
        local i = 0
        while i < SettingsData.EntitiesPerTick do
            local pair = iterationFunc:next().value
            key = pair[1]
            local trackingData = pair[2]
            if not key then
                GlobalData.resourceTracker.iterationKey = nil
                GlobalData.resourceTracker.iterationFunction = nil
                return
            end
            if not trackingData.entity or not trackingData.entity.valid then
                trackingData.resourceAmount = 0
                trackingData.entity = nil
                trackingData.valid = false
            else
                trackingData.resourceAmount = trackingData.entity.amount
            end
            i = i + 1
        end
    end
    resourceTracker.iterationKey = key
    resourceTracker.iterationFunction = iterationFunc
end
function ResourceCache.prototype.addEntity(self, entity)
    if not entity or not entity.valid or entity.type ~= "resource" then
        return -1
    end
    local positionKey = positionToString(nil, entity.position)
    local trackingData = self:getEntity(positionKey)
    if trackingData then
        trackingData.entity = entity
        trackingData.valid = entity.valid
        trackingData.position = entity.position
        trackingData.resourceAmount = entity.amount
        return self:getEntityIndexInCache(entity)
    end
    __TS__ArrayPush(GlobalData.resourceTracker.trackedEntities, {entity = entity, valid = entity.valid, position = entity.position, resourceAmount = entity.amount})
    local pushedIndex = #GlobalData.resourceTracker.trackedEntities - 1
    GlobalData.resourceTracker.positionCache[positionKey] = pushedIndex
    return pushedIndex
end
function ResourceCache.prototype.hasEntity(self, entity)
    if not entity or not entity.valid or entity.type ~= "resource" then
        return false
    end
    local positionKey = positionToString(nil, entity.position)
    return not not GlobalData.resourceTracker.positionCache[positionKey]
end
function ResourceCache.prototype.getEntityIndexInCache(self, entity)
    if not entity or not entity.valid or entity.type ~= "resource" then
        return -1
    end
    local positionKey = positionToString(nil, entity.position)
    local positionIndex = GlobalData.resourceTracker.positionCache[positionKey]
    if not positionIndex then
        return -1
    end
    return positionIndex
end
function ResourceCache.prototype.getEntity(self, positionKey)
    if positionKey == "" then
        return nil
    end
    local positionIndex = GlobalData.resourceTracker.positionCache[positionKey]
    if positionIndex and positionIndex > -1 then
        return GlobalData.resourceTracker.trackedEntities[positionIndex + 1]
    end
    return nil
end
local resourceCache = __TS__New(____exports.ResourceCache)
____exports.default = resourceCache
return ____exports
