AstroidGen = Object.extend(Object)

function outOfBounds(x, y, width)
end


function AstroidGen:new(speed)
    local width, height = love.graphics.getDimensions()
    self.x = 0
    self.y = -2
    self.width = 3
    self.height = 3
    self.speed = 10
    self.patterns = {"LINE"}
    self.pattern = "LINE"
    self.spawned = false
end




function AstroidGen:update(dt)
    if self.spawned == false then
       if self.pattern == "LINE" then

        local x, y = 0, 0
        while x <= love.graphics.getWidth() do
            x = x + self.width + 1
            --coordinates.insert{x, y}
            table.insert(listOfAstroids, Astroid(x, y, self.speed))
        end
        self.spawned = true
    end
    end
end
