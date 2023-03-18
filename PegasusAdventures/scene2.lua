--------------------------------
-- scene2 file
--------------------------------
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")


function scene:create( event )
 
   local sceneGroup = self.view
   function onSwitchPress( event )
      local switch = event.target
      print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
   end

   -- Create three associated radio buttons (inserted into the same display group)

  local opt = {
      frames = {
      { x = 743, y = 130, width = 603, height = 451}, -- 1. Buttercup 
      { x = 4266, y = 130, width = 603, height = 451}, -- 2. Snowflake  
      { x = 2853, y = 832, width = 603, height = 446}, -- 3. Pumpkin 
      }
      }   

      local sheet = graphics.newImageSheet( "world.png", opt);



   local picture = display.newImage("background.png");
    picture:scale( 0.5,0.5 )
    picture.x = display.contentCenterX + 200
    picture.y = display.contentCenterY + 650
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


   local button1 = display.newText("Magical", 440 ,350, native.systemFont, 60)
   button1.text = "Princess Buttercup"
   button1:setFillColor(1,0.5,0.5)
   local buttercup = display.newImage(sheet, 1); 
   buttercup.x = 800;
   buttercup.y = 350;
   buttercup.xScale =.25;
   buttercup.yScale = .25;
   sceneGroup:insert(buttercup)

   sceneGroup:insert(button1) -- Inserts button1 to sceneGroup

   local button2 = display.newText("Halloween", 420 ,450,native.systemFont, 60)
   button2.text = "Princess Pumpkin"
   button2:setFillColor(1,0.5,0.5)
   local pumpkin = display.newImage(sheet, 3); 
   pumpkin.x = 800;
   pumpkin.y = 450;
   pumpkin.xScale =.25;
   pumpkin.yScale = .25;
   sceneGroup:insert(pumpkin)


   sceneGroup:insert(button2) -- Inserts button2 to sceneGroup
   
   local button3 = display.newText("Christmas", 440 ,550,native.systemFont, 60)
   button3.text = "Princess Snowflake"
   button3:setFillColor(1,0.5,0.5)
   local snowflake = display.newImage(sheet, 2); 
   snowflake.x = 800;
   snowflake.y = 550;
   snowflake.xScale =.25;
   snowflake.yScale = .25;
   sceneGroup:insert(snowflake)

   sceneGroup:insert(button3) -- Inserts button2 to sceneGroup

   local button4 = display.newText("Magical", 577 ,90, native.systemFont, 35)
   button4.text = "Tap to Flap! Avoid trees, Animals and Thunder Clouds!"
   button4:setFillColor(1,0.5,0.5)
   sceneGroup:insert(button4)

   local button5 = display.newText("Magical", 577 ,130, native.systemFont, 35)
   button5.text = "Collect the candy and special items!"
   button5:setFillColor(1,0.5,0.5)
   sceneGroup:insert(button5)

   -- Create a group for the radio button set
   local radioGroup = display.newGroup()
   local radioButton1 = widget.newSwitch(
      {
       left = 75,
       top = 310,
       style = "radio",
       id = "RadioButton1",
       width = 80,
       height = 80,
       initialSwitchState = true,
       onPress = onSwitchPress
      }
   )
   radioGroup:insert( radioButton1 )
   sceneGroup:insert( radioButton1 )

   local radioButton2 = widget.newSwitch(
     {
      left = 75,
      top = 410,
      style = "radio",
      id = "RadioButton2",
      width = 80,
      height = 80,
      onPress = onSwitchPress
     }
   )
   radioGroup:insert( radioButton2 )
   sceneGroup:insert( radioButton2 )

   local radioButton3 = widget.newSwitch(
     {
      left = 75,
      top = 510,
      style = "radio",
      id = "RadioButton3",
      width = 80,
      height = 80,
      onPress = onSwitchPress
     }
   )
   radioGroup:insert( radioButton3 )
   sceneGroup:insert( radioButton3 )

   local nextbutton = display.newImage("next.png")
   nextbutton.x = 1050
   nextbutton.y = 100
   nextbutton.xScale = 0.25;
   nextbutton.yScale = 0.25;
   sceneGroup:insert(nextbutton)

   function moveNext (event)
      composer.gotoScene("scene3", {
         effect = "slideLeft",
         time = 100,
         params = {
            radio1 = radioButton1.isOn,
            radio2 = radioButton2.isOn,
            radio3 = radioButton3.isOn
         }
      });
   end
   nextbutton:addEventListener("tap", moveNext)

   --sceneGroup:insert(radioGroup.parent)
end


-- "scene:show()"
function scene:show( event )
 
   	local sceneGroup = self.view
   	local phase = event.phase
 
   	if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   
   	elseif ( phase == "did" ) then
      
      --[[function map (value, istart, istop, ostart, ostop) 
         return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
      end]]

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