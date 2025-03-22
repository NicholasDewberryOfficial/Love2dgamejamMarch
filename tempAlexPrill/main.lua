if arg[2] == "debug" then
    require("lldebugger").start()
end

function isOffScreen(astroid)
    if (astroid.x < 0) or (astroid.x > love.graphics.getWidth()) or (atroid.y > love.graphics.getHeight()) then
        return true
    end
    return false
end

function love.load()
    Object = require "classic"
    require "AstroidGen"
    require "Astroid"

    generator = AstroidGen(10)
    ass = Astroid(10, 10 , 10)
    listOfAstroids = {}
end


function love.update(dt)
    ass:update(dt)
    generator:update(dt)
    for i, v in ipairs(listOfAstroids) do
        v:update(dt)
    end
    for i, v in ipairs(listOfAstroids) do
        if isOffScreen(v) then
            table.remove(listOfAstroids, i)
        end
    end
end

function love.draw()
    ass:draw()
    for i, v in ipairs(listOfAstroids) do
        v:draw()
    end
end