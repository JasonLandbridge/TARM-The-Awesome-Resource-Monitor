--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 4,["8"] = 5,["9"] = 4,["10"] = 8,["11"] = 9,["12"] = 10,["13"] = 11,["15"] = 8});
local ____exports = {}
local ____global_2Ddata = require("data.global-data")
local Global = ____global_2Ddata.default
function ____exports.getForceData(self, forceName)
    return Global.forceData[forceName] or nil
end
function ____exports.addResourceSiteToForce(self, forceName, site)
    local forceData = ____exports.getForceData(nil, forceName)
    if forceData then
        __TS__ArrayPush(forceData.resourceSites, site)
    end
end
return ____exports
