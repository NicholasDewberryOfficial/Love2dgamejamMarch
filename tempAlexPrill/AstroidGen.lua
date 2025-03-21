AstroidGen = Object.extend(Object)

function outOfBounds(x, y, width)
end


function AstroidGen:new(speed)
    local width, height = love.graphics.getDimensions()
    self.x = 0
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
       coordinates = {} 
       if self.pattern == "LINE" then

        coordinates.inserrt({0,0})
        local x, y = 0, 0
        while x <= love.graphics.getWidth() do
            x = x + self.width + 1
            --coordinates.insert{x, y}
            table.insert(listOfAstroids, Astroid(x, y, self.speed))
        end
    end
    end
end
