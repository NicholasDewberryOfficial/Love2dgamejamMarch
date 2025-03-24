local Playeractions = {}
local playersprite 
local projectile = require("Projectile")
local fireCooldownTimer = 0
local fireCooldown = .15 -- modify to control projectile generation
local canFire = true

-- declared here so can be used for sprite animation calculation
local quadx = 32
local quady = 32

local scalex = 1.5
local scaley = 1.5

-- used for decceleration purposes
local direction = {up = 1, down = 2, left = 3, right = 4}
local lastPressed

--audio section 
local shootsound = love.audio.newSource("audio/alienshoot1.wav", "static")
local noAmmoSFX = love.audio.newSource("audio/ErrorMessage_NoAmmo_Clipped.wav", "static")
local bgmusic = love.audio.newSource("audio/alienshoot1.wav", "stream")

--base is 1, losing is 2, winning is 3 
local haswonorlost = 1

--local enemy = { x = 150, y = 150, width = 50, height = 50 }

function Playeractions.checkCollision(enemyobject)
    return playerpos.x - playerpos.width/2 < enemyobject.x + enemyobject.width and
           playerpos.x + playerpos.width/2 > enemyobject.x and
           playerpos.y - (playerpos.height/2 * scaley) < enemyobject.y + enemyobject.height and
           playerpos.y + (playerpos.height/2 * scaley) > enemyobject.y
end

function Playeractions.load()
  haswonorlost = 1
  bgmusic:setLooping(true)
 --@TODO: UNCOMMENT THIS ONCE WE GET ACUTAL MUSIC!! bgmusic:play()
 
  --player movement
  playerpos = {}
  playerpos.x = 300
  playerpos.y = 330
  playerpos.width = quadx
  playerpos.height = quady
  playerpos.MinSpeed = 300
  playerpos.CurrSpeed = playerpos.MinSpeed
  playerpos.Acceleration = 700
  playerpos.Decceleration = 4000
  playerpos.MaxSpeed = 500

  --@TODO: for some reason wheenever we start the scene
  --we automatically shoot
  
  
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
  Playeractions.movementactions(dt)
  Playeractions.updateFireCoolDown(dt)
  projectile.update(dt)

end

function Playeractions.movementactions(dt)
  --player movement
  if love.keyboard.isDown("left") then
      Playeractions.whenmoveleft(dt)
      lastPressed = direction.left
  end
  
  if love.keyboard.isDown("right") then
      Playeractions.whenmoveright(dt)
      lastPressed = direction.right
  end

  if love.keyboard.isDown("up") then
      Playeractions.whenmoveup(dt)
      lastPressed = direction.up
  end

  if love.keyboard.isDown("down") then
      Playeractions.whenmovedown(dt)
      lastPressed = direction.down
  end

  if not love.keyboard.isDown("left") and not love.keyboard.isDown("right") and not love.keyboard.isDown("up") and not
  love.keyboard.isDown("down") then 
    Playeractions.deccelerate(dt)
  end 

  Playeractions.checkBounds()
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
  love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], playerpos.x, playerpos.y, 0, scalex, scaley, (quadx / 2) , (quady/ 2) )
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


function Playeractions.checkBounds()
  
  -- check left border
  if(playerpos.x - (playerpos.width/2) <= 0 ) then
    playerpos.x = playerpos.width/2
  end
  -- check right border
  if(playerpos.x + (playerpos.width/2 ) >= love.graphics.getWidth()) then 
    playerpos.x = love.graphics.getWidth() - (playerpos.width/2)
  end
  -- check top border
  if(playerpos.y + (playerpos.height/2 * scaley) >= love.graphics.getHeight()) then
    playerpos.y = love.graphics.getHeight() - (playerpos.height/2 * scaley)
  end
  -- check bottom border
  if(playerpos.y - (playerpos.height/2 * scaley) <= 0) then 
    playerpos.y = playerpos.height/2  * scaley
  end 

  return true
end

function Playeractions.accelerate(dt)
  playerpos.CurrSpeed = playerpos.CurrSpeed + playerpos.Acceleration * dt
  if(playerpos.CurrSpeed > playerpos.MaxSpeed) then 
    playerpos.CurrSpeed = playerpos.MaxSpeed
  end 
end

function Playeractions.deccelerate(dt)
  if (playerpos.CurrSpeed > playerpos.MinSpeed) then 
    playerpos.CurrSpeed = playerpos.CurrSpeed - playerpos.Decceleration * dt

    --- clamp the player speed
    if(playerpos.CurrSpeed < playerpos.MinSpeed) then 
      playerpos.CurrSpeed = playerpos.MinSpeed
    end 

    if(lastPressed == direction.up) then
      playerpos.y = playerpos.y - playerpos.CurrSpeed * dt 
    end 
    if (lastPressed == direction.down) then 
      playerpos.y = playerpos.y + playerpos.CurrSpeed * dt
    end 
    if (lastPressed == direction.right) then 
      playerpos.x = playerpos.x + playerpos.CurrSpeed * dt
    end
    if (lastPressed == direction.left) then 
      playerpos.x = playerpos.x - playerpos.CurrSpeed * dt
    end 
  end  
end 

function Playeractions.whenmoveleft(dt)
  Playeractions.accelerate(dt)
  playerpos.x = playerpos.x - playerpos.CurrSpeed * dt
end 

function Playeractions.whenmoveright(dt)
  Playeractions.accelerate(dt)
  playerpos.x = playerpos.x + playerpos.CurrSpeed * dt
end 

function Playeractions.whenmoveup(dt)
  Playeractions.accelerate(dt)
  playerpos.y = playerpos.y - playerpos.CurrSpeed * dt
end 

function Playeractions.whenmovedown(dt)
  Playeractions.accelerate(dt)
  playerpos.y = playerpos.y + playerpos.CurrSpeed * dt
end 

function Playeractions.fire()
  if projectile.projectileCount > 0 then
    if canFire then 
      shootsound:play()
      projectile.newProjectile(playerpos.x , playerpos.y - 30)
      canFire = false
      fireCooldownTimer = 0;
      shootsound:play()
    end 
  else 
    noAmmoSFX:play()
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

function Playeractions.playerDeath()
  haswonorlost = 2
end

function Playeractions.returnplayerX()
  return playerpos.x
end

function Playeractions.returnplayery()
  return playerpos.y
end

function Playeractions.howmuchammo()
  return projectile.projectileCount
end


return Playeractions