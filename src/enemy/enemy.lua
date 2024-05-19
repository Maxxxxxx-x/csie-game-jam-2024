local Enemy = {}
Enemy.__index = Enemy

function Enemy.new()
    local World = _G.World
    local self = setmetatable({}, Enemy)
    self.Collider = World:newCircleCollider(654, 398, 15)
    self.Collider:setCollisionClass("Enemy")
    self.Collider:setObject(self)
    self.Sprite = _G.Resources.Sprites.Enemy
    self.Position = {
        X = love.graphics.getWidth(),
        Y = love.graphics.getHeight()
    }

    self.Angle = 0
    self.Size = {
        Width = 10,
        Height = 10
    }

    self.Health = 100
    self.MaxHealth = 100
    self.Damage = 10
    return self
end

return Enemy
