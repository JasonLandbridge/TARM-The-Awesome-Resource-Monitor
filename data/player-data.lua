--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
local getPlayers = ____game.getPlayers
local ____force_2Ddata = require("data.force-data")
local getForceData = ____force_2Ddata.getForceData
local ____log = require("lib.log")
local Log = ____log.default
local ____global_2Dsave_2Ddata = require("data.global-save-data")
local Global = ____global_2Dsave_2Ddata.default
function ____exports.initForce(self, force)
    local force_data = getForceData(nil, force.name)
    if not force_data then
        if not Global.valid then
            Log:errorAll("initForce => Could not initForce due to GlobalData being invalid")
            return nil
        end
        Global.forceData[force.name] = {resourceSites = {}}
        return Global.forceData[force.name]
    end
    return force_data
end
function ____exports.getPlayerData(self, playerIndex)
    return __TS__ArrayFind(
        Global.playerData,
        function(____, x) return x.index == playerIndex end
    ) or nil
end
function ____exports.initPlayer(self, playerIndex)
    local player = getPlayer(nil, playerIndex)
    if not player then
        return
    end
    ____exports.initForce(nil, player.force)
    if not ____exports.getPlayerData(nil, playerIndex) then
        __TS__ArrayPush(Global.GlobalData.playerData, {index = playerIndex, guiUpdateTicks = 60, draftResourceSite = nil})
    end
end
function ____exports.initPlayers(self)
    __TS__ArrayForEach(
        getPlayers(nil),
        function(____, value, index)
            ____exports.initPlayer(nil, index)
        end
    )
end
return ____exports
