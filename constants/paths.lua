--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 7,["16"] = 8,["17"] = 7,["18"] = 3});
local ____exports = {}
local ____general = require("constants.general")
local General = ____general.default
____exports.default = __TS__Class()
local Paths = ____exports.default
Paths.name = "Paths"
function Paths.prototype.____constructor(self)
end
function Paths.Graphics(self, fileName)
    return (("__" .. General.ModName) .. "__/graphics/") .. fileName
end
function Paths.IconGraphics(self, fileName)
    return (("__" .. General.ModName) .. "__/graphics/icons/") .. fileName
end
____exports.default = Paths
return ____exports
