--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 4,["7"] = 3,["8"] = 7,["9"] = 8,["10"] = 9,["11"] = 10,["13"] = 7});
local ____exports = {}
function ____exports.getForceData(self, forceName)
    return GlobalData.forceData[forceName]
end
function ____exports.addResourceSiteToForce(self, forceName, site)
    local forceData = ____exports.getForceData(nil, forceName)
    if forceData then
        __TS__ArrayPush(forceData.resourceSites, site)
    end
end
return ____exports
