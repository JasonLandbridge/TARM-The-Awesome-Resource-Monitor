--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 5,["11"] = 7,["12"] = 7,["13"] = 7,["15"] = 7,["16"] = 8,["17"] = 8,["18"] = 20,["19"] = 21,["20"] = 22,["23"] = 26,["24"] = 27,["26"] = 31,["27"] = 32,["29"] = 33,["30"] = 33,["31"] = 34,["32"] = 35,["33"] = 36,["34"] = 37,["35"] = 38,["36"] = 39,["39"] = 43,["40"] = 44,["41"] = 45,["42"] = 46,["44"] = 48,["46"] = 33,["49"] = 51,["50"] = 52,["51"] = 20,["52"] = 62,["53"] = 63,["54"] = 64,["56"] = 67,["57"] = 68,["58"] = 69,["59"] = 73,["60"] = 74,["61"] = 75,["62"] = 76,["63"] = 78,["65"] = 84,["66"] = 91,["67"] = 62,["68"] = 94,["69"] = 95,["70"] = 96,["72"] = 98,["73"] = 99,["74"] = 94,["75"] = 102,["76"] = 103,["77"] = 104,["79"] = 106,["80"] = 102,["81"] = 110,["82"] = 111});
local ____exports = {}
local ____common = require("lib.common")
local positionToString = ____common.positionToString
local ____global_2Ddata = require("data.global-data")
local Global = ____global_2Ddata.default
local ____settings_2Ddata = require("data.settings-data")
local SettingsData = ____settings_2Ddata.default
____exports.ResourceCache = __TS__Class()
local ResourceCache = ____exports.ResourceCache
ResourceCache.name = "ResourceCache"
function ResourceCache.prototype.____constructor(self)
end
function ResourceCache.prototype.OnLoad(self)
end
function ResourceCache.prototype.OnTick(self, event)
    local resourceTracker = Global.resourceTracker
    if not resourceTracker or resourceTracker.trackedResources.size == 0 then
        return
    end
    if not resourceTracker.iterationFunction then
        resourceTracker.iterationFunction = resourceTracker.trackedResources:entries()
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
                Global.resourceTracker.iterationKey = nil
                Global.resourceTracker.iterationFunction = nil
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
    Global.resourceTracker.trackedResources:set(positionKey, {entity = entity, valid = entity.valid, position = entity.position, resourceAmount = entity.amount})
    return positionKey
end
function ResourceCache.prototype.hasEntity(self, entity)
    if not entity or not entity.valid or entity.type ~= "resource" then
        return false
    end
    local positionKey = positionToString(nil, entity.position)
    return Global.resourceTracker.trackedResources:has(positionKey)
end
function ResourceCache.prototype.getEntity(self, positionKey)
    if positionKey == "" then
        return nil
    end
    return Global.resourceTracker.trackedResources:get(positionKey)
end
local resourceCache = __TS__New(____exports.ResourceCache)
____exports.default = resourceCache
return ____exports
