local AstroidController = {}
local Astroid = require("Astroid")
local asteroids = {}
local spawnCooldown = 0.3

-- Initialize/reset the controller.
function AstroidController.start()
    spawnCooldown = 0.3
end

-- Update tick: handle spawning, updating, and removing asteroids.
function AstroidController.update(dt)
    -- Decrement the cooldown timer.
    spawnCooldown = spawnCooldown - dt
    if spawnCooldown <= 0 then
        -- Spawn a new asteroid.
        -- For example, spawn at a random x between 50 and 750, and above the screen.
        local x = math.random(50, 750)
        local y = -50
        local newAsteroid = Astroid.new(x, y)
        table.insert(asteroids, newAsteroid)
        spawnCooldown = 0.3  -- reset the cooldown
    end

    -- Update all asteroids and remove those that should be removed.
    for i = #asteroids, 1, -1 do
        local a = asteroids[i]
        a:update(dt)
        if a:shouldRemove() then
            table.remove(asteroids, i)
        end
    end
end

-- Draw all asteroids.
function AstroidController.draw()
    for _, a in ipairs(asteroids) do
        a:draw()
    end
end

return AstroidController
