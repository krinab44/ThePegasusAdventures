local Collideable = require("Collideable");
local Player = Collideable:new({xPos = 50, yPos = display.contentCenterY, deltaX = 0, deltaY = 0, tag = "Player", physicsType = "kinematic", HP = 3});

--insert sprite options here
local opt = {
   	frames = {
		{ x = 743, y = 130, width = 603, height = 451}, -- 1. Buttercup 1
 		{ x = 1447, y = 130, width = 603, height = 451}, -- 2. Buttercup 2
      	{ x = 2151, y = 130, width = 603, height = 451}, -- 3. Buttercup 3

   	    { x = 4266, y = 130, width = 603, height = 451}, -- 4. Snowflake  1
   	    { x = 741, y = 832, width = 603, height = 446}, -- 5. Snowflake  2
   	    { x = 1449, y = 832, width = 603, height = 446}, -- 6. Snowflake  3

  		{ x = 2853, y = 832, width = 603, height = 446}, -- 7. Pumpkin 1
    	{ x = 3560, y = 832, width = 603, height = 446}, -- 8. Pumpkin 2
    	{ x = 4262, y = 832, width = 603, height = 446}, -- 9. Pumpkin 3
    }
}

local sequenceData = {
    {name = "butterFlying", frames = {1, 2, 3, 2}, time = 1800, loopCount = 0},
    {name = "snowFlying", frames = {4, 5, 6, 5}, time = 1800, loopCount = 0},
    {name = "pumpkinFlying", frames = {7, 8, 9, 8}, time = 1800, loopCount = 0}
}  

local sheet = graphics.newImageSheet("world.png", opt);

function Player:spawn()
    self.shape = display.newSprite(sheet, sequenceData);
    self.shape.xScale = 0.15
    self.shape.yScale = 0.15
    if(theme == 1) then
        self.shape:setSequence("butterFlying");
    elseif(theme == 3) then
        self.shape:setSequence("pumpkinFlying");
    elseif(theme == 2) then
        self.shape:setSequence("snowFlying");
    end
    self.shape.pp = self;
    self.shape.tag = self.tag;
    self.shape.x = self.xPos;
    self.shape.y = self.yPos;
    physics.addBody(self.shape, self.physicsType);

    local function drop()
        self.shape.y = self.shape.y - self.deltaY;
        self.deltaY = self.deltaY - 0.3;
    end

    local function maintain()
        if(self.shape.y > display.contentHeight + 20) then
            self.HP = self.HP - 3;
            self:collide();
        elseif(self.shape.y <= 0) then
            self.shape.y = 0;
            self.deltaY = 0;
        end
    end

    local movement = timer.performWithDelay(17, drop, 0);
    local maintainence = timer.performWithDelay(17, maintain, 0);

    self.shape:play();
end

function Player:flap()
    self.deltaY = 8;
end

physics.start();
return Player;