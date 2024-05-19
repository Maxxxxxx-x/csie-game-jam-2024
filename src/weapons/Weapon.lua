local Weapon = {}
Weapon.__index = Weapon

function Weapon.new(Config, Player)
    local self = setmetatable({}, Weapon)
    self.Config = Config
    self.ToShoot = {}
    self.CanShoot = true
    self.Parent = Player
    return self
end

local function ScreenShake()
    _G.ScreenShaker:setShear(math.random(-0.5, 0.5), math.random(-0.5, 0.5))
end

local function fire(self)
    print("Pew")
    ScreenShake()
    _G.BulletService:CreateBullet(self)
end

function Weapon:update(dt)
    if self.Config.Mode == "Semi" then
        function love.mousepressed(x, y, key)
            if key == 1 then
                if not self.CanShoot then return end
                self.CanShoot = false
                fire(self)
            end
            if key == 2 then
                self.Parent.IsADS = true
            end
        end

        function love.mousereleased(x, y, key)
            if key == 1 then
                self.CanShoot = true
            end
            if key == 2 then
                self.Parent.IsADS = false
            end
        end
    end
end

return Weapon
