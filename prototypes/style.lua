--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____styles = require("constants.styles")
local Styles = ____styles.default
function ____exports.default(self, defaultGui)
    defaultGui[Styles.RowsPaneStyle] = {
        type = "scroll_pane_style",
        parent = "scroll_pane",
        graphical_set = {base = {}, shadow = nil},
        vertical_scrollbar_style = {background_graphical_set = {blend_mode = "multiplicative-with-alpha", corner_size = 8, opacity = 0.7, position = {0, 72}}, type = "vertical_scrollbar_style"},
        vertically_stretchable = "on",
        horizontally_squashable = "on",
        padding = 0,
        extra_padding_when_activated = 0
    }
    defaultGui[Styles.RowButtonStyle] = {
        type = "button_style",
        horizontally_stretchable = "on",
        horizontally_squashable = "on",
        bottom_margin = -3,
        default_font_color = {250 / 255, 250 / 255, 250 / 255},
        hovered_font_color = {0, 0, 0},
        selected_clicked_font_color = {0.97, 0.54, 0.15},
        selected_font_color = {0.97, 0.54, 0.15},
        selected_hovered_font_color = {0.97, 0.54, 0.15},
        clicked_graphical_set = {corner_size = 8, position = {51, 17}},
        default_graphical_set = {corner_size = 8, position = {208, 17}},
        disabled_graphical_set = {corner_size = 8, position = {17, 17}},
        hovered_graphical_set = {base = {corner_size = 8, position = {34, 17}}}
    }
    defaultGui[Styles.RowButtonSelectedStyle] = {
        type = "button_style",
        parent = Styles.RowButtonStyle,
        top_padding = 3,
        left_padding = 11,
        default_font_color = {0, 0, 0},
        hovered_font_color = {0, 0, 0},
        selected_clicked_font_color = {0, 0, 0},
        selected_font_color = {0, 0, 0},
        selected_hovered_font_color = {0, 0, 0},
        clicked_graphical_set = {
            border = 1,
            filename = "__core__/graphics/gui.png",
            position = {75, 108},
            scale = 1,
            size = 36
        },
        default_graphical_set = {
            border = 1,
            filename = "__core__/graphics/gui.png",
            position = {75, 108},
            scale = 1,
            size = 36
        },
        hovered_graphical_set = {
            border = 1,
            filename = "__core__/graphics/gui.png",
            position = {75, 108},
            scale = 1,
            size = 36
        }
    }
    defaultGui[Styles.CellBaseStyle] = {type = "label_style", margin = 0, width = 68}
    defaultGui[Styles.CellNameStyle] = {
        type = "label_style",
        parent = Styles.CellBaseStyle,
        horizontal_align = "left",
        left_padding = 16,
        width = 210
    }
    defaultGui[Styles.CellNumericValueStyle] = {type = "label_style", parent = Styles.CellBaseStyle, horizontal_align = "right", right_padding = 16}
    defaultGui[Styles.CellResourceStyle] = {type = "label_style", parent = Styles.CellBaseStyle, horizontal_align = "center"}
    return defaultGui
end
return ____exports
