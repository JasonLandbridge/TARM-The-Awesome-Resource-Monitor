--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____log = require("lib.log")
local Log = ____log.default
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
local getPlayers = ____game.getPlayers
local ____player_2Ddata = require("data.player-data")
local getPlayerData = ____player_2Ddata.getPlayerData
local initPlayer = ____player_2Ddata.initPlayer
local ____settings_2Ddata = require("data.settings-data")
local SettingsData = ____settings_2Ddata.default
local ____constants = require("constants.index")
local Entity = ____constants.Entity
local General = ____constants.General
local ____common = require("lib.common")
local findResourceAt = ____common.findResourceAt
local shiftPosition = ____common.shiftPosition
local ____global_2Dsave_2Ddata = require("data.global-save-data")
local Global = ____global_2Dsave_2Ddata.default
function ____exports.updateUi(self, playerIndex)
end
function ____exports.processOverlayForExistingResourceSite(self, index)
end
function ____exports.clearCurrentSite(self, playerIndex)
    local player = getPlayer(nil, playerIndex)
    local playerData = getPlayerData(nil, playerIndex)
    if not (player and playerData) then
        return
    end
    playerData.draftResourceSite = nil
    while #playerData.overlays > 0 do
        local ____playerData_overlays_pop_result_destroy_result_0 = table.remove(playerData.overlays)
        if ____playerData_overlays_pop_result_destroy_result_0 ~= nil then
            ____playerData_overlays_pop_result_destroy_result_0 = ____playerData_overlays_pop_result_destroy_result_0.destroy()
        end
    end
end
local function findMajorityResourceEntity(self, entities)
    local results = __TS__New(Map)
    for ____, entity in ipairs(entities) do
        if entity.type == "resource" then
            local currentCount = results:get(entity.name) or 0
            results:set(entity.name, currentCount + 1)
        end
    end
    local winnerType = __TS__ArrayReduce(
        {__TS__Spread(results:entries())},
        function(____, a, e) return e[2] > a[2] and e or a end
    )[1]
    return __TS__ArrayFind(
        entities,
        function(____, x) return x.name == winnerType end
    ) or ({})
end
function ____exports.startResourceSiteCreation(self, event)
    local playerIndex = event.player_index
    local player = getPlayer(nil, playerIndex)
    local playerData = getPlayerData(nil, playerIndex)
    if not (playerData and player) then
        Log:errorAll("startResourceSiteCreation() => Could not find playerData and player for player index " .. tostring(playerIndex))
        return
    end
    local resourceEntities = event.entities
    local sampleResource = findMajorityResourceEntity(nil, resourceEntities)
    local sameResourceEntities = __TS__ArrayFilter(
        resourceEntities,
        function(____, x) return x.name == sampleResource.name end
    )
    local resourceSite = {
        center = {0, 0},
        orePerMinute = 0,
        remainingPerMille = 0,
        addedAt = 0,
        surface = event.surface,
        force = player.force,
        oreType = sampleResource.name,
        oreName = sampleResource.prototype.localised_name,
        amount = 0,
        entityCount = 0,
        etdMinutes = 0,
        extents = {left = 0, right = 0, top = 0, bottom = 0},
        initialAmount = 0,
        lastModifiedAmount = nil,
        lastOreCheck = nil,
        name = "",
        trackedPositionKeys = {}
    }
    local totalResources = 0
    for ____, resourceEntity in ipairs(sameResourceEntities) do
        local amount = resourceEntity.amount
        resourceSite.amount = resourceSite.amount + amount
        resourceSite.entityCount = resourceSite.entityCount + 1
        totalResources = totalResources + amount
    end
    resourceSite.entityCount = totalResources
    local resourceSiteCreation = {
        finalizingSince = 0,
        finalizing = false,
        isOverlayBeingCreated = false,
        isSiteExpanding = false,
        hasExpanded = false,
        nextToScan = {},
        nextToOverlay = {},
        resourceEntities = sameResourceEntities,
        resourceSite = resourceSite
    }
    Global:setDraftResourceSite(playerIndex, resourceSiteCreation)
