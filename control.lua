--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 5,["15"] = 6,["16"] = 6,["17"] = 7,["18"] = 7,["19"] = 7,["20"] = 8,["21"] = 8,["22"] = 8,["23"] = 8,["24"] = 8,["25"] = 9,["26"] = 9,["27"] = 11,["28"] = 13,["29"] = 14,["30"] = 13,["31"] = 17,["32"] = 18,["33"] = 17,["34"] = 21,["35"] = 22,["36"] = 21,["37"] = 25,["38"] = 25,["39"] = 25,["40"] = 26,["41"] = 27,["42"] = 25,["43"] = 25,["44"] = 30,["45"] = 30,["46"] = 30,["47"] = 31,["48"] = 32,["49"] = 33,["50"] = 34,["53"] = 30,["54"] = 30,["55"] = 39,["56"] = 39,["57"] = 39,["58"] = 40,["59"] = 41,["60"] = 42,["62"] = 39,["63"] = 39,["64"] = 46,["65"] = 46,["66"] = 46,["67"] = 47,["70"] = 51,["71"] = 52,["74"] = 57,["75"] = 58,["77"] = 60,["79"] = 63,["80"] = 64,["81"] = 65,["84"] = 46,["85"] = 46,["86"] = 70,["87"] = 70,["88"] = 70,["89"] = 71,["90"] = 70,["91"] = 70});
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
local ____resource_2Dcache = require("lib.resource-cache")
local ResourceCache = ____resource_2Dcache.default
setup_gvv(nil)
script.on_init(function()
    setupGlobalData(nil)
end)
script.on_configuration_changed(function()
    setupGlobalData(nil)
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
