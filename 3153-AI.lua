-- Gui to Lua
-- Version: 3.2

-- Instances:

local Robot = Instance.new("ScreenGui")
local DisableAI = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local EnableAI = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")

--Properties:

Robot.Name = "Robot"
Robot.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Robot.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Robot.ResetOnSpawn = false

DisableAI.Name = "DisableAI"
DisableAI.Parent = Robot
DisableAI.BackgroundColor3 = Color3.fromRGB(245, 139, 87)
DisableAI.BorderColor3 = Color3.fromRGB(0, 0, 0)
DisableAI.BorderSizePixel = 0
DisableAI.Position = UDim2.new(0.843610942, 0, 0.26205796, 0)
DisableAI.Size = UDim2.new(0, 212, 0, 61)
DisableAI.Font = Enum.Font.Cartoon
DisableAI.Text = "Disable AI"
DisableAI.TextColor3 = Color3.fromRGB(255, 255, 255)
DisableAI.TextScaled = true
DisableAI.TextSize = 14.000
DisableAI.TextWrapped = true

UICorner.Parent = DisableAI

EnableAI.Name = "EnableAI"
EnableAI.Parent = Robot
EnableAI.BackgroundColor3 = Color3.fromRGB(245, 139, 87)
EnableAI.BorderColor3 = Color3.fromRGB(0, 0, 0)
EnableAI.BorderSizePixel = 0
EnableAI.Position = UDim2.new(0.843610942, 0, 0.172469571, 0)
EnableAI.Size = UDim2.new(0, 212, 0, 61)
EnableAI.Font = Enum.Font.Cartoon
EnableAI.Text = "Enable AI"
EnableAI.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableAI.TextScaled = true
EnableAI.TextSize = 14.000
EnableAI.TextWrapped = true

UICorner_2.Parent = EnableAI

-- Scripts:

