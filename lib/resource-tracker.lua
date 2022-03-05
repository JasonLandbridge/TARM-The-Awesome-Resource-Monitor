--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____log = require("lib.log")
local Log = ____log.default
local ____game = require("lib.game")
local getPlayers = ____game.getPlayers
local ____player_2Ddata = require("data.player-data")
local getPlayerData = ____player_2Ddata.getPlayerData
local initPlayer = ____player_2Ddata.initPlayer
local ____global_2Dsave_2Ddata = require("data.global-save-data")
local Global = ____global_2Dsave_2Ddata.default
local ____resource_2Dsite_2Dcreator = require("lib.resource-site-creator")
local clearDraftResourceSite = ____resource_2Dsite_2Dcreator.clearDraftResourceSite
local finalizeResourceSite = ____resource_2Dsite_2Dcreator.finalizeResourceSite
local registerResourceSite = ____resource_2Dsite_2Dcreator.registerResourceSite
local scanResourceSite = ____resource_2Dsite_2Dcreator.scanResourceSite
function ____exports.updateUi(self, playerIndex)
end
function ____exports.processOverlayForExistingResourceSite(self, index)
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
            clearDraftResourceSite(nil, player.index)
        end
        local ____playerData_draftResourceSite_0 = playerData
        if ____playerData_draftResourceSite_0 ~= nil then
            ____playerData_draftResourceSite_0 = ____playerData_draftResourceSite_0.draftResourceSite
        end
        if ____playerData_draftResourceSite_0 then
            local resourceSite = playerData.draftResourceSite
            if #resourceSite.nextToScan > 0 then
                scanResourceSite(nil, player.index)
            elseif not resourceSite.finalizing then
                finalizeResourceSite(nil, player.index)
            elseif resourceSite.finalizingSince + 120 == event.tick then
                registerResourceSite(nil, player.index)
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
