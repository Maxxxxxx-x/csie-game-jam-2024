local Game = require("src.game.game").new()

function love.load()
    Game:load()
    Game.UIManager:load()

end

function love.update(dt)
    Game:update(dt)
end

function love.draw()
    Game:draw()
end

function love.focus(focused)
    Game.Paused = not focused
end
