local physics = require("physics");

local Collideable = {tag="Collideable", HP=1, xPos=0, yPos=0, deltaX=4, deltaY=0, physicsType="dynamic", transition="nil", collideSFX="collide.mp3", collectSFX="collect.mp3"};

function Collideable:new(o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function Collideable:spawn()
    self.shape=display.newCircle(self.xPos, self.yPos, 20);
    self.shape.pp = self;
    self.shape.tag = self.tag;
    physics.addBody(self.shape, self.physicsType, {bounce=0.3});
end

function Collideable:delete()
    if self.shape then
        self.shape:removeSelf();
        self.shape = nil;
    end
    self = nil;
end

function Collideable:collide()
    local soundEffect = audio.loadSound(self.collideSFX);
    audio.play(soundEffect);
end

function Collideable:collect()
    local soundEffect = audio.loadSound(self.collectSFX);
    audio.play(soundEffect);
end

return Collideable;