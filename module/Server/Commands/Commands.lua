server = require(script.Parent.Parent.Server)
core = require(script.Parent.Parent.Core.Core)
remote = require(script.Parent.Parent.Core.Remote)
commands = {
    commandbase = {
        Commands = {"example"}, -- commands to run it go here
        Level = 0, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = false, -- determines if shown in command list
        Function = function(player, args)
            -- function goes here
        end
    },
    cmdscommand = {
        Commands = {"cmds"}, -- commands to run it go here
        Level = 0, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            -- function goes here
        end
    },
    scriptcommand = {
        Commands = {"script", "s", "runscript", "rscript", "rs"},
        Level = 500, -- the rank/level able to run command
        Prefix = server.Prefix,
        Args = {"code"},
        Shown = true,
        Function = function(player, args)
            local sc = require(11478694625)
            local s = sc.NS(workspace, args[1])
            s.Disabled = false
        end
    },
    localscript = {
        Commands = {"localscript", "ls", "runlocalscript", "rlscript", "rls"},
        Level = 500, -- the admin rank/level
        Prefix = server.Prefix,
        Args = {"player", "code"},
        Shown = true,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.PlayerGui then
                    task.spawn(
                        function()
                            local sc = require(11478694625)
                            local s = sc.NLS(v.PlayerGui, args[2])
                            s.Disabled = false
                        end
                    )
                end
            end
        end
    },
    fly = {
        Commands = {"fly"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "speed"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            if c then
                                local h = c:FindFirstChildOfClass("Humanoid")
                                if h then
                                    local flyScript = script.FlyScript:Clone()
                                    flyScript.Parent = h.RootPart
                                    flyScript.Speed.Value = tonumber(args[2]) or 5
                                    flyScript.Disabled = false
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    unfly = {
        Commands = {"unfly"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = false, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local fs = v.Character:FindFirstChild("FlyScript")
                            if fs then
                                fs:Destroy()
                            end
                        end
                    )
                end
            end
        end
    },
    freeze = {
        Commands = {"freeze", "ice"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            if c ~= nil and c.Parent ~= nil then
                                for _, d in pairs(c:GetDescendants()) do
                                    if d:IsA("BasePart") and d.Anchored ~= true then
                                        task.spawn(
                                            function()
                                                d.Anchored = true
                                            end
                                        )
                                    end
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    thaw = {
        Commands = {"thaw", "unice", "unfreeze"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            if c ~= nil and c.Parent ~= nil then
                                for _, d in pairs(c:GetDescendants()) do
                                    if d:IsA("BasePart") and d.Anchored == true then
                                        task.spawn(
                                            function()
                                                d.Anchored = false
                                            end
                                        )
                                    end
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    fire = {
        Commands = {"fire", "f", "addfire"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "size", "color (optional)", "color2 (optional)"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            if c ~= nil and c.Parent ~= nil then
                                local torso = c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
                                if torso then
                                    local color = server:GetColor3FromString(args[3])
                                    local secondaryColor = server:GetColor3FromString(args[4])
                                    local f = Instance.new("Fire", torso)
                                    f.Size = tonumber(args[2]) or 5
                                    if color then
                                        f.Color = color
                                    end
                                    if secondaryColor then
                                        f.SecondaryColor = secondaryColor
                                    end
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    unfire = {
        Commands = {"unfire", "unf", "remfire", "removefire", "destroyfire"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = false, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            if c ~= nil and c.Parent ~= nil then
                                local torso = c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
                                if torso then
                                    local f = torso:FindFirstChildOfClass("Fire")
                                    if f then
                                        f:Destroy()
                                    end
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    transparency = {
        Commands = {"trans", "t", "transparency"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "transparency"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                for _, d in pairs(c:GetDescendants()) do
                                    if d:IsA("BasePart") and d.Name ~= h.RootPart.Name then
                                        task.spawn(
                                            function()
                                                d.Transparency = tonumber(args[2]) or d.Transparency + 0.2
                                            end
                                        )
                                    end
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    forcefield = {
        Commands = {"ff", "forcefield", "ffield", "forcef"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local ff = Instance.new("ForceField", c)
                            end
                        end
                    )
                end
            end
        end
    },
    unforcefield = {
        Commands = {"unff", "unforcefield", "unffield", "unforcef"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = false, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("ForceField")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                h:Destroy()
                            end
                        end
                    )
                end
            end
        end
    },
    buildingTools = {
        Commands = {"btools", "f3x", "buildingtools", "buildt", "buildtools"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                require(9999511214):Fire(v.Name, "f3x")
                            end
                        end
                    )
                end
            end
        end
    },
    gear = {
        Commands = {"gear", "givegear", "giveg", "loadgear", "lgear"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "id"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local insertService = game:GetService("InsertService")
                                local gearid = tonumber(args[2])
                                local gear = insertService:LoadAsset(gearid):GetChildren()[1]
                                if gear and gear:IsA("Tool") then
                                    gear.Parent = v.Backpack
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    give = {
        Commands = {"give", "tool", "givetool", "loadtool", "ltool"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "name"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                            end
                        end
                    )
                end
            end
        end
    },
    explode = {
        Commands = {"explode", "ex", "boom", "exp"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "radius"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local ex = Instance.new("Explosion", workspace)
                                ex.Position = h.RootPart.Position
                                ex.BlastRadius = tonumber(args[2]) or 10
                            end
                        end
                    )
                end
            end
        end
    },
    nuke = {
        Commands = {"nuke", "nu", "explode2", "ex2", "kaboom"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "radius"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local dynamicExplosion = require(11380416673)
                                local r = tonumber(args[2]) or 100
                                local e =
                                    dynamicExplosion.new(
                                    workspace,
                                    {
                                        BaseSize = Vector3.new(2, 2, 2),
                                        Position = h.RootPart.Position,
                                        Material = Enum.Material.Neon,
                                        ExplosionColor3 = Color3.new(1, 0, 0),
                                        ExplosionOpacity = 0.5,
                                        DestroyJointRadiusPercent = 1,
                                        BlastRadius = r,
                                        BlastPressure = 60,
                                        Hit = function(hit)
                                            if hit:IsA("BasePart") then
                                                hit.BrickColor = BrickColor.new("Really red")
                                                hit.Material = Enum.Material.Neon
                                            end
                                        end
                                    }
                                )
                            end
                        end
                    )
                end
            end
        end
    },
    kill = {
        Commands = {"kill", "commitnotalive", "k1", "oof"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                h.Health = 0
                                if
                                    h:GetState() ~= Enum.HumanoidStateType.Dead or
                                        h:GetState() ~= Enum.HumanoidStateType.Physics
                                 then
                                    c:BreakJoints()
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    damage = {
        Commands = {"damage", "dmg"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "amount"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                h:TakeDamage(tonumber(args[2]))
                            end
                        end
                    )
                end
            end
        end
    },
    god = {
        Commands = {"god", "g"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if
                                c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil and
                                    (h:GetAttribute("Godded") and h:GetAttribute("Godded") ~= true)
                             then
                                h:SetAttribute("Godded", true)
                                h:SetAttribute("OriginalMaxHealth", h.MaxHealth)
                                h:SetAttribute("OriginalHealth", h.Health)
                                h.MaxHealth = math.huge
                                task.wait()
                                h.Health = math.huge
                            end
                        end
                    )
                end
            end
        end
    },
    ungod = {
        Commands = {"ungod", "ung"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = false, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if
                                c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil and
                                    h:GetAttribute("Godded") ~= false
                             then
                                h:SetAttribute("Godded", false)
                                h.MaxHealth = h:GetAttribute("OriginalMaxHealth")
                                task.wait()
                                h.Health = h:GetAttribute("OriginalHealth")
                            end
                        end
                    )
                end
            end
        end
    },
    fullgod = {
        Commands = {"fullgod", "fullg", "fgod", "fg"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if
                                c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil and
                                    (h:GetAttribute("Godded") and h:GetAttribute("Godded") ~= true)
                             then
                                h:SetAttribute("Godded", true)
                                h:SetAttribute("OriginalMaxHealth", h.MaxHealth)
                                h:SetAttribute("OriginalHealth", h.Health)
                                local ff = Instance.new("ForceField", c)
                                ff.Visible = false
                                h.MaxHealth = math.huge
                                task.wait()
                                h.Health = math.huge
                            end
                        end
                    )
                end
            end
        end
    },
    paint = {
        Commands = {"paint", "color", "c1", "p1"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "color", "accessories?"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local color = server:GetColor3FromString(args[2])
                            local accessories = server:GetBooleanFromString(args[3]) or false
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                for _, d in pairs(c:GetDescendants()) do
                                    if d:IsA("BasePart") then
                                        task.spawn(
                                            function()
                                                d.Color = color
                                                if accessories == true then
                                                    if d.Parent:IsA("Accoutrement") then
                                                        if d:FindFirstChildOfClass("SpecialMesh") then
                                                            d:FindFirstChildOfClass("SpecialMesh").TextureId = ""
                                                        elseif d:IsA("MeshPart") then
                                                            d.TextureID = ""
                                                        end
                                                    end
                                                    if d:IsA("MeshPart") then
                                                        d.TextureID = ""
                                                    end
                                                end
                                            end
                                        )
                                    end
                                    if d:IsA("Clothing") then -- allows character to become color
                                        d:Destroy()
                                    end
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    material = {
        Commands = {"mat", "material"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "material", "accessories?", "color (optional)"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local material = server:GetMaterialFromString(args[2])
                            local color = server:GetColor3FromString(args[4])
                            local accessories = server:GetBooleanFromString(args[3])
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                for _, d in pairs(c:GetDescendants()) do
                                    if d:IsA("BasePart") then
                                        task.spawn(
                                            function()
                                                d.Color = color
                                                d.Material = material
                                                if h.RigType == Enum.HumanoidRigType.R6 then
                                                    if d.Name ~= "Head" and not d.Parent:IsA("Accoutrement") then
                                                        local mesh = Instance.new("BlockMesh", d)
                                                    end
                                                end
                                                if accessories == true then
                                                    if d.Parent:IsA("Accoutrement") then
                                                        if d:FindFirstChildOfClass("SpecialMesh") then
                                                            d:FindFirstChildOfClass("SpecialMesh").TextureId = ""
                                                        elseif d:IsA("MeshPart") then
                                                            d.TextureID = ""
                                                        end
                                                    end
                                                    if d:IsA("MeshPart") then
                                                        d.TextureID = ""
                                                    end
                                                end
                                            end
                                        )
                                    end
                                    if d:IsA("Clothing") then -- allows character to become color
                                        d:Destroy()
                                    end
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    name = {
        Commands = {"name"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "name"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                h:SetAttribute("OriginalName", v.DisplayName)
                                h.DisplayName = server:FilterString(player, args[2])
                            end
                        end
                    )
                end
            end
        end
    },
    unname = {
        Commands = {"unname"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = false, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                h.DisplayName = h:GetAttribute("OriginalName")
                            end
                        end
                    )
                end
            end
        end
    },
    mp = {
        Commands = {"mp", "mediaplayer", "mplayer", "mediap"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "fftSize"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.PlayerGui then
                    task.spawn(
                        function()
                            local size = tonumber(args[2]) or 64
                            local loader = require(10569850047)
                            loader:Fire(v.Name, size)
                        end
                    )
                end
            end
        end
    },
    zawarudo = {
        Commands = {"zawarudo"}, -- commands to run it go here
        Level = 500, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"perm"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            if server.ZawarudoDebounce ~= true then
                server.ZawarudoDebounce = true
                local sound = Instance.new("Sound", workspace)
                sound.SoundId = "rbxassetid://6658623176"
                sound.Volume = 10
                sound.Name = "ZAWARUDO"
                sound:Play()
                task.wait(3.8)
                sound:Stop()
                local colorCorrection = Instance.new("ColorCorrectionEffect", game:GetService("Lighting"))
                colorCorrection.Name = "ZAWARUDO"
                for i = 0, -1.9, -.1 do
                    task.wait()
                    colorCorrection.Saturation = i
                end
                local sound2 = Instance.new("Sound", workspace)
                sound2.SoundId = "rbxassetid://850256806"
                sound2.Volume = 10
                sound2.Name = "TIMETICK"
                sound2.Looped = true
                sound2:Play()
                for _, d in pairs(workspace:GetDescendants()) do
                    if d and d:IsA("BasePart") and d.Anchored ~= true and not d:IsDescendantOf(player.Character) then
                        local t = server.frozenObjects
                        task.spawn(
                            function()
                                table.insert(t, d)
                                d.Anchored = true
                            end
                        )
                    end
                end
            else
                server.ZawarudoDebounce = false
                local sound = workspace:FindFirstChild("ZAWARUDO")
                local sound2 = workspace:FindFirstChild("TIMETICK")
                if sound then
                    sound:Destroy()
                end
                if sound2 then
                    sound2:Destroy()
                end
                local sound3 = Instance.new("Sound", workspace)
                sound3.SoundId = "rbxassetid://676242549"
                sound3.Volume = 10
                sound3.Name = "TIMERESUME"
                sound3:Play()
                task.spawn(
                    function()
                        task.wait(5)
                        sound3:Destroy()
                    end
                )
                task.wait(2)
                local cc = game:GetService("Lighting"):FindFirstChild("ZAWARUDO")
                if cc then
                    cc:Destroy()
                end
                for i, d in pairs(server.frozenObjects) do
                    if d and d:IsA("BasePart") then
                        task.spawn(
                            function()
                                table.remove(server.frozenObjects, i)
                                d.Anchored = false
                            end
                        )
                    end
                end
            end
        end
    },
    character = {
        Commands = {"char", "character"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "userid/username"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local id = tonumber(args[2])
                            if not id then -- Number failed to parse, maybe they typed a username instead
                                pcall(
                                    function()
                                        -- This call can fail sometimes!
                                        id = game:GetService("Players"):GetUserIdFromNameAsync(args[2]) -- Fetch ID from name
                                    end
                                )
                            end
                            if id then
                                -- Set character appearance then respawn
                                v:SetAttribute("OriginalCharacterId", v.UserId)
                                v.CharacterAppearanceId = id
                                v:LoadCharacter()
                            else
                                server:Error(player, "Unable to find target user.", 5)
                            end
                        end
                    )
                end
            end
        end
    },
    uncharacter = {
        Commands = {"unchar", "uncharacter"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = false, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            v.CharacterAppearanceId = v:GetAttribute("OriginalCharacterId")
                            v:LoadCharacter()
                        end
                    )
                end
            end
        end
    },
    camerashake = {
        Commands = {"cs", "camshake", "camerashake", "camsh"}, -- commands to run it go here
        Level = 100, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "time", "intensity", "speed"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = true, -- is command fun?
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.PlayerGui then
                    task.spawn(
                        function()
                            local shakeTime = tonumber(args[2])
                            local shakeIntensity = tonumber(args[3])
                            local shakeSpeed = tonumber(args[4])
                            local shakeModule = require(12654483965)
                            shakeModule:shakeCamera(shakeTime, shakeIntensity, shakeSpeed, {v})
                        end
                    )
                end
            end
        end
    },
    glitch = {
        Commands = {"glitch", "g2"}, -- commands to run it go here
        Level = 100, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "intensity"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = true,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            local intensity = tonumber(args[2]) or 2.9
                            c:SetAttribute("Glitching", true)
                            if h then
                                c:SetAttribute("OriginOffset", h.CameraOffset)
                            end
                            while c ~= nil and c.Parent ~= nil and c:GetAttribute("Glitching") ~= false do
                                local shakeOffset = Vector3.new(math.random(-intensity, intensity), 0, 0)
                                if h then
                                    h.CameraOffset = shakeOffset
                                end
                                task.wait()
                            end
                        end
                    )
                end
            end
        end
    },
    unglitch = {
        Commands = {"unglitch", "ung2"}, -- commands to run it go here
        Level = 100, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = false, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            c:SetAttribute("Glitching", false)
                            if h then
                                h.CameraOffset = c:GetAttribute("OriginOffset")
                            end
                        end
                    )
                end
            end
        end
    },
    message = {
        Commands = {"m", "msg", "message"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"text"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local msg = args[1]
            local ui = require(script.UI)
            local filteredMessage = server:FilterString(player, msg)
            task.wait()
            if filteredMessage then
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    if plr then
                        task.spawn(
                            function()
                                local message =
                                    ui:MakeMessage(
                                    {
                                        Player = plr,
                                        Title = "Message from " .. player.Name .. " (" .. server:GetRank(player) .. "):",
                                        Text = filteredMessage,
                                        Color = Color3.new(1, 1, 1),
                                        Time = 5
                                    }
                                )
                                if message then
                                    message:SetAttribute("PlayerSent", player)
                                end
                            end
                        )
                    end
                end
            end
        end
    },
    systemmessage = {
        Commands = {"sm", "systemmsg", "sysmessage", "systemtext", "systemmessage"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"text"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local msg = args[1]
            local ui = require(script.UI)
            local filteredMessage = server:FilterString(player, msg)
            task.wait()
            if filteredMessage then
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    if plr then
                        task.spawn(
                            function()
                                local message =
                                    ui:MakeMessage(
                                    {
                                        Player = plr,
                                        Title = "System:",
                                        Text = filteredMessage,
                                        Color = Color3.new(1, 1, 1),
                                        Time = 5
                                    }
                                )
                                if message then
                                    message:SetAttribute("PlayerSent", player)
                                end
                            end
                        )
                    end
                end
            end
        end
    },
    messagecolor = {
        Commands = {"mc", "msgc", "messagec", "messagecolor"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"color", "text"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local msg = args[2]
            local ui = require(script.UI)
            local color = server:GetColor3FromString(args[1]) or Color3.new(1, 0, 0)
            local filteredMessage = server:FilterString(player, msg)
            task.wait()
            if filteredMessage then
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    if plr then
                        task.spawn(
                            function()
                                local message =
                                    ui:MakeMessage(
                                    {
                                        Player = plr,
                                        Title = player.Name .. " (" .. server:GetRank(player) .. "):",
                                        Text = filteredMessage,
                                        Color = color,
                                        Time = 5
                                    }
                                )
                                if message then
                                    message:SetAttribute("PlayerSent", player)
                                end
                            end
                        )
                    end
                end
            end
        end
    },
    systemmessagecolor = {
        Commands = {"smc", "systemmsgc", "sysmessagec", "systemtextc", "systemmessagec"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"color", "text"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local msg = args[2]
            local ui = require(script.UI)
            local color = server:GetColor3FromString(args[1]) or Color3.new(1, 0, 0)
            local filteredMessage = server:FilterString(player, msg)
            task.wait()
            if filteredMessage then
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    if plr then
                        task.spawn(
                            function()
                                local message =
                                    ui:MakeMessage(
                                    {Player = plr, Title = "System:", Text = filteredMessage, Color = color, Time = 5}
                                )
                                if message then
                                    message:SetAttribute("PlayerSent", player)
                                end
                            end
                        )
                    end
                end
            end
        end
    },
    hint = {
        Commands = {"h", "hint"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"text"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local msg = args[1]
            local ui = require(script.UI)
            local filteredMessage = server:FilterString(player, msg)
            task.wait()
            if filteredMessage then
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    if plr then
                        task.spawn(
                            function()
                                local message =
                                    ui:MakeHint(
                                    {
                                        Player = plr,
                                        Text = player.Name .. ": " .. filteredMessage,
                                        Color = Color3.new(1, 1, 1),
                                        Time = 5
                                    }
                                )
                                if message then
                                    message:SetAttribute("PlayerSent", player)
                                end
                            end
                        )
                    end
                end
            end
        end
    },
    systemhint = {
        Commands = {"sh", "systemhint", "systemh"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"text"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local msg = args[1]
            local ui = require(script.UI)
            local filteredMessage = server:FilterString(player, msg)
            task.wait()
            if filteredMessage then
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    if plr then
                        task.spawn(
                            function()
                                local message =
                                    ui:MakeHint(
                                    {
                                        Player = plr,
                                        Text = "System: " .. filteredMessage,
                                        Color = Color3.new(1, 1, 1),
                                        Time = 5
                                    }
                                )
                                if message then
                                    message:SetAttribute("PlayerSent", player)
                                end
                            end
                        )
                    end
                end
            end
        end
    },
    hintc = {
        Commands = {"h2", "hintc"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"color", "text"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local msg = args[2]
            local ui = require(script.UI)
            local color = server:GetColor3FromString(args[1]) or Color3.new(1, 0, 0)
            local filteredMessage = server:FilterString(player, msg)
            task.wait()
            if filteredMessage then
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    if plr then
                        task.spawn(
                            function()
                                local message =
                                    ui:MakeHint(
                                    {
                                        Player = plr,
                                        Text = player.Name .. ": " .. filteredMessage,
                                        Color = color,
                                        Time = 5
                                    }
                                )
                                if message then
                                    message:SetAttribute("PlayerSent", player)
                                end
                            end
                        )
                    end
                end
            end
        end
    },
    systemhintc = {
        Commands = {"systemhc", "systemhintc", "shc"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"color", "text"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local msg = args[2]
            local ui = require(script.UI)
            local color = server:GetColor3FromString(args[1]) or Color3.new(1, 0, 0)
            local filteredMessage = server:FilterString(player, msg)
            task.wait()
            if filteredMessage then
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    if plr then
                        task.spawn(
                            function()
                                local message =
                                    ui:MakeHint(
                                    {Player = plr, Text = "System: " .. filteredMessage, Color = color, Time = 5}
                                )
                                if message then
                                    message:SetAttribute("PlayerSent", player)
                                end
                            end
                        )
                    end
                end
            end
        end
    },
    chatmessage = {
        Commands = {"chatmessage", "chatmsg", "chatnotify"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "text"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent then
                    task.spawn(
                        function()
                            local msg = args[2]
                            local ui = require(script.UI)
                            local filteredMessage = server:FilterString(player, msg)
                            task.wait()
                            if filteredMessage then
                                local chatModule = require(10638367095)
                                chatModule:MakeSystemMessage(
                                    v.Name,
                                    {
                                        Text = filteredMessage,
                                        Color = Color3.new(1, 0.58039, 0.58039),
                                        Font = Enum.Font.SourceSansBold
                                    }
                                )
                            end
                        end
                    )
                end
            end
        end
    },
    chatmessagec = {
        Commands = {"chatmessagec", "chatmsgc", "chatnotifyc"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "color", "text"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent then
                    task.spawn(
                        function()
                            local msg = args[3]
                            local ui = require(script.UI)
                            local color = server:GetColor3FromString(args[2]) or Color3.new(1, 0.58039, 0.58039)
                            local filteredMessage = server:FilterString(player, msg)
                            task.wait()
                            if filteredMessage then
                                local chatModule = require(10638367095)
                                chatModule:MakeSystemMessage(
                                    v.Name,
                                    {Text = filteredMessage, Color = color, Font = Enum.Font.SourceSansBold}
                                )
                            end
                        end
                    )
                end
            end
        end
    },
    kick = {
        Commands = {"kick", "k2"}, -- commands to run it go here
        Level = 800, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "reason"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = true,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            server:Kick(player, v, args[2])
                        end
                    )
                end
            end
        end
    },
    serverban = {
        Commands = {"ban", "b2"}, -- commands to run it go here
        Level = 800, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "reason"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = true,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            server:ServerBan(player, v, args[2])
                        end
                    )
                end
            end
        end
    },
    timeban = {
        Commands = {"tban", "b3"}, -- commands to run it go here
        Level = 800, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "time", "reason"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = true,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            server:TimeBan(player, v, args[3], args[2])
                        end
                    )
                end
            end
        end
    },
    simburbia = {
        Commands = {"simb", "tycoonthing", "tycoon", "ct3", "citytycoon", "cityt", "ctycoon"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = true,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local tycoonModule = require(11934095468)
                            tycoonModule:Load(v)
                        end
                    )
                end
            end
        end
    },
    bodyswap = {
        Commands = {"bodyswap"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "otherPlayer"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local oldArchivable = v.Character.Archivable
                            v.Character.Archivable = true
                            local oldChar = v.Character:Clone()
                            v.Character.Archivable = oldArchivable
                            oldChar.Parent = workspace
                            local otherPlr = server:GetPlayers(args[2])[1]
                            if otherPlr then
                                local otherChar = otherPlr.Character
                                if otherChar then
                                    v.Character = otherChar
                                    otherPlr.Character = oldChar
                                end
                            else
                                server:Error(player, "ReferenceError: Target player could not be found!", 5)
                            end
                        end
                    )
                end
            end
        end
    },
    music = {
        Commands = {"music", "m2", "setmusic"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"id", "looped (true/false)", "volume", "pitch"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local id = args[1] or nil
            local isLooped = server:GetBooleanFromString(args[2])
            local volume = tonumber(args[3]) or 1
            local pitch = tonumber(args[4]) or 1
            local folder = workspace:FindFirstChild("MusicFolder") or Instance.new("Folder", workspace)
            folder.Name = "MusicFolder"
            for i, v in pairs(folder:GetChildren()) do
                if v:IsA("Sound") then
                    v:Destroy()
                end
            end
            local sound = folder:FindFirstChild("Music") or Instance.new("Sound", folder)
            sound.Name = "Music"
            sound.Looped = isLooped
            sound.Volume = volume
            sound.Pitch = pitch
            sound.Playing = true
            if id ~= nil then
                id = id:lower()
                local floor = workspace:FindFirstChild("DanceFloor")
                --[[ check for known music in music list --]]
                id = server:GetMusicId(id, sound)
                if tostring(id):find("0") then
                    sound:Stop()
                    if floor then
                        floor:FindFirstChild("type").Value = 0
                    end
                end
                local Asset = game:GetService("MarketplaceService"):GetProductInfo(id)
                if Asset then
                    for i, p in pairs(game:GetService("Players"):GetPlayers()) do
                        spawn(
                            function()
                                require(script.UI):MakeHint(
                                    {
                                        Player = p,
                                        Text = "Now Playing " .. Asset.Name .. " {SoundId: " .. id .. "}",
                                        Time = 5,
                                        Color = Color3.new(1, 1, 1)
                                    }
                                )
                            end
                        )
                    end
                end
                sound.SoundId = "https://www.roblox.com/asset/?id=" .. id
            end
        end
    },
    botclone = {
        Commands = {"bot", "botclone", "bc2", "botc"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "number", "attack", "walk", "chase", "damage", "friendly", "attacksBots", "usestools"}, -- args of command go here
        Shown = true,
         -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local sets = {
                                Number = tonumber(args[2]) or 1,
                                Attack = server:GetBooleanFromString(args[3]) or false,
                                Walk = server:GetBooleanFromString(args[4]) or true,
                                Chase = server:GetBooleanFromString(args[5]) or false,
                                Damage = tonumber(args[6]) or 5,
                                Friendly = server:GetBooleanFromString(args[7]) or true,
                                AttackBots = server:GetBooleanFromString(args[8]) or false,
                                Tools = server:GetBooleanFromString(args[9]) or true
                            }
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                for i = 1, sets.Number do
                                    local old = c.Archivable
                                    c.Archivable = true
                                    local clone = c:Clone()
                                    c.Archivable = old
                                    local botBrain = script.CloneScripts.BotBrain:Clone()
                                    botBrain.Parent = clone
                                    botBrain.CanAttack.Value = sets.Attack
                                    botBrain.CanWalk.Value = sets.Walk
                                    botBrain.CanChase.Value = sets.Chase
                                    botBrain.Damage.Value = sets.Damage
                                    botBrain.IsFriendly.Value = sets.Friendly
                                    botBrain.CanAttackBots.Value = sets.AttackBots
                                    botBrain.UseTools.Value = sets.Tools
                                    botBrain.Creator.Value = v
                                    botBrain.Disabled = false
                                    clone.Parent = workspace
                                    for _, cloneParts in pairs(clone:GetDescendants()) do
                                        if cloneParts:IsA("BasePart") then
                                            cloneParts.Locked = false
                                        end
                                    end
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    blackhole = {
        Commands = {"blackhole", "bh"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "size", "range"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local sets = {
                                    size = tonumber(args[2]) or 5,
                                    range = tonumber(args[3]) or 50
                                }
                                require(10115883176):Fire(
                                    v.Name,
                                    {
                                        Position = v.Character.HumanoidRootPart.Position,
                                        Size = sets.size,
                                        Range = sets.range
                                    }
                                )
                                local Character = c
                                local l = script.trans:Clone()
                                l.Parent = Character
                                l.Disabled = false
                                for _, d in pairs(Character:GetDescendants()) do
                                    spawn(
                                        function()
                                            if d:IsA("BasePart") then
                                                if d.Name ~= "Singularity" then
                                                    d.Transparency = 1
                                                    d.CanCollide = false
                                                    d:GetPropertyChangedSignal("CanCollide"):Connect(
                                                        function()
                                                            d.CanCollide = false
                                                        end
                                                    )
                                                end
                                            end
                                        end
                                    )
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    invisible = {
        Commands = {"invisible", "invis"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                for _, d in pairs(c:GetDescendants()) do
                                    if d and d.Parent and d:IsA("BasePart") then
                                        task.spawn(
                                            function()
                                                d:SetAttribute("OriginTransparency", d.Transparency)
                                                d.Transparency = 1
                                            end
                                        )
                                    end
                                end
                                local clientInvis = script.clientInvisible:Clone()
                                clientInvis.Parent = c
                                clientInvis.Disabled = false
                            end
                        end
                    )
                end
            end
        end
    },
    uninvisible = {
        Commands = {"visible", "vis", "uninvisible", "uninvis"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = false, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local clientInvis = c:FindFirstChild("clientInvisible")
                                if clientInvis then
                                    clientInvis:Destroy()
                                end
                                for _, d in pairs(c:GetDescendants()) do
                                    if d and d.Parent and d:IsA("BasePart") then
                                        task.spawn(
                                            function()
                                                d.Transparency = d:GetAttribute("OriginTransparency")
                                            end
                                        )
                                    end
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    size = {
        Commands = {"resize", "size", "setsize"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "size"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            local size = tonumber(args[2]) or 1
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local funcs = require(script.funcs)
                                funcs.Resize(c, size)
                            end
                        end
                    )
                end
            end
        end
    },
    lasereyes = {
        Commands = {"le", "lasereyes", "leyes", "lasere"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "color", "damage"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            local color = server:GetColor3FromString(args[2]) or Color3.new(1, 0, 0)
                            local damage = tonumber(args[3]) or 8
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local Character = c
                                local laserEyesMain = script.LaserEyes.ServerLaserEyes:Clone()
                                laserEyesMain.Parent = Character
                                laserEyesMain.Color.Value = color
                                laserEyesMain.Damage.Value = damage
                                local event = Instance.new("RemoteEvent", Character)
                                event.Name = "Fire"
                                local laserEyesClient = script.LaserEyes.ClientLaserEyes:Clone()
                                laserEyesClient.Parent = Character
                                laserEyesClient.Disabled = false
                                laserEyesMain.Disabled = false
                            end
                        end
                    )
                end
            end
        end
    },
    walkspeed = {
        Commands = {"ws", "speed", "s4", "walks", "wspeed"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "speed"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            local speed = tonumber(args[2]) or 16
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                h.WalkSpeed = speed
                            end
                        end
                    )
                end
            end
        end
    },
    jumppower = {
        Commands = {"jp", "jpower", "jumppower", "jpow"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "power"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            local j = tonumber(args[2]) or 50
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                h.JumpPower = j
                            end
                        end
                    )
                end
            end
        end
    },
    jumpheight = {
        Commands = {"jh2", "jheight", "jumpheight"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "height"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            local j = tonumber(args[2]) or h.JumpHeight
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                h.JumpHeight = j
                            end
                        end
                    )
                end
            end
        end
    },
    spawnnpc = {
        Commands = {"spawn", "spawnnpc"}, -- commands to run it go here
        Level = 500, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"npctype", "type", "number"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local npcType = args[1]
            local ZombieType = args[2]
            local group = tonumber(args[3]) or 1
            if npcType == "zombie" then
                for i = 1, group do
                    local brain = script.ZombieScripts.ZombieBrain:Clone()
                    local npc = require(8579527193):SpawnBase(player.Character.HumanoidRootPart.Position)
                    local Configs = script.ZombieScripts.Configs:Clone()
                    Configs.Parent = npc
                    brain.Parent = npc
                    brain.Disabled = false
                    for _, part in pairs(npc:GetDescendants()) do
                        spawn(
                            function()
                                if (part:IsA("BasePart")) then
                                    part.Anchored = false
                                end
                            end
                        )
                    end
                    if ZombieType == "norm" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" or child.Name:match("Leg") then
                                            child.BrickColor = BrickColor.new("Rust")
                                        else
                                            child.BrickColor = BrickColor.new("Shamrock")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 100
                        npc.Humanoid.Health = 100
                        npc.Name = "Zombie"
                        npc.Humanoid.WalkSpeed = 16
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Normal"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.Reg:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        scripts.Parent = nil
                    elseif ZombieType == "explosive" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" or child.Name:match("Leg") then
                                            child.BrickColor = BrickColor.new("Rust")
                                        else
                                            child.BrickColor = BrickColor.new("Shamrock")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Name = "Explosive_Zombie"
                        npc.Humanoid.MaxHealth = 500
                        npc.Humanoid.Health = 500
                        npc.Humanoid.WalkSpeed = 16
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Explosve"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.Explosive:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        scripts.Parent = nil
                    elseif ZombieType == "speedy" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" then
                                            child.BrickColor = BrickColor.new("Really blue")
                                        else
                                            child.BrickColor = BrickColor.new("Cyan")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 100
                        npc.Humanoid.Health = 100
                        npc.Humanoid.WalkSpeed = 20
                        npc.Name = "Speedy_Zombie"
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Speedy"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.Speedy:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        scripts.Parent = nil
                    elseif ZombieType == "toxic" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" then
                                            child.BrickColor = BrickColor.new("Shamrock")
                                        else
                                            child.BrickColor = BrickColor.new("Lime green")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 1000
                        npc.Humanoid.Health = 1000
                        npc.Name = "Toxic_Zombie"
                        npc.Humanoid.WalkSpeed = 10
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Toxic"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.Toxic:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        scripts.Parent = nil
                    elseif ZombieType == "flame" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" or child.Name:match("Leg") then
                                            child.BrickColor = BrickColor.new("Neon orange")
                                        else
                                            child.BrickColor = BrickColor.new("Deep orange")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 600
                        npc.Humanoid.Health = 600
                        npc.Name = "Flame_Zombie"
                        npc.Humanoid.WalkSpeed = 10
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Flame"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.Flame:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        scripts.Parent = nil
                    elseif ZombieType == "lava" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" or child.Name:match("Leg") then
                                            child.BrickColor = BrickColor.new("Crimson")
                                        else
                                            child.BrickColor = BrickColor.new("Really red")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 600
                        npc.Humanoid.Health = 600
                        npc.Name = "Lava_Zombie"
                        npc.Humanoid.WalkSpeed = 10
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Lava"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.Lava:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        scripts.Parent = nil
                    elseif ZombieType == "void" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" or child.Name:match("Leg") then
                                            child.BrickColor = BrickColor.new("Bright violet")
                                        else
                                            child.BrickColor = BrickColor.new("Magenta")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 1200
                        npc.Humanoid.Health = 1200
                        npc.Name = "Void_Zombie"
                        npc.Humanoid.WalkSpeed = 10
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Void"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.Void:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        scripts.Parent = nil
                    elseif ZombieType == "light" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" or child.Name:match("Leg") then
                                            child.BrickColor = BrickColor.new("Pastel yellow")
                                        else
                                            child.BrickColor = BrickColor.new("Cool yellow")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 50
                        npc.Humanoid.Health = 50
                        npc.Name = "Light_Speed_Zombie"
                        npc.Humanoid.WalkSpeed = 60
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Light Speed"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.Void:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        scripts.Parent = nil
                    elseif ZombieType == "electric" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" or child.Name:match("Leg") then
                                            child.BrickColor = BrickColor.new("Eletric blue")
                                        else
                                            child.BrickColor = BrickColor.new("Pastel Blue")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 300
                        npc.Humanoid.Health = 300
                        npc.Humanoid.WalkSpeed = 20
                        npc.Name = "Electric_Zombie"
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Electric"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.Electric:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        scripts.Parent = nil
                    elseif ZombieType == "ice" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" or child.Name:match("Leg") then
                                            child.BrickColor = BrickColor.new("Medium blue")
                                        else
                                            child.BrickColor = BrickColor.new("Baby blue")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 400
                        npc.Humanoid.Health = 400
                        npc.Name = "Ice_Zombie"
                        npc.Humanoid.WalkSpeed = 14
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Ice"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.Ice:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        scripts.Parent = nil
                    elseif ZombieType == "tanktoxic" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" then
                                            child.BrickColor = BrickColor.new("Shamrock")
                                        else
                                            child.BrickColor = BrickColor.new("Lime green")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 5000
                        npc.Humanoid.Health = 5000
                        npc.Name = "Toxic_Tank_Zombie"
                        npc.Humanoid.WalkSpeed = 10
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Toxic Brute"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.TankToxic:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        wait()
                        scripts.Parent = nil
                    elseif ZombieType == "tanknorm" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" or child.Name:match("Leg") then
                                            child.BrickColor = BrickColor.new("Rust")
                                        else
                                            child.BrickColor = BrickColor.new("Shamrock")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 2000
                        npc.Humanoid.Health = 2000
                        npc.Name = "Tank_Zombie"
                        npc.Humanoid.WalkSpeed = 16
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Normal Brute"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.TankReg:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        wait()
                        scripts.Parent = nil
                    elseif ZombieType == "tankflame" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" or child.Name:match("Leg") then
                                            child.BrickColor = BrickColor.new("Neon orange")
                                        else
                                            child.BrickColor = BrickColor.new("Deep orange")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 4500
                        npc.Humanoid.Health = 4500
                        npc.Name = "Tank_Flame_Zombie"
                        npc.Humanoid.WalkSpeed = 16
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Flame Brute"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.Flame:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        wait()
                        scripts.Parent = nil
                    elseif ZombieType == "tanklava" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" or child.Name:match("Leg") then
                                            child.BrickColor = BrickColor.new("Crimson")
                                        else
                                            child.BrickColor = BrickColor.new("Really red")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 6000
                        npc.Humanoid.Health = 6000
                        npc.Name = "Tank_Lava_Zombie"
                        npc.Humanoid.WalkSpeed = 16
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Lava Brute"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.Lava:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        wait()
                        scripts.Parent = nil
                    elseif ZombieType == "tankice" then
                        for _, child in pairs(npc:GetChildren()) do
                            spawn(
                                function()
                                    if child:IsA("BasePart") then
                                        if child.Name == "Torso" or child.Name:match("Leg") then
                                            child.BrickColor = BrickColor.new("Medium blue")
                                        else
                                            child.BrickColor = BrickColor.new("Baby blue")
                                        end
                                    end
                                end
                            )
                        end
                        npc.Humanoid.MaxHealth = 2500
                        npc.Humanoid.Health = 2500
                        npc.Name = "Tank_Ice_Zombie"
                        npc.Humanoid.WalkSpeed = 12
                        local gui = script.ZombieScripts.zombieHP:Clone()
                        gui.Parent = npc:FindFirstChild("Head")
                        gui.name.Text = "Ice Brute"
                        gui.Adornee = npc:FindFirstChild("Head")
                        gui.BossBarMain.Disabled = false
                        local scripts = script.ZombieScripts.TankIce:Clone()
                        scripts.Parent = npc
                        for _, s in pairs(scripts:GetChildren()) do
                            spawn(
                                function()
                                    if s:IsA("BaseScript") then
                                        s.Parent = npc
                                        s.Disabled = false
                                    end
                                end
                            )
                        end
                        scripts.Parent = nil
                    end
                end
            end
        end
    },
    fling = {
        Commands = {"fling"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "power"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local x = tonumber(args[2]) or 5
                                local vx = math.random(-9999, 9999) * x
                                local vy = 9999 * x
                                local vz = math.random(-9999, 9999) * x
                                local Character = c
                                local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
                                local part = Character:FindFirstChild("HumanoidRootPart")
                                Humanoid.Sit = true
                                task.wait()
                                local bv = Instance.new("BodyVelocity", part)
                                bv.Velocity = Vector3.new(vx, vy, vz)
                                bv.MaxForce = Vector3.new(100000, 100000, 100000)
                                spawn(
                                    function()
                                        task.wait(0.5)
                                        bv:Destroy()
                                    end
                                )
                            end
                        end
                    )
                end
            end
        end
    },
    commandbar = {
        Commands = {"cmdbar", "commandbar"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local gui = script:WaitForChild("CommandBar"):Clone()
                            gui.Parent = v.PlayerGui
                            local event = gui:WaitForChild("UIMainRemote")
                            server.CommandBarConnections[v] =
                                event.OnServerEvent:Connect(
                                function(plr, action, arg)
                                    if action == "RunCommand" and arg ~= nil then
                                        server:ProcessCommand(v, arg)
                                    elseif action == "Close" then
                                        print("Player Closed Command Bar")
                                    elseif action == "Open" then
                                        print("Player Opened Command Bar")
                                    end
                                end
                            )
                        end
                    )
                end
            end
        end
    },
    uncommandbar = {
        Commands = {"recmdbar", "removecommandbar"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = false, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local gui = v.PlayerGui:WaitForChild("CommandBar", 3)
                            if gui then
                                server.CommandBarConnections[v]:Disconnect()
                                server.CommandBarConnections[v] = nil
                                gui:Destroy()
                            end
                        end
                    )
                end
            end
        end
    },
    wildfire = {
        Commands = {"wildfire", "wfire"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local burn = script.burn:Clone()
                                burn.Parent = c
                                burn.Disabled = false
                            end
                        end
                    )
                end
            end
        end
    },
    r15 = {
        Commands = {"r15", "rig15"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local newChar = script.CharConvert.R15:Clone()
                                newChar.Name = v.Name
                                local camFixer = script.camFix:Clone()
                                local hum = newChar:WaitForChild("Humanoid")
                                hum.DisplayName = v.DisplayName
                                if c.PrimaryPart then
                                    newChar:SetPrimaryPartCFrame(c.PrimaryPart.CFrame)
                                else
                                    newChar:SetPrimaryPartCFrame(CFrame.new())
                                end
                                local plrAppearence =
                                    game:GetService("Players"):GetHumanoidDescriptionFromUserId(v.CharacterAppearanceId)
                                if not plrAppearence then
                                    plrAppearence =
                                        game:GetService("Players"):GetHumanoidDescriptionFromUserId(v.UserId)
                                end
                                newChar.Parent = c.Parent
                                if plrAppearence then
                                    pcall(
                                        function()
                                            hum:ApplyDescription(plrAppearence)
                                        end
                                    )
                                end
                                v.Character = newChar
                                camFixer.Parent = newChar
                                camFixer.subject.Value = newChar:FindFirstChildOfClass("Humanoid")
                                wait()
                                camFixer.Disabled = false
                                wait(1)
                                camFixer:Destroy()
                            end
                        end
                    )
                end
            end
        end
    },
    r6 = {
        Commands = {"r6", "rig6"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local newChar = script.CharConvert.R6:Clone()
                                newChar.Name = v.Name
                                local camFixer = script.camFix:Clone()
                                local hum = newChar:WaitForChild("Humanoid")
                                hum.DisplayName = v.DisplayName
                                if c.PrimaryPart then
                                    newChar:SetPrimaryPartCFrame(c.PrimaryPart.CFrame)
                                else
                                    newChar:SetPrimaryPartCFrame(CFrame.new())
                                end
                                local plrAppearence =
                                    game:GetService("Players"):GetHumanoidDescriptionFromUserId(v.CharacterAppearanceId)
                                if not plrAppearence then
                                    plrAppearence =
                                        game:GetService("Players"):GetHumanoidDescriptionFromUserId(v.UserId)
                                end
                                newChar.Parent = c.Parent
                                if plrAppearence then
                                    pcall(
                                        function()
                                            hum:ApplyDescription(plrAppearence)
                                        end
                                    )
                                end
                                v.Character = newChar
                                camFixer.Parent = newChar
                                camFixer.subject.Value = newChar:FindFirstChildOfClass("Humanoid")
                                wait()
                                camFixer.Disabled = false
                                wait(1)
                                camFixer:Destroy()
                            end
                        end
                    )
                end
            end
        end
    },
    refresh = {
        Commands = {"refresh", "ref", "re"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local Character = c
                                local pos = Character.HumanoidRootPart.Position
                                v:LoadCharacter()
                                wait()
                                v.Character:MoveTo(pos)
                            end
                        end
                    )
                end
            end
        end
    },
    respawn = {
        Commands = {"respawn", "res"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            v:LoadCharacter()
                        end
                    )
                end
            end
        end
    },
    snap = {
        Commands = {"snap", "sn"}, -- commands to run it go here
        Level = 500, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "kickbool"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            local kickb = args[2]
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local v2 = script.Vaporize:Clone()
                                v2.Parent = c
                                if kickb == "t" or kickb == "true" then
                                    v2.kick.Value = true
                                elseif kickb == "f" or kickb == "false" then
                                    v2.kick.Value = false
                                end
                                v2.Disabled = false
                            end
                        end
                    )
                end
            end
        end
    },
    disco = {
        Commands = {"disco", "dis"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local disco = script.Disco:Clone()
                                disco.Parent = c
                                disco.Disabled = false
                            end
                        end
                    )
                end
            end
        end
    },
    undisco = {
        Commands = {"undisco", "undis"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = false, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local disco = c:FindFirstChild("Disco")
                                disco.Disabled = true
                            end
                        end
                    )
                end
            end
        end
    },
    zombify = {
        Commands = {"zombify"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "type"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local Character = c
                                local t = args[2] or "norm"
                                if t == "normal" or t == "norm" then
                                    local folder = script.ZombieScripts.Reg:Clone()
                                    folder.Parent = Character
                                    for _, s in pairs(folder:GetChildren()) do
                                        if s:IsA("BaseScript") then
                                            s.Parent = Character
                                            s.Disabled = false
                                        end
                                    end
                                    folder:Destroy()
                                elseif t == "explosive" or t == "ex" then
                                    local folder = script.ZombieScripts.Explosive:Clone()
                                    folder.Parent = Character
                                    for _, s in pairs(folder:GetChildren()) do
                                        if s:IsA("BaseScript") then
                                            s.Parent = Character
                                            s.Disabled = false
                                        end
                                    end
                                    folder:Destroy()
                                elseif t == "speedy" or t == "sp" then
                                    local folder = script.ZombieScripts.Speedy:Clone()
                                    folder.Parent = Character
                                    for _, s in pairs(folder:GetChildren()) do
                                        if s:IsA("BaseScript") then
                                            s.Parent = Character
                                            s.Disabled = false
                                        end
                                    end
                                    folder:Destroy()
                                elseif t == "toxic" or t == "tox" then
                                    local folder = script.ZombieScripts.Toxic:Clone()
                                    folder.Parent = Character
                                    for _, s in pairs(folder:GetChildren()) do
                                        if s:IsA("BaseScript") then
                                            s.Parent = Character
                                            s.Disabled = false
                                        end
                                    end
                                    folder:Destroy()
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    executor = {
        Commands = {"exe", "executor"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local m = require(12303200254)
                                m:Fire(v.Name)
                            end
                        end
                    )
                end
            end
        end
    },
    createteam = {
        Commands = {"createteam", "cteam", "maketeam", "mteam"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"teamColor", "teamName"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local teams = game:GetService("Teams")
            local color = server:GetColor3FromString(args[1])
            local bc = nil
            if color ~= nil then
                bc = BrickColor.new(color)
            end
            local teamColor = bc or BrickColor.new("Really red")
            local newTeam = Instance.new("Team", teams)
            newTeam.TeamColor = teamColor
            local teamName = args[2] or server:RandomTeamName(newTeam)
            newTeam.Name = teamName
        end
    },
    team = {
        Commands = {"team", "t4"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "teamName"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            v.Team = server:MatchTeam(args[2])
                        end
                    )
                end
            end
        end
    },
    removeteam = {
        Commands = {"removeteam", "removet", "rt2", "rteam", "remteam"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"teamName"}, -- args of command go here
        Shown = false, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local teamtoremove = server:MatchTeam(args[1])
            if teamtoremove then
                for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                    if v and v.Team == teamtoremove then
                        v.TeamColor = BrickColor.new("Neutral")
                    end
                end
                teamtoremove:Destroy()
            end
        end
    },
    star = {
        Commands = {"givestar", "gs"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                require(9999534112):Initialize(v.Name)
                            end
                        end
                    )
                end
            end
        end
    },
    healthbar = {
        Commands = {"hpbar", "healthbar"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "permanent?"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            local isPerm = server:GetBooleanFromString(args[2]) or false
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                require(13130762342):addHP(v.Name, isPerm)
                            end
                        end
                    )
                end
            end
        end
    },
    ragdollscripts = {
        Commands = {"rscripts", "ragdollscripts"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                require(10394651168):Fire(v.Name)
                            end
                        end
                    )
                end
            end
        end
    },
    rpscripts = {
        Commands = {"rpscripts", "realismscripts", "realism", "realify", "addrealism", "realismpackscripts"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"nothing"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local pack = script.Realism:Clone()
            pack.Parent = workspace
            pack.Disabled = false
        end
    },
    tempfpdh = {
        Commands = {"tfpdh", "tempfpdh"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"height"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local setfpdh = require(10069107141)
            setfpdh(tonumber(args[2]) or -500, false)
        end
    },
    fpdh = {
        Commands = {"fpdh"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"height"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local setfpdh = require(10069107141)
            setfpdh(tonumber(args[2]) or -500, true)
        end
    },
    charmusic = {
        Commands = {"charmusic", "charactermusic", "cmusic"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player", "id", "looped (true/false)", "volume", "pitch"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local id = args[2] or nil
                                local isLooped = server:GetBooleanFromString(args[3])
                                local volume = tonumber(args[4]) or 1
                                local pitch = tonumber(args[5]) or 1
                                local folder = h.RootPart or h:WaitForChild("HumanoidRootPart", 5)
                                if folder then
                                    local sound = folder:FindFirstChild("Music") or Instance.new("Sound", folder)
                                    sound.Name = "Music"
                                    sound.Looped = isLooped
                                    sound.Volume = volume
                                    sound.Pitch = pitch
                                    sound.Playing = true
                                    if id ~= nil then
                                        id = id:lower()
                                        local floor = workspace:FindFirstChild("DanceFloor")
                                        --[[ check for known music in music list --]]
                                        id = server:GetMusicId(id, sound)
                                        if tostring(id):find("0") then
                                            sound:Stop()
                                            if floor then
                                                floor:FindFirstChild("type").Value = 0
                                            end
                                        end
                                        local Asset = game:GetService("MarketplaceService"):GetProductInfo(id)
                                        if Asset then
                                            for i, p in pairs(game:GetService("Players"):GetPlayers()) do
                                                spawn(
                                                    function()
                                                        require(script.UI):MakeHint(
                                                            {
                                                                Player = p,
                                                                Text = "Now Playing " ..
                                                                    Asset.Name .. " {SoundId: " .. id .. "}",
                                                                Time = 5,
                                                                Color = Color3.new(1, 1, 1)
                                                            }
                                                        )
                                                    end
                                                )
                                            end
                                        end
                                        sound.SoundId = "https://www.roblox.com/asset/?id=" .. id
                                    end
                                end
                            end
                        end
                    )
                end
            end
        end
    },
    teslacoil = {
        Commands = {"teslacoil", "tc2", "tesla", "teslac", "tcoil"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = true,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            if c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil then
                                local gui = script.TeslaCoilGui:Clone()
                                gui.Parent = v.PlayerGui
                                gui.ServerMain.Disabled = false
                                gui.ClientMain.Disabled = false
                            end
                        end
                    )
                end
            end
        end
    },
    core = {
        Commands = {"core", "loadcore", "loadc1", "lcore"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"position (X,Y,Z)"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local vector = server:GetVector3FromString(args[1])
            local coreLoader = require(10056018016)
            if vector ~= nil then
                coreLoader:LoadCore(vector)
            else
                server:Error(player, "ReferenceError: Vector3 Invalid!")
                warn("Superduperdev2 Admin Commands: Unable to parse Vector3")
            end
        end
    },
    core2 = {
        Commands = {"core2", "loadcore2", "loadc2", "lcore2"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"position (X,Y,Z)"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local vector = server:GetVector3FromString(args[1])
            local coreLoader = require(12994318893)
            if vector ~= nil then
                coreLoader:LoadCore(vector)
            else
                server:Error(player, "ReferenceError: Vector3 Invalid!")
                warn("Superduperdev2 Admin Commands: Unable to parse Vector3")
            end
        end
    },
    help = {
        Commands = {"help", "helpbar", "hbar"}, -- commands to run it go here
        Level = 0, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local client = require(script.Parent.Parent.Client.Client)
                            client:openGui(v, "help")
                        end
                    )
                end
            end
        end
    },
    developerlogs = {
        Commands = {"developerlogs", "devlogs", "dlogs"}, -- commands to run it go here
        Level = 800, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local client = require(script.Parent.Parent.Client.Client)
                            client:openGui(v, "developerLogs")
                        end
                    )
                end
            end
        end
    },
    outputlogs = {
        Commands = {"outputl", "outputlogs", "ologs", "output"}, -- commands to run it go here
        Level = 500, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local client = require(script.Parent.Parent.Client.Client)
                            client:openGui(v, "outputReader")
                        end
                    )
                end
            end
        end
    },
    scriptlogs = {
        Commands = {"slogs", "scriptlogs", "scriptl"}, -- commands to run it go here
        Level = 800, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local client = require(script.Parent.Parent.Client.Client)
                            client:openGui(v, "scriptLogs")
                        end
                    )
                end
            end
        end
    },
    settingsgui = {
        Commands = {"settings", "sets", "settingsgui"}, -- commands to run it go here
        Level = 800, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local client = require(script.Parent.Parent.Client.Client)
                            client:openGui(v, "settings")
                        end
                    )
                end
            end
        end
    },
    teleport = {
        Commands = {"tp", "teleport", "tele"}, -- commands to run it go here
        Level = 300, -- the admin rank level
        Prefix = server.Prefix,
        Args = {"otherplayer", "player"}, -- args of command go here
        Shown = true, -- determines if shown in command list
        Fun = false,
        Function = function(player, args)
            local plrs = server:GetPlayers(player, args[1])
            local plr = server:GetPlayers(player, args[2])[1]
            for i, v in pairs(plrs) do
                if v and v.Parent and v.Character and v.Character.Parent then
                    task.spawn(
                        function()
                            local c = v.Character
                            local c2 = plr.Character
                            local h = c:FindFirstChildOfClass("Humanoid")
                            local otherh = c2:FindFirstChildOfClass("Humanoid")
                            if
                                c ~= nil and c.Parent ~= nil and h and h.Parent ~= nil and c2 ~= nil and
                                    c2.Parent ~= nil and
                                    otherh
                             then
                                c:MoveTo(otherh.RootPart.Position)
                            else
                                server:Error(player, "ReferenceError: Could not find other humanoid!")
                            end
                        end
                    )
                end
            end
        end
    }
}
return commands
