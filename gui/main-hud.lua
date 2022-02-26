--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 14,["12"] = 15,["15"] = 18,["16"] = 20,["17"] = 25,["18"] = 26,["19"] = 28,["20"] = 36,["21"] = 37,["22"] = 38,["23"] = 40,["24"] = 41,["25"] = 42,["26"] = 44,["27"] = 45,["28"] = 46,["29"] = 47,["30"] = 48,["31"] = 51,["32"] = 51,["33"] = 51,["34"] = 51,["35"] = 51,["36"] = 51,["37"] = 51,["38"] = 60,["39"] = 63,["40"] = 64,["41"] = 65,["42"] = 66,["43"] = 67,["44"] = 68,["45"] = 68,["46"] = 68,["47"] = 68,["48"] = 68,["49"] = 68,["50"] = 68,["51"] = 68,["52"] = 68,["53"] = 77,["54"] = 78,["55"] = 79,["56"] = 80,["57"] = 83,["58"] = 89,["59"] = 90,["60"] = 91,["61"] = 96,["62"] = 104,["63"] = 105,["64"] = 14,["65"] = 108,["66"] = 109,["67"] = 110,["70"] = 114,["71"] = 116,["72"] = 117,["75"] = 121,["76"] = 123,["77"] = 124,["78"] = 126,["79"] = 127,["81"] = 108,["82"] = 5,["83"] = 6,["84"] = 7,["85"] = 8,["87"] = 10,["89"] = 5});
local ____exports = {}
local ____hud = require("constants.hud")
local HUD = ____hud.default
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
local ____force_2Ddata = require("data.force-data")
local getForceData = ____force_2Ddata.getForceData
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
    ____exports.updateHud(nil, player.index, zoneListScroll)
end
function ____exports.updateHud(self, playerIndex, parent)
    local player = getPlayer(nil, playerIndex)
    if not (player and player.connected) then
        return
    end
    local window = player.gui.screen[HUD.MainFrame]
    local forceData = getForceData(nil, player.force.name)
    if not forceData then
        return
    end
    for ____, resourceSite in ipairs(forceData.resourceSites) do
        local row = parent.add({type = "button", name = resourceSite.name})
        local row_flow = row.add({type = "flow", name = "row_flow", direction = "horizontal", ignored_by_interaction = true})
        row_flow.add({type = "label", name = "cell_name", caption = resourceSite.name, style = "se_zonelist_cell_name"})
        row_flow.add({type = "label", name = "cell_type", caption = resourceSite.amount, style = "se_zonelist_cell_type"})
    end
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