local function ISRF_fake_script() -- Robot.Robot 
	local script = Instance.new('LocalScript', Robot)

	local chatservice = game:GetService("TextChatService")
	local textChannel = chatservice:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
	local playerserv = game:GetService("Players")
	local plr = playerserv.LocalPlayer
	local phrases = {}
	local speech = {}
	local roots = {}
	local blacklisted = {}
	local pathfindserv = game:GetService("PathfindingService")
	local onbutton = script.Parent:WaitForChild("EnableAI")
	local offbutton = script.Parent:WaitForChild("DisableAI")
	local enabled2 = true
	local enabled = true
	local timeout = 0.01
	
	local function getphrases()
		phrases = {}
		for i,v in ipairs(getgenv().BotConfig.DefaultPhrases[1]) do
			table.insert(phrases,v)
		end
	end
	
	task.spawn(getphrases)
	
	local function getsecondPhrases()
		phrases = {}
		for i,v in ipairs(getgenv().BotConfig.EncounterPhrases[1]) do
			table.insert(speech,v)
		end
	end
	
	task.spawn(getsecondPhrases)
	
	game.Players.PlayerAdded:Connect(function(plr)
		for i,v in pairs(blacklisted) do
			if plr.UserId == v then
				plr:Kick("You cannot be in a server with this person")
			end
		end
	end)
	
	local function scanserver()
		while task.wait(0.1) do
			for i,v in pairs(playerserv:GetPlayers()) do
				if #blacklisted > 0 then
					for i,userids in ipairs(blacklisted) do
						if v.UserId == userids then
							plr:Kick("You cannot be in a server with this person")
						end
					end
				end
			end
		end
	end
	
	local function refbblacklist()
		for i,v in ipairs(getgenv().Blacklist.blacklistt[1]) do
			table.insert(blacklisted,v)
		end
	end
	
	local function refreshroots()
		table.clear(roots)
		local players = playerserv:GetPlayers()
		for i,v in pairs(players) do
			if v ~= plr then
				if v.Character then
					if v.Character:FindFirstChild("HumanoidRootPart") then
						local root = v.Character:FindFirstChild("HumanoidRootPart")
						if root:IsA("Part") then
							table.insert(roots,root)
						end
					end
				end
			end
		end
		print(roots)
	end
	
	task.spawn(refreshroots)
	
	local function onandoff()
		onbutton.MouseButton1Down:Connect(function()
			enabled = true
			enabled2 = true
		end)
		offbutton.MouseButton1Down:Connect(function()
			enabled = false
			enabled2 = false
		end)
	end
	
	task.spawn(onandoff)
	
	local function sentient()
		if enabled2 == true then
			enabled = false
			local chr = plr.Character
			if chr then
				local hum = chr:WaitForChild("Humanoid")
				local root = chr:WaitForChild("HumanoidRootPart")
				if #roots > 0 and root:IsA("Part") then
					local targetRoot = roots[math.random(1, #roots)]
					local goal = targetRoot.CFrame * CFrame.new(0, 0, -5)
					local goalpos = goal.Position
					local path = pathfindserv:CreatePath({
						WaypointSpacing = 1,
						AgentCanClimb = true
					})
					path:ComputeAsync(root.Position, goalpos)
	
					if path.Status == Enum.PathStatus.NoPath then
						print("unable to move there")
					else
						for i,v in pairs(path:GetWaypoints()) do
							if v.Action == Enum.PathWaypointAction.Jump then
								hum:ChangeState(Enum.HumanoidStateType.Jumping)
							end
							hum:MoveTo(v.Position)
							local reached = hum.MoveToFinished:Wait(timeout)
							if not reached then
								print("taken too long")
								break
							end
						end
						root.CFrame = CFrame.lookAt(root.Position,targetRoot.Position)
						for i,v in ipairs(speech) do
							textChannel:SendAsync(v)
							task.wait(math.random(100,300)/100)
						end
					end
				end		
			end
			task.wait(1)
			enabled = true
		end
	end
	
	local function unsit()
		if plr.Character then
			if plr.Character:FindFirstChildWhichIsA("Humanoid") then
				local hum = plr.Character:FindFirstChildWhichIsA("Humanoid")
				while task.wait(0.1) do
					if hum.Sit == true then
						hum.Sit = false
					end
				end
			end
		end
	end
	
	task.spawn(unsit)
	
	local function pathfind()
		local chr = plr.Character
		if chr then
			local hum = chr:WaitForChild("Humanoid")
			local root = chr:WaitForChild("HumanoidRootPart")
			if root:IsA("Part") and hum:IsA("Humanoid") then
				local randomx = math.random(-50,50)
				local randomz = math.random(-50,50)
				hum.WalkSpeed = math.random(1000,1700)/100
				local pos = root.Position + Vector3.new(randomx,0,randomz)
				local path = pathfindserv:CreatePath({
					WaypointSpacing = 1,
					AgentCanClimb = true
				})
				path:ComputeAsync(root.Position,pos)
	
				if path.Status == Enum.PathStatus.NoPath then
					print("unable to move there")
				else
					for i,v in pairs(path:GetWaypoints()) do
						if enabled == true then
							if v.Action == Enum.PathWaypointAction.Jump then
								hum:ChangeState(Enum.HumanoidStateType.Jumping)
							end
							hum:MoveTo(v.Position)
							local reached = hum.MoveToFinished:Wait(timeout)
							if not reached then
								print("taken too long")
								break
							end
						else
							break
						end
					end
				end
			end
		end
	end
	
	local function pfstart()
		while task.wait(math.random(500,30000)/10000) do
			if enabled == true then
				pathfind()
				if enabled == true then
					if #phrases > 0 then
						textChannel:SendAsync(phrases[math.random(1,#phrases)])
					end
				end
			end
		end
	end
	
	local function easterpf()
		while task.wait(math.random(10000,60000)/1000) do
			if enabled == true then
				task.spawn(refreshroots)
				sentient()
			end
		end
	end
	
	task.spawn(easterpf)
	task.spawn(pfstart)
end
coroutine.wrap(ISRF_fake_script)()
