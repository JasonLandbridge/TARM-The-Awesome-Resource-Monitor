--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
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
local Global = ____global_2Ddata.default
local ____player_2Ddata = require("data.player-data")
local getPlayerData = ____player_2Ddata.getPlayerData
local initPlayer = ____player_2Ddata.initPlayer
local initPlayers = ____player_2Ddata.initPlayers
local ____resource_2Dtracker = require("lib.resource-tracker")
local addResource = ____resource_2Dtracker.addResource
local clearCurrentSite = ____resource_2Dtracker.clearCurrentSite
local createResourceSite = ____resource_2Dtracker.createResourceSite
local updatePlayers = ____resource_2Dtracker.updatePlayers
local ____resource_2Dcache = require("lib.resource-cache")
local ResourceCache = ____resource_2Dcache.default
local ____global_2Dtemp_2Ddata = require("data.global-temp-data")
local GlobalTemp = ____global_2Dtemp_2Ddata.default
local ____settings_2Ddata = require("data.settings-data")
local SettingsData = ____settings_2Ddata.default
setup_gvv(nil)
script.on_init(function()
    SettingsData:OnInit()
    Global:OnInit()
    GlobalTemp:OnInit()
    initPlayers(nil)
end)
script.on_configuration_changed(function()
    Global:OnInit()
    SettingsData:OnLoad()
    initPlayers(nil)
end)
script.on_load(function()
    SettingsData:OnLoad()
    GlobalTemp:OnLoad()
end)
script.on_event(
    Events.OnTick,
    function(event)
        ResourceCache:OnTick(event)
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
        if playerData.currentSite then
            createResourceSite(nil, event.player_index)
        else
            clearCurrentSite(nil, event.player_index)
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
