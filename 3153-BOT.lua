local botscript = Instance.new("ScreenGui")
local StartButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local StopButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local PhraseBox = Instance.new("TextBox")
local UICorner_3 = Instance.new("UICorner")
local AddPhrase = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local ClearPhrases = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local ResetPhrases = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")

botscript.Name = "botscript"
botscript.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
botscript.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function BotMain()
	local enabled = true
	local chatservice = game:GetService("TextChatService")
	local textChannel = chatservice:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
	local startbutton = botscript.StartButton
	local stopbutton = botscript.StopButton
	local addphrase = botscript.AddPhrase
	local clearphrases = botscript.ClearPhrases
	local phrasebox = botscript.PhraseBox
	local resetphrases = botscript.ResetPhrases
	local Playerservice = game:GetService("Players")

	local phrases = {}
	local roots = {}
	local localplr = Playerservice.LocalPlayer

	local function resettable()
		phrases = {}
		for _,v in ipairs(getgenv().BotConfig.DefaultPhrases) do
			table.insert(phrases,v)
		end
	end
	task.spawn(resettable)

	local function onandoff()
		startbutton.MouseButton1Up:Connect(function()
			enabled = true
		end)
		stopbutton.MouseButton1Up:Connect(function()
			enabled = false
		end)
		addphrase.MouseButton1Up:Connect(function()
			local text = phrasebox.Text
			if text ~= "" then
				table.insert(phrases,text)
			end
		end)
		clearphrases.MouseButton1Up:Connect(function()
			table.clear(phrases)
		end)
		resetphrases.MouseButton1Up:Connect(function()
			table.clear(phrases)
			task.spawn(resettable)
		end)
	end
	task.spawn(onandoff)

	local function spin()
		if localplr.Character and localplr.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = localplr.Character:FindFirstChild("HumanoidRootPart")
			if hrp:IsA("Part") then
				while task.wait() do
					hrp.CFrame *= CFrame.Angles(0,0.1,0)
				end
			end
		end
	end
	task.spawn(spin)

	local function tablerefresh()
		table.clear(roots)
		for _,v in ipairs(Playerservice:GetPlayers()) do
			if v ~= localplr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local root = v.Character.HumanoidRootPart
				table.insert(roots,root)
			end
		end
	end

	while task.wait(3) do
		if enabled then
			print("script is enabled")
			task.spawn(tablerefresh)
			if localplr.Character and localplr.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = localplr.Character.HumanoidRootPart
				if #roots > 0 then
					local randomhrp = roots[math.random(1,#roots)]
					hrp.CFrame = randomhrp.CFrame
					if #phrases > 0 then
						textChannel:SendAsync(phrases[math.random(1,#phrases)])
					else
						print("no phrases")
					end
				else
					print("no roots")
				end
			end
		else
			print("script is disabled")
		end
	end
end

coroutine.wrap(BotMain)()
