local Resources = {}
Resources.__index = Resources

function Resources.new()
    local self = setmetatable({}, Resources)
    self.Sprites = {}
    self.Fonts = {}
    self.Audio = {}

    self.Sprites.Player = love.graphics.newImage("src/assets/images/player/handgun/idle/survivor-idle_handgun_0.png")
    self.Sprites.Enemy = love.graphics.newImage("src/assets/images/enemy/skeleton-attack_0.png")
    self.Fonts.GeneralFont = love.graphics.newFont("src/assets/fonts/jaro/Jaro_24pt-Regular.ttf")
    love.graphics.setFont(self.Fonts.GeneralFont)
    return self
end

function Resources:draw()
    if _G.Game.Player.Health <= 0 then
        _G.Screen:apply()
    end
end



return Resources
