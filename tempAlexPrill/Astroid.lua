Astroid = Object:extend()

function Astroid:new(x, y, speed)
    --self.image = love.graphics.newImage("Astroid.png")
    self.x = x
    self.y = y
    self.speed = speed
    
    --Testing purposes code
    self.width = 3
    self.height = 3
end


function Astroid:update(dt)
    self.y = self.y + self.speed * dt
end


function Astroid:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end