--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 3,["9"] = 3,["10"] = 4,["11"] = 4,["12"] = 5,["13"] = 5,["14"] = 28,["15"] = 29,["16"] = 30,["17"] = 31,["18"] = 32,["19"] = 33,["21"] = 35,["22"] = 36,["24"] = 38,["25"] = 28,["26"] = 41,["27"] = 42,["28"] = 42,["29"] = 42,["30"] = 42,["31"] = 41,["32"] = 7,["33"] = 8,["34"] = 9,["37"] = 12,["38"] = 13,["39"] = 14,["41"] = 7,["42"] = 18,["43"] = 19,["44"] = 19,["45"] = 19,["46"] = 20,["47"] = 19,["48"] = 19,["49"] = 18});
local ____exports = {}
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
local getPlayers = ____game.getPlayers
local ____force_2Ddata = require("data.force-data")
local getForceData = ____force_2Ddata.getForceData
local ____log = require("lib.log")
local Log = ____log.default
local ____global_2Ddata = require("data.global-data")
local Global = ____global_2Ddata.default
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
        __TS__ArrayPush(Global.GlobalData.playerData, {overlays = {}, index = playerIndex, guiUpdateTicks = 60, currentSite = nil})
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
