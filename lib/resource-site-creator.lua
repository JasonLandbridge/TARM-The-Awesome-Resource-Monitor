--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local countDeposits
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
local ____player_2Ddata = require("data.player-data")
local getPlayerData = ____player_2Ddata.getPlayerData
local ____global_2Dsave_2Ddata = require("data.global-save-data")
local Global = ____global_2Dsave_2Ddata.default
local ____log = require("lib.log")
local Log = ____log.default
local ____force_2Ddata = require("data.force-data")
local addResourceSiteToForce = ____force_2Ddata.addResourceSiteToForce
local getForceData = ____force_2Ddata.getForceData
local ____common = require("lib.common")
local findCenter = ____common.findCenter
local findMajorityResourceEntity = ____common.findMajorityResourceEntity
local findResourceAt = ____common.findResourceAt
local generateGuid = ____common.generateGuid
local getOctantName = ____common.getOctantName
local shiftPosition = ____common.shiftPosition
local ____settings_2Ddata = require("data.settings-data")
local SettingsData = ____settings_2Ddata.default
local ____util = require("util")
local distance = ____util.distance
local ____constants = require("constants.index")
local Entity = ____constants.Entity
local General = ____constants.General
local ____resource_2Dcache = require("lib.resource-cache")
local ResourceCache = ____resource_2Dcache.default
function countDeposits(self, resourceSite, updateCycle)
end
function ____exports.addResourceEntityToDraftResourceSite(self, draftResourceSite, resourceEntity)
    local positionKey = ResourceCache:addResourceEntityToCache(resourceEntity)
    if positionKey and not draftResourceSite.resourceSite.trackedPositionKeys[positionKey] then
        draftResourceSite.resourceSite.trackedPositionKeys[positionKey] = true
        ____exports.addOverlayOnResource(nil, resourceEntity, draftResourceSite)
        ____exports.checkResourceSiteExtents(nil, draftResourceSite.resourceSite, resourceEntity)
        __TS__ArrayPush(draftResourceSite.nextToScan, resourceEntity)
        local ____draftResourceSite_resourceSite_3, ____initialAmount_4 = draftResourceSite.resourceSite, "initialAmount"
        ____draftResourceSite_resourceSite_3[____initialAmount_4] = ____draftResourceSite_resourceSite_3[____initialAmount_4] + resourceEntity.amount
    end
end
function ____exports.checkResourceSiteExtents(self, resourceSite, resourceEntity)
    if resourceEntity.position.x < resourceSite.extents.left then
        resourceSite.extents.left = resourceEntity.position.x
    elseif resourceEntity.position.x > resourceSite.extents.right then
        resourceSite.extents.right = resourceEntity.position.x
    end
    if resourceEntity.position.y < resourceSite.extents.top then
        resourceSite.extents.top = resourceEntity.position.y
    elseif resourceEntity.position.x > resourceSite.extents.bottom then
        resourceSite.extents.bottom = resourceEntity.position.y
    end
end
function ____exports.addOverlayOnResource(self, entity, draftResourceSite)
    local pos = entity.position
    local surface = entity.surface
    local overlayStep = SettingsData.OverlayStep
    if math.floor(pos.x) % overlayStep ~= 0 or math.floor(pos.y) % overlayStep ~= 0 then
        return
    end
    local overlay = surface.create_entity({name = Entity.ResourceManagerOverlay, force = game.forces.neutral, position = pos})
    if not overlay then
        Log:error(
            draftResourceSite.playerIndex,
            (("addOverlayOnResource() => Could not create resource overlay on position x: " .. tostring(pos.x)) .. ", y: ") .. tostring(pos.y)
        )
        return
    end
    overlay.minable = false
    overlay.destructible = false
    overlay.operable = false
    __TS__ArrayPush(draftResourceSite.overlays, overlay)
