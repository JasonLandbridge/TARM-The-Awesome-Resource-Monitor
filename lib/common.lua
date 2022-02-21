--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 7,["6"] = 8,["7"] = 7});
local ____exports = {}
function ____exports.positionToString(self, position)
    return string.format("%d%d", position.x * 100, position.y * 100)
end
return ____exports
