--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
____exports.default = __TS__Class()
local General = ____exports.default
General.name = "General"
function General.prototype.____constructor(self)
end
General.Prefix = "TERM"
General.ModName = "TARM-The-Awesome-Resource-Monitor"
General.Directions = {
    "north",
    "northeast",
    "east",
    "southeast",
    "south",
    "southwest",
    "northwest",
    "west"
}
General.OctantNames = {
    "E",
    "SE",
    "S",
    "SW",
    "W",
    "NW",
    "N",
    "NE"
}
____exports.default = General
return ____exports
