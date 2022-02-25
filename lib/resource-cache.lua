--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 5,["11"] = 5,["12"] = 7,["13"] = 7,["14"] = 7,["16"] = 7,["17"] = 8,["18"] = 9,["19"] = 10,["20"] = 11,["23"] = 8,["24"] = 16,["25"] = 17,["26"] = 18,["29"] = 22,["30"] = 23,["32"] = 27,["33"] = 28,["35"] = 29,["36"] = 29,["37"] = 30,["38"] = 31,["39"] = 32,["40"] = 33,["41"] = 34,["42"] = 35,["45"] = 39,["46"] = 40,["47"] = 41,["48"] = 42,["50"] = 44,["52"] = 29,["55"] = 47,["56"] = 48,["57"] = 16,["58"] = 58,["59"] = 59,["60"] = 60,["62"] = 63,["63"] = 64,["64"] = 65,["65"] = 69,["66"] = 70,["67"] = 71,["68"] = 72,["69"] = 74,["71"] = 80,["72"] = 87,["73"] = 58,["74"] = 90,["75"] = 91,["76"] = 92,["78"] = 94,["79"] = 95,["80"] = 90,["81"] = 98,["82"] = 99,["83"] = 100,["85"] = 102,["86"] = 98,["87"] = 106,["88"] = 107});
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