end
function ____exports.addResourcesToDraftResourceSite(self, playerIndex, resources)
    local playerData = getPlayerData(nil, playerIndex)
    if not playerData then
        Log:errorAll("addResourcesToDraftResourceSite() => Could not find playerData and player for player index " .. tostring(playerIndex))
        return
    end
    local draftResourceSite = Global:getDraftResourceSite(playerIndex)
    if not draftResourceSite then
        Log:error(
            playerIndex,
            ("addResourcesToDraftResourceSite() => No draftResourceSite set for playerIndex " .. tostring(playerIndex)) .. ", could not add resources"
        )
        return
    end
    local sameResourceEntities = __TS__ArrayFilter(
        resources,
        function(____, x)
            local ____x_name_4 = x.name
            local ____draftResourceSite_resourceSite_oreType_2 = draftResourceSite
            if ____draftResourceSite_resourceSite_oreType_2 ~= nil then
                ____draftResourceSite_resourceSite_oreType_2 = ____draftResourceSite_resourceSite_oreType_2.resourceSite.oreType
            end
            return ____x_name_4 == ____draftResourceSite_resourceSite_oreType_2
        end
    )
    draftResourceSite.resourceEntities = __TS__ArrayConcat(draftResourceSite.resourceEntities, sameResourceEntities)
    for ____, resource in ipairs(sameResourceEntities) do
        local ____draftResourceSite_resourceSite_5, ____amount_6 = draftResourceSite.resourceSite, "amount"
        ____draftResourceSite_resourceSite_5[____amount_6] = ____draftResourceSite_resourceSite_5[____amount_6] + resource.amount
        local ____draftResourceSite_resourceSite_7, ____entityCount_8 = draftResourceSite.resourceSite, "entityCount"
        ____draftResourceSite_resourceSite_7[____entityCount_8] = ____draftResourceSite_resourceSite_7[____entityCount_8] + 1
    end
    Global:setDraftResourceSite(playerIndex, draftResourceSite)
end
function ____exports.registerResourceSite(self, resourceSite)
end
function ____exports.addOverlayOnResource(self, entity, playerData)
    local pos = entity.position
    local surface = entity.surface
    if math.floor(pos.x) % SettingsData.OverlayStep ~= 0 or math.floor(pos.y) % SettingsData.OverlayStep ~= 0 then
        return
    end
    local overlay = surface.create_entity({name = Entity.ResourceManagerOverlay, force = game.forces.neutral, position = pos})
    if not overlay then
        Log:error(
            playerData.index,
            (("addOverlayOnResource() => Could not create resource overlay on position x: " .. tostring(pos.x)) .. ", y: ") .. tostring(pos.y)
        )
        return
    end
    overlay.minable = false
    overlay.destructible = false
    overlay.operable = false
    __TS__ArrayPush(playerData.overlays, overlay)
end
function ____exports.scanResourceSite(self, playerIndex)
    local ____getPlayerData_result_draftResourceSite_9 = getPlayerData(nil, playerIndex)
    if ____getPlayerData_result_draftResourceSite_9 ~= nil then
        ____getPlayerData_result_draftResourceSite_9 = ____getPlayerData_result_draftResourceSite_9.draftResourceSite
    end
    local currentSite = ____getPlayerData_result_draftResourceSite_9
    if not currentSite then
        Log:errorAll("scanResourceSite() => Could not retrieve the currentSite with playerIndex: " .. tostring(playerIndex))
        return
    end
    local toScan = math.min(30, #currentSite.nextToScan)
    do
        local i = 1
        while toScan do
            local entity = table.remove(currentSite.nextToScan)
            if not entity then
                Log:debugAll("scanResourceSite() => No more resources to scan for draftResourceSite!")
                break
            end
            local position = entity.position
            local surface = entity.surface
            for ____, direction in ipairs(General.Directions) do
                local resourceFound = findResourceAt(
                    nil,
                    surface,
                    shiftPosition(nil, position, direction)
                )
                if resourceFound and resourceFound.name == currentSite.resourceSite.oreType then
                end
            end
            i = i + 1
        end
    end
end
local function countDeposits(self, resourceSite, updateCycle)
end
function ____exports.updatePlayers(self, event)
    if not Global.valid or not Global.playerData then
        Log:warnAll("updatePlayers() => Either Global or Global.playerData was invalid")
        return
    end
    local players = getPlayers(nil)
    for ____, player in ipairs(players) do
        local playerData = getPlayerData(nil, player.index)
        if not playerData then
            initPlayer(nil, player.index)
            playerData = getPlayerData(nil, player.index)
        elseif not player.connected and playerData.draftResourceSite then
            ____exports.clearCurrentSite(nil, player.index)
        end
        local ____playerData_draftResourceSite_11 = playerData
        if ____playerData_draftResourceSite_11 ~= nil then
            ____playerData_draftResourceSite_11 = ____playerData_draftResourceSite_11.draftResourceSite
        end
        if ____playerData_draftResourceSite_11 then
            local resourceSite = playerData.draftResourceSite
            if #resourceSite.nextToScan > 0 then
                ____exports.scanResourceSite(nil, player.index)
            elseif not resourceSite.finalizing then
            elseif resourceSite.finalizingSince + 120 == event.tick then
            end
            if resourceSite.isOverlayBeingCreated then
                ____exports.processOverlayForExistingResourceSite(nil, player.index)
            end
        end
        if playerData and event.tick % playerData.guiUpdateTicks == 15 + player.index then
            ____exports.updateUi(nil, player.index)
        end
    end
end
return ____exports
