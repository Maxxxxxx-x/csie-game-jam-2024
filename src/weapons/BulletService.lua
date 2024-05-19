local BulletService = {}
BulletService.__index = BulletService

function BulletService.new()
    local self = setmetatable({}, BulletService)
    self.Bullets = {}
    return self
end

function BulletService:ClearAll()
    for i = 1, #self.Bullets do
        table.remove(self.Bullets, i)
    end
end

function BulletService:CreateBullet(Weapon)
    local MouseX, MouseY = love.mouse.getPosition()

    local DirectionX = MouseX - Weapon.Parent.Position.X
    local DirectionY = MouseY - Weapon.Parent.Position.Y

    local DirectionLen = math.sqrt(DirectionX ^ 2 + DirectionY ^ 2)
    DirectionX = DirectionX / DirectionLen
    DirectionY = DirectionY / DirectionLen

    local bullet = {}
    bullet.X = Weapon.Parent.Position.X + DirectionX * 24
    bullet.Y = Weapon.Parent.Position.Y + DirectionY * 24
    bullet.LastPosX = 0
    bullet.LastPosY = 0
    bullet.Speed = Weapon.Config.BulletSpeed
    bullet.Direction = Weapon.Parent.Angle
    table.insert(self.Bullets, 1, bullet)
end

function BulletService:update(dt)
    for i, b in pairs(self.Bullets) do
        b.X = b.X + (math.cos(b.Direction) * b.Speed * dt)
        b.Y = b.Y + (math.sin(b.Direction) * b.Speed * dt)
    end

    for i = #self.Bullets, 1, -1 do
        local b = self.Bullets[i]

        if b.X < 0 or b.Y < 0 or b.X > love.graphics.getWidth() or b.Y > love.graphics.getHeight() then
            self.Bullets[i] = self.Bullets[#self.Bullets]
            self.Bullets[#self.Bullets] = nil
            print("Removed Bullet #" .. i)
        end
    end
end

function drawRotatedRectangle(mode, x, y, width, height, angle)
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(angle)
    love.graphics.rectangle(mode, 0, 0, width, height)
    love.graphics.pop()
end

function BulletService:draw()
    for _, b in pairs(self.Bullets) do
        drawRotatedRectangle("fill", b.X + 22, b.Y , 10, 1, b.Direction)
    end
end

return BulletService
