--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 5,["15"] = 6,["16"] = 6,["17"] = 7,["18"] = 7,["19"] = 9,["20"] = 16,["21"] = 17,["22"] = 16,["23"] = 20,["24"] = 20,["25"] = 20,["26"] = 21,["27"] = 22,["28"] = 23,["29"] = 24,["32"] = 20,["33"] = 20,["34"] = 29,["35"] = 29,["36"] = 29,["37"] = 30,["38"] = 31,["39"] = 32,["41"] = 29,["42"] = 29,["43"] = 36,["44"] = 36,["45"] = 36,["46"] = 37,["49"] = 36,["50"] = 36,["51"] = 42,["52"] = 42,["53"] = 42,["54"] = 43,["55"] = 42,["56"] = 42});
local ____exports = {}
local ____hud = require("constants.hud")
local HUD = ____hud.default
local ____events = require("constants.events")
local Events = ____events.default
local ____main_2Dhud = require("gui.main-hud")
local toggleInterface = ____main_2Dhud.toggleInterface
local ____constants = require("constants.index")
local Entity = ____constants.Entity
local ____debug = require("debug")
local setup_gvv = ____debug.setup_gvv
local ____global_2Ddata = require("lib.global-data")
local setupGlobalData = ____global_2Ddata.setupGlobalData
local ____player_2Ddata = require("data.player-data")
local initPlayer = ____player_2Ddata.initPlayer
setup_gvv(nil)
script.on_init(function()
    setupGlobalData(nil)
end)
script.on_event(
    defines.events.on_gui_closed,
    function(event)
        if event.element and event.element.name == HUD.MainFrame then
            local player = game.get_player(event.player_index)
            if player then
                toggleInterface(nil, player)
            end
        end
    end
)
script.on_event(
    Events.Toggle_Interface,
    function(event)
        local player = game.get_player(event.player_index)
        if player then
            toggleInterface(nil, player)
        end
    end
)
script.on_event(
    defines.events.on_player_selected_area,
    function(event)
        if event.item ~= Entity.SelectorTool then
            return
        end
    end
)
script.on_event(
    defines.events.on_player_created,
    function(event)
        initPlayer(nil, event.player_index)
    end
)
return ____exports
