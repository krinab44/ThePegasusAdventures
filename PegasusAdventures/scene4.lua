--------------------------------
-- scene4 file
--------------------------------
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local picture;
local message;

local csv = require("csv")

highscoreValue = display.newText(score, 500, 100, native.systemFont, 30)
highscoreValue:setFillColor(1, 0.5, 0.75)

function scene:create( event )
 
   local sceneGroup = self.view
   --[[ 	-- Initialize the scene here.
   			-- Example: add display objects to "sceneGroup", add touch listeners, etc.
	]]

	picture = display.newImage("background.png");
   picture:scale( 0.5,0.5 )
   picture.x = display.contentCenterX + 200
   sceneGroup:insert(picture);
   local backbutton = display.newImage("back.png");
    backbutton.x = 100
    backbutton.y = 100
    backbutton.xScale = 0.25;
    backbutton.yScale = 0.25;
   sceneGroup:insert(backbutton)
   local backOptions = {
      effect = "slideRight",
      time = 100
   }
   function moveBack (event)
      composer.gotoScene("scene1", 
         backOptions)
   end
   backbutton:addEventListener("tap", moveBack)

   
   sceneGroup:insert(highscoreValue)
   highscoreText = display.newText ("High Score: ", 400, 100, native.systemFont, 30)
   highscoreText:setFillColor(1, 0.5, 0.75)
   sceneGroup:insert(highscoreText)
end



-- "scene:show()"
function scene:show( event )
 
   	local sceneGroup = self.view
   	local phase = event.phase
 
   	if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
         if (theme == 1) then
            picture.y = display.contentCenterY + 650
            
            message = display.newImage("bded.png")
         elseif (theme == 2) then
            picture.y = display.contentCenterY - 10
            message = display.newImage("sded.png")
         else
            picture.y = display.contentCenterY - 665
            message = display.newImage("pded.png")
         end
         message.x = display.contentCenterX;
         message.y = display.contentCenterY;
         message.xScale = 3
         message.yScale = 3
         sceneGroup:insert(message)
         

   	elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
         
      
      if score > highscore then
         highscore = score
         highscoreValue.text = highscore
      end

      
      local path = system.pathForFile("score.csv", system.DocumentsDirectory);
      f = csv.open(path, {separator = ",", header = true});
      if(f == nil) then
           print("Making new CSV file")
           local file = io.open(path, "w");
           file:write("NAME, POINTS,\nPhillip, 3000")
           file:write("\nMitch, 2800")
           io.close(file)
           file = nil;
           f = csv.open(path, {separator = ",", header = true});
           --print("f equals: " .. f);
           print(path);
      end
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
      message:removeSelf();
      message = nil;
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
   local sceneGroup = self.view
 
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
  
return scene