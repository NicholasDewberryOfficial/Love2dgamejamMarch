local Losescreen = {}

local selectedoption

local movearrowsound = love.audio.newSource("audio/alienshoot1.wav", "static")

local myscore = 0

--ugly ahh menu
function Losescreen.initializeVals()
  selectedoption = 0 
end 

function Losescreen.drawMenu()
  love.graphics.print("You lost...", 150, 100, 0, 1.5,1.5)
  love.graphics.print("Score is " .. myscore, 200, 200)
  love.graphics.print("RESTART GAME!", 200, 400)
  love.graphics.print("Main Menu", 200, 500)
  love.graphics.print("QUIT", 200, 600)
end 
 
 function Losescreen.findcsscore(score) 
  myscore = score
end
  
function Losescreen.MoveArrow()
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


function Losescreen.keypressed(key)
  
  if key == "up" then
      if selectedoption > 0 then
        selectedoption = selectedoption - 1
      end
      
      
  elseif key == "down" then
      if selectedoption < 2 then
        selectedoption = selectedoption + 1
      end
      end
      
  if (key == "z" and selectedoption==0) then 
    return 1
  end
  
if (key == "z" and selectedoption==1) then
  return 0
end 

if (key =="z" and selectedoption==2) then
love.event.quit(0)
end 
return 2
end








  




return Losescreen