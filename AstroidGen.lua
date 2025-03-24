AstroidGen = Object.extend(Object)

function outOfBounds(x, y, width)
end


function AstroidGen:new(speed)
    local width, height = love.graphics.getDimensions()
    self.x = 0
    self.y = -2
    self.width = 35
    self.height = 3
    self.speed = 90
    self.patterns = {"LINE", "L", "MBLOCKER"}
    self.pattern = "LINE"
    self.spawned = false
    self.coolDown = 2
end




function AstroidGen:update(dt)
    if self.coolDown >= 2 then
       if self.pattern == "LINE" then
        
        local x, y = 0, 0
        
        while x <= love.graphics.getWidth() do
            table.insert(listOfAstroids, Astroid(x, y, self.speed))
            x = x + self.width + 1
        end
        self.spawned = true
        self.coolDown = 0
        elseif self.pattern == "L" then
            local x, y = 0, 0
            --do stuff to make them spawn in an L shape
            local side = math.random(0,1)
            if side == 0 then
                --The wall will be on the right
                x = love.graphics.getWidth() / 2
                while x <= love.graphics.getWidth() do
                    table.insert(listOfAstroids, Astroid(x, y, self.speed))
                    x = x + self.width + 1
                end

                local xMod = love.graphics.getWidth()/2
                for i = 0, 10, 1 do
                    local varyingSpeed = self.speed + (i*10)
                    table.insert(listOfAstroids, Astroid(xMod,y, varyingSpeed))
                end
                self.spawned = true
                self.coolDown = 0

            elseif side == 1 then
                --Wall will be on the left side
                x = 0
                while x <= (love.graphics.getWidth() / 2) do
                    table.insert(listOfAstroids, Astroid(x, y, self.speed))
                    x = x + self.width + 1
                end
                --spawn the center line of astroids
                --start with a 10 count of astroids
                local xMod = love.graphics.getWidth() / 2
                for i = 0, 10, 1 do
                   local varyingSpeed = self.speed + (i*10)
                   table.insert(listOfAstroids, Astroid(xMod, y, varyingSpeed)) 
                end
                self.spawned = true
                self.coolDown = 0
        elseif self.pattern == "MBLOCKER" then
            local startX = math.random(0, love.graphics.getWidth()-(4*self.width))
            startX = 0
            local i = 0
            local x, y = 0, 0
            while i < 3 do
                table.insert(listOfAstroids, Astroid(startX, y, self.speed))
                i = i + 1
                startX = startX + self.width + 1
            end
            self.spawned = true
            self.coolDown = 0
        end
            love.graphics.print("Hello world", 100, 100)
        self.coolDown = self.coolDown + dt
    end
end
self.coolDown = self.coolDown + dt
end



