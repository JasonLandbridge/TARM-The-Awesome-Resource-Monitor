--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 4,["13"] = 4,["14"] = 5,["15"] = 5,["16"] = 7,["17"] = 7,["18"] = 8,["19"] = 8,["20"] = 39,["21"] = 40,["22"] = 41,["23"] = 43,["26"] = 47,["27"] = 50,["28"] = 51,["29"] = 51,["30"] = 51,["33"] = 39,["34"] = 112,["35"] = 113,["36"] = 114,["39"] = 117,["40"] = 118,["41"] = 119,["44"] = 122,["45"] = 124,["48"] = 128,["49"] = 129,["51"] = 133,["52"] = 134,["53"] = 135,["54"] = 136,["55"] = 139,["56"] = 140,["57"] = 141,["58"] = 142,["60"] = 145,["61"] = 146,["62"] = 147,["63"] = 148,["65"] = 152,["66"] = 112,["67"] = 155,["68"] = 156,["69"] = 157,["70"] = 159,["73"] = 163,["74"] = 164,["75"] = 165,["76"] = 165,["77"] = 165,["78"] = 165,["81"] = 171,["82"] = 172,["83"] = 173,["84"] = 175,["85"] = 155,["86"] = 10,["87"] = 11,["88"] = 12,["89"] = 13,["92"] = 16,["93"] = 17,["94"] = 19,["95"] = 20,["96"] = 20,["97"] = 20,["98"] = 20,["101"] = 24,["102"] = 24,["103"] = 24,["104"] = 24,["106"] = 24,["107"] = 25,["108"] = 27,["109"] = 28,["110"] = 29,["111"] = 30,["112"] = 31,["113"] = 32,["114"] = 32,["115"] = 32,["116"] = 32,["119"] = 35,["121"] = 10,["122"] = 55,["123"] = 56,["124"] = 57,["125"] = 59,["128"] = 63,["129"] = 64,["130"] = 65,["132"] = 67,["135"] = 71,["136"] = 72,["137"] = 72,["138"] = 72,["139"] = 72,["140"] = 72,["141"] = 72,["142"] = 72,["143"] = 72,["144"] = 72,["145"] = 72,["146"] = 72,["147"] = 72,["148"] = 72,["149"] = 72,["150"] = 72,["151"] = 72,["152"] = 72,["153"] = 72,["154"] = 72,["155"] = 72,["156"] = 72,["157"] = 72,["158"] = 72,["160"] = 102,["161"] = 104,["162"] = 105,["163"] = 106,["166"] = 109,["167"] = 55});
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
