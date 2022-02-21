--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 5,["8"] = 7,["9"] = 7,["10"] = 7,["11"] = 7,["12"] = 7,["13"] = 7,["14"] = 7,["15"] = 7,["16"] = 5,["17"] = 16,["18"] = 16,["19"] = 16,["20"] = 16,["21"] = 16,["22"] = 16,["23"] = 16,["24"] = 16,["25"] = 5,["26"] = 25,["27"] = 25,["28"] = 25,["29"] = 25,["30"] = 25,["31"] = 25,["32"] = 5,["33"] = 32,["34"] = 32,["35"] = 32,["36"] = 32,["37"] = 32,["38"] = 32,["39"] = 32,["40"] = 32,["41"] = 5,["42"] = 41,["43"] = 41,["44"] = 41,["45"] = 41,["46"] = 41,["47"] = 41,["48"] = 5,["49"] = 48,["50"] = 48,["51"] = 48,["52"] = 48,["53"] = 48,["54"] = 48,["55"] = 5,["56"] = 57,["57"] = 57,["58"] = 57,["59"] = 57,["60"] = 57,["61"] = 57,["62"] = 57,["63"] = 57,["64"] = 5,["65"] = 66,["66"] = 66,["67"] = 66,["68"] = 66,["69"] = 66,["70"] = 66,["71"] = 72,["72"] = 72,["73"] = 72,["74"] = 72,["75"] = 72,["76"] = 72,["77"] = 66,["78"] = 5,["79"] = 5});
local ____exports = {}
local ____settings = require("constants.settings")
local Settings = ____settings.default
data:extend({
    {
        type = "int-setting",
        name = Settings.TickBetweenChecks,
        setting_type = "runtime-global",
        order = "a",
        default_value = 600,
        minimum_value = 20,
        maximum_value = 1200
    },
    {
        type = "int-setting",
        name = Settings.EntitiesPerTick,
        setting_type = "runtime-global",
        order = "a",
        default_value = 100,
        minimum_value = 10,
        maximum_value = 1000
    },
    {
        type = "bool-setting",
        name = Settings.MapMarkers,
        setting_type = "runtime-global",
        order = "b",
        default_value = true
    },
    {
        type = "int-setting",
        name = Settings.OverlayStep,
        setting_type = "runtime-global",
        order = "c",
        default_value = 1,
        minimum_value = 1,
        maximum_value = 5
    },
    {
        type = "bool-setting",
        name = Settings.PrefixSiteWithSurface,
        setting_type = "runtime-global",
        order = "d",
        default_value = false
    },
    {
        type = "bool-setting",
        name = Settings.DebugProfiling,
        setting_type = "runtime-global",
        order = "zz[debug]",
        default_value = false
    },
    {
        type = "int-setting",
        name = Settings.WarnPercentage,
        setting_type = "runtime-per-user",
        order = "a",
        default_value = 10,
        minimum_value = 0,
        maximum_value = 100
    },
    {
        type = "string-setting",
        name = Settings.OrderBy,
        setting_type = "runtime-per-user",
        order = "b",
        default_value = "percent-remaining",
        allowed_values = {
            "alphabetical",
            "percent-remaining",
            "ore-type",
            "ore-count",
            "etd"
        }
    }
})
return ____exports
