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
local ____resource_2Dcache = require("lib.resource-cache")
local ResourceCache = ____resource_2Dcache.default
local ____settings_2Ddata = require("data.settings-data")
local SettingsData = ____settings_2Ddata.default
local ____constants = require("constants.index")
local Entity = ____constants.Entity
local General = ____constants.General
local ____common = require("lib.common")
local findResourceAt = ____common.findResourceAt
local shiftPosition = ____common.shiftPosition
local sum = ____common.sum
local ____global_2Dsave_2Ddata = require("data.global-save-data")
local Global = ____global_2Dsave_2Ddata.default
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
function ____exports.addSingleResourceEntityToResourceDraft(self, draftResourceSite, resourceEntity)
    local positionKey = ResourceCache:addResourceEntityToCache(resourceEntity)
    if positionKey and not draftResourceSite.resourceSite.trackedPositionKeys[positionKey] then
        draftResourceSite.resourceSite.trackedPositionKeys[positionKey] = true
        ____exports.addOverlayOnResource(nil, resourceEntity, draftResourceSite)
        ____exports.checkResourceSiteExtents(nil, draftResourceSite.resourceSite, resourceEntity)
        __TS__ArrayPush(draftResourceSite.nextToScan, resourceEntity)
    end
end
function ____exports.updateUi(self, playerIndex)
end
function ____exports.processOverlayForExistingResourceSite(self, index)
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
        local ____draftResourceSite_overlays_pop_result_destroy_result_0 = table.remove(draftResourceSite.overlays)
        if ____draftResourceSite_overlays_pop_result_destroy_result_0 ~= nil then
            ____draftResourceSite_overlays_pop_result_destroy_result_0 = ____draftResourceSite_overlays_pop_result_destroy_result_0.destroy()
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
        ____exports.addSingleResourceEntityToResourceDraft(nil, draftResourceSite, resourceEntity)
    end
    resourceSite.totalAmount = sum(
        nil,
        __TS__ArrayMap(
            sameResourceEntities,
            function(____, x) return x.amount end
        )
    )
    resourceSite.initialAmount = resourceSite.totalAmount
    resourceSite.entityCount = #__TS__ObjectKeys(resourceSite.trackedPositionKeys)
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
            local ____x_name_4 = x.name
            local ____draftResourceSite_resourceSite_oreType_2 = draftResourceSite
            if ____draftResourceSite_resourceSite_oreType_2 ~= nil then
                ____draftResourceSite_resourceSite_oreType_2 = ____draftResourceSite_resourceSite_oreType_2.resourceSite.oreType
            end
            return ____x_name_4 == ____draftResourceSite_resourceSite_oreType_2
        end
    )
    draftResourceSite.resourceEntities = __TS__ArrayConcat(draftResourceSite.resourceEntities, sameResourceEntities)
    local resourceSite = draftResourceSite.resourceSite
    for ____, resourceEntity in ipairs(sameResourceEntities) do
        ____exports.addSingleResourceEntityToResourceDraft(nil, draftResourceSite, resourceEntity)
    end
    resourceSite.totalAmount = resourceSite.totalAmount + sum(
        nil,
        __TS__ArrayMap(
            sameResourceEntities,
            function(____, x) return x.amount end
        )
    )
    resourceSite.initialAmount = resourceSite.totalAmount
    resourceSite.entityCount = #__TS__ObjectKeys(resourceSite.trackedPositionKeys)
    Global:setDraftResourceSite(playerIndex, draftResourceSite)
end
function ____exports.registerResourceSite(self, resourceSite)
end
function ____exports.scanResourceSite(self, playerIndex)
    local draftResourceSite = Global:getDraftResourceSite(playerIndex)
    if not draftResourceSite then
        Log:errorAll("scanResourceSite() => Could not retrieve the draftResourceSite with playerIndex: " .. tostring(playerIndex))
        return
    end
    local toScan = math.min(30, #draftResourceSite.nextToScan)
    do
        local i = 1
        while toScan do
            local entity = table.remove(draftResourceSite.nextToScan)
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
                    ____exports.addSingleResourceEntityToResourceDraft(nil, draftResourceSite, resourceFound)
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
            ____exports.clearDraftResourceSite(nil, player.index)
        end
        local ____playerData_draftResourceSite_5 = playerData
        if ____playerData_draftResourceSite_5 ~= nil then
            ____playerData_draftResourceSite_5 = ____playerData_draftResourceSite_5.draftResourceSite
        end
        if ____playerData_draftResourceSite_5 then
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
