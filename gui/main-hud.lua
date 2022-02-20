--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____hud = require("constants.hud")
local HUD = ____hud.default
local ____general = require("constants.general")
local General = ____general.default
function ____exports.buildInterface(self, player)
    if not player then
        return
    end
    local screen_element = player.gui.screen
    local main_frame = screen_element.add({type = "frame", name = HUD.MainFrame, caption = General.Prefix .. ".hello_world"})
    main_frame.style.size = {385, 165}
    main_frame.auto_center = true
    main_frame.add({type = "scroll-pane", name = HUD.MainScrollFrame, vertical_scroll_policy = "auto-and-reserve-space"})
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
