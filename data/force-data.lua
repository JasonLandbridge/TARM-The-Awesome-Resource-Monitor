--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 4,["7"] = 4,["8"] = 4,["10"] = 4,["11"] = 3,["12"] = 7,["13"] = 8,["14"] = 9,["15"] = 10,["17"] = 7});
local ____exports = {}
function ____exports.getForceData(self, forceName)
    local ____GlobalData_forceData_forceName_0 = GlobalData
    if ____GlobalData_forceData_forceName_0 ~= nil then
        ____GlobalData_forceData_forceName_0 = ____GlobalData_forceData_forceName_0.forceData[forceName]
    end
    return ____GlobalData_forceData_forceName_0 or nil
end
function ____exports.addResourceSiteToForce(self, forceName, site)
    local forceData = ____exports.getForceData(nil, forceName)
    if forceData then
        __TS__ArrayPush(forceData.resourceSites, site)
    end
end
return ____exports
