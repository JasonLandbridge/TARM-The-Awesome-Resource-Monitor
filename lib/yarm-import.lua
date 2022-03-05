--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local migrateOreTracker, migrateForceData, convertTrackerIndicesToPositionKeys, migratePlayerData
local ____log = require("lib.log")
local Log = ____log.default
local ____global_2Dsave_2Ddata = require("data.global-save-data")
local Global = ____global_2Dsave_2Ddata.default
local ____util = require("util")
local ____table = ____util.table
local ____common = require("lib.common")
local generateGuid = ____common.generateGuid
local positionToString = ____common.positionToString
function migrateOreTracker(self, entities)
    local newTrackedResources = ____table.deepcopy(Global.trackedResources)
    for ____, yarmEntity in ipairs(entities) do
        local key = positionToString(nil, yarmEntity.position)
        newTrackedResources[key] = {entity = yarmEntity.entity, position = yarmEntity.position, resourceAmount = yarmEntity.resource_amount, valid = yarmEntity.valid}
    end
    Global:setAllTrackedResources(newTrackedResources)
end
function migrateForceData(self, entities, forceDatum)
    local entries = __TS__ObjectEntries(forceDatum)
    local newForceData = ____table.deepcopy(Global.forceData)
    for ____, ____value in __TS__Iterator(__TS__ArrayEntries(entries)) do
        local index = ____value[1]
        local key = ____value[2][1]
        local value = ____value[2][2]
        if not newForceData[key] then
            newForceData[key] = {resourceSites = {}}
        end
        for ____, ____value in ipairs(__TS__ObjectEntries(value.ore_sites)) do
            local name = ____value[1]
            local yarmResourceSite = ____value[2]
            __TS__ArrayPush(
                newForceData[key].resourceSites,
                {
                    guid = generateGuid(nil),
                    totalAmount = yarmResourceSite.amount,
                    addedAt = yarmResourceSite.added_at,
                    center = yarmResourceSite.center,
                    entityCount = yarmResourceSite.entity_count,
                    etdMinutes = yarmResourceSite.etd_minutes,
                    extents = yarmResourceSite.extents,
                    force = yarmResourceSite.force,
                    initialAmount = yarmResourceSite.initial_amount,
                    lastModifiedAmount = yarmResourceSite.last_modified_amount,
                    lastOreCheck = yarmResourceSite.last_ore_check,
                    name = yarmResourceSite.name,
                    oreName = yarmResourceSite.ore_name,
                    orePerMinute = yarmResourceSite.ore_per_minute,
                    oreType = yarmResourceSite.ore_type,
                    remainingPerMille = yarmResourceSite.remaining_permille,
                    surface = yarmResourceSite.surface,
                    trackedPositionKeys = convertTrackerIndicesToPositionKeys(nil, entities, yarmResourceSite.tracker_indices)
                }
            )
        end
    end
end
function convertTrackerIndicesToPositionKeys(self, entities, trackerIndices)
    local positionKeys = {}
    for ____, ____value in ipairs(__TS__ObjectEntries(trackerIndices)) do
        local key = ____value[1]
        local value = ____value[2]
        do
            local entity = entities[__TS__Number(key) + 1]
            if not entity then
                Log:errorAll("convertTrackerIndicesToPositionKeys() => entity could not be found with key " .. key)
                goto __continue15
            end
            local positionKey = positionToString(nil, entity.position)
            positionKeys[positionKey] = value
        end
        ::__continue15::
    end
    return positionKeys
end
function migratePlayerData(self, yarmPlayerDatum)
    local playerDatum = ____table.deepcopy(Global.playerData)
    local yarmPlayerDatumEntries = __TS__ObjectEntries(yarmPlayerDatum)
    for ____, playerData in ipairs(playerDatum) do
        local yarmPlayerDataEntry = __TS__ArrayFind(
            yarmPlayerDatumEntries,
            function(____, ____bindingPattern0)
                local index
                index = ____bindingPattern0[1]
                local value = ____bindingPattern0[2]
                return __TS__Number(index) == playerData.index
            end
        )
        if yarmPlayerDataEntry then
            playerData.guiUpdateTicks = yarmPlayerDataEntry[2].gui_update_ticks
        end
    end
    Global:setAllPlayerData(playerDatum)
end
function ____exports.importYarmData(self)
    if remote.interfaces.YARM and remote.interfaces.YARM.get_global_data then
        local globalState = remote.call("YARM", "get_global_data")
        if globalState and #__TS__ObjectKeys(globalState) > 0 then
            Log:infoAll("Start of importing YARM data")
            local resourceEntities = globalState.ore_tracker.entities
            migrateOreTracker(nil, resourceEntities)
            Log:infoAll("Imported the resource entities of YARM")
            migrateForceData(nil, resourceEntities, globalState.force_data)
            Log:infoAll("Imported the force data of YARM")
            migratePlayerData(nil, globalState.player_data)
            Log:infoAll("Imported the player data of YARM")
            Log:infoAll("Successfully imported YARM data")
            return
        end
        Log:errorAll("Yarm import failed, YARM global contained no values")
    end
end
return ____exports
