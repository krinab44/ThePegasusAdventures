--------------------------------
-- scene3 file
--------------------------------
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local Player = require("Player");
local Objects = require("Objects");
local Buttercup;
audio.reserveChannels( 1 );
audio.setVolume( 0.5, { channel=1 } )
score = 0;

theme = 3;

local scoreText;
local livesText;


function scene:create( event )
 
   local sceneGroup = self.view
	bTrack = audio.loadStream( "FantasyMusic.wav");
   pTrack = audio.loadStream( "HalloweenMusic.mp3");
   sTrack = audio.loadStream( "ChristmasMusic.mp3");
end

-- "scene:show()"
function scene:show( event )
 
   	local sceneGroup = self.view
   	local phase = event.phase
 
   	if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   	elseif ( phase == "did" ) then

         local picture = display.newImage("background.png");
         local picture2 = display.newImage("background.png");
         local picture3 = display.newImage("background.png");

         params = event.params
         magicButton = params.radio1
         halloweenButton = params.radio2
         christmasButton = params.radio3
         print(magicButton);
         print(halloweenButton);
         print(christmasButton);

         if (magicButton == true) then
            theme = 1;
            audio.play( bTrack, { channel=1, loops=-1 } );
            picture:scale( 0.5,0.5 )
            picture.x = display.contentCenterX + 200
            picture.y = display.contentCenterY + 650
            sceneGroup:insert(picture);
            picture2:scale( 0.5,0.5 )
            picture2.x = display.contentCenterX + 200 + picture2.contentWidth
            picture2.y = display.contentCenterY + 650
            sceneGroup:insert(picture2);
            picture3:scale( 0.5,0.5 )
            picture3.x = display.contentCenterX + 200 * picture3.contentWidth * 2
            picture3.y = display.contentCenterY + 650
            sceneGroup:insert(picture3);
         elseif (halloweenButton == true) then 
            theme = 3;
            audio.play( pTrack, { channel=1, loops=-1 } );
            picture:scale( 0.49,0.49 )
            picture.x = display.contentCenterX + 200
            picture.y = display.contentCenterY - 645
            sceneGroup:insert(picture);
            picture2:scale( 0.49,0.49 )
            picture2.x = display.contentCenterX + 200 + picture2.contentWidth
            picture2.y = display.contentCenterY - 645
            sceneGroup:insert(picture2);
            picture3:scale( 0.49,0.49 )
            picture3.x = display.contentCenterX + 200 + picture3.contentWidth * 2
            picture3.y = display.contentCenterY - 645
            sceneGroup:insert(picture3);
         elseif (christmasButton == true) then
            theme = 2;
            audio.play( sTrack, { channel=1, loops=-1 } );
            picture:scale( 0.49,0.49 )
            picture.x = display.contentCenterX + 200
            picture.y = display.contentCenterY + 0
            sceneGroup:insert(picture);
            picture2:scale( 0.49,0.49 )
            picture2.x = display.contentCenterX + 200 + picture2.contentWidth
            picture2.y = display.contentCenterY + 0 
            sceneGroup:insert(picture2);
            picture3:scale( 0.49,0.49 )
            picture3.x = display.contentCenterX + 200 + picture3.contentWidth * 2
            picture3.y = display.contentCenterY + 0
            sceneGroup:insert(picture3);
         end

         local function move(event)
            picture.x = picture.x - 5
            picture2.x = picture2.x - 5
            picture3.x = picture3.x - 5
            if(picture.x + picture.contentWidth) < 0 then
               picture:translate(2*picture.contentWidth, 0)
            end
            if(picture2.x + picture2.contentWidth) < 0 then
               picture2:translate(2*picture.contentWidth, 0)
            end
            if(picture3.x + picture3.contentWidth) < 0 then
               picture3:translate(2*picture.contentWidth, 0)
            end
         end

         Runtime:addEventListener("enterFrame", move)
         
         Buttercup = Player:new();
         scoreText = display.newText(score, 300, 60, native.systemFont, 30)
         livesText = display.newText(Buttercup.HP, 300, 110, native.systemFont, 30)
         scoreText:setFillColor(1, 0.5, 0.75)
         livesText:setFillColor(1, 0.5, 0.75)
         score = 0;
         local spawning;
         local updating;
		   Buttercup:spawn();
		   local function flap()
		      Buttercup:flap();
		   end

		   local function spawnObject()
		      Objects:spawn(Buttercup);
		   end

         local function update()
            score = score + 1;
            scoreText.text = score;
            livesText.text = Buttercup.HP;
            if(Buttercup.HP <= 0) then
               timer.cancel(spawning);
               timer.cancel(updating);
               local gameoverOptions = {effect = "slideRight", time = 100}
               composer.gotoScene("scene4", gameoverOptions) 
            end
         end

		spawning = timer.performWithDelay(700, spawnObject, 0);
      updating = timer.performWithDelay(17, update, 0);
		Runtime:addEventListener("tap", flap);
   	end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      timer.cancelAll();
      Buttercup:delete();
      audio.stop(1);
      Objects:deleteAll();
      scoreText:removeSelf();
      livesText:removeSelf();
      composer.removeScene("scene3");
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