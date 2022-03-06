--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
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
local ____settings_2Ddata = require("data.settings-data")
local SettingsData = ____settings_2Ddata.default
____exports.ResourceTracker = __TS__Class()
local ResourceTracker = ____exports.ResourceTracker
ResourceTracker.name = "ResourceTracker"
function ResourceTracker.prototype.____constructor(self)
end
function ResourceTracker.prototype.OnTick(self, event)
    local forceKeys = __TS__ObjectKeys(Global.forceData)
    local ticksBetweenChecks = SettingsData.TickBetweenChecks
    local currentTick = event.tick
    for ____, forceKey in ipairs(forceKeys) do
        local resourceSites = Global.forceData[forceKey].resourceSites
        for ____, resourceSite in __TS__Iterator(resourceSites) do
            if currentTick - resourceSite.lastResourceCheckTick > ticksBetweenChecks then
                local totalAmount = 0
                for ____, ____value in ipairs(__TS__ObjectEntries(resourceSite.trackedPositionKeys)) do
                    local key = ____value[1]
                    local value = ____value[2]
                    totalAmount = totalAmount + Global.trackedResources[key].resourceAmount
                end
                resourceSite.totalAmount = totalAmount
            end
        end
    end
end
function ResourceTracker.prototype.updateResourceAmounts(self)
    local cacheIteration = Global.cacheIteration
    if not cacheIteration then
        return
    end
    if not cacheIteration.force then
    end
    do
        local i = 0
        while i < 50 do
            i = i + 1
        end
    end
end
function ResourceTracker.prototype.updatePlayers(self, event)
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
                self:processOverlayForExistingResourceSite(player.index)
            end
        end
        if playerData and event.tick % playerData.guiUpdateTicks == 15 + player.index then
            self:updateUi(player.index)
        end
    end
end
function ResourceTracker.prototype.updateUi(self, playerIndex)
end
function ResourceTracker.prototype.processOverlayForExistingResourceSite(self, index)
end
local resourceCache = __TS__New(____exports.ResourceTracker)
____exports.default = resourceCache
return ____exports
