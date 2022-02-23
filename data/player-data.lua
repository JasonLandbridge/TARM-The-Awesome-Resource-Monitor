--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 20,["10"] = 21,["11"] = 22,["12"] = 23,["13"] = 24,["15"] = 26,["16"] = 20,["17"] = 29,["18"] = 30,["19"] = 30,["20"] = 30,["21"] = 30,["22"] = 29,["23"] = 5,["24"] = 6,["25"] = 7,["28"] = 10,["29"] = 11,["30"] = 12,["32"] = 5});
local ____exports = {}
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
local ____force_2Ddata = require("data.force-data")
local getForceData = ____force_2Ddata.getForceData
function ____exports.initForce(self, force)
    local force_data = getForceData(nil, force.name)
    if not force_data then
        GlobalData.forceData[force.name] = {resourceSites = {}}
        return GlobalData.forceData[force.name]
    end
    return force_data
end
function ____exports.getPlayerData(self, playerIndex)
    return __TS__ArrayFind(
        GlobalData.playerData,
        function(____, x) return x.index == playerIndex end
    )
end
function ____exports.initPlayer(self, playerIndex)
    local player = getPlayer(nil, playerIndex)
    if not player then
        return
    end
    ____exports.initForce(nil, player.force)
    if not ____exports.getPlayerData(nil, playerIndex) then
        __TS__ArrayPush(GlobalData.playerData, {overlays = {}, index = playerIndex, guiUpdateTicks = 60, currentSite = nil})
    end
end
return ____exports
