--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 57,["8"] = 58,["9"] = 59,["11"] = 61,["12"] = 62,["13"] = 63,["14"] = 64,["16"] = 66,["17"] = 57,["18"] = 69,["19"] = 70,["20"] = 71,["22"] = 73,["23"] = 74,["24"] = 75,["26"] = 77,["27"] = 69,["28"] = 11,["29"] = 12,["30"] = 13,["32"] = 16,["33"] = 17,["34"] = 18,["35"] = 22,["36"] = 23,["37"] = 24,["38"] = 25,["39"] = 27,["41"] = 32,["42"] = 39,["43"] = 40,["44"] = 41,["45"] = 11,["46"] = 44,["47"] = 45,["48"] = 46,["50"] = 48,["51"] = 49,["52"] = 44});
local ____exports = {}
local ____common = require("lib.common")
local positionToString = ____common.positionToString
function ____exports.getEntityIndexInCache(self, entity)
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
function ____exports.getEntity(self, positionKey)
    if positionKey == "" then
        return nil
    end
    local positionIndex = GlobalData.resourceTracker.positionCache[positionKey]
    if positionIndex and positionIndex > -1 then
        return GlobalData.resourceTracker.entities[positionIndex + 1]
    end
    return nil
end
function ____exports.addEntity(self, entity)
    if not entity or not entity.valid or entity.type ~= "resource" then
        return -1
    end
    local positionKey = positionToString(nil, entity.position)
    local trackingData = ____exports.getEntity(nil, positionKey)
    if trackingData then
        trackingData.entity = entity
        trackingData.valid = entity.valid
        trackingData.position = entity.position
        trackingData.resourceAmount = entity.amount
        return ____exports.getEntityIndexInCache(nil, entity)
    end
    __TS__ArrayPush(GlobalData.resourceTracker.entities, {entity = entity, valid = entity.valid, position = entity.position, resourceAmount = entity.amount})
    local pushedIndex = #GlobalData.resourceTracker.entities - 1
    GlobalData.resourceTracker.positionCache[positionKey] = pushedIndex
    return pushedIndex
end
function ____exports.hasEntity(self, entity)
    if not entity or not entity.valid or entity.type ~= "resource" then
        return false
    end
    local positionKey = positionToString(nil, entity.position)
    return not not GlobalData.resourceTracker.positionCache[positionKey]
end
return ____exports
