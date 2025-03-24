AstroidGen = Object.extend(Object)

function outOfBounds(x, y, width)
end


function AstroidGen:new(speed)
    local width, height = love.graphics.getDimensions()
    self.x = 0
    self.y = -2
    self.width = 35
    self.height = 3

    --ediitng to make them fall faster, used to be 10
    self.speed = 100
    self.patterns = {"L", "MBLOCKER", "single"}
    self.spawned = false
    self.coolDown = 1
end




function AstroidGen:update(dt)
    if self.coolDown >= 2 then
        math.randomseed(os.time())
        local rnd = math.random(1,3)
        self.pattern = self.patterns[rnd]
        if self.pattern == "LINE" then
            print("LINE")
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
            end
            self.spawned = true
            self.coolDown = -2
        elseif self.pattern == "SINGLE" then
            local sX = math.random(0, love.graphics.getWidth()-self.width)
            table.insert(listOfAstroids, Astroid(sX, self.y, self.speed))
            self.coolDown = 0
            self.spawned = true
        elseif self.pattern == "MBLOCKER" then
            math.randomseed(os.time())
            local startX = math.random(0, love.graphics.getWidth()-(4*self.width))
            print(startX)
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
    end
    self.coolDown = self.coolDown + dt
end
--self.coolDown = self.coolDown + dt


