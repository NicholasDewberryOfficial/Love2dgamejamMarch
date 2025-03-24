Astroid = Object:extend()

local myquadart

--https://www.codecademy.com/resources/docs/lua/mathematical-library/random

function Astroid:new(x, y, speed, newimage)
    --self.image = love.graphics.newImage("Astroid.png")
    self.x = x
    self.y = y
    self.xSpeed = 0
    self.ySpeed = 0
    self.speed = speed
    
    --Testing purposes code
    self.width = 35
    self.height = 35
    --self.height = self.image:getHeight()
    --self.width = self.image:getWidth()
    self.image = newimage
    
    self.disabled = false
end

function givememyquad()
  val =  math.random(1,1)
  
  if val == 1 then 
  return love.graphics.newQuad(0,0,32,32, spirtesheetimg)
  end
end


function Astroid:update(dt)
  if disabled == 1 then return end
    self.y = self.y + self.speed * dt
end


function Astroid:draw()
    if not disabled then 
      love.graphics.draw(self.image, self.x,self.y)
    end 
    --love.graphics.setColor(255, 0, 0)
    --love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    --love.graphics.draw(sprite, v.x, v.y, 0, 1,1, sprite:getWidth()/2, sprite:getHeight()/2 )
    
end



