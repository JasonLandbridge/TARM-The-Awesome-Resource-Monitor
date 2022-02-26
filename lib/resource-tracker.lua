--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local countDeposits
local ____log = require("lib.log")
local Log = ____log.default
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
local getPlayers = ____game.getPlayers
local ____player_2Ddata = require("data.player-data")
local getPlayerData = ____player_2Ddata.getPlayerData
local initPlayer = ____player_2Ddata.initPlayer
local ____force_2Ddata = require("data.force-data")
local addResourceSiteToForce = ____force_2Ddata.addResourceSiteToForce
local getForceData = ____force_2Ddata.getForceData
local ____resource_2Dcache = require("lib.resource-cache")
local ResourceCache = ____resource_2Dcache.default
local ____settings_2Ddata = require("data.settings-data")
local SettingsData = ____settings_2Ddata.default
local ____constants = require("constants.index")
local Entity = ____constants.Entity
local General = ____constants.General
local ____common = require("lib.common")
local findCenter = ____common.findCenter
local findResourceAt = ____common.findResourceAt
local getOctantName = ____common.getOctantName
local shiftPosition = ____common.shiftPosition
local ____util = require("util")
local distance = ____util.distance
local ____global_2Ddata = require("data.global-data")
local Global = ____global_2Ddata.default
function ____exports.clearCurrentSite(self, playerIndex)
    local player = getPlayer(nil, playerIndex)
    local playerData = getPlayerData(nil, playerIndex)
    if not (player and playerData) then
        return
    end
    playerData.currentSite = nil
    while #playerData.overlays > 0 do
        local ____playerData_overlays_pop_result_destroy_result_0 = table.remove(playerData.overlays)
        if ____playerData_overlays_pop_result_destroy_result_0 ~= nil then
            ____playerData_overlays_pop_result_destroy_result_0 = ____playerData_overlays_pop_result_destroy_result_0.destroy()
        end
    end
end
function ____exports.addSingleEntity(self, playerIndex, entity)
    local playerData = getPlayerData(nil, playerIndex)
    if not playerData then
        return
    end
    local resourceSite = playerData.currentSite
    if not resourceSite then
        Log:warn(playerIndex, "addSingleEntity() => 'playerData.currentSite' was invalid")
        return
    end
    local positionKey = ResourceCache:addEntity(entity)
    if not positionKey then
        Log:errorAll("addSingleEntity() => Failed to add entity " .. tostring(entity.position))
        return
    end
    if __TS__ArrayFind(
        resourceSite.trackedPositionKeys,
        function(____, x) return x == positionKey end
    ) then
        return
    end
    if resourceSite.finalizing then
        resourceSite.finalizing = false
    end
    __TS__ArrayPush(resourceSite.trackedPositionKeys, positionKey)
    resourceSite.entityCount = resourceSite.entityCount + 1
    __TS__ArrayPush(resourceSite.nextToScan, entity)
    resourceSite.amount = resourceSite.amount + entity.amount
    if entity.position.x < resourceSite.extents.left then
        resourceSite.extents.left = entity.position.x
    elseif entity.position.x > resourceSite.extents.right then
        resourceSite.extents.right = entity.position.x
    end
    if entity.position.y < resourceSite.extents.top then
        resourceSite.extents.top = entity.position.y
    elseif entity.position.x > resourceSite.extents.bottom then
        resourceSite.extents.bottom = entity.position.y
    end
    ____exports.addOverlayOnResource(nil, entity, playerData)
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
function countDeposits(self, resourceSite, updateCycle)
end
function ____exports.updateUi(self, playerIndex)
end
function ____exports.processOverlayForExistingResourceSite(self, index)
end
function ____exports.createResourceSite(self, playerIndex)
    local player = getPlayer(nil, playerIndex)
    local playerData = getPlayerData(nil, playerIndex)
    if not (player and playerData) then
        return
    end
    local forceData = getForceData(nil, player.force.name)
    local resourceSite = playerData.currentSite
    if not (forceData and resourceSite) then
        Log:debug(
            playerIndex,
            ((("createResourceSite => Either forceData (" .. tostring(forceData)) .. ") or resourceSite (") .. tostring(resourceSite)) .. ") was invalid"
        )
        return
    end
    addResourceSiteToForce(nil, player.force.name, resourceSite)
    ____exports.clearCurrentSite(nil, playerIndex)
    if resourceSite.isSiteExpanding then
        if resourceSite.hasExpanded then
            resourceSite.lastOreCheck = nil
            resourceSite.lastModifiedAmount = nil
            local amountAdded = resourceSite.amount - (resourceSite.originalAmount or 0)
            Log:info(
                playerIndex,
                (("TARM Site expanded - " .. resourceSite.name) .. " - ") .. tostring(amountAdded)
            )
        end
    else
        Log:info(playerIndex, "TARM site submitted - " .. resourceSite.name)
    end
    if resourceSite.isSiteExpanding then
        resourceSite.isSiteExpanding = nil
        resourceSite.hasExpanded = nil
        resourceSite.originalAmount = nil
    end
