--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 5,["10"] = 6,["11"] = 8,["12"] = 8,["13"] = 8,["14"] = 9,["15"] = 8,["16"] = 8,["17"] = 5});
local ____exports = {}
local ____player_2Ddata = require("data.player-data")
local initPlayer = ____player_2Ddata.initPlayer
local ____game = require("lib.game")
local getPlayers = ____game.getPlayers
function ____exports.setupGlobalData(self)
    GlobalData = {playerData = {}, forceData = {}}
    __TS__ArrayForEach(
        getPlayers(nil),
        function(____, value, index)
            initPlayer(nil, index)
        end
    )
end
return ____exports
