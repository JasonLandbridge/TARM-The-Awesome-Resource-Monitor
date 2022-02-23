--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 5,["15"] = 6,["16"] = 6,["17"] = 7,["18"] = 7,["19"] = 7,["20"] = 8,["21"] = 8,["22"] = 8,["23"] = 8,["24"] = 8,["25"] = 10,["26"] = 12,["27"] = 13,["28"] = 12,["29"] = 16,["30"] = 16,["31"] = 16,["32"] = 17,["33"] = 16,["34"] = 16,["35"] = 20,["36"] = 20,["37"] = 20,["38"] = 21,["39"] = 22,["40"] = 23,["41"] = 24,["44"] = 20,["45"] = 20,["46"] = 29,["47"] = 29,["48"] = 29,["49"] = 30,["50"] = 31,["51"] = 32,["53"] = 29,["54"] = 29,["55"] = 36,["56"] = 36,["57"] = 36,["58"] = 37,["61"] = 41,["62"] = 42,["65"] = 45,["66"] = 47,["67"] = 48,["69"] = 50,["72"] = 54,["73"] = 55,["74"] = 56,["77"] = 36,["78"] = 36,["79"] = 61,["80"] = 61,["81"] = 61,["82"] = 62,["83"] = 61,["84"] = 61});
local ____exports = {}
local ____hud = require("constants.hud")
local HUD = ____hud.default
local ____events = require("constants.events")
local Events = ____events.default
local ____main_2Dhud = require("gui.main-hud")
local toggleInterface = ____main_2Dhud.toggleInterface
local ____constants = require("constants.index")
local Entity = ____constants.Entity
local ____debug = require("lib.debug")
local setup_gvv = ____debug.setup_gvv
local ____global_2Ddata = require("data.global-data")
local setupGlobalData = ____global_2Ddata.setupGlobalData
local ____player_2Ddata = require("data.player-data")
local getPlayerData = ____player_2Ddata.getPlayerData
local initPlayer = ____player_2Ddata.initPlayer
local ____resource_2Dtracker = require("lib.resource-tracker")
local addResource = ____resource_2Dtracker.addResource
local clearCurrentSite = ____resource_2Dtracker.clearCurrentSite
local createResourceSite = ____resource_2Dtracker.createResourceSite
local updatePlayers = ____resource_2Dtracker.updatePlayers
setup_gvv(nil)
script.on_init(function()
    setupGlobalData(nil)
end)
script.on_event(
    defines.events.on_tick,
    function(event)
        updatePlayers(nil, event)
    end
)
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
        local playerData = getPlayerData(nil, event.player_index)
        if not playerData then
            return
        end
        if #event.entities < 1 then
            if playerData.currentSite and playerData.currentSite.isSiteExpanding then
                createResourceSite(nil, event.player_index)
            else
                clearCurrentSite(nil, event.player_index)
            end
        end
        for ____, entity in ipairs(event.entities) do
            if entity.type == "resource" then
                addResource(nil, event.player_index, entity)
            end
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
