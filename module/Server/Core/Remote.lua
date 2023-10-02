remote = {}
server = require(script.Parent.Parent.Server)
client = require(script.Parent.Parent.Parent.Client.Client)
core = require(script.Parent.Core)

function remote.Send(var,data)
    if game:GetService('RunService'):IsServer() then
        if (data.SendToAll == true) then
            game:GetService('ReplicatedStorage'):WaitForChild('Superduperdev2MainRemote'):FireAllClients(var,data)
        else
            for i,v in pairs(data.Targets) do
                if v then
                    task.spawn(function()
                        game:GetService('ReplicatedStorage'):WaitForChild('Superduperdev2MainRemote'):FireClient(v,var,data))
                    end)
                end
            end
        end
    elseif game:GetService('RunService'):IsClient() then
        game:GetService('ReplicatedStorage'):WaitForChild('Superduperdev2MainRemote'):FireServer(var,data)
    end
end

game:GetService('ReplicatedStorage'):WaitForChild('Superduperdev2MainRemote').OnServerEvent:Connect(function(plr,var,data)
    if var=='ProcessCommand' then
        server.ProcessCommand(plr,data)
    elseif var=='RunCommand' then
        server.RunCommand(data) --[[ Doesnt care about rank for this.--]]
    end
end)

game:GetService('ReplicatedStorage'):WaitForChild('Superduperdev2MainRemote').OnClientEvent:Connect(function(var,data)
    if var=='ChatMessage' then
        server:DisplaySystemMessage(game:GetService('Players').LocalPlayer,data.MessageData)
    end
end)

return remote
