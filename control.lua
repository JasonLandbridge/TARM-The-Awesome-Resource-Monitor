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
