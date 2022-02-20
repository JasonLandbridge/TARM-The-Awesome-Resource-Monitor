--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 2,["7"] = 3,["9"] = 5,["10"] = 1,["11"] = 8,["12"] = 9,["13"] = 8});
local ____exports = {}
function ____exports.getPlayer(self, playerIndex)
    if playerIndex <= 0 then
        return nil
    end
    return game.players[playerIndex]
end
function ____exports.getPlayers(self)
    return game.players
end
return ____exports
