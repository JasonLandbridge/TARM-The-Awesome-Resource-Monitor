--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 5,["15"] = 5,["17"] = 4,["18"] = 8,["19"] = 9,["20"] = 9,["21"] = 9,["23"] = 8,["24"] = 12,["25"] = 14,["26"] = 14,["27"] = 14,["29"] = 12,["30"] = 17,["31"] = 19,["32"] = 19,["33"] = 19,["35"] = 17,["36"] = 3});
local ____exports = {}
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
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
function Log.info(self, playerIndex, message)
    local ____getPlayer_result_print_result_2 = getPlayer(nil, playerIndex)
    if ____getPlayer_result_print_result_2 ~= nil then
        ____getPlayer_result_print_result_2 = ____getPlayer_result_print_result_2.print("[INFO]: " .. message)
    end
end
function Log.warn(self, playerIndex, message)
    local ____getPlayer_result_print_result_4 = getPlayer(nil, playerIndex)
    if ____getPlayer_result_print_result_4 ~= nil then
        ____getPlayer_result_print_result_4 = ____getPlayer_result_print_result_4.print("[WARN]: " .. message, {r = 255, g = 204, b = 0})
    end
end
function Log.error(self, playerIndex, message)
    local ____getPlayer_result_print_result_6 = getPlayer(nil, playerIndex)
    if ____getPlayer_result_print_result_6 ~= nil then
        ____getPlayer_result_print_result_6 = ____getPlayer_result_print_result_6.print("[ERROR]: " .. message, {r = 204, g = 51, b = 0})
    end
end
____exports.default = Log
return ____exports
