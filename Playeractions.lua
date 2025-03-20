local Playeractions = {}
local text
local updownspeed = 1 
local leftrightspeed = 1
local playersprite 

function Playeractions.load()
  love.graphics.setNewFont(12)
  
  text=("Blank for now")
  playerpos = {}
  playerpos.x = 300
  playerpos.y = 330
  playersprite = love.graphics.newImage('art/playership1.png')
end

function Playeractions.update(dt)
  if love.keyboard.isDown("left") then
    Playeractions.whenmoveleft()
  end
  
  if love.keyboard.isDown("right") then
    Playeractions.whenmoveright()
    end
  if love.keyboard.isDown("up") then
    Playeractions.whenmoveup()
    end
  if love.keyboard.isDown("down") then
    Playeractions.whenmovedown()
    end
  
end

function Playeractions.draw()
  --love.graphics.print(text, playerpos.x,playerpos.y)
  love.graphics.draw(playersprite, playerpos.x, playerpos.y)
end

function Playeractions.whenmoveleft()
  playerpos.x = playerpos.x - leftrightspeed
end 

function Playeractions.whenmoveright()
  playerpos.x = playerpos.x + leftrightspeed
end 

function Playeractions.whenmoveup()
  playerpos.y = playerpos.y - updownspeed
end 

function Playeractions.whenmovedown()
  playerpos.y = playerpos.y + updownspeed
end 


return Playeractions