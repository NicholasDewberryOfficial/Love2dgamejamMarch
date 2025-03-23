local Projectile = {}
local sprite

local ammoCountText
local projectileCount
bullets = {}
function Projectile.load()
    sprite = love.graphics.newImage('art/projectile.png')
    Projectile.projectileCount = 30
    local font = love.graphics.newFont(15)
    ammoCountText = love.graphics.newText(font, "Ammo Count: ")
end

function Projectile.update(dt)
    local projectilesToRemove = {}
   for i,v in ipairs(bullets) do
        if v.currSpeed < v.maxSpeed then 
            v.currSpeed = v.currSpeed + v.acceleration * dt
        else 
            v.currSpeed = v.maxSpeed
        end 
        v.y = v.y - (v.currSpeed * dt)
        if not Projectile.checkInBounds(v.x, v.y, v.width, v.height) then 
            table.insert(projectilesToRemove, i)
        end
   end

   for i,v in ipairs(projectilesToRemove) do 
        table.remove(bullets, v)
    end 
end 

function Projectile.checkInBounds(x, y, width, height)
    -- make sure projectile is completely offscreen before removing
    
    -- top border
    if y + height/2 < 0 then 
        return false 
    end
    
    -- bottom border
    if y - height/2 > love.graphics:getHeight() then 
        return false
    end 
    
    -- left border
    if x + width/2 < 0 then 
        return false 
    end 

    -- right border
    if x - width/2 > love.graphics:getWidth() then 
        return false
    end 

    return true
end 

function Projectile.draw()

    for i,v in ipairs(bullets) do 
        love.graphics.draw(sprite, v.x, v.y, 0, 1,1, sprite:getWidth()/2, sprite:getHeight()/2 )
        love.graphics.print("curr speed: " .. v.currSpeed, 0, 0)
    end

    love.graphics.draw(ammoCountText, 0, love.graphics.getHeight() - 20 )
end

function Projectile.newProjectile(_x, _y)
    if Projectile.projectileCount > 0 then 
    table.insert(bullets, {x = _x, y = _y, width = sprite:getWidth(), height = sprite:getHeight(), currSpeed = 100, maxSpeed = 400, acceleration = 400})
    Projectile.projectileCount = Projectile.projectileCount - 1
    end 

    if Projectile.projectileCount == 0 then 
        ammoCountText = love.graphics.newText(love.graphics.newFont(20), {{1,0,0}, "AMMO EMPTY"})
    else 
        ammoCountText:set("Ammo Count: " ..  Projectile.projectileCount )
    end
end

function Projectile.getBullets()
if bullets == nil then return 0
else return bullets
end
end

return Projectile