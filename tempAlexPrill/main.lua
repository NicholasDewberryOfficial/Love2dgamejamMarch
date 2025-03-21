if arg[2] == "debug" then
    require("lldebugger").start()
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
        v:update()
    end
end

function love.draw()
    ass:draw()
    for i, v in ipairs(listOfAstroids) do
        v:draw()
    end
end