local Mainmenuscreen = {}

local selectedoption

--ugly ahh menu
function Mainmenuscreen.initializeVals()
  selectedoption = 0 
end 

function Mainmenuscreen.ShowMainMenu()
  love.graphics.print("UNTITLED SPACESHIP GAME", 150, 200, 0, 1.5,1.5)
  love.graphics.print("START", 200, 400)
  love.graphics.print("ABOUT", 200, 500)
  love.graphics.print("QUIT", 200, 600)
end 
  
  
function Mainmenuscreen.MoveArrow()
  xpos = 150
  ypos = 400 
if selectedoption == 0 then
  ypos = 400
elseif selectedoption ==1 then
  ypos = 500
elseif selectedoption ==2 then
  ypos=600
  end 
  love.graphics.circle("fill", xpos, ypos, 30)
end

function Mainmenuscreen.selectTheOption(dt)
  if love.keyboard.keyreleased("up") then
    if selectedoption > 0 then
      selectedoption = selectedoption - 1 
    end
  end

  if love.keyboard.keyreleased("down") then
    if selectedoption < 2 then
      selectedoption = selectedoption + 1
    end
  end
  
  if love.keyboard.isDown("z") then 
      print("YES")
  end
end

  




return Mainmenuscreen