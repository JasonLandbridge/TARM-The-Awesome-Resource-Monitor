--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 19,["8"] = 20,["9"] = 20,["10"] = 20,["11"] = 20,["12"] = 21,["13"] = 22,["14"] = 23,["16"] = 25,["17"] = 19,["18"] = 28,["19"] = 29,["20"] = 29,["21"] = 29,["22"] = 29,["23"] = 28,["24"] = 4,["25"] = 5,["26"] = 6,["29"] = 9,["30"] = 10,["31"] = 11,["33"] = 4});
local ____exports = {}
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
function ____exports.initForce(self, force)
    local force_data = __TS__ArrayFind(
        GlobalData.forceData,
        function(____, x) return x.name == force.name end
    )
    if not force_data then
        __TS__ArrayPush(GlobalData.forceData, {name = force.name, resourceSites = {}})
        force_data = GlobalData.forceData[#GlobalData.forceData]
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
        __TS__ArrayPush(GlobalData.playerData, {index = playerIndex, guiUpdateTicks = 60})
    end
end
return ____exports
