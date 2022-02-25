--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 5,["11"] = 5,["12"] = 6,["13"] = 6,["14"] = 8,["15"] = 8,["16"] = 8,["18"] = 8,["19"] = 9,["20"] = 10,["21"] = 11,["22"] = 12,["25"] = 9,["26"] = 17,["27"] = 18,["28"] = 19,["31"] = 23,["32"] = 24,["34"] = 28,["35"] = 29,["37"] = 30,["38"] = 30,["39"] = 31,["40"] = 32,["41"] = 33,["42"] = 34,["43"] = 35,["44"] = 36,["47"] = 40,["48"] = 41,["49"] = 42,["50"] = 43,["52"] = 45,["54"] = 30,["57"] = 48,["58"] = 49,["59"] = 17,["60"] = 59,["61"] = 60,["62"] = 61,["64"] = 64,["65"] = 65,["66"] = 66,["67"] = 70,["68"] = 71,["69"] = 72,["70"] = 73,["71"] = 75,["73"] = 81,["74"] = 88,["75"] = 59,["76"] = 91,["77"] = 92,["78"] = 93,["80"] = 95,["81"] = 96,["82"] = 91,["83"] = 99,["84"] = 100,["85"] = 101,["87"] = 103,["88"] = 99,["89"] = 107,["90"] = 108});
local ____exports = {}
local ____common = require("lib.common")
local positionToString = ____common.positionToString
local ____global_2Ddata = require("data.global-data")
local getResourceTracker = ____global_2Ddata.getResourceTracker
local getTrackingData = ____global_2Ddata.getTrackingData
local ____settings_2Ddata = require("data.settings-data")
local SettingsData = ____settings_2Ddata.default
local ____globals = require("typings.globals")
local GlobalData = ____globals.GlobalData
____exports.ResourceCache = __TS__Class()
local ResourceCache = ____exports.ResourceCache
ResourceCache.name = "ResourceCache"
function ResourceCache.prototype.____constructor(self)
end
function ResourceCache.prototype.OnLoad(self)
    local resourceTracker = getResourceTracker(nil)
    local entities = getTrackingData(nil)
    if not resourceTracker or entities.size == 0 then
        return
    end
end
function ResourceCache.prototype.OnTick(self, event)
    local resourceTracker = getResourceTracker(nil)
    if not resourceTracker or resourceTracker.trackedEntities.size == 0 then
        return
    end
    if not resourceTracker.iterationFunction then
        resourceTracker.iterationFunction = resourceTracker.trackedEntities:entries()
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
        return nil
    end
    local positionKey = positionToString(nil, entity.position)
    local trackingData = self:getEntity(positionKey)
    if trackingData then
        trackingData.entity = entity
        trackingData.valid = entity.valid
        trackingData.position = entity.position
        trackingData.resourceAmount = entity.amount
        return positionKey
    end
    GlobalData.resourceTracker.trackedEntities:set(positionKey, {entity = entity, valid = entity.valid, position = entity.position, resourceAmount = entity.amount})
    return positionKey
end
function ResourceCache.prototype.hasEntity(self, entity)
    if not entity or not entity.valid or entity.type ~= "resource" then
        return false
    end
    local positionKey = positionToString(nil, entity.position)
    return GlobalData.resourceTracker.trackedEntities:has(positionKey)
end
function ResourceCache.prototype.getEntity(self, positionKey)
    if positionKey == "" then
        return nil
    end
    return GlobalData.resourceTracker.trackedEntities:get(positionKey)
end
local resourceCache = __TS__New(____exports.ResourceCache)
____exports.default = resourceCache
return ____exports
