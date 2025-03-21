AstroidGen = Object.extend(Object)

function outOfBounds(x, y, width)
end


function AstroidGen:new(speed)
    local width, height = love.graphics.getDimensions()
    self.x = (width / 2) -1
    self.y = -2
    self.width = 3
    self.height = 3
    self.speed = speed
    self.patterns = {"LINE"}
    self.pattenr = "LINE"
    self.spawned = false
end




function AstroidGen:update(dt)
    if not self.spawned then
        
    end
end
