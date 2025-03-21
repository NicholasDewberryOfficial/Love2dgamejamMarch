io.stdout:setvbuf("no")
--[[IDEALLY main.lua is reserved just
    for loading stuff and
    basic scene-to-scene logic (EX. going from mainmenu/bacck)
    Best practices say: keep stuff to its own file
    
    ]]
    
local gamestate
  
local playeractions = require("Playeractions")
local mainmenuref = require("Mainmenuscreen")
function love.load()
gamestate = 0
love.window.setMode(609, 812, {resizable=true, vsync=0, minwidth=480, minheight=640})
if gamestate == 0 
then
mainmenuref.initializeVals()


  
elseif gamestate == 1 then 


playeractions.load()

elseif gamestate == 2 then

end

end

function love.update(dt)
if gamestate == 0  then
mainmenuref.selectTheOption(dt)

elseif gamestate == 1  then  
playeractions.update(dt)

elseif gamestate ==2  then
    
  end
end 


function love.draw()
if gamestate == 0
then
mainmenuref.ShowMainMenu()
mainmenuref.MoveArrow()
elseif gamestate ==1 
then
playeractions.draw()
elseif gamestate ==2 
then
  
end
end

