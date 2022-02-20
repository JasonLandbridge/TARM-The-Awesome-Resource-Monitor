script.on_event(defines.events.on_tick, (_evt: any) => {
    game.print(serpent.block({
        hello: "world",
        its_nice: "to see you"
    }));
});


script.on_event(defines.events.on_player_created, (event: OnPlayerCreatedEvent) => {
    let player = game.get_player(event.player_index);
    if (!player) {
        return;
    }
    let screen_element = player.gui.screen;
    let main_frame = screen_element.add({type: "frame", name: "ugg_main_frame", caption: "ugg.hello_world"})
    main_frame.style.size = [385, 165]
    main_frame.auto_center = true
});
