io.stdout:setvbuf("no")
--[[IDEALLY main.lua is reserved just
    for loading stuff and
    basic scene-to-scene logic (EX. going from mainmenu/bacck)
    Best practices say: keep stuff to its own file
    
    ]]
  
local playeractions = require("Playeractions")
function love.load()
  love.window.setMode(609, 812, {resizable=true, vsync=0, minwidth=480, minheight=640})
  print("Game loaded")
  playeractions.load()
end

function love.update(dt)
  playeractions.update(dt)
end


function love.draw()
    love.graphics.print("I'm in your walls")
    playeractions.draw()
end

