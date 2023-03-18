--------------------------------
-- scene1 file
--------------------------------
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
display.setStatusBar(display.HiddenStatusBar)

highscore = 0;

function scene:create( event )
 
   local sceneGroup = self.view
   --[[     -- Initialize the scene here.
               -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    ]]

    local picture = display.newImage("background.png");
    picture:scale( 0.5,0.5 )
    picture.x = display.contentCenterX + 200
    picture.y = display.contentCenterY + 650
    sceneGroup:insert(picture);
    -- Create the button to transition to scene 2
   local button = display.newRoundedRect(display.contentCenterX , display.contentCenterY + 150, 150, 100,12);
   sceneGroup:insert(button);
   button:setFillColor( 1,.7,.7 )
   local myText = display.newText( "START", display.contentCenterX , display.contentCenterY + 150, native.systemFontBold, 30)
   myText:setFillColor( 1, 0.5, 0.5 )
   local myTitle = display.newText( "The Pegasus Adventures", display.contentCenterX , display.contentCenterY + 50, native.systemFontBold, 50)
   myTitle:setFillColor( 1, 0.5, 0.5 )
   local myCredit = display.newText( "Credits: Krina Bhagat, Nathaniel Smith, Gabriel Morgan, Cayman Tisdale, Katie Wagner", display.contentCenterX , display.contentCenterY + 250, native.systemFontBold, 25)
   myCredit:setFillColor( 0,0,0 )
   sceneGroup:insert(myText);
   sceneGroup:insert(myTitle);
   sceneGroup:insert(myCredit);

   local function moveNext (event)
      composer.gotoScene("scene2", {
         effect = "slideLeft",
         time = 100,
      });
   end

   button:addEventListener("tap", moveNext);
end



-- "scene:show()"
function scene:show( event )
 
   	local sceneGroup = self.view
   	local phase = event.phase
 
   	if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   

   	elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.


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