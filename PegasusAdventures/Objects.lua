local Collideable = require("Collideable");
local Objects = {};

local opt = {
   	frames = {
		{ x = 2348, y = 1579, width = 211, height = 360}, -- 1. Butter's Cupcake 1
		{ x = 1556, y = 1623, width = 405, height = 257}, -- 2. Butter's Rainbow 1
    	{ x = 3028, y = 1571, width = 216, height = 438}, -- 3. Butter's Clover 1

    	--Not " animations "
  		{ x = 3754, y = 1571, width = 215, height = 372}, -- 4. Snow's Cupcake 1
    	{ x = 4262, y = 1424, width = 626, height = 648}, -- 5. Snow's Candy 1
    	{ x = 830, y = 2191, width = 453, height = 566}, -- 6. Snow's Wreath 1

    	--Not " animations "
    	{ x = 1643, y = 2278, width = 207, height = 372}, -- 7. Pumpkin's Cupcake 1
		{ x = 2879, y = 2236, width = 536, height = 500}, -- 8. Pumpkin's Candy 1
    	{ x = 2327, y = 2325, width = 250, height = 344}, -- 9. Pumpkin's Jack'o Lantern 1

		{ x = 3493, y = 2153, width = 668, height = 656}, -- 10. Thunder Cloud 1
  		{ x = 4219, y = 2153, width = 668, height = 656}, -- 11. Thunder Cloud 2
    	{ x = 0, y = 2854, width = 668, height = 656}, -- 12. Thunder Cloud 3
    	{ x = 694, y = 2854, width = 668, height = 656}, -- 13. Thunder Cloud 4
    	{ x = 1404, y = 2854, width = 668, height = 656}, -- 14. Thunder Cloud 5

    	--Not " animations "
    	{ x = 2190, y = 2853, width = 615, height = 691}, -- 15. Butter's Tree 1
    	{ x = 2878, y = 3072, width = 602, height = 408}, -- 16. Butter's Bush 1

    	--Not " animations "
  		{ x = 3642, y = 2835, width = 519, height = 687}, -- 17. Snow's Tree 1
    	{ x = 4277, y = 3061, width = 617, height = 419}, -- 18. Snow's Bush 1

    	--Not " animations "
    	{ x = 77, y = 3537, width = 616, height = 688}, -- 19. Pumpkin's Tree 1
    	{ x = 741, y = 3747, width = 609, height = 462} -- 20. Pumpkin's Bush 1
    }
}
Thunder_sequenceData = {
		{name = "thunderBoom", frames = {10, 11, 12, 13, 14}, time = 1800, loopCount = 0}
	} 
ObjectOne = {
	{name = "objectOne", frames = {1,4,7}}
}
ObjectTwo = {
	{name = "objectTwo", frames = {2,5,8}}
}
ObjectThree = {
	{name = "objectThree", frames={3,6,9}}
}
Tree = {
	{name = "Tree", frames = {15,17,19}}
}
Bush = {
	{name = "Bush", frames = {16,18,20}}
}
local sheet = graphics.newImageSheet("world.png", opt);

local objectGroup = {};

function Objects:spawn(player)
	local Object = Collideable:new({xPos = display.contentWidth + 200, yPos = 555, deltaX = -5, deltaY = 0, tag = "Object", physicsType = "kinematic", HP = 1})
	table.insert(objectGroup, Object);
	local type = math.random(6);
	if(type == 6) then
		Object.yPos = 600
	elseif(type ~= 5) then
		Object.yPos = math.random(50, 500);
	end
	if(type == 1) then
		Object.shape = display.newSprite(sheet, Thunder_sequenceData);
		Object.tag = "Obstacle";
		Object.shape:play();
	else
		if(type == 2) then
			Object.shape = display.newSprite(sheet,ObjectOne);
			Object.tag = "Collectable";
		elseif(type == 3) then
			Object.shape = display.newSprite(sheet, ObjectTwo);
			Object.tag = "Collectable";
		elseif(type == 4) then
			Object.shape = display.newSprite(sheet, ObjectThree);
			Object.tag = "Collectable";
		elseif(type == 5) then
			Object.shape = display.newSprite(sheet, Tree);
			Object.tag = "Obstacle";
		elseif(type == 6) then
			Object.shape = display.newSprite(sheet, Bush);
			Object.tag = "Obstacle";
		end
		Object.shape:setFrame(theme);
	end
	Object.shape.gravityScale = 0;
	Object.shape.xScale = 0.15;
    Object.shape.yScale = 0.15;
	if(type == 5) then
		Object.shape.xScale = 0.25;
		Object.shape.yScale = 0.25;
	end
	Object.shape.pp = Object;
    Object.shape.tag = Object.tag;
    Object.shape.x = Object.xPos;
    Object.shape.y = Object.yPos;
    physics.addBody(Object.shape, Object.physicsType);

	local movement;
	local collisionDetection;

	local function collided(a, b)
		if(a and b) then
			local dx = a.shape.x - b.shape.x;
			local dy = a.shape.y - b.shape.y;
			local distance = math.sqrt(dx*dx + dy*dy);
			local objectSize = (a.shape.contentWidth/2) + (b.shape.contentWidth/2);
			if (distance < objectSize) then
				return true;
			end
		end
		return false;
	end

	local function collision()
        if(collided(Object, player)) then
			if(Object.tag == "Obstacle") then
				player:collide();
				player.HP = player.HP - 1;
			else
				player:collect();
				score = score + 1000;
			end
			Object:delete();
			Object = nil;
			timer.cancel(movement);
			timer.cancel(collisionDetection);
		end
	end

	local function move()
		Object.shape.x = Object.shape.x + Object.deltaX;
		if(Object.shape.x < -50) then
			Object:delete();
			Object = nil;
			timer.cancel(movement);
			timer.cancel(collisionDetection);
		end
	end

	function Objects:deleteAll()
		for _, object in pairs(objectGroup) do
			object:delete();
		end
	end

	movement = timer.performWithDelay(17, move, 0);
	collisionDetection = timer.performWithDelay(17, collision, 0);

end

return Objects;