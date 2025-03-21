local Playeractions = {}
local updownspeed = 1 
local leftrightspeed = 1
local playersprite 
local projectile = require("Projectile")
local fireCooldownTimer = 0
local fireCooldown = .15 -- modify to control projectile generation
local canFire = true

-- declared here so can be used for sprite animation calculation
local quadx = 32
local quady = 32

--audio section 
local shootsound = love.audio.newSource("audio/alienshoot1.wav", "static")
local bgmusic = love.audio.newSource("audio/alienshoot1.wav", "stream")

--base is 1, losing is 2, winning is 3 
local haswonorlost = 1

function Playeractions.load()
  haswonorlost = 1
  bgmusic:setLooping(true)
 --@TODO: UNCOMMENT THIS ONCE WE GET ACUTAL MUSIC!! bgmusic:play()
 
  --player movement
  playerpos = {}
  playerpos.x = 300
  playerpos.y = 330
  
  --player art animations
  playersprite = love.graphics.newImage('art/Ligher.png')
  animation = Playeractions.newAnimation(playersprite, quadx, quady,.5)
  projectile.load()
  
end

function Playeractions.update(dt)
  --animation
  animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end
  --player movmenet
  Playeractions.movementactions()

  Playeractions.updateFireCoolDown(dt)
  projectile.update(dt)
  
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

  -- player firing
  if love.keyboard.isDown("z") then 
      Playeractions.fire()
    end
  if love.keyboard.isDown("p") then 
    haswonorlost = 2
    end
end

function Playeractions.draw()
  local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
  love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], playerpos.x, playerpos.y, 0,1.5, 1.5, (quadx / 2) , (quady/ 2) )
  projectile.draw()
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

function Playeractions.fire()
  if canFire then 
    projectile.newProjectile(playerpos.x , playerpos.y - 50)
    canFire = false
    fireCooldownTimer = 0;
    shootsound:play()
  end 
end

function Playeractions.updateFireCoolDown(dt)
  if (not canFire) then 
    if(fireCooldownTimer >= fireCooldown) then
      canFire = true;
    else
      fireCooldownTimer = fireCooldownTimer + dt
    end  
  end
end

function Playeractions.checkforwinorloss()
  return haswonorlost
end 

return Playeractions