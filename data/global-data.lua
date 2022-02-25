--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 4,["10"] = 4,["11"] = 6,["12"] = 7,["13"] = 8,["14"] = 9,["15"] = 9,["16"] = 9,["17"] = 12,["18"] = 12,["19"] = 12,["20"] = 9,["21"] = 9,["23"] = 19,["24"] = 20,["26"] = 23,["27"] = 24,["28"] = 25,["29"] = 25,["30"] = 25,["31"] = 25,["32"] = 25,["33"] = 25,["34"] = 25,["35"] = 25,["36"] = 25,["37"] = 26,["38"] = 27,["41"] = 33,["42"] = 34,["43"] = 34,["44"] = 34,["45"] = 34,["47"] = 37,["48"] = 37,["49"] = 37,["50"] = 38,["51"] = 37,["52"] = 37,["53"] = 6,["54"] = 49,["55"] = 50,["56"] = 50,["57"] = 50,["59"] = 50,["60"] = 50,["61"] = 50,["63"] = 50,["64"] = 50,["65"] = 50,["67"] = 50,["68"] = 49,["69"] = 53,["70"] = 54,["71"] = 54,["72"] = 54,["74"] = 54,["75"] = 54,["76"] = 54,["78"] = 54,["79"] = 53});
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
        GlobalData = {
            playerData = {},
            forceData = {},
            resourceTracker = {
                trackedEntities = __TS__New(Map),
                positionCache = __TS__New(Map)
            }
        }
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
        GlobalData.resourceTracker = {
            trackedEntities = __TS__New(Map),
            positionCache = __TS__New(Map)
        }
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
    local ____GlobalData_resourceTracker_trackedEntities_0_4 = ____GlobalData_resourceTracker_trackedEntities_0
    if ____GlobalData_resourceTracker_trackedEntities_0_4 == nil then
        ____GlobalData_resourceTracker_trackedEntities_0_4 = __TS__New(Map)
    end
    return ____GlobalData_resourceTracker_trackedEntities_0_4
end
function ____exports.getResourceTracker(self)
    local ____GlobalData_resourceTracker_5 = GlobalData
    if ____GlobalData_resourceTracker_5 ~= nil then
        ____GlobalData_resourceTracker_5 = ____GlobalData_resourceTracker_5.resourceTracker
    end
    local ____GlobalData_resourceTracker_5_7 = ____GlobalData_resourceTracker_5
    if ____GlobalData_resourceTracker_5_7 == nil then
        ____GlobalData_resourceTracker_5_7 = nil
    end
    return ____GlobalData_resourceTracker_5_7
end
return ____exports
