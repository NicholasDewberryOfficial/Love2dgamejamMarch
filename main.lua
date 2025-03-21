--DEWBERRY - for debugging and print statements. 
io.stdout:setvbuf("no")
--[[IDEALLY main.lua is reserved just
    for loading stuff and
    basic scene-to-scene logic (EX. going from mainmenu/bacck)
    Best practices say: keep stuff to its own file
    
    ]]
    
--gamestate represents what menu we're on. 
--0=mainmenu, 1=ingame, 2=death, 3=victory
local gamestate = 0

--loading in the other lua files 
local playeractions = require("Playeractions")
local mainmenuref = require("Mainmenuscreen")

function love.load()
love.window.setMode(609, 812, {resizable=true, vsync=0, minwidth=480, minheight=640})
love.switchscenes()
end

function love.switchscenes()
if gamestate == 0 
then
mainmenuref.initializeVals()
  
-- mainscene is entered: 

elseif gamestate == 1 then 
playeractions.load()

--end mainscene is entered

elseif gamestate == 2 then
--blank for now (no death screen) 
--@TODO: add win screen 
end

end
  
function love.update(dt)
if gamestate == 0 then 

--mainloop controls/physics/interactions

elseif gamestate == 1  then  
playeractions.update(dt)

--end mainloop controls/physics/interactions

elseif gamestate ==2  then
    --blank for now (no death screen) 
    --@TODO: add win screen 
  end
end 


function love.draw()
if gamestate == 0
then
mainmenuref.ShowMainMenu()
mainmenuref.MoveArrow()

--mainloop draw
elseif gamestate ==1 
then
playeractions.draw()

--end mainloopdraw

elseif gamestate ==2 
then
  --blank for now (no death screen) 
  --@TODO: add win screen 
end
end


--[[DEWBERRY, we use this function for controlling menu buttons. 
We can't do the simplle thing (iskeydown) because the key goes all the way down.
So we have to use this love.keypressed thingy. 
]]
function love.keypressed(key, scancode, isrepeat)
  --we use localscope as a 1-time use variable to switch scenes. It's ugly, but it works.
  localscope =0
  if gamestate == 0  then
  localscope = mainmenuref.keypressed(key)
  end
  if localscope == 1 then
  gamestate = 1 
  love.switchscenes()
  end

end

