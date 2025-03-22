local Astroid = {}
Astroid.__index = Astroid

local defaultFallspeed = 40

-- Constructor
function Astroid.new(x, y)
    local self = setmetatable({}, Astroid)
    --This is stupid handy. If we dont get x or y 
    --we make it ourself
    --self for some reason is a thing in love2d??? im suprised
    self.x = x or 300
    self.y = y or 330
    self.width = 50
    self.height = 50
    self.fallspeed = defaultFallspeed
    return self
end

-- Update, in the update loop
function Astroid:update(dt)
    self.y = self.y + self.fallspeed * dt
end

-- Draw loop.
function Astroid:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

--Ok, this is cool AF. For now, we 
function Astroid:shouldRemove()
    if self.y > 900 then return 1 end
end

return Astroid
