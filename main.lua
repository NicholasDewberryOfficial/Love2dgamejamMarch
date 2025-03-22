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
local losescreenref = require("Losescreen")


local gameSceneBG
function love.load()
love.window.setMode(609, 812, {resizable=true, vsync=0, minwidth=480, minheight=640})
love.switchscenes()
gameSceneBG = love.graphics.newImage('art/gameBG.png')
end

function love.switchscenes()
if gamestate == 0 
then
mainmenuref.initializeVals()
  
-- mainscene is entered: 

elseif gamestate == 1 then 
--asc.start()
playeractions.load()
--end mainscene is entered

elseif gamestate == 2 then
--blank for now (no death screen) 
losescreenref.initializeVals()
end

end
  
function love.update(dt)
--mainmenu controls/physics/interaction
if gamestate == 0 then 
--end mainmenu

--mainloop controls/physics/interactions
elseif gamestate == 1  then  
--asc.update(dt)
playeractions.update(dt)

--end mainloop controls/physics/interactions

elseif gamestate ==2  then
    --blank for now (no death screen) 
    --@TODO: add win screen 
  
  end
end 


function love.draw()
  
--mainmenu draw graphics
if gamestate == 0
then
mainmenuref.ShowMainMenu()
mainmenuref.MoveArrow()
--end mainmenu draw graphics 

--mainloop draw
elseif gamestate ==1 
then

love.graphics.draw(gameSceneBG, 0, 0)

playeractions.draw()


--end mainloopdraw

elseif gamestate ==2 
then
losescreenref:drawMenu()
losescreenref:MoveArrow()
end
end


--[[DEWBERRY, we use this function for controlling menu buttons. 
We can't do the simplle thing (iskeydown) because the key goes all the way down.
So we have to use this love.keypressed thingy. 
]]
function love.keypressed(key, scancode, isrepeat)
  --we use localscope as a 1-time use variable to switch scenes. It's ugly, but it works.
  --this section is for loading in the main menu
  localscope =0
  if gamestate == 0  then
  localscope = mainmenuref.keypressed(key)
  end
  
  if gamestate == 1 then
    localscope = playeractions.checkforwinorloss()
  end
  
  if gamestate == 2 then 
  localscope = losescreenref.keypressed(key)
end 
  
--this section is for starting the action gamefrom the mainmenu 
  if localscope == 1 and gamestate == 0 then
  gamestate = 1 
  love.switchscenes()
end

--(death) actiongame -> deathscreen
  if localscope == 2 and gamestate == 1 then
  gamestate = 2
  love.switchscenes()
  end

--lose screen -> restartactiongame
  if localscope == 1 and gamestate == 2 then
  gamestate = 1
  love.switchscenes()
end
--lose screen -> main menu
  if localscope == 0 and gamestate == 2 then
  gamestate = 0
  love.switchscenes()
  end






end


