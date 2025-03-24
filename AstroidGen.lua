AstroidGen = Object.extend(Object)

local tvimg = love.graphics.newImage("art/tv.png")
local trashimg = love.graphics.newImage("art/trash-can.png")
local alarmimg = love.graphics.newImage("art/alarm-clock.png")

function outOfBounds(x, y, width)
end


function AstroidGen:new(speed)
    local width, height = love.graphics.getDimensions()
    self.x = 0
    self.y = -2
    self.width = 3
    self.height = 3
    --ediitng to make them fall faster, used to be 10
    self.speed = 100
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
            thisimg = selectimage(love.math.random(1,3))
            table.insert(listOfAstroids, Astroid(x, y, self.speed, thisimg))
        end
        self.spawned = true
    end
    end
end

function selectimage(value)
if value == 1 then return tvimg elseif value == 2 then return trashimg elseif value == 3 then return alarmimg end end