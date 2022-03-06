--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
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
    return stuff[1]
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
function ____exports.generateGuid(self)
    return __TS__StringSubstring(
        __TS__NumberToString(
            math.random(),
            36
        ),
        2,
        15
    ) .. __TS__StringSubstring(
        __TS__NumberToString(
            math.random(),
            36
        ),
        2,
        15
    )
end
function ____exports.findMajorityResourceEntity(self, entities)
    local results = __TS__New(Map)
    for ____, entity in ipairs(entities) do
        if entity.type == "resource" then
            local currentCount = results:get(entity.name) or 0
            results:set(entity.name, currentCount + 1)
        end
    end
    local winnerType = __TS__ArrayReduce(
        {__TS__Spread(results:entries())},
        function(____, a, e) return e[2] > a[2] and e or a end
    )[1]
    return __TS__ArrayFind(
        entities,
        function(____, x) return x.name == winnerType end
    ) or ({})
end
return ____exports
