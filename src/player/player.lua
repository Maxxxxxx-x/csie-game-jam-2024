local Weapon = require("src.weapons.Weapon")
local WeaponConfig = require("src.weapons.config.Handgun")

local Utils = require("src.game.utils")

local Player = {}
Player.__index = Player

function Player.new()
    local World = _G.World
    local self = setmetatable({}, Player)
    self.Collider = World:newCircleCollider(654, 398, 15)
    self.Collider:setCollisionClass("Player")
    self.Collider:setObject(self)
    self.Sprite = _G.Resources.Sprites.Player
    self.Position = {
        X = love.graphics.getWidth() / 2,
        Y = love.graphics.getHeight() / 2
    }

    self.Angle = 0
    self.Size = {
        Width = 10,
        Height = 10,
    }

    self.Health = 100
    self.MaxHeath = 100
    self.Speed = 0.25
    self.Direction = 1

    self.IsMoving = false
    self.IsSprinting = false
    self.IsADS = false

    self.CanMove = true
    self.CanSprint = true

    self.Inventory = {}
    self.InventorySize = 3
    self.CurrentItmeIdx = 1
    self.CurrentItem = Weapon.new(WeaponConfig, self)
    return self
end

function Player:update(dt)
    self.isMoving = false
    self.CurrentItem:update(dt)
    if love.keyboard.isDown("w") then
        self.IsMoving = true
        self.Position.Y = self.Position.Y - self.Speed
    end

    if love.keyboard.isDown("a") then
        self.Position.X = self.Position.X - self.Speed
        self.IsMoving   = true
    end

    if love.keyboard.isDown("s") then
        self.Position.Y = self.Position.Y + self.Speed
        self.IsMoving = true
    end

    if love.keyboard.isDown("d") then
        self.Position.X = self.Position.X + self.Speed
        self.IsMoving   = true
    end

    if love.keyboard.isDown("lshift") then
        self.Speed = 0.4
    else
        self.Speed = 0.25
    end

    if self.Collider:enter("Enemy") then
        self.isDead = true
        self.animation = self.animations.dead
        _G.GameState = "Dead"
    end

    self.Angle = Utils:ToMouseAngle(self.Position)
end

function Player:draw()
    if self.Health <= 0 then
    else
        love.graphics.draw(
            self.Sprite,
            self.Position.X,
            self.Position.Y,
            self.Angle,
            1,
            1,
            self.Sprite:getWidth() / 2,
            self.Sprite:getHeight() / 2
        )
    end

    love.graphics.setFont(_G.Resources.Fonts.GeneralFont)

    if self.isDashing then
        love.graphics.setFont(_G.Resources.Fonts.GeneralFont)
        love.graphics.print("Out of Stamina!", 30, 50)
    end
end

return Player
