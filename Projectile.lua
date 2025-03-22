local Projectile = {}
local sprite

function Projectile.load()
    sprite = love.graphics.newImage('art/projectile.png')
    bullets = {}
    bulletSpeed = 100
end

function Projectile.update(dt)
   for i,v in ipairs(bullets) do
        v.y = v.y - (v.speed * dt)
        --if(v.y < 0) then 
       -- table.remove(bullets,v)
  -- end
   
end
end

function Projectile.draw()
    for i,v in ipairs(bullets) do 
        love.graphics.draw(sprite, v.x, v.y, 0, 1,1, sprite:getWidth()/2, sprite:getHeight()/2 )
    end
end

function Projectile.newProjectile(_x, _y)
    table.insert(bullets, {x = _x, y = _y, speed = bulletSpeed})
end

return Projectile