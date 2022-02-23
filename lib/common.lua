--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 10,["8"] = 11,["9"] = 10,["10"] = 14,["11"] = 18,["12"] = 19,["13"] = 20,["14"] = 22,["15"] = 23,["17"] = 27,["18"] = 14,["19"] = 30,["20"] = 31,["21"] = 32,["22"] = 34,["23"] = 34,["24"] = 34,["25"] = 34,["26"] = 30,["27"] = 37,["29"] = 38,["30"] = 39,["32"] = 40,["34"] = 41,["36"] = 42,["38"] = 43,["40"] = 44,["42"] = 45,["44"] = 46,["46"] = 47,["48"] = 48,["50"] = 49,["52"] = 50,["54"] = 51,["56"] = 52,["58"] = 53,["60"] = 54,["63"] = 56,["66"] = 37,["67"] = 60,["68"] = 61,["69"] = 62,["70"] = 63,["71"] = 60});
local ____exports = {}
local ____constants = require("constants.index")
local General = ____constants.General
function ____exports.positionToString(self, position)
    return string.format("%d%d", position.x * 100, position.y * 100)
end
function ____exports.findResourceAt(self, surface, position)
    local top_left = {x = position.x - 0.5, y = position.y - 0.5}
    local bottom_right = {x = position.x + 0.5, y = position.y + 0.5}
    local stuff = surface.find_entities_filtered({area = {top_left, bottom_right}, type = "resource"})
    if #stuff < 1 then
        return nil
    end
    return stuff[2]
end
function ____exports.findCenter(self, area)
    local xPos = (area.left + area.right) / 2
    local yPos = (area.top + area.bottom) / 2
    return {
        math.floor(xPos),
        math.floor(yPos)
    }
end
function ____exports.shiftPosition(self, position, direction)
    repeat
        local ____switch7 = direction
        local ____cond7 = ____switch7 == General.Directions[2]
        if ____cond7 then
            return {x = position.x, y = position.y - 1}
        end
        ____cond7 = ____cond7 or ____switch7 == General.Directions[3]
        if ____cond7 then
            return {x = position.x + 1, y = position.y - 1}
        end
        ____cond7 = ____cond7 or ____switch7 == General.Directions[4]
        if ____cond7 then
            return {x = position.x + 1, y = position.y}
        end
        ____cond7 = ____cond7 or ____switch7 == General.Directions[5]
        if ____cond7 then
            return {x = position.x + 1, y = position.y + 1}
        end
        ____cond7 = ____cond7 or ____switch7 == General.Directions[6]
        if ____cond7 then
            return {x = position.x, y = position.y + 1}
        end
        ____cond7 = ____cond7 or ____switch7 == General.Directions[7]
        if ____cond7 then
            return {x = position.x - 1, y = position.y + 1}
        end
        ____cond7 = ____cond7 or ____switch7 == General.Directions[8]
        if ____cond7 then
            return {x = position.x - 1, y = position.y}
        end
        ____cond7 = ____cond7 or ____switch7 == General.Directions[9]
        if ____cond7 then
            return {x = position.x - 1, y = position.y - 1}
        end
        do
            return position
        end
    until true
end
function ____exports.getOctantName(self, vector)
    local radians = math.atan2(vector[2], vector[1])
    local octant = math.floor(8 * radians / (2 * math.pi) + 8.5) % 8
    return General.OctantNames[octant + 1]
end
return ____exports