end
function ____exports.clearDraftResourceSite(self, playerIndex)
    local player = getPlayer(nil, playerIndex)
    local playerData = getPlayerData(nil, playerIndex)
    if not (player and playerData) then
        return
    end
    local draftResourceSite = Global:getDraftResourceSite(playerIndex)
    if not draftResourceSite then
        Log:error(playerIndex, "clearDraftResourceSite() => Could not clear DraftResourceSite as it is undefined already")
        return
    end
    playerData.draftResourceSite = nil
    while #draftResourceSite.overlays > 0 do
        local ____draftResourceSite_overlays_pop_result_destroy_result_5 = table.remove(draftResourceSite.overlays)
        if ____draftResourceSite_overlays_pop_result_destroy_result_5 ~= nil then
            ____draftResourceSite_overlays_pop_result_destroy_result_5 = ____draftResourceSite_overlays_pop_result_destroy_result_5.destroy()
        end
    end
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
        guid = generateGuid(nil),
        center = {0, 0},
        orePerMinute = 0,
        remainingPerMille = 0,
        addedAt = 0,
        surface = event.surface,
        force = player.force,
        oreType = sampleResource.name,
        oreName = sampleResource.prototype.localised_name,
        totalAmount = 0,
        entityCount = 0,
        etdMinutes = 0,
        extents = {left = 0, right = 0, top = 0, bottom = 0},
        initialAmount = 0,
        lastModifiedAmount = nil,
        lastOreCheck = nil,
        name = "",
        trackedPositionKeys = {}
    }
    local draftResourceSite = {
        playerIndex = playerIndex,
        overlays = {},
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
    for ____, resourceEntity in ipairs(sameResourceEntities) do
        ____exports.addResourceEntityToDraftResourceSite(nil, draftResourceSite, resourceEntity)
    end
    Global:setDraftResourceSite(playerIndex, draftResourceSite)
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
            local ____x_name_2 = x.name
            local ____draftResourceSite_resourceSite_oreType_0 = draftResourceSite
            if ____draftResourceSite_resourceSite_oreType_0 ~= nil then
                ____draftResourceSite_resourceSite_oreType_0 = ____draftResourceSite_resourceSite_oreType_0.resourceSite.oreType
            end
            return ____x_name_2 == ____draftResourceSite_resourceSite_oreType_0
        end
    )
    draftResourceSite.resourceEntities = __TS__ArrayConcat(draftResourceSite.resourceEntities, sameResourceEntities)
    for ____, resourceEntity in ipairs(sameResourceEntities) do
        ____exports.addResourceEntityToDraftResourceSite(nil, draftResourceSite, resourceEntity)
    end
    Global:setDraftResourceSite(playerIndex, draftResourceSite)
end
function ____exports.finalizeResourceSite(self, playerIndex)
    local draftResourceSite = Global:getDraftResourceSite(playerIndex)
    if not draftResourceSite then
        return
    end
    draftResourceSite.finalizing = true
    draftResourceSite.finalizingSince = game.tick
    local resourceSite = draftResourceSite.resourceSite
    resourceSite.entityCount = #__TS__ObjectKeys(resourceSite.trackedPositionKeys)
    resourceSite.totalAmount = resourceSite.initialAmount
    resourceSite.orePerMinute = 0
    resourceSite.remainingPerMille = 1000
    resourceSite.center = findCenter(nil, resourceSite.extents)
    if not draftResourceSite.isSiteExpanding then
        local surfaceName = ""
        if SettingsData.PrefixSiteWithSurface then
            surfaceName = resourceSite.surface.name .. " "
        end
        resourceSite.name = ((((surfaceName .. resourceSite.name) .. " ") .. getOctantName(nil, resourceSite.center)) .. " ") .. tostring(distance({0, 0}, resourceSite.center))
    end
    local updateCycle = resourceSite.addedAt % SettingsData.TickBetweenChecks
    countDeposits(nil, resourceSite, updateCycle)
end
function ____exports.registerResourceSite(self, playerIndex)
    local player = getPlayer(nil, playerIndex)
    if not player then
        return
    end
    local draftResourceSite = Global:getDraftResourceSite(playerIndex)
    if not draftResourceSite then
        Log:error(playerIndex, "registerResourceSite() => Could not retrieve the draftResourceSite for registration.")
        return
    end
    local forceData = getForceData(nil, player.force.name)
    local resourceSite = draftResourceSite.resourceSite
    resourceSite.addedAt = game.tick
    if not (forceData and resourceSite) then
        Log:debug(
            playerIndex,
            ((("createResourceSite => Either forceData (" .. tostring(forceData)) .. ") or resourceSite (") .. tostring(resourceSite)) .. ") was invalid"
        )
        return
    end
    addResourceSiteToForce(nil, player.force.name, resourceSite)
    if draftResourceSite.isSiteExpanding then
        if draftResourceSite.hasExpanded then
            resourceSite.lastOreCheck = nil
            resourceSite.lastModifiedAmount = nil
            Log:info(playerIndex, (("TARM Site expanded - " .. resourceSite.name) .. " - ") .. 0)
        end
    else
        Log:info(playerIndex, "TARM site submitted - " .. resourceSite.name)
    end
    if draftResourceSite.isSiteExpanding then
        draftResourceSite.isSiteExpanding = nil
        draftResourceSite.hasExpanded = nil
    end
    ____exports.clearDraftResourceSite(nil, playerIndex)
end
function ____exports.scanResourceSite(self, playerIndex)
    local draftResourceSite = Global:getDraftResourceSite(playerIndex)
    if not draftResourceSite then
        Log:errorAll("scanResourceSite() => Could not retrieve the draftResourceSite with playerIndex: " .. tostring(playerIndex))
        return
    end
    local toScan = math.min(10, #draftResourceSite.nextToScan)
    do
        local i = 0
        while i < toScan do
            local entity = __TS__ArrayShift(draftResourceSite.nextToScan)
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
                if resourceFound and resourceFound.name == draftResourceSite.resourceSite.oreType then
                    ____exports.addResourceEntityToDraftResourceSite(nil, draftResourceSite, resourceFound)
                end
            end
            i = i + 1
        end
    end
end
return ____exports
