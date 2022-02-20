--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 3,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 3});
local ____exports = {}
local ____general = require("constants.general")
local General = ____general.default
____exports.default = __TS__Class()
local HUD = ____exports.default
HUD.name = "HUD"
function HUD.prototype.____constructor(self)
end
HUD.MainFrame = General.Prefix .. "_main_frame"
HUD.MainScrollFrame = General.Prefix .. "_scroll_frame"
____exports.default = HUD
return ____exports
