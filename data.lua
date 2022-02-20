--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 7,["12"] = 7,["13"] = 16,["14"] = 16,["15"] = 16,["16"] = 16,["17"] = 16,["18"] = 16,["19"] = 16,["20"] = 23,["21"] = 23,["22"] = 23,["23"] = 23,["24"] = 23,["25"] = 23,["26"] = 16,["27"] = 30,["28"] = 30,["29"] = 30,["30"] = 30,["31"] = 30,["32"] = 30,["33"] = 16,["34"] = 37,["35"] = 37,["36"] = 37,["37"] = 37,["38"] = 37,["39"] = 37,["40"] = 16,["41"] = 7,["42"] = 46,["43"] = 46,["44"] = 46,["45"] = 46,["46"] = 46,["47"] = 46,["48"] = 46,["49"] = 46,["50"] = 46,["51"] = 46,["52"] = 46,["53"] = 46,["54"] = 46,["55"] = 46,["56"] = 46,["57"] = 46,["58"] = 7,["59"] = 64,["60"] = 64,["61"] = 64,["62"] = 64,["63"] = 64,["64"] = 64,["65"] = 64,["66"] = 64,["67"] = 64,["68"] = 64,["69"] = 64,["70"] = 64,["71"] = 85,["72"] = 85,["73"] = 85,["74"] = 85,["75"] = 85,["76"] = 85,["77"] = 64,["78"] = 7,["79"] = 7});
local ____exports = {}
local ____constants = require("constants.index")
local Events = ____constants.Events
local General = ____constants.General
local Paths = ____constants.Paths
local ____constants = require("constants.index")
local Entity = ____constants.Entity
data:extend({
    {type = "custom-input", name = Events.Toggle_Interface, key_sequence = "F", order = "a"},
    {
        type = "shortcut",
        name = General.Prefix .. "-selector",
        order = ("a[" .. General.Prefix) .. "]",
        action = "spawn-item",
        item_to_spawn = Entity.SelectorTool,
        style = "red",
        icon = {
            filename = Paths:Graphics("resource-monitor-x32-white.png"),
            priority = "extra-high-no-scale",
            size = 32,
            scale = 1,
            flags = {"icon"}
        },
        small_icon = {
            filename = Paths:Graphics("resource-monitor-x24.png"),
            priority = "extra-high-no-scale",
            size = 24,
            scale = 1,
            flags = {"icon"}
        },
        disabled_small_icon = {
            filename = Paths:Graphics("resource-monitor-x24-white.png"),
            priority = "extra-high-no-scale",
            size = 24,
            scale = 1,
            flags = {"icon"}
        }
    },
    {
        type = "selection-tool",
        name = Entity.SelectorTool,
        icon = Paths:Graphics("resource-monitor.png"),
        icon_size = 32,
        flags = {"only-in-cursor", "hidden", "spawnable"},
        stack_size = 1,
        stackable = false,
        selection_color = {g = 1},
        selection_mode = "any-entity",
        alt_selection_color = {g = 1, b = 1},
        alt_selection_mode = {"nothing"},
        selection_cursor_box_type = "copy",
        alt_selection_cursor_box_type = "copy",
        entity_filter_mode = "whitelist",
        entity_type_filters = {"resource"}
    },
    {
        type = "container",
        name = General.Prefix .. "_rm_overlay",
        flags = {"placeable-neutral", "player-creation", "not-repairable"},
        icon = Paths:Graphics("rm_Overlay.png"),
        icon_size = 32,
        max_health = 1,
        order = "z[resource-monitor]",
        collision_mask = {"resource-layer"},
        collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        inventory_size = 1,
        picture = {
            filename = Paths:Graphics("rm_Overlay.png"),
            priority = "extra-high",
            width = 32,
            height = 32,
            shift = {0, 0}
        }
    }
})
return ____exports
