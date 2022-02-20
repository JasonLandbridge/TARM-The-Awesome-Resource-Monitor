--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
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
____exports.default = Paths
return ____exports
