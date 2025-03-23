local Projectile = {}
local sprite

local plainText
local projectileCount
bullets = {}
function Projectile.load()
    sprite = love.graphics.newImage('art/projectile.png')
    bullets = {}
    bulletSpeed = 100
    Projectile.projectileCount = 20
    local font = love.graphics.newFont(15)
    plainText = love.graphics.newText(font, "Ammo Count: ")
end

function Projectile.update(dt)
   for i,v in ipairs(bullets) do
        v.y = v.y - (v.speed * dt)
   end
end 

function Projectile.draw()
    for i,v in ipairs(bullets) do 
        love.graphics.draw(sprite, v.x, v.y, 0, 1,1, sprite:getWidth()/2, sprite:getHeight()/2 )
    end
    love.graphics.draw(plainText, 0, love.graphics.getHeight() - 20 )
  
end

function Projectile.newProjectile(_x, _y)
    if Projectile.projectileCount > 0 then 
    table.insert(bullets, {x = _x, y = _y, speed = bulletSpeed, width = sprite:getWidth()/2, height = sprite:getHeight()/2})
    Projectile.projectileCount = Projectile.projectileCount - 1
    end 

    if Projectile.projectileCount == 0 then 
        plainText = love.graphics.newText(love.graphics.newFont(20), {{1,0,0}, "AMMO EMPTY"})
    else 
        plainText:set("Ammo Count: " ..  Projectile.projectileCount )
    end
end

function Projectile.getBullets()
if bullets == nil then return 0
else return bullets
end
end

return Projectile