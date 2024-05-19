local Suit = require("src.lib.suit")

local Menu = {}
Menu.__index = {}
Menu.Name = "Credits"

function Menu:load()
    Suit.theme.color.normal.fg = { 255, 255, 255 }
    Suit.theme.color.hovered = { bg = { 200, 230, 255 }, fg = { 0, 0, 0 } }
    Suit.theme.color.active = { bg = { 200, 230, 255 }, fg = { 0, 0, 0 } }
    print("Loaded menu" .. self.Name)
end

function Menu:update(dt)
    Suit.layout:reset(500, 450)
    Suit.layout:padding(30, 30)

    if _G.GameState == "Credits" then
        if Suit.Button("Back", { id = 4 }, Suit.layout:row(300, 30)).hit then
            _G.GameState = "MainMenu"
        end
    end
end

function Menu:draw()
     love.graphics.printf(
        "Maxxxxxxxxx - Code\nMiyukiii - Artistic Design, Game Design\npika0303 - Artistic Design, Game Design",
        400,
        320,
        500,
        "center"
    )

    Suit.draw()
end

return Menu
