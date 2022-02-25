--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 260,["6"] = 1,["7"] = 1,["8"] = 1,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 3,["15"] = 4,["16"] = 4,["17"] = 5,["18"] = 5,["19"] = 7,["20"] = 7,["21"] = 8,["22"] = 8,["23"] = 8,["24"] = 9,["25"] = 9,["26"] = 9,["27"] = 9,["28"] = 9,["29"] = 10,["30"] = 10,["31"] = 54,["32"] = 55,["33"] = 56,["34"] = 58,["37"] = 62,["38"] = 65,["39"] = 66,["40"] = 66,["41"] = 66,["44"] = 54,["45"] = 133,["46"] = 134,["47"] = 135,["50"] = 138,["51"] = 139,["52"] = 140,["55"] = 143,["56"] = 145,["59"] = 149,["60"] = 150,["62"] = 154,["63"] = 155,["64"] = 156,["65"] = 157,["66"] = 160,["67"] = 161,["68"] = 162,["69"] = 163,["71"] = 166,["72"] = 167,["73"] = 168,["74"] = 169,["76"] = 173,["77"] = 133,["78"] = 176,["79"] = 177,["80"] = 178,["81"] = 180,["84"] = 184,["85"] = 185,["86"] = 186,["87"] = 186,["88"] = 186,["89"] = 186,["92"] = 192,["93"] = 193,["94"] = 194,["95"] = 196,["96"] = 176,["97"] = 260,["99"] = 298,["100"] = 298,["101"] = 300,["102"] = 300,["103"] = 17,["104"] = 18,["105"] = 19,["106"] = 20,["109"] = 23,["110"] = 24,["111"] = 26,["112"] = 27,["113"] = 27,["114"] = 27,["115"] = 27,["118"] = 31,["119"] = 32,["120"] = 34,["121"] = 35,["122"] = 36,["123"] = 37,["124"] = 38,["125"] = 39,["126"] = 39,["127"] = 39,["128"] = 39,["131"] = 42,["133"] = 47,["134"] = 48,["135"] = 49,["136"] = 50,["138"] = 17,["139"] = 70,["140"] = 71,["141"] = 72,["142"] = 74,["145"] = 78,["146"] = 79,["147"] = 80,["149"] = 82,["152"] = 86,["153"] = 87,["154"] = 87,["155"] = 87,["156"] = 87,["157"] = 87,["158"] = 87,["159"] = 87,["160"] = 87,["161"] = 87,["162"] = 87,["163"] = 87,["164"] = 87,["165"] = 87,["166"] = 87,["167"] = 87,["168"] = 87,["169"] = 87,["170"] = 87,["171"] = 87,["172"] = 87,["173"] = 87,["174"] = 87,["175"] = 87,["176"] = 87,["177"] = 87,["178"] = 87,["179"] = 87,["180"] = 87,["181"] = 87,["183"] = 123,["184"] = 125,["185"] = 126,["186"] = 127,["189"] = 130,["190"] = 70,["191"] = 199,["192"] = 200,["193"] = 200,["194"] = 200,["196"] = 200,["197"] = 201,["200"] = 205,["202"] = 207,["203"] = 207,["205"] = 208,["206"] = 209,["207"] = 210,["209"] = 212,["210"] = 213,["211"] = 215,["212"] = 216,["213"] = 216,["214"] = 216,["215"] = 216,["216"] = 216,["217"] = 217,["218"] = 218,["223"] = 207,["226"] = 199,["227"] = 224,["228"] = 225,["229"] = 226,["230"] = 227,["233"] = 231,["234"] = 232,["237"] = 236,["238"] = 237,["239"] = 238,["240"] = 239,["241"] = 240,["242"] = 241,["243"] = 245,["244"] = 246,["245"] = 247,["246"] = 248,["248"] = 250,["250"] = 256,["251"] = 257,["252"] = 224,["253"] = 262,["254"] = 263,["257"] = 267,["258"] = 268,["259"] = 269,["260"] = 270,["261"] = 271,["262"] = 272,["263"] = 273,["265"] = 276,["266"] = 276,["267"] = 276,["269"] = 276,["270"] = 277,["271"] = 279,["272"] = 280,["273"] = 281,["274"] = 282,["275"] = 283,["276"] = 284,["278"] = 287,["279"] = 288,["282"] = 292,["283"] = 293,["286"] = 262});
local ____exports = {}
local countDeposits
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
local getPlayers = ____game.getPlayers
local ____player_2Ddata = require("data.player-data")
local getPlayerData = ____player_2Ddata.getPlayerData
local initPlayer = ____player_2Ddata.initPlayer
local ____force_2Ddata = require("data.force-data")
local addResourceSiteToForce = ____force_2Ddata.addResourceSiteToForce
local getForceData = ____force_2Ddata.getForceData
local ____log = require("lib.log")
local Log = ____log.default
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
    local trackerCacheIndex = ResourceCache:addEntity(entity)
    if resourceSite.trackerIndices[trackerCacheIndex + 1] then
        return
    end
    if resourceSite.finalizing then
        resourceSite.finalizing = false
    end
    resourceSite.trackerIndices[trackerCacheIndex + 1] = true
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
            trackerIndices = {}
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
        return
    end
    local toScan = math.min(30, #currentSite.nextToScan)
    do
        local i = 1
        while toScan do
            do
                local entity = table.remove(currentSite.nextToScan)
                if not entity then
                    goto __continue34
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
            end
            ::__continue34::
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
    for ____, player in ipairs(getPlayers(nil)) do
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
