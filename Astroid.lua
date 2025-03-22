Astroid = Object:extend()

function Astroid:new(x, y, speed)
    --self.image = love.graphics.newImage("Astroid.png")
    self.x = x
    self.y = y
    self.xSpeed = 0
    self.ySpeed = 0
    self.speed = 10
    
    --Testing purposes code
    self.width = 35
    self.height = 35
    --self.height = self.image:getHeight()
    --self.width = self.image:getWidth()
end


function Astroid:update(dt)
    self.y = self.y + self.speed * dt
end


function Astroid:draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end