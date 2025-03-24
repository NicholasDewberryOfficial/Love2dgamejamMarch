--Literally a 1:1 copy of lose screen 
--look at those comments

local Winscreen = {}

local selectedoption

local movearrowsound = love.audio.newSource("audio/alienshoot1.wav", "static")

local myscore = 0
--ugly ahh menu
function Winscreen.initializeVals()
  selectedoption = 0 
end 

function Winscreen.drawMenu()
  love.graphics.print("You've Wonnered!", 150, 100, 0, 1.5,1.5)
  love.graphics.print("Score is " .. myscore, 200, 200)
  love.graphics.print("RESTART GAME!", 200, 400)
  love.graphics.print("Main Menu", 200, 500)
  love.graphics.print("QUIT", 200, 600)
end 

 function Winscreen.findcsscore(score) 
  myscore = score
end
  
  
  
function Winscreen.MoveArrow()
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


function Winscreen.keypressed(key)
  
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








  




return Winscreen