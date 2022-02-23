--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 4,["10"] = 5,["11"] = 14,["12"] = 14,["13"] = 14,["14"] = 14,["15"] = 14,["16"] = 14,["17"] = 14,["18"] = 14,["19"] = 14,["20"] = 15,["21"] = 16,["23"] = 21,["24"] = 21,["25"] = 21,["26"] = 22,["27"] = 21,["28"] = 21,["29"] = 4});
local ____exports = {}
local ____player_2Ddata = require("data.player-data")
local initPlayer = ____player_2Ddata.initPlayer
local ____game = require("lib.game")
local getPlayers = ____game.getPlayers
function ____exports.setupGlobalData(self)
    GlobalData = {playerData = {}, forceData = {}, resourceTracker = {entities = {}, positionCache = {}}}
    local forces = {
        "player",
        "enemy",
        "neutral",
        "conquest",
        "ignore",
        "capture",
        "friendly"
    }
    for ____, force in ipairs(forces) do
        GlobalData.forceData[force] = {resourceSites = {}}
    end
    __TS__ArrayForEach(
        getPlayers(nil),
        function(____, value, index)
            initPlayer(nil, index)
        end
    )
end
return ____exports
