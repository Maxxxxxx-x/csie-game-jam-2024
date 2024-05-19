local Suit = require("src.lib.suit")

local Menu = {}
Menu.__index = {}
Menu.Name = "HowToPlay"

function Menu:load()
    Suit.theme.color.normal.fg = { 255, 255, 255 }
    Suit.theme.color.hovered = { bg = { 200, 230, 255 }, fg = { 0, 0, 0 } }
    Suit.theme.color.active = { bg = { 200, 230, 255 }, fg = { 0, 0, 0 } }
    print("Loaded menu" .. self.Name)
end

function Menu:update(dt)
    Suit.layout:reset(500, 450)
    Suit.layout:padding(30, 30)

    if _G.GameState == "HowToPlay" then
        if Suit.Button("Back", { id = 4 }, Suit.layout:row(300, 30)).hit then
            _G.GameState = "MainMenu"
        end
    end
end

function Menu:draw()
    love.graphics.printf(
        "WASD - Character Movement\nLMB - Shoot\nRMB - Aim Down Sights",
        400,
        320,
        500,
        "center"
    )
    Suit.draw()
end

return Menu
