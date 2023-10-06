service = {}
server = require(script.Parent.Parent.Server)

function service:GetMusicId(id)
    local floor = workspace:FindFirstChild("DanceFloor")
    if tonumber(id) then
        id = tonumber(id)
    end
    if tostring(id):lower():find("caramell") then
        id = 2303479
    end
    if tostring(id):find("epic") then
        id = 27697743
        pitch = 2.5
    end
    if tostring(id):find("rick") then
        id = 2027611
    end
    if tostring(id):find("halo") then
        id = 1034065
    end
    if tostring(id):find("pokemon") then
        id = 1372261
    end
    if tostring(id):find("cursed") then
        id = 1372257
    end
    if tostring(id):find("extreme") then
        id = 11420933
    end
    if tostring(id):find("awaken") then
        id = 27697277
    end
    if tostring(id):find("alone") then
        id = 27697392
    end
    if tostring(id):find("mario") then
        id = 1280470
    end
    if tostring(id):find("choir") then
        id = 1372258
    end
    if tostring(id):find("chrono") then
        id = 1280463
    end
    if tostring(id):find("dotr") then
        id = 11420922
    end
    if tostring(id):find("entertain") then
        id = 27697267
    end
    if tostring(id):find("fantasy") then
        id = 1280473
    end
    if tostring(id):find("final") then
        id = 1280414
    end
    if tostring(id):find("emblem") then
        id = 1372259
    end
    if tostring(id):find("flight") then
        id = 27697719
    end
    if tostring(id):find("banjo") then
        id = 27697298
    end
    if tostring(id):find("gothic") then
        id = 27697743
    end
    if tostring(id):find("hiphop") then
        id = 27697735
    end
    if tostring(id):find("intro") then
        id = 27697707
    end
    if tostring(id):find("mule") then
        id = 1077604
    end
    if tostring(id):find("film") then
        id = 27697713
    end
    if tostring(id):find("nezz") then
        id = 8610025
    end
    if tostring(id):find("angel") then
        id = 1372260
    end
    if tostring(id):find("resist") then
        id = 27697234
    end
    if tostring(id):find("schala") then
        id = 5985787
    end
    if tostring(id):find("organ") then
        id = 11231513
    end
    if tostring(id):find("tunnel") then
        id = 9650822
    end
    if tostring(id):find("spanish") then
        id = 5982975
    end
    if tostring(id):find("venom") then
        id = 1372262
    end
    if tostring(id):find("wind") then
        id = 1015394
    end
    if tostring(id):find("guitar") then
        id = 5986151
    end
    if tostring(id):find("marshalone") then
        id = 1046122558
        if floor then
            floor.type.Value = 1
        end
    end
    if tostring(id):find("despacito") then
        id = 1223104968
        if floor then
            floor.type.Value = 1
        end
    end
    if tostring(id):find("hello") then
        id = 1004152986
    end
    if tostring(id):find("spectre") then
        id = 747095460
    end
    if tostring(id):find("fade") then
        id = 531158940
    end
    if tostring(id):find("loud") then
        id = 141509625
    end
    if tostring(id):find("megalovania") then
        id = 3182300166
    end
    if tostring(id):find("meltdown") then
        id = 2738948201
    end
    if tostring(id):find("candyland") then
        id = 9172120741
        if floor then
            floor:FindFirstChild("type").Value = 1
        end
    end
    if tostring(id):find("candyl2") then
        id = 13292738552
        if floor then
            floor:FindFirstChild("type").Value = 1
        end
    end
    if tostring(id):find("infectious") then
        id = 9597426447
        if floor then
            floor:FindFirstChild("type").Value = 1
        end
    end
    if tostring(id):find("cl9") then
        id = 531165615
        if floor then
            floor:FindFirstChild("type").Value = 1
        end
    end
    if tostring(id):find("hope") then
        id = 9172133312
        if floor then
            floor:FindFirstChild("type").Value = 1
        end
    end
    if tostring(id):find("sweetstory") then
        id = 10617886359
        if floor then
            floor:FindFirstChild("type").Value = 1
        end
    end
    if tostring(id):find("caelum") then
        id = 13292771271
        if floor then
            floor:FindFirstChild("type").Value = 1
        end
    end
    if tostring(id):find("sunburst") then
        id = 978633882
        if floor then
            floor:FindFirstChild("type").Value = 1
        end
    end
    if tostring(id):find("boa") then
        id = 1333217879
    end
    if tostring(id):find("colors") then
        id = 5613736298
        for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            local disco = script.Disco:Clone()
            disco.Parent = p.Character
            disco.Disabled = false
        end
    end
    if tostring(id):find("sandstorm") then
        id = 572470293
    end
    if tostring(id):find("suchfun") then
        id = 10617969200
        if floor then
            floor:FindFirstChild("type").Value = 1
        end
    end
    if tostring(id):find("roots") then
        id = 515535889
        if floor then
            floor:FindFirstChild("type").Value = 1
        end
    end
    if tostring(id):find("freaks") then
        id = 3096344509
        pitch = 0.9
    end
    if tostring(id):find("iet") then
        id = 2750483913
        spawn(function()
            for i = 1, 10 do
                local sky = Instance.new("Sky", game.Lighting)
                sky.SkyboxUp = "rbxassetid://1069011469"
                sky.SkyboxBk = "rbxassetid://1069011469"
                sky.SkyboxDn = "rbxassetid://1069011469"
                sky.SkyboxFt = "rbxassetid://1069011469"
                sky.SkyboxLf = "rbxassetid://1069011469"
                sky.SkyboxRt = "rbxassetid://1069011469"
                wait(1)
                sky.SkyboxBk = "rbxasset://textures/sky/sky512_bk.tex"
                sky.SkyboxUp = "rbxasset://textures/sky/sky512_up.tex"
                sky.SkyboxDn = "rbxasset://textures/sky/sky512_dn.tex"
                sky.SkyboxFt = "rbxasset://textures/sky/sky512_ft.tex"
                sky.SkyboxLf = "rbxasset://textures/sky/sky512_lf.tex"
                sky.SkyboxRt = "rbxasset://textures/sky/sky512_rt.tex"
                wait(1)
            end
        end)
    end
    if id then
        return id
    end
end

return service
