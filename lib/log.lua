--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 3,["9"] = 3,["10"] = 3,["12"] = 3,["13"] = 5,["14"] = 6,["15"] = 6,["16"] = 6,["18"] = 5,["19"] = 9,["20"] = 10,["21"] = 11,["23"] = 9,["24"] = 17,["25"] = 18,["26"] = 18,["27"] = 18,["29"] = 17,["30"] = 21,["31"] = 22,["32"] = 23,["34"] = 21,["35"] = 29,["36"] = 31,["37"] = 31,["38"] = 31,["40"] = 29,["41"] = 34,["42"] = 35,["43"] = 36,["45"] = 34,["46"] = 43,["47"] = 45,["48"] = 45,["49"] = 45,["51"] = 43,["52"] = 48,["53"] = 49,["54"] = 50,["56"] = 48,["57"] = 3});
local ____exports = {}
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
local getPlayers = ____game.getPlayers
____exports.default = __TS__Class()
local Log = ____exports.default
Log.name = "Log"
function Log.prototype.____constructor(self)
end
function Log.debug(self, playerIndex, message)
    local ____getPlayer_result_print_result_0 = getPlayer(nil, playerIndex)
    if ____getPlayer_result_print_result_0 ~= nil then
        ____getPlayer_result_print_result_0 = ____getPlayer_result_print_result_0.print("[DEBUG]: " .. message)
    end
end
function Log.debugAll(self, message)
    for ____, player in ipairs(getPlayers(nil)) do
        self:debug(player.index, message)
    end
end
function Log.info(self, playerIndex, message)
    local ____getPlayer_result_print_result_2 = getPlayer(nil, playerIndex)
    if ____getPlayer_result_print_result_2 ~= nil then
        ____getPlayer_result_print_result_2 = ____getPlayer_result_print_result_2.print("[INFO]: " .. message)
    end
end
function Log.infoAll(self, message)
    for ____, player in ipairs(getPlayers(nil)) do
        self:debug(player.index, message)
    end
end
function Log.warn(self, playerIndex, message)
    local ____getPlayer_result_print_result_4 = getPlayer(nil, playerIndex)
    if ____getPlayer_result_print_result_4 ~= nil then
        ____getPlayer_result_print_result_4 = ____getPlayer_result_print_result_4.print("[WARN]: " .. message, {r = 255, g = 204, b = 0})
    end
end
function Log.warnAll(self, message)
    for ____, player in ipairs(getPlayers(nil)) do
        self:warn(player.index, message)
    end
end
function Log.error(self, playerIndex, message)
    local ____getPlayer_result_print_result_6 = getPlayer(nil, playerIndex)
    if ____getPlayer_result_print_result_6 ~= nil then
        ____getPlayer_result_print_result_6 = ____getPlayer_result_print_result_6.print("[ERROR]: " .. message, {r = 204, g = 51, b = 0})
    end
end
function Log.errorAll(self, message)
    for ____, player in ipairs(getPlayers(nil)) do
        self:error(player.index, message)
    end
end
____exports.default = Log
return ____exports
