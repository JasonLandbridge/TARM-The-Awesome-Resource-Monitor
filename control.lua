--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 5,["15"] = 6,["16"] = 6,["17"] = 7,["18"] = 7,["19"] = 7,["20"] = 7,["21"] = 8,["22"] = 8,["23"] = 8,["24"] = 8,["25"] = 8,["26"] = 9,["27"] = 9,["28"] = 11,["29"] = 13,["30"] = 14,["31"] = 15,["32"] = 13,["33"] = 18,["34"] = 19,["35"] = 20,["36"] = 18,["37"] = 23,["38"] = 24,["39"] = 23,["40"] = 27,["41"] = 27,["42"] = 27,["43"] = 28,["44"] = 29,["45"] = 27,["46"] = 27,["47"] = 32,["48"] = 32,["49"] = 32,["50"] = 33,["51"] = 34,["52"] = 35,["53"] = 36,["56"] = 32,["57"] = 32,["58"] = 41,["59"] = 41,["60"] = 41,["61"] = 42,["62"] = 43,["63"] = 44,["65"] = 41,["66"] = 41,["67"] = 48,["68"] = 48,["69"] = 48,["70"] = 49,["73"] = 53,["74"] = 54,["77"] = 59,["78"] = 60,["80"] = 62,["82"] = 65,["83"] = 66,["84"] = 67,["87"] = 48,["88"] = 48,["89"] = 72,["90"] = 72,["91"] = 72,["92"] = 73,["93"] = 72,["94"] = 72});
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
setup_gvv(nil)
script.on_init(function()
    Global:OnInit()
    initPlayers(nil)
end)
script.on_configuration_changed(function()
    Global:OnInit()
    initPlayers(nil)
end)
script.on_load(function()
    ResourceCache:OnLoad()
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
