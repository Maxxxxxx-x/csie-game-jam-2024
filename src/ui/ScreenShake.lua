local Screen = require("src.lib.shack.shack")

local ScreenShake = {}
ScreenShake.__index = ScreenShake

function ScreenShake.new()
    local self = setmetatable({}, ScreenShake)
    self.Shaker = Screen:setDimensions(love.graphics.getDimensions())
    return self
end

return ScreenShake
