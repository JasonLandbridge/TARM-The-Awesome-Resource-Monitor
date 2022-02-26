--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____general = require("constants.general")
local General = ____general.default
____exports.default = __TS__Class()
local Events = ____exports.default
Events.name = "Events"
function Events.prototype.____constructor(self)
end
Events.Toggle_Interface = General.Prefix .. "_toggle_interface"
Events.OnTick = defines.events.on_tick
____exports.default = Events
return ____exports
