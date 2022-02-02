local m = {};

function applyVelocity(instance)
    local returns = nil
    if instance:IsA("BasePart") then
        local bv = Instance.new('BodyVelocity',instance)
        bv.Velocity = Vector3.new(1000,1000,1000)
        bv.MaxForce = Vector3.new(10000,10000,10000)
        returns = bv
    else
        for _,child in pairs(instance:GetChildren()) do
            spawn(function()
                returns = applyVelocity(child)
            end)
        end
    end
    return returns
end

function m.fling(instance)
    applyVelocity(instance)
end

return m
