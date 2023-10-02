core = {}
server = require(script.Parent.Parent.Server)
client = require(script.Parent.Parent.Parent.Client.Client)
remote = require(script.Parent.Remote)

function core:Initialize()
    local theEvent = game:GetService('ReplicatedStorage'):FindFirstChild('Superduperdev2MainRemote') or Instance.new('RemoteEvent',game:GetService('ReplicatedStorage'))
    theEvent.Name = 'Superduperdev2MainRemote'
end

return core
