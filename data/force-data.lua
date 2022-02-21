--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 4,["7"] = 4,["8"] = 4,["9"] = 4,["10"] = 3,["11"] = 7,["12"] = 8,["13"] = 9,["14"] = 10,["16"] = 7});
local ____exports = {}
function ____exports.getForceData(self, forceName)
    return __TS__ArrayFind(
        GlobalData.forceData,
        function(____, x) return x.name == forceName end
    )
end
function ____exports.addResourceSiteToForce(self, forceName, site)
    local forceData = ____exports.getForceData(nil, forceName)
    if forceData then
        __TS__ArrayPush(forceData.resourceSites, site)
    end
end
return ____exports
