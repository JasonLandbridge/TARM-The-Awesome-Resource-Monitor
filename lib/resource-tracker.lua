--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 269,["6"] = 1,["7"] = 1,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 3,["13"] = 3,["14"] = 4,["15"] = 4,["16"] = 4,["17"] = 5,["18"] = 5,["19"] = 7,["20"] = 7,["21"] = 8,["22"] = 8,["23"] = 8,["24"] = 9,["25"] = 9,["26"] = 9,["27"] = 9,["28"] = 9,["29"] = 10,["30"] = 10,["31"] = 11,["32"] = 11,["33"] = 55,["34"] = 56,["35"] = 57,["36"] = 59,["39"] = 63,["40"] = 66,["41"] = 67,["42"] = 67,["43"] = 67,["46"] = 55,["47"] = 134,["48"] = 135,["49"] = 136,["52"] = 139,["53"] = 140,["54"] = 141,["57"] = 145,["58"] = 146,["59"] = 147,["62"] = 152,["63"] = 152,["64"] = 152,["65"] = 152,["68"] = 156,["69"] = 157,["71"] = 161,["72"] = 162,["73"] = 163,["74"] = 164,["75"] = 167,["76"] = 168,["77"] = 169,["78"] = 170,["80"] = 173,["81"] = 174,["82"] = 175,["83"] = 176,["85"] = 180,["86"] = 134,["87"] = 183,["88"] = 184,["89"] = 185,["90"] = 187,["93"] = 191,["94"] = 192,["95"] = 193,["96"] = 193,["97"] = 193,["98"] = 193,["101"] = 199,["102"] = 200,["103"] = 201,["104"] = 203,["105"] = 183,["106"] = 269,["108"] = 309,["109"] = 309,["110"] = 311,["111"] = 311,["112"] = 18,["113"] = 19,["114"] = 20,["115"] = 21,["118"] = 24,["119"] = 25,["120"] = 27,["121"] = 28,["122"] = 28,["123"] = 28,["124"] = 28,["127"] = 32,["128"] = 33,["129"] = 35,["130"] = 36,["131"] = 37,["132"] = 38,["133"] = 39,["134"] = 40,["135"] = 40,["136"] = 40,["137"] = 40,["140"] = 43,["142"] = 48,["143"] = 49,["144"] = 50,["145"] = 51,["147"] = 18,["148"] = 71,["149"] = 72,["150"] = 73,["151"] = 75,["154"] = 79,["155"] = 80,["156"] = 81,["158"] = 83,["161"] = 87,["162"] = 88,["163"] = 88,["164"] = 88,["165"] = 88,["166"] = 88,["167"] = 88,["168"] = 88,["169"] = 88,["170"] = 88,["171"] = 88,["172"] = 88,["173"] = 88,["174"] = 88,["175"] = 88,["176"] = 88,["177"] = 88,["178"] = 88,["179"] = 88,["180"] = 88,["181"] = 88,["182"] = 88,["183"] = 88,["184"] = 88,["185"] = 88,["186"] = 88,["187"] = 88,["188"] = 88,["189"] = 88,["190"] = 88,["192"] = 124,["193"] = 126,["194"] = 127,["195"] = 128,["198"] = 131,["199"] = 71,["200"] = 206,["201"] = 207,["202"] = 207,["203"] = 207,["205"] = 207,["206"] = 208,["207"] = 209,["210"] = 213,["212"] = 215,["213"] = 215,["214"] = 216,["215"] = 217,["216"] = 218,["219"] = 221,["220"] = 222,["221"] = 224,["222"] = 225,["223"] = 225,["224"] = 225,["225"] = 225,["226"] = 225,["227"] = 226,["228"] = 227,["231"] = 215,["234"] = 206,["235"] = 233,["236"] = 234,["237"] = 235,["238"] = 236,["241"] = 240,["242"] = 241,["245"] = 245,["246"] = 246,["247"] = 247,["248"] = 248,["249"] = 249,["250"] = 250,["251"] = 254,["252"] = 255,["253"] = 256,["254"] = 257,["256"] = 259,["258"] = 265,["259"] = 266,["260"] = 233,["261"] = 271,["262"] = 272,["263"] = 273,["266"] = 277,["267"] = 278,["268"] = 279,["269"] = 280,["270"] = 281,["271"] = 282,["272"] = 283,["273"] = 284,["275"] = 287,["276"] = 287,["277"] = 287,["279"] = 287,["280"] = 288,["281"] = 290,["282"] = 291,["283"] = 292,["284"] = 293,["285"] = 294,["286"] = 295,["288"] = 298,["289"] = 299,["292"] = 303,["293"] = 304,["296"] = 271});
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
