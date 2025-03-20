local Playeractions = {}
local updownspeed = 1 
local leftrightspeed = 1
local playersprite 

function Playeractions.load()
  
  --player movement
  playerpos = {}
  playerpos.x = 300
  playerpos.y = 330
  
  --player art animations
  playersprite = love.graphics.newImage('art/Ligher.png')
  animation = Playeractions.newAnimation(playersprite, 32,32,.5)
end


function Playeractions.update(dt)
  --animation
  animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end
  --player movmenet
  Playeractions.movementactions()
  
end

function Playeractions.movementactions()
  --player movement
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
  local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
  love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], playerpos.x, playerpos.y, 0,1.5, 1.5)
  --love.graphics.print(text, playerpos.x,playerpos.y)
  --love.graphics.draw(playersprite, playerpos.x, playerpos.y, 0,.3, .3)
    
end



function Playeractions.newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
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