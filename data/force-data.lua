--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____global_2Dsave_2Ddata = require("data.global-save-data")
local Global = ____global_2Dsave_2Ddata.default
function ____exports.addResourceSiteToForce(self, forceName, site)
    local forceData = Global:getForceData(forceName)
    if forceData then
        __TS__ArrayPush(forceData.resourceSites, site)
    end
end
return ____exports
