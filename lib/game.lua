--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
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
