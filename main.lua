local sac = {
    Services = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        TweenService = game:GetService("TweenService"),
        ServerScriptService = game:GetService("ServerScriptService"),
        ServerStorage = game:GetService("ServerStorage"),
        ReplicatedStorage = game:GetService("ReplicatedStorage"),
    },
};
local server = require(script.Server.Server),
local client = require(script.Client.Client),

function sac:Initialize()
    server.InitializeServer()
end

function sac.InitOnPlayer(p)
    local plr = sac.Services.Players:WaitForChild(p);
    server.InitOnPlayer(plr.Name);
end

return sac
