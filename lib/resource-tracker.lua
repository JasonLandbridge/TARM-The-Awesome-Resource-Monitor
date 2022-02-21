--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 4,["13"] = 4,["14"] = 5,["15"] = 5,["16"] = 7,["17"] = 7,["18"] = 8,["19"] = 8,["20"] = 52,["21"] = 53,["22"] = 54,["23"] = 56,["26"] = 60,["27"] = 63,["28"] = 64,["29"] = 64,["30"] = 64,["33"] = 52,["34"] = 125,["35"] = 126,["36"] = 127,["39"] = 130,["40"] = 131,["41"] = 132,["44"] = 135,["45"] = 137,["48"] = 141,["49"] = 142,["51"] = 146,["52"] = 147,["53"] = 148,["54"] = 149,["55"] = 152,["56"] = 153,["57"] = 154,["58"] = 155,["60"] = 158,["61"] = 159,["62"] = 160,["63"] = 161,["65"] = 165,["66"] = 125,["67"] = 168,["68"] = 169,["69"] = 170,["70"] = 172,["73"] = 176,["74"] = 177,["75"] = 178,["76"] = 178,["77"] = 178,["78"] = 178,["81"] = 184,["82"] = 185,["83"] = 186,["84"] = 188,["85"] = 168,["86"] = 15,["87"] = 16,["88"] = 17,["89"] = 18,["92"] = 21,["93"] = 22,["94"] = 24,["95"] = 25,["96"] = 25,["97"] = 25,["98"] = 25,["101"] = 29,["102"] = 29,["103"] = 29,["104"] = 29,["106"] = 29,["107"] = 30,["108"] = 32,["109"] = 33,["110"] = 34,["111"] = 35,["112"] = 36,["113"] = 37,["114"] = 37,["115"] = 37,["116"] = 37,["119"] = 40,["121"] = 45,["122"] = 46,["123"] = 47,["124"] = 48,["126"] = 15,["127"] = 68,["128"] = 69,["129"] = 70,["130"] = 72,["133"] = 76,["134"] = 77,["135"] = 78,["137"] = 80,["140"] = 84,["141"] = 85,["142"] = 85,["143"] = 85,["144"] = 85,["145"] = 85,["146"] = 85,["147"] = 85,["148"] = 85,["149"] = 85,["150"] = 85,["151"] = 85,["152"] = 85,["153"] = 85,["154"] = 85,["155"] = 85,["156"] = 85,["157"] = 85,["158"] = 85,["159"] = 85,["160"] = 85,["161"] = 85,["162"] = 85,["163"] = 85,["165"] = 115,["166"] = 117,["167"] = 118,["168"] = 119,["171"] = 122,["172"] = 68});
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
local ____settings_2Ddata = require("data.settings-data")
local SettingsData = ____settings_2Ddata.default
local ____constants = require("constants.index")
local Entity = ____constants.Entity
function ____exports.clearCurrentSite(self, playerIndex)
    local player = getPlayer(nil, playerIndex)
    local playerData = getPlayerData(nil, playerIndex)
    if not (player and playerData) then
        return
    end
    playerData.currentSite = nil
    while #playerData.overlays > 0 do
        local ____playerData_overlays_pop_result_destroy_result_3 = table.remove(playerData.overlays)
        if ____playerData_overlays_pop_result_destroy_result_3 ~= nil then
            ____playerData_overlays_pop_result_destroy_result_3 = ____playerData_overlays_pop_result_destroy_result_3.destroy()
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
