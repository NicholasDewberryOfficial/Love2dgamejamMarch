if arg[2] == "debug" then
  require("lldebugger").start()
end
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
local winscreenref = require("Winscreen")

local projectilearrref = require("Projectile")
local explosions = require("Explosions")

--not a timer, its a stopwatch
local gameTime =0 
local deathanimtime = 0 

--checks if astroids are off screen, erases them
function isOffScreen(astroid)
  if (astroid.x < 0 or astroid.x > love.graphics.getWidth() or astroid.y > love.graphics.getHeight()) then
  return true
  else
  return false
  end
end

--used for projectile collisions
-- collision formula is calculated with the assumption that the projectile sprites position is in the center of the sprite
-- while the asteroid position is at the top left of the sprite
function checkProjectileCollision(obj1, obj2)
    return obj1.x - obj1.width/2 < obj2.x + obj2.width and
           obj1.x + obj1.width/2 > obj2.x and
           obj1.y - obj1.height/2 < obj2.y + obj2.height and
           obj1.y + obj1.height/2 > obj2.y
end

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
listOfAstroids = {}
Object = require "classic"
require "AstroidGen"
require "Astroid"
generator = AstroidGen(10)
playeractions.load()
gameTime =0
deathanimtime = 0 
--end mainscene is entered

elseif gamestate == 2 then
--blank for now (no death screen) 
losescreenref.initializeVals()

elseif gamestate == 3 then
winscreenref.initializeVals()

end



end
  
function love.update(dt)
--mainmenu controls/physics/interaction
if gamestate == 0 then 
--end mainmenu

--mainloop controls/physics/interactions
elseif gamestate == 1  then  
playeractions.update(dt)


for index, boom in ipairs(explosions) do
    boom:update(dt)
    if boom:isFinished() then
      --This might not be necessary
      --table.remove(explosions, boom)
    end
  end


--Here is where we iterate through the astroids.
generator:update(dt)
for i, v in ipairs(listOfAstroids) do
  v:update(dt)
  if playeractions.checkCollision(v) 
  then  
    --play death anim
    --@TODO player death explosion aint working
    table.insert(explosions, createExplosion(v.x, v.y))
    if deathanimtime > 3 then
    --go to next screen
    playeractions.playerDeath()
  else 
    deathanimtime = deathanimtime + dt
  end
  end
end

--logic for erasing astroids 
for i, v in ipairs(listOfAstroids) do
  if isOffScreen(v) then
    table.remove(listOfAstroids, i)
  end
end

--see if any bullets and astroids are colliding. if they are, delete em
local bulletsToRemove = {}
local asteroidsToRemove = {}
for i, b in ipairs(projectilearrref.getBullets()) do
  for x, c in ipairs(listOfAstroids) do 
    if checkProjectileCollision(b, c) then
      table.insert(bulletsToRemove, i)
      table.insert(explosions, createExplosion(c.x, c.y))
      table.insert(asteroidsToRemove, x)
    end
  end
end

-- moved the removal of asteroids / bullets to outside of the loop iterating for collisions
-- dangerous to remove items from a list while iterating through that same list
for i, b in ipairs(bulletsToRemove) do 
  table.remove(projectilearrref.getBullets(), b)
end

for i, b in ipairs(asteroidsToRemove) do
  table.remove(listOfAstroids, b) 
end

--for winning and losing, this
arcadeControlFlow()

--for increasing the time 
gameTime = gameTime + dt

--end mainloop controls/physics/interactions

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
for i, v in ipairs(listOfAstroids) do
  v:draw()
end
playeractions.draw()
  
for index, explosion in ipairs(explosions) do
  explosion:draw()
  end



--end mainloopdraw

elseif gamestate ==2 
then
losescreenref:drawMenu()
losescreenref:MoveArrow()


elseif gamestate ==3
then
winscreenref:drawMenu()
winscreenref:MoveArrow()
end
end




function arcadeControlFlow()

  localscope = 0
    if gamestate == 1 then
    localscope = playeractions.checkforwinorloss()
    end
  
--@TODO change this for game time. rn the game ends in 30 seconds.
  if gameTime > 30 then
  localscope = 3 
  end 
  
    --(death) actiongame -> deathscreen
  if localscope == 2 and gamestate == 1 then
  losescreenref.findcsscore(calculatescore())
  gamestate = 2
  love.switchscenes()
end

--winscreen
if localscope == 3 and gamestate == 1 then
  winscreenref.findcsscore(calculatescore())
  gamestate = 3
  love.switchscenes()
  end
end 

--@TODO change this for game balance
function calculatescore()
  return ( (gameTime * 10) + (playeractions.howmuchammo() * 300) )
end


--[[DEWBERRY, we use this function for controlling menu buttons. 
We can't do the simplle thing (iskeydown) because the key goes all the way down.
So we have to use this love.keypressed thingy. 
]]
--need revamped

function love.keypressed(key, scancode, isrepeat)
  --we use localscope as a 1-time use variable to switch scenes. It's ugly, but it works.
  --this section is for loading in the main menu
  localscope =0
  if gamestate == 0  then
  localscope = mainmenuref.keypressed(key)
  end
  

  
  if gamestate == 2 then 
  localscope = losescreenref.keypressed(key)
end 

if gamestate == 3 then 
  localscope = winscreenref.keypressed(key)
end 
  
--this section is for starting the action gamefrom the mainmenu 
  if localscope == 1 and gamestate == 0 then
  gamestate = 1 
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

--winscren stuff  
if localscope == 1 and gamestate == 3 then
  gamestate = 1
  love.switchscenes()
end
--win screen -> main menu
  if localscope == 0 and gamestate == 3 then
  gamestate = 0
  love.switchscenes()
end



end

end