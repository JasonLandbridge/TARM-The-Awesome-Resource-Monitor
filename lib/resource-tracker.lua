--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 268,["6"] = 1,["7"] = 1,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 3,["13"] = 3,["14"] = 4,["15"] = 4,["16"] = 4,["17"] = 5,["18"] = 5,["19"] = 7,["20"] = 7,["21"] = 8,["22"] = 8,["23"] = 8,["24"] = 9,["25"] = 9,["26"] = 9,["27"] = 9,["28"] = 9,["29"] = 10,["30"] = 10,["31"] = 54,["32"] = 55,["33"] = 56,["34"] = 58,["37"] = 62,["38"] = 65,["39"] = 66,["40"] = 66,["41"] = 66,["44"] = 54,["45"] = 133,["46"] = 134,["47"] = 135,["50"] = 138,["51"] = 139,["52"] = 140,["55"] = 144,["56"] = 145,["57"] = 146,["60"] = 151,["61"] = 151,["62"] = 151,["63"] = 151,["66"] = 155,["67"] = 156,["69"] = 160,["70"] = 161,["71"] = 162,["72"] = 163,["73"] = 166,["74"] = 167,["75"] = 168,["76"] = 169,["78"] = 172,["79"] = 173,["80"] = 174,["81"] = 175,["83"] = 179,["84"] = 133,["85"] = 182,["86"] = 183,["87"] = 184,["88"] = 186,["91"] = 190,["92"] = 191,["93"] = 192,["94"] = 192,["95"] = 192,["96"] = 192,["99"] = 198,["100"] = 199,["101"] = 200,["102"] = 202,["103"] = 182,["104"] = 268,["106"] = 307,["107"] = 307,["108"] = 309,["109"] = 309,["110"] = 17,["111"] = 18,["112"] = 19,["113"] = 20,["116"] = 23,["117"] = 24,["118"] = 26,["119"] = 27,["120"] = 27,["121"] = 27,["122"] = 27,["125"] = 31,["126"] = 32,["127"] = 34,["128"] = 35,["129"] = 36,["130"] = 37,["131"] = 38,["132"] = 39,["133"] = 39,["134"] = 39,["135"] = 39,["138"] = 42,["140"] = 47,["141"] = 48,["142"] = 49,["143"] = 50,["145"] = 17,["146"] = 70,["147"] = 71,["148"] = 72,["149"] = 74,["152"] = 78,["153"] = 79,["154"] = 80,["156"] = 82,["159"] = 86,["160"] = 87,["161"] = 87,["162"] = 87,["163"] = 87,["164"] = 87,["165"] = 87,["166"] = 87,["167"] = 87,["168"] = 87,["169"] = 87,["170"] = 87,["171"] = 87,["172"] = 87,["173"] = 87,["174"] = 87,["175"] = 87,["176"] = 87,["177"] = 87,["178"] = 87,["179"] = 87,["180"] = 87,["181"] = 87,["182"] = 87,["183"] = 87,["184"] = 87,["185"] = 87,["186"] = 87,["187"] = 87,["188"] = 87,["190"] = 123,["191"] = 125,["192"] = 126,["193"] = 127,["196"] = 130,["197"] = 70,["198"] = 205,["199"] = 206,["200"] = 206,["201"] = 206,["203"] = 206,["204"] = 207,["205"] = 208,["208"] = 212,["210"] = 214,["211"] = 214,["212"] = 215,["213"] = 216,["214"] = 217,["217"] = 220,["218"] = 221,["219"] = 223,["220"] = 224,["221"] = 224,["222"] = 224,["223"] = 224,["224"] = 224,["225"] = 225,["226"] = 226,["229"] = 214,["232"] = 205,["233"] = 232,["234"] = 233,["235"] = 234,["236"] = 235,["239"] = 239,["240"] = 240,["243"] = 244,["244"] = 245,["245"] = 246,["246"] = 247,["247"] = 248,["248"] = 249,["249"] = 253,["250"] = 254,["251"] = 255,["252"] = 256,["254"] = 258,["256"] = 264,["257"] = 265,["258"] = 232,["259"] = 270,["260"] = 271,["263"] = 275,["264"] = 276,["265"] = 277,["266"] = 278,["267"] = 279,["268"] = 280,["269"] = 281,["270"] = 282,["272"] = 285,["273"] = 285,["274"] = 285,["276"] = 285,["277"] = 286,["278"] = 288,["279"] = 289,["280"] = 290,["281"] = 291,["282"] = 292,["283"] = 293,["285"] = 296,["286"] = 297,["289"] = 301,["290"] = 302,["293"] = 270});
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
    if not GlobalData or not GlobalData.playerData then
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
