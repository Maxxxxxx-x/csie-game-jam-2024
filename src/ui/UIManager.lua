local UIManager = {}
UIManager.__index = UIManager
function UIManager.new()
    local self = setmetatable({}, UIManager)
    self.UIs = {}

    self.UIs.MainMenu = require("src.ui.Components.MainMenu")
    self.UIs.HowToPlay = require("src.ui.Components.HowToPlay")
    self.UIs.Credits = require("src.ui.Components.Credits")

    print("Createrd UI Manager")
    return self
end

function UIManager:show()
    if _G.GameState == "Play" then return end
    assert(self.UIs[_G.GameState] ~= nil, "Does not have UI component " .. _G.GameState)
    self.UIs[_G.GameState]:draw()
end

function UIManager:update(name, dt)
    if name == "Play" then return end
    assert(self.UIs[name] ~= nil, "Does not have UI component " .. name)
    self.UIs[name]:update(dt)
end

function UIManager:load()
    for _, v in pairs(self.UIs) do
        v:load()
    end
end

return UIManager
