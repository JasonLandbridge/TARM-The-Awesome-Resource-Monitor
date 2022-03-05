--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____hud = require("constants.hud")
local HUD = ____hud.default
local ____game = require("lib.game")
local getPlayer = ____game.getPlayer
local ____force_2Ddata = require("data.force-data")
local getForceData = ____force_2Ddata.getForceData
local ____graphics = require("constants.graphics")
local Graphics = ____graphics.default
local ____styles = require("constants.styles")
local Styles = ____styles.default
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
    local title_frame = titleTable.add({type = "frame", name = "title_frame", caption = "space-exploration.zonelist-window-title", ignored_by_interaction = true})
    local filter_search_container = titleTable.add({type = "flow", name = "filter_search_flow", direction = "horizontal"})
    local zoneListSearch = filter_search_container.add({type = "textfield", name = "Zonelist.name_zonelist_search"})
    zoneListSearch.style.width = 150
    zoneListSearch.style.height = 30
    zoneListSearch.style.top_margin = -4
    zoneListSearch.style.left_margin = 30
    local searchButton = filter_search_container.add({
        type = "sprite-button",
        name = "Zonelist.name_zonelist_search_clear",
        sprite = Graphics.SearchCloseWhite,
        hovered_sprite = Graphics.SearchCloseBlack,
        clicked_sprite = Graphics.SearchCloseBlack,
        tooltip = "space-exploration.clear-search"
    })
    searchButton.style.left_margin = 5
    searchButton.style.height = 28
    searchButton.style.width = 28
    searchButton.style.top_margin = -2
    local zoneListFrame = mainLeftFlow.add({type = "frame", name = "zonelist_frame", direction = "vertical"})
    zoneListFrame.style.horizontally_stretchable = true
    zoneListFrame.style.minimal_height = 300
    local zoneListHeadingsRow = zoneListFrame.add({type = "flow", name = "Zonelist.name_zonelist_headings_row", direction = "horizontal"})
    local zoneListScroll = zoneListFrame.add({type = "scroll-pane", name = "Zonelist.name_zonelist_scroll", style = Styles.RowsPaneStyle})
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
        local row = parent.add({type = "button", name = resourceSite.name, style = Styles.RowButtonStyle})
        local row_flow = row.add({type = "flow", name = "row_flow", direction = "horizontal", ignored_by_interaction = true})
        row_flow.add({type = "label", name = "cell_resource_site_name", caption = resourceSite.name, style = Styles.CellNameStyle})
        row_flow.add({type = "label", name = "cell_resource_amount", caption = resourceSite.totalAmount, style = Styles.CellNumericValueStyle})
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
