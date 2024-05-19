local Suit = require("src.lib.suit")

local IsOnButton = {}

local Buttons = {
    { Name = "Start",       GameState = "Play" },
    { Name = "How to Play", GameState = "HowToPlay" },
    { Name = "Credits",     GameState = "Credits" },
    { Name = "Back",        Requires = { ["HowToPlay"] = true, ["Credits"] = true }, GameState = "MainMenu" },
    {
        Name = "Exit",
        GameState = "Exit",
        Callback = function()
            love.event.quit()
        end
    }
}

local Menu = {}
Menu.__index = Menu
Menu.Name = "MainMenu"

function Menu:load()
    Suit.theme.color.normal.fg = { 255, 255, 255 }
    Suit.theme.color.hovered = { bg = { 200, 230, 255 }, fg = { 0, 0, 0 } }
    Suit.theme.color.active = { bg = { 200, 230, 255 }, fg = { 0, 0, 0 } }
    print("Loaded menu" .. self.Name)
end

function Menu:update(dt)
    Suit.layout:reset(500, 350)
    Suit.layout:padding(30, 30)

    for i, btn in pairs(Buttons) do
        if #IsOnButton == 0 then
           IsOnButton[btn.GameState] = false
        end

        if btn.Requires == nil then
            if Suit.Button(btn.Name, { id = i }, Suit.layout:row(300, 30)).hit then
                if btn.Callback then
                    btn.Callback()
                    return
                end
                if _G.GameState ~= btn.GameState then
                    _G.GameState = btn.GameState
                    print("New state: ".._G.GameState)
                end
            end
        else
            if (btn.Requires[_G.GameState]) then
                if Suit.Button(btn.Name, { id = i }, Suit.layout:row(300, 30)).hit then
                    if _G.GameState ~= btn.GameState then
                        _G.GameState = btn.GameState
                        print("Back clicked")
                    end
                end
            end
        end

        if Suit.isHovered(i) and not IsOnButton[btn.GameState] then
            IsOnButton[btn.GameState] = true
        elseif not Suit.wasHovered(i) then
            IsOnButton[btn.GameState] = false
        end
    end

end

function Menu:draw()
    Suit.draw()
end

return Menu
