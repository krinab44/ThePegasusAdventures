local Player = require("Player");
local Buttercup = Player:new();

Buttercup:spawn();
local function flap()
    Buttercup:flap();
end
Runtime:addEventListener("tap", flap);
