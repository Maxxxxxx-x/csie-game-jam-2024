local utils = {}

function utils:ToMouseAngle(Position)
    local MouseX, MouseY = love.mouse.getPosition()
    local dx = MouseX - Position.X
    local dy = MouseY - Position.Y
    return math.atan2(dy, dx)
end

return utils
