--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
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