end
function ____exports.addResource(self, playerIndex, entity)
    local player = getPlayer(nil, playerIndex)
    local playerData = getPlayerData(nil, playerIndex)
    if not (playerData and player) then
        return
    end
    if playerData.currentSite and playerData.currentSite.oreType ~= entity.name then
        if playerData.currentSite.finalizing then
            ____exports.createResourceSite(nil, playerIndex)
        else
            ____exports.clearCurrentSite(nil, playerIndex)
        end
    end
    if not playerData.currentSite then
        playerData.currentSite = {
            isOverlayBeingCreated = false,
            center = {0, 0},
            finalizingSince = 0,
            iterating = nil,
            orePerMinute = 0,
            remainingPerMille = 0,
            addedAt = game.tick,
            surface = entity.surface,
            force = player.force,
            oreType = entity.name,
            oreName = entity.prototype.localised_name,
            amount = 0,
            entityCount = 0,
            etdMinutes = 0,
            extents = {left = entity.position.x, right = entity.position.x, top = entity.position.y, bottom = entity.position.y},
            nextToScan = {},
            entitiesToBeOverlaid = {},
            finalizing = false,
            hasExpanded = false,
            initialAmount = 0,
            isSiteExpanding = false,
            lastModifiedAmount = nil,
            lastOreCheck = nil,
            name = "",
            nextToOverlay = {},
            originalAmount = 0,
            trackedPositionKeys = {}
        }
    end
    if playerData.currentSite.isSiteExpanding then
        playerData.currentSite.hasExpanded = true
        if not playerData.currentSite.originalAmount then
            playerData.currentSite.originalAmount = playerData.currentSite.amount
        end
    end
    ____exports.addSingleEntity(nil, playerIndex, entity)
end
function ____exports.scanResourceSite(self, playerIndex)
    local ____getPlayerData_result_currentSite_2 = getPlayerData(nil, playerIndex)
    if ____getPlayerData_result_currentSite_2 ~= nil then
        ____getPlayerData_result_currentSite_2 = ____getPlayerData_result_currentSite_2.currentSite
    end
    local currentSite = ____getPlayerData_result_currentSite_2
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
                Log:debugAll(("scanResourceSite() => No more resources to scan for site \"" .. currentSite.name) .. "\"!")
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
                if resourceFound and resourceFound.name == currentSite.oreType then
                    ____exports.addSingleEntity(nil, playerIndex, resourceFound)
                end
            end
            i = i + 1
        end
    end
end
function ____exports.finalizeResourceSite(self, playerIndex)
    local player = getPlayer(nil, playerIndex)
    local playerData = getPlayerData(nil, playerIndex)
    if not (player and playerData) then
        return
    end
    local resourceSite = playerData.currentSite
    if not resourceSite then
        return
    end
    resourceSite.finalizing = true
    resourceSite.finalizingSince = game.tick
    resourceSite.initialAmount = resourceSite.amount
    resourceSite.orePerMinute = 0
    resourceSite.remainingPerMille = 1000
    resourceSite.center = findCenter(nil, resourceSite.extents)
    if not resourceSite.isSiteExpanding then
        local surfaceName = ""
        if SettingsData.PrefixSiteWithSurface then
            surfaceName = resourceSite.surface.name .. " "
        end
        resourceSite.name = ((((surfaceName .. resourceSite.name) .. " ") .. getOctantName(nil, resourceSite.center)) .. " ") .. tostring(distance({0, 0}, resourceSite.center))
    end
    local updateCycle = resourceSite.addedAt % SettingsData.TickBetweenChecks
    countDeposits(nil, resourceSite, updateCycle)
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
        elseif not player.connected and playerData.currentSite then
            ____exports.clearCurrentSite(nil, player.index)
        end
        local ____playerData_currentSite_4 = playerData
        if ____playerData_currentSite_4 ~= nil then
            ____playerData_currentSite_4 = ____playerData_currentSite_4.currentSite
        end
        if ____playerData_currentSite_4 then
            local resourceSite = playerData.currentSite
            if #resourceSite.nextToScan > 0 then
                ____exports.scanResourceSite(nil, player.index)
            elseif not resourceSite.finalizing then
                ____exports.finalizeResourceSite(nil, player.index)
            elseif resourceSite.finalizingSince + 120 == event.tick then
                ____exports.createResourceSite(nil, player.index)
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
