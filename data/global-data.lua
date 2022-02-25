--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 4,["10"] = 4,["11"] = 6,["12"] = 7,["13"] = 8,["14"] = 9,["16"] = 19,["17"] = 20,["19"] = 23,["20"] = 24,["21"] = 25,["22"] = 25,["23"] = 25,["24"] = 25,["25"] = 25,["26"] = 25,["27"] = 25,["28"] = 25,["29"] = 25,["30"] = 26,["31"] = 27,["34"] = 33,["35"] = 34,["37"] = 37,["38"] = 37,["39"] = 37,["40"] = 38,["41"] = 37,["42"] = 37,["43"] = 6,["44"] = 49,["45"] = 50,["46"] = 50,["47"] = 50,["49"] = 50,["50"] = 50,["51"] = 50,["53"] = 50,["54"] = 49,["55"] = 53,["56"] = 54,["57"] = 54,["58"] = 54,["60"] = 54,["61"] = 53});
local ____exports = {}
local ____player_2Ddata = require("data.player-data")
local initPlayer = ____player_2Ddata.initPlayer
local ____game = require("lib.game")
local getPlayers = ____game.getPlayers
local ____log = require("lib.log")
local Log = ____log.default
function ____exports.setupGlobalData(self)
    if not GlobalData then
        Log:debugAll("setupGlobalData => Setting up GlobalData")
        GlobalData = {playerData = {}, forceData = {}, resourceTracker = {trackedEntities = {}, positionCache = {}}}
    end
    if not GlobalData.playerData then
        GlobalData.playerData = {}
    end
    if not GlobalData.forceData then
        GlobalData.forceData = {}
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
    end
    if not GlobalData.resourceTracker then
        GlobalData.resourceTracker = {trackedEntities = {}, positionCache = {}}
    end
    __TS__ArrayForEach(
        getPlayers(nil),
        function(____, value, index)
            initPlayer(nil, index)
        end
    )
end
function ____exports.getTrackingData(self)
    local ____GlobalData_resourceTracker_2 = GlobalData
    if ____GlobalData_resourceTracker_2 ~= nil then
        ____GlobalData_resourceTracker_2 = ____GlobalData_resourceTracker_2.resourceTracker
    end
    local ____GlobalData_resourceTracker_trackedEntities_0 = ____GlobalData_resourceTracker_2
    if ____GlobalData_resourceTracker_trackedEntities_0 ~= nil then
        ____GlobalData_resourceTracker_trackedEntities_0 = ____GlobalData_resourceTracker_trackedEntities_0.trackedEntities
    end
    return ____GlobalData_resourceTracker_trackedEntities_0 or ({})
end
function ____exports.getResourceTracker(self)
    local ____GlobalData_resourceTracker_4 = GlobalData
    if ____GlobalData_resourceTracker_4 ~= nil then
        ____GlobalData_resourceTracker_4 = ____GlobalData_resourceTracker_4.resourceTracker
    end
    return ____GlobalData_resourceTracker_4 or nil
end
return ____exports
