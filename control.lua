--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]

local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file, ...)
    if ____moduleCache[file] then
        return ____moduleCache[file].value
    end
    if ____modules[file] then
        local module = ____modules[file]
        ____moduleCache[file] = { value = (select("#", ...) > 0) and module(...) or module(file) }
        return ____moduleCache[file].value
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["control"] = function(...) 
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
script.on_event(
    defines.events.on_tick,
    function(_evt)
        game.print(serpent.block({hello = "world", its_nice = "to see you"}))
    end
)
script.on_event(
    defines.events.on_player_created,
    function(event)
        local player = game.get_player(event.player_index)
        if not player then
            return
        end
        local screen_element = player.gui.screen
        local main_frame = screen_element.add({type = "frame", name = "ugg_main_frame", caption = "ugg.hello_world"})
        main_frame.style.size = {385, 165}
        main_frame.auto_center = true
    end
)
 end,
}
return require("control", ...)
