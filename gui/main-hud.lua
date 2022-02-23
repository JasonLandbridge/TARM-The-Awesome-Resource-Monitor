--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 3,["9"] = 4,["10"] = 4,["11"] = 15,["12"] = 16,["15"] = 19,["16"] = 21,["17"] = 26,["18"] = 27,["19"] = 29,["20"] = 37,["21"] = 38,["22"] = 39,["23"] = 41,["24"] = 42,["25"] = 43,["26"] = 45,["27"] = 46,["28"] = 47,["29"] = 48,["30"] = 49,["31"] = 52,["32"] = 52,["33"] = 52,["34"] = 52,["35"] = 52,["36"] = 52,["37"] = 52,["38"] = 61,["39"] = 64,["40"] = 65,["41"] = 66,["42"] = 67,["43"] = 68,["44"] = 69,["45"] = 69,["46"] = 69,["47"] = 69,["48"] = 69,["49"] = 69,["50"] = 69,["51"] = 69,["52"] = 69,["53"] = 78,["54"] = 79,["55"] = 80,["56"] = 81,["57"] = 84,["58"] = 90,["59"] = 91,["60"] = 92,["61"] = 97,["62"] = 105,["63"] = 106,["64"] = 15,["65"] = 109,["66"] = 110,["67"] = 111,["70"] = 115,["71"] = 117,["72"] = 118,["75"] = 122,["76"] = 124,["77"] = 125,["78"] = 127,["79"] = 128,["81"] = 109,["82"] = 6,["83"] = 7,["84"] = 8,["85"] = 9,["87"] = 11,["89"] = 6});
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
