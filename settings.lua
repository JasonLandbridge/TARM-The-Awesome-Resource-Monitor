--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
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
