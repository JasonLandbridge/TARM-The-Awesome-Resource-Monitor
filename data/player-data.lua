--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 4,["10"] = 4,["11"] = 21,["12"] = 22,["13"] = 23,["14"] = 24,["15"] = 25,["16"] = 26,["18"] = 28,["19"] = 29,["21"] = 31,["22"] = 21,["23"] = 34,["24"] = 35,["25"] = 35,["26"] = 35,["28"] = 35,["29"] = 35,["30"] = 35,["32"] = 35,["33"] = 34,["34"] = 6,["35"] = 7,["36"] = 8,["39"] = 11,["40"] = 12,["41"] = 13,["43"] = 6});
local ____exports = {}
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
local ____force_2Ddata = require("data.force-data")
local getForceData = ____force_2Ddata.getForceData
local ____log = require("lib.log")
local Log = ____log.default
function ____exports.initForce(self, force)
    local force_data = getForceData(nil, force.name)
    if not force_data then
        if not GlobalData then
            Log:errorAll("initForce => Could not initForce due to GlobalData being invalid")
            return nil
        end
        GlobalData.forceData[force.name] = {resourceSites = {}}
        return GlobalData.forceData[force.name]
    end
    return force_data
end
function ____exports.getPlayerData(self, playerIndex)
    local ____GlobalData_playerData_find_result_0 = GlobalData
    if ____GlobalData_playerData_find_result_0 ~= nil then
        ____GlobalData_playerData_find_result_0 = ____GlobalData_playerData_find_result_0.playerData:find(function(____, x) return x.index == playerIndex end)
    end
    local ____GlobalData_playerData_find_result_0_2 = ____GlobalData_playerData_find_result_0
    if ____GlobalData_playerData_find_result_0_2 == nil then
        ____GlobalData_playerData_find_result_0_2 = nil
    end
    return ____GlobalData_playerData_find_result_0_2
end
function ____exports.initPlayer(self, playerIndex)
    local player = getPlayer(nil, playerIndex)
    if not player then
        return
    end
    ____exports.initForce(nil, player.force)
    if not ____exports.getPlayerData(nil, playerIndex) then
        GlobalData.playerData:push({overlays = {}, index = playerIndex, guiUpdateTicks = 60, currentSite = nil})
    end
end
return ____exports
