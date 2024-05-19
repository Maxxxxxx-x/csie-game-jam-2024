local Enemy = require("src.enemy.enemy")

local Spawner = {}
Spawner.__index = Spawner

function Spawner.new()
    local self = setmetatable({}, Spawner)
    self.SpawnedEntities = {}
    self.SpawnRate = 1
    return self
end

function Spawner:spawn()
    local NewEntity = Enemy.new()
    NewEntity.Position.X = math.random(0, 1280)
    NewEntity.Position.Y = math.random(0, 758)
end

return Spawner
