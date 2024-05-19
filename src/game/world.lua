local Windfield = require("src.lib.windfield.windfield")

local World = {}

function World.new()
    local self = Windfield.newWorld()
    self:setQueryDebugDrawing(true)
    self:addCollisionClass("Player")
    self:addCollisionClass("Bullet")
    self:addCollisionClass("Enemy", { ignores = { "Enemy" }, enter = { "Bullet" } })
    self:addCollisionClass("DeadBody", { ignores = { "Player", "Enemy", "Bullet" } })
    self:addCollisionClass("Wall", { ignores = { "Enemy", "Bullet" } })
    _G.World = self
    return self
end

return World
