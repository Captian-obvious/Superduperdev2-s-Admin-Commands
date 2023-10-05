server = {}
remote = require(script.Parent.Core.Remote)
core = require(script.Parent.Core.Core)
admin = require(script.Parent.Admin.Admin)

function server:Initialize()
    warn('Superduperdev2 Admin Commands: Loading..')
    warn('Superduperdev2 Admin Commands: Initializing server...')
    warn('Superduperdev2 Admin Commands: Requiring modules...')
    
end

function server:ProcessArguments(str,t)
	local args = str:split(server.StringSplitter)
	if args ~= nil then
		local referenceTable = t
		if (referenceTable) and (#referenceTable < #args) then
			for i=#referenceTable+1,#args do
				if args[i] then
					--task.spawn(function()
					args[#referenceTable]=args[#referenceTable]..' '..args[i]
					--end)
				end
			end
		end
	end
	print("Processed args: ", args)
	return args
end

function server:ProcessCommand(player,message)
	local commands = message:split(server.Seperator)
	if commands then
		for _,msg in pairs(commands) do
			if msg~=nil then
				local command = server:GetCommand(msg:lower())
				if command~=nil then
					local com = command.Command -- gives the server a reference back to the command table
					local args = command.Args
					if player:GetAttribute('Rank') >= com.Level then
						local c = command.Command
						local f = c.Function
						local args = server:ProcessArguments(args,c.Args)
						if args ~= nil then
							f(player,args)
						end
					else
						server:Error(player,'You do not have permission to run'..msg,5)
					end
				end
			end
		end
	end
end

function server:Rank(player,level)
	if player ~=nil then
		player:SetAttribute('Rank',level)
	end
end

function server:Kick(player,plr,reason)
	if plr ~= nil then
		local r = reason or 'No Reason Provided.'
		if plr:GetAttribute('Rank') < 500 then
			plr:Kick([[
		        Superduperdev2 Admin Commands:
		        You have been kicked from this server!
		        Reason: ]]..r..[[
		        Please rejoin and do not attempt the above again.
		    ]])
		else
			server:Error(player,'This player is an Administrator and cannot be kicked!',5)
		end
	end
end

function server:ServerBan(player,plr,reason,t)
	if plr ~= nil then
		local r = reason or 'No Reason Provided.'
		if plr:GetAttribute('Rank') < 500 then
			plr:Kick(r)
			game:GetService('Players').PlayerAdded:Connect(function(p)
				if p.Name == plr.Name then
					plr:Kick([[
		                Superduperdev2 Admin Commands: 
		                You have been banned from this server! 
		                Reason: ]]..r..[[
		                You cannot rejoin this server!
		                Join another server.
		            ]])
				end
			end)
		else
			server:Error(player,'This player is an Administrator and cannot be kicked!',5)
		end
	end
end

function server:TimeBan(player,plr,reason,t)
	if plr ~= nil then
		local r = reason or 'No Reason Provided.'
		if plr:GetAttribute('Rank') < 500 then
			local banTime = server:GetSecondsFromTime(t)
			plr:Kick([[
		        Superduperdev2 Admin Commands: 
            	You have been banned! 
            	Reason: ]]..r..[[
            	Ban Length: ]]..t..[[
            	You cannot join the game until above time has elapsed!
            	Please abide by the rules or you will be perm banned.
		    ]])
			server.banDataStore:SetAsync(plr.UserId..'_Bans',{
				StartDate = tick(),
				EndDate = tick() + banTime,
				Reason = r,
				Moderator = player,
				FormattedDate = t,
			})
		else
			server:Error(player,'This player is an Administrator and cannot be kicked!',5)
		end
	end
end

function server:GetSecondsFromTime(str)
	local day = 86400 -- time in a day for bans
	local hour = 3600 -- time in an hour for bans
	local minute = 60
	local result = 0
	local number = str:match('%d+')
	if number then
		local dayKey = 'd'
		local hourKey = 'h'
		local minuteKey = 'min'
		if string.find(str,dayKey) then
			local seconds = number * day
			result = seconds
		end
		if string.find(str,hourKey) then
			local seconds = number * hour
			result = seconds
		end
		if string.find(str,minuteKey) then
			local seconds = number * minute
			result = seconds
		end
	end
	return result
end

function server:GetRank(player)
	local result = 'Player'
	if player ~=nil then
		local level = player:GetAttribute('Rank')
		if level >= 100 and level < 300 then
			result = 'VIP'
		elseif level >= 300 and level < 500 then
			result = 'Moderator'
		elseif level >= 500 and level < 800 then
			result = 'Admin'
		elseif level >= 800 and level < 1000 then
			result = 'Owner'
		elseif level >= 1000 then
			result = 'Creator'
		end
	end
	return result
end

function server:GetCommand(str) 
	local thecommand = nil
	local args = nil
	if str:sub(1,2):find('/e') then
		local msg = str:sub(4)
		warn("Silent Command detected: "..tostring(str))
		for i,v in pairs(server.Commands) do
			if v and v.Prefix then
				for c,com in pairs(v.Commands) do
					local cmd = string.split(msg, server.StringSplitter)
					if cmd[1] and cmd[1] == v.Prefix..com:lower() then 
						thecommand = v
						table.remove(cmd, 1)
						args = table.concat(cmd, server.StringSplitter)
						warn("Command detected (" .. com .. ")")
					else
						--warn("Command not detected (" .. com .. ")")
					end
				end
			else
				warn("Command is nil (" .. i .. " | Cmd Table: " .. tostring(v) .. " | Pre: " .. tostring(v.Prefix) .. ")")
			end
		end
	else
		for i,v in pairs(server.Commands) do
			if v and v.Prefix then
				for c,com in pairs(v.Commands) do
					local cmd = string.split(str, server.StringSplitter)
					if cmd[1] and cmd[1] == v.Prefix..com:lower() then 
						thecommand = v
						table.remove(cmd, 1)
						args = table.concat(cmd, server.StringSplitter)
						warn("Command detected (" .. com .. ")")
					else
						--warn("Command not detected (" .. com .. ")")
					end
				end
			else
				warn("Command is nil (" .. i .. " | Cmd Table: " .. tostring(v) .. " | Pre: " .. tostring(v.Prefix) .. ")")
			end
		end
	end
	if thecommand then
		print("Returned command ", thecommand, " | Args: " .. tostring(args))
		return {Command=thecommand,Args = args}
	else
		warn("Superduperdev2 Admin Commands: Could not find command! | String: " .. tostring(str) .. " | Args: " .. tostring(args) .. " | Cmd: " .. tostring(thecommand)) -- using tostring bc they might be nil
		return nil
	end
end

function server:GetColor3FromString(str)
	local result = nil
	if str~=nil then
	    result = Color3.new(1,1,1)
		local args = string.split(str,',')
		if args[1]:lower()=='red' then
			result = Color3.new(1,0,0)
		elseif args[1]:lower()=='orange' then
			result = BrickColor.new('Neon orange').Color
		elseif args[1]:lower()=='yellow' then
			result = Color3.new(1,1,0)
		elseif args[1]:lower()=='green' then
			result = Color3.new(0,1,0)
		elseif args[1]:lower()=='toothpaste' then
			result = Color3.new(0,1,1)
		elseif args[1]:lower()=='blue' then
			result = Color3.new(0,0,1)
		elseif args[1]:lower()=='dark_blue' then
			result = BrickColor.new('Earth blue').Color
		elseif args[1]:lower()=='lavender' then
			result = BrickColor.new('Lavender').Color
		elseif args[1]:lower()=='teal' then
			result = BrickColor.new('Teal').Color
		elseif args[1]:lower()=='maroon' then
			result = BrickColor.new('Maroon').Color
		elseif args[1]:lower()=='dark_red' then
			result = Color3.new(0.59607,0,0)
		elseif args[1]:lower()=='dark_red2' then
			result = BrickColor.new('Dark red').Color
		elseif args[1]:lower()=='dark_green' then
			result = BrickColor.new('Dark green').Color
		elseif args[1]:lower()=='pink' then
			result = BrickColor.new('Magenta').Color
		elseif args[1]:lower()=='flame' then
			result = BrickColor.new('Flame reddish orange').Color
		elseif args[1]:lower()=='flame2' then
			result = BrickColor.new('Flame yellowish orange').Color
		elseif args[1]:lower()=='flame3' then
			result = BrickColor.new('Fire Yellow').Color
		elseif args[1]:lower()=='sand_red' then
			result = BrickColor.new('Sand red').Color
		elseif args[1]:lower()=='cadet_blue' then
			result = BrickColor.new('Cadet blue').Color
		elseif args[1]:lower()=='electric_blue' then
			result = BrickColor.new('Electric blue').Color
		else
			if tonumber(args[1]) ~= nil and tonumber(args[2])~=nil and tonumber(args[3])~=nil then
				result = Color3.new(tonumber(args[1]),tonumber(args[2]),tonumber(args[3]))
			end
		end
	end
	return result
end

function server:MatchTeam(str)
    local teams = game:GetService('Teams')
    local result = teams:WaitForChild('Neutral',5)
    if str ~= nil then
        local m = str:lower()
        for i,v in pairs(teams:GetChildren()) do
            if v.Name:match(m) then
                result = v
            end
        end
    end
    return result
end

function server:RandomTeamName(team)
    local names = {
        ['Institutional white'] = BrickColor.new('Institutional white'),
        ['Really Red'] = BrickColor.new('Really red'),
        ['Really Blue'] = BrickColor.new('Really blue'),
        ['Yellow Ones'] = BrickColor.new('New Yeller'),
        ['Lime Green'] = BrickColor.new('Lime green'),
        ['Flaming Ones'] = BrickColor.new('Flame reddish orange'),
        ['Flaming Masters'] = BrickColor.new('Flame yellowish orange'),
        ['Fire Benders'] = BrickColor.new('Fire yellow'),
        ['Cyan Ones'] = BrickColor.new('Cyan'),
        ['Maroons'] = BrickColor.new('Maroon'),
        ['Electrically Charged'] = BrickColor.new('Electric blue'),
        ['Darkened Reds'] = BrickColor.new('Dark red'),
        ['Darkened Greens'] = BrickColor.new('Dark green'),
        ['The Cadets'] = BrickColor.new('Cadet blue'),
        ['Teal'] = BrickColor.new('Teal'),
        ['Mint'] = BrickColor.new('Mint'),
        ['Neon Oranges'] = BrickColor.new('Neon orange'),
        ['Lavender Ones'] = BrickColor.new('Lavender'),
        ['Sandy Reds'] = BrickColor.new('Sand red'),
        ['Sandy Blues'] = BrickColor.new('Sand blue'),
        ['Magenta Ones'] = BrickColor.new('Magenta'),
        ['Earthly Greens'] = BrickColor.new('Earth green'),
        ['Earthly Blues'] = BrickColor.new('Earth blue'),
    }
    local result = nil
    if team ~= nil then
        local teamColor = team.TeamColor
        if teamColor then
            result = 'Unnamed Color'
            for name,v in pairs(names) do
                if name then
                    if teamColor == v then
                        result = tostring(name) -- in case it returns a random value
                    end
                end
            end
        end
    end
    return result
end

function server:GetMaterialFromString(str)
	local result = Enum.Material.Sand
	if str~=nil then
		local mat = Enum.Material[str]
		if mat ~= nil then
			result = mat
		else
			warn('Superduperdev2 Admin Commands: Could not find material!')
		end
		return mat
	end
end

function server:GetBooleanFromString(str)
	local result = nil
	if str~=nil then
		if str:lower()=='true' then
			result = true
		else
			result = false
		end
	end
	return result
end

function server:GetPlayers(plr,str)
	local result = {}
	local plrs = game:GetService('Players'):GetPlayers()
	local n = str:lower()
	if server.Selectors[n]==nil then
		for i,v in pairs(plrs) do
			if n == v.Name then
				table.insert(result,v)
			end
		end
	else
		if n:match('all') then
			result = plrs
		elseif n:match('me') then
			result = {plr}
		elseif n:match('random') then
			result = plrs[math.random(1,#plrs)]
		elseif n:match('others') then
			for i,v in pairs(plrs) do
				if v.Name~=plr.Name then
					table.insert(result,v)
				end
			end
		end
	end
	print("Get Players Result: ", result)
	return result
end

function server:FilterString(fromPlayer,str)
	local TextService = game:GetService("TextService")
	local filteredText = ""
	local result = ""
	local filteredTextResult
	local success, errorMessage = pcall(function()
		filteredTextResult = TextService:FilterStringAsync(str, fromPlayer.UserId)
	end)
	local success, errorMessage = pcall(function()
		filteredText = filteredTextResult:GetNonChatStringForBroadcastAsync()
	end)
	if success then
		result = filteredText
	elseif errorMessage then
		warn("Error filtering message:", errorMessage)
	end
	if not success then
		warn("Error filtering text:", str, ":", errorMessage)
	end
	return result
end

return server
