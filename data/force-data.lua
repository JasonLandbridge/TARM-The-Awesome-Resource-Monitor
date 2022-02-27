--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____global_2Dsave_2Ddata = require("data.global-save-data")
local Global = ____global_2Dsave_2Ddata.default
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
