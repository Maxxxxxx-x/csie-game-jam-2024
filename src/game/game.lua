local ScreenShaker = require("src.ui.ScreenShake")
local UIManager = require("src.ui.UIManager")
local World = require("src.game.world")
local Player = require("src.player.player")
local Resources = require("src.game.resources")
local BulletService = require("src.weapons.BulletService")

local Game = {}
Game.__index = Game

function Game.new()
    local self = setmetatable({}, Game)
    self.StartTime = os.time()
    self.Paused = false
    self.GameState = "MainMenu"
    self.Player = nil
    self.UIManager = UIManager.new()
    self.World = World.new()

    self.Constants = {}
    self.Constants = {
        WindowSize = {
            WIDTH = 1280,
            HEIGHT = 768,
        }
    }

    self.Resources = Resources.new()
    _G.Resources = self.Resources
    self.Player = Player.new(self.World)
    _G.GameState = self.GameState
    return self
end

function Game:load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Unseen Threats")
    love.window.setMode(
        self.Constants.WindowSize.WIDTH,
        self.Constants.WindowSize.HEIGHT,
        {
            fullscreen = false,
            resizable = false,
            vsync = false
        }
    )
    self.ScreenShaker = ScreenShaker.new()
    _G.ScreenShaker = self.ScreenShaker.Shaker
    self.BulletService = BulletService.new()
    _G.BulletService = self.BulletService
    print("Loaded new game")
end

function Game:update(dt)
    if not self.Paused then
        self.World:update(dt)
    else
        return
    end

    if _G.GameState == "Play" then
        self.ScreenShaker.Shaker:update(dt)
        self.Player:update(dt)
        self.BulletService:update(dt)
    end

    if self.GameState == "MainMenu" or self.GameState == "Credits" or self.GameState == "HowToPlay" then
        love.graphics.setColor(1, 1, 1)
        self.UIManager:update(_G.GameState, dt)
    end
end

function Game:draw()
    if self.GameState == "MainMenu" or self.GameState == "Credits" or self.GameState == "HowToPlay" then
        love.graphics.setColor(1, 1, 1)
        self.UIManager:show(self.GameState)
    end

    if _G.GameState == "Play" then
        self.BulletService:draw()
        self.ScreenShaker.Shaker:apply()
        self.Player:draw()
    end
end


return Game
