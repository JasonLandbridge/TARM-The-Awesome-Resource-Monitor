--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 13,["8"] = 14,["11"] = 17,["12"] = 19,["13"] = 24,["14"] = 25,["15"] = 27,["16"] = 35,["17"] = 36,["18"] = 37,["19"] = 39,["20"] = 40,["21"] = 41,["22"] = 43,["23"] = 44,["24"] = 45,["25"] = 46,["26"] = 47,["27"] = 50,["28"] = 50,["29"] = 50,["30"] = 50,["31"] = 50,["32"] = 50,["33"] = 50,["34"] = 59,["35"] = 62,["36"] = 63,["37"] = 64,["38"] = 65,["39"] = 66,["40"] = 67,["41"] = 67,["42"] = 67,["43"] = 67,["44"] = 67,["45"] = 67,["46"] = 67,["47"] = 67,["48"] = 67,["49"] = 76,["50"] = 77,["51"] = 78,["52"] = 79,["53"] = 82,["54"] = 88,["55"] = 89,["56"] = 90,["57"] = 95,["58"] = 103,["59"] = 13,["60"] = 4,["61"] = 5,["62"] = 6,["63"] = 7,["65"] = 9,["67"] = 4});
local ____exports = {}
local ____hud = require("constants.hud")
local HUD = ____hud.default
function ____exports.buildInterface(self, player)
    if not player then
        return
    end
    local screen_element = player.gui.screen
    local main_frame = screen_element.add({type = "frame", name = HUD.MainFrame, direction = "vertical"})
    main_frame.style.bottom_padding = 10
    main_frame.auto_center = true
    local mainTable = main_frame.add({type = "table", name = "main_table", column_count = 2, draw_horizontal_lines = false})
    mainTable.style.horizontally_stretchable = true
    mainTable.style.column_alignments[1] = "left"
    mainTable.style.column_alignments[2] = "right"
    local mainLeftFlow = mainTable.add({type = "flow", name = "main_left_flow", direction = "vertical"})
    local mainRightFlow = mainTable.add({type = "flow", name = "main_right_flow", direction = "vertical"})
    mainLeftFlow.style.right_margin = 10
    local titleTable = mainLeftFlow.add({type = "table", name = "title_table", column_count = 2, draw_horizontal_lines = false})
    titleTable.drag_target = main_frame
    titleTable.style.horizontally_stretchable = true
    titleTable.style.column_alignments[1] = "left"
    titleTable.style.column_alignments[2] = "right"
    local title_frame = titleTable.add({
        type = "frame",
        name = "title_frame",
        caption = "space-exploration.zonelist-window-title",
        style = "informatron_title_frame",
        ignored_by_interaction = true
    })
    local filter_search_container = titleTable.add({type = "flow", name = "filter_search_flow", direction = "horizontal"})
    local zoneListSearch = filter_search_container.add({type = "textfield", name = "Zonelist.name_zonelist_search"})
    zoneListSearch.style.width = 150
    zoneListSearch.style.height = 30
    zoneListSearch.style.top_margin = -4
    zoneListSearch.style.left_margin = 30
    local searchButton = filter_search_container.add({
        type = "sprite-button",
        name = "Zonelist.name_zonelist_search_clear",
        sprite = "se-search-close-white",
        hovered_sprite = "se-search-close-black",
        clicked_sprite = "se-search-close-black",
        tooltip = "space-exploration.clear-search",
        style = "informatron_close_button"
    })
    searchButton.style.left_margin = 5
    searchButton.style.height = 28
    searchButton.style.width = 28
    searchButton.style.top_margin = -2
    local zoneListFrame = mainLeftFlow.add({type = "frame", name = "zonelist_frame", style = "informatron_inside_deep_frame", direction = "vertical"})
    zoneListFrame.style.horizontally_stretchable = true
    zoneListFrame.style.minimal_height = 300
    local zoneListHeadingsRow = zoneListFrame.add({type = "flow", name = "Zonelist.name_zonelist_headings_row", direction = "horizontal"})
    local zoneListScroll = zoneListFrame.add({type = "scroll-pane", name = "Zonelist.name_zonelist_scroll", style = "zonelist_rows_pane"})
    player.opened = main_frame
end
function ____exports.toggleInterface(self, player)
    local main_frame = player.gui.screen[HUD.MainFrame]
    if not main_frame then
        ____exports.buildInterface(nil, player)
    else
        main_frame.destroy()
    end
end
return ____exports
