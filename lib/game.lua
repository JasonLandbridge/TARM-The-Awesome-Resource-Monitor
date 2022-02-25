--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 8,["6"] = 9,["7"] = 11,["8"] = 12,["10"] = 15,["11"] = 8,["12"] = 1,["13"] = 2,["14"] = 2,["15"] = 2,["16"] = 2,["17"] = 1});
local ____exports = {}
function ____exports.getPlayers(self)
    local players = {}
    for index, player in pairs(game.players) do
        __TS__ArrayPush(players, player)
    end
    return players
end
function ____exports.getPlayer(self, playerIndex)
    return __TS__ArrayFind(
        ____exports.getPlayers(nil),
        function(____, x) return x.index == playerIndex end
    )
end
return ____exports
