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
local ____global_2Dsave_2Ddata = require("data.global-save-data")
local Global = ____global_2Dsave_2Ddata.default
local ____player_2Ddata = require("data.player-data")
local getPlayerData = ____player_2Ddata.getPlayerData
local initPlayer = ____player_2Ddata.initPlayer
local initPlayers = ____player_2Ddata.initPlayers
local ____resource_2Dtracker = require("lib.resource-tracker")
local ResourceTracker = ____resource_2Dtracker.default
local ____resource_2Dcache = require("lib.resource-cache")
local ResourceCache = ____resource_2Dcache.default
local ____global_2Dtemp_2Ddata = require("data.global-temp-data")
local GlobalTemp = ____global_2Dtemp_2Ddata.default
local ____settings_2Ddata = require("data.settings-data")
local SettingsData = ____settings_2Ddata.default
local ____yarm_2Dimport = require("lib.yarm-import")
local importYarmData = ____yarm_2Dimport.importYarmData
local ____resource_2Dsite_2Dcreator = require("lib.resource-site-creator")
local addResourcesToDraftResourceSite = ____resource_2Dsite_2Dcreator.addResourcesToDraftResourceSite
local startResourceSiteCreation = ____resource_2Dsite_2Dcreator.startResourceSiteCreation
setup_gvv(nil)
script.on_init(function()
    SettingsData:OnInit()
    Global:OnInit()
    GlobalTemp:OnInit()
    initPlayers(nil)
    importYarmData(nil)
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
        ResourceTracker:OnTick(event)
        ResourceTracker:updatePlayers(event)
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
        if not playerData.draftResourceSite then
            startResourceSiteCreation(nil, event)
        else
            addResourcesToDraftResourceSite(nil, playerData.index, event.entities)
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
