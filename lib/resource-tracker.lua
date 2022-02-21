--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 4,["13"] = 4,["14"] = 5,["15"] = 5,["16"] = 36,["17"] = 37,["18"] = 38,["19"] = 40,["22"] = 44,["23"] = 46,["24"] = 49,["25"] = 49,["26"] = 49,["27"] = 49,["29"] = 36,["30"] = 110,["31"] = 111,["32"] = 112,["35"] = 115,["36"] = 116,["37"] = 117,["40"] = 120,["41"] = 122,["44"] = 126,["45"] = 127,["47"] = 131,["48"] = 132,["49"] = 133,["50"] = 134,["51"] = 137,["52"] = 138,["53"] = 139,["54"] = 140,["56"] = 143,["57"] = 144,["58"] = 145,["59"] = 146,["61"] = 110,["62"] = 7,["63"] = 8,["64"] = 9,["65"] = 10,["68"] = 13,["69"] = 14,["70"] = 16,["71"] = 17,["72"] = 17,["73"] = 17,["74"] = 17,["77"] = 21,["78"] = 21,["79"] = 21,["80"] = 21,["82"] = 21,["83"] = 22,["84"] = 24,["85"] = 25,["86"] = 26,["87"] = 27,["88"] = 28,["89"] = 29,["90"] = 29,["91"] = 29,["92"] = 29,["95"] = 32,["97"] = 7,["98"] = 53,["99"] = 54,["100"] = 55,["101"] = 57,["104"] = 61,["105"] = 62,["106"] = 63,["108"] = 65,["111"] = 69,["112"] = 70,["113"] = 70,["114"] = 70,["115"] = 70,["116"] = 70,["117"] = 70,["118"] = 70,["119"] = 70,["120"] = 70,["121"] = 70,["122"] = 70,["123"] = 70,["124"] = 70,["125"] = 70,["126"] = 70,["127"] = 70,["128"] = 70,["129"] = 70,["130"] = 70,["131"] = 70,["132"] = 70,["133"] = 70,["134"] = 70,["136"] = 100,["137"] = 102,["138"] = 103,["139"] = 104,["142"] = 107,["143"] = 53});
local ____exports = {}
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
local ____player_2Ddata = require("data.player-data")
local getPlayerData = ____player_2Ddata.getPlayerData
local ____force_2Ddata = require("data.force-data")
local addResourceSiteToForce = ____force_2Ddata.addResourceSiteToForce
local getForceData = ____force_2Ddata.getForceData
local ____log = require("lib.log")
local Log = ____log.default
local ____resource_2Dcache = require("lib.resource-cache")
local addEntity = ____resource_2Dcache.addEntity
function ____exports.clearCurrentSite(self, playerIndex)
    local player = getPlayer(nil, playerIndex)
    local playerData = getPlayerData(nil, playerIndex)
    if not (player and playerData) then
        return
    end
    playerData.currentSite = nil
    while playerData.overlays > 0 do
        Log:debug(
            playerIndex,
            String(nil, playerData.overlays)
        )
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
    local trackerCacheIndex = addEntity(nil, entity)
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
    if entity.position.x < resourceSite.extends.left then
        resourceSite.extends.left = entity.position.x
    elseif entity.position.x > resourceSite.extends.right then
        resourceSite.extends.right = entity.position.x
    end
    if entity.position.y < resourceSite.extends.top then
        resourceSite.extends.top = entity.position.y
    elseif entity.position.x > resourceSite.extends.bottom then
        resourceSite.extends.bottom = entity.position.y
    end
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
    local ____addResourceSiteToForce_2 = addResourceSiteToForce
    local ____forceData_name_0 = forceData
    if ____forceData_name_0 ~= nil then
        ____forceData_name_0 = ____forceData_name_0.name
    end
    ____addResourceSiteToForce_2(nil, ____forceData_name_0, resourceSite)
    ____exports.clearCurrentSite(nil, playerIndex)
    if resourceSite.isSiteExpanding then
        if resourceSite.hasExpanded then
            resourceSite.lastOreCheck = nil
            resourceSite.lastModifiedAmount = nil
            local amountAdded = resourceSite.amount - resourceSite.originalAmount
            Log:info(
                playerIndex,
                (("TARM Site expanded - " .. resourceSite.name) .. " - ") .. tostring(amountAdded)
            )
        end
    else
        Log:info(playerIndex, "TARM site submitted - " .. resourceSite.name)
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
            addedAt = game.tick,
            surface = entity.surface,
            force = player.force,
            oreType = entity.name,
            oreName = entity.prototype.localised_name,
            amount = 0,
            entityCount = 0,
            etdMinutes = 0,
            extends = {left = entity.position.x, right = entity.position.x, top = entity.position.y, bottom = entity.position.y},
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
return ____exports
