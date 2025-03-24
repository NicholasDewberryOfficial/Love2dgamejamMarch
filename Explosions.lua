--Basically, this is a 1-shot class that creates an explosion then dips
local Explosions = {}

local explosion = {}
function createExplosion(x, y)
  -- Load your particle image (this should be done once in love.load ideally)
  local particleImage = love.graphics.newImage("art/explosionparticle.png")
  
  explosion = {}
  explosion.x = x
  explosion.y = y

  -- Create a new particle system with a buffer for up to 100 particles.
  --100 might be overkill
  explosion.ps = love.graphics.newParticleSystem(particleImage, 100)
  
  -- Configure the particle system for a short explosion effect.
  explosion.ps:setEmitterLifetime(0.1, .15)   -- Each particle lives between 0.1 and .15 seconds. Too short...??
  explosion.ps:setEmissionRate(100)          -- Emission rate if in continuous mode (not used here).
  explosion.ps:setSizes(1, 0)                -- Particles shrink from full size to 0.
  explosion.ps:setSpeed(200, 400)            -- Random speed for particles.
  explosion.ps:setSpread(math.pi * 2)        -- Emit in all directions.
  
  -- Immediately emit 50 particles.
  explosion.ps:emit(50)
  
  -- Update function: call this from love.update(dt)
  --do this on every explosion in the table
  function explosion:update(dt)
    self.ps:update(dt)
  end
  
  -- Draw function: call this from love.draw
  function explosion:draw()
    love.graphics.draw(self.ps, self.x, self.y)
  end
  
  -- Returns true if the explosion is finished (all particles have faded)
  function explosion:isFinished()
    return self.ps:getCount() == 0
  end
  
  return explosion
end

return Explosions