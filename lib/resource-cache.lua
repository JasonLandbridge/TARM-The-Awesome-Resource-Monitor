--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
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
    if Global.trackedResources.size == 0 then
        return
    end
    local x = __TS__New(Map)
    for ____, ____value in __TS__Iterator(Global.trackedResources) do
        local key = ____value[1]
        local trackingData = ____value[2]
        x:set(key, trackingData)
    end
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
    Global:setTrackedResources(positionKey, {entity = entity, valid = entity.valid, position = entity.position, resourceAmount = entity.amount})
    return positionKey
end
function ResourceCache.prototype.hasEntity(self, entity)
    if not entity or not entity.valid or entity.type ~= "resource" then
        return false
    end
    local positionKey = positionToString(nil, entity.position)
    return Global.trackedResources:has(positionKey)
end
function ResourceCache.prototype.getEntity(self, positionKey)
    if positionKey == "" or Global.trackedResources.size == 0 then
        return nil
    end
    return Global.trackedResources:get(positionKey)
end
local resourceCache = __TS__New(____exports.ResourceCache)
____exports.default = resourceCache
return ____exports
