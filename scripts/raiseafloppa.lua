local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local window = library.CreateLib("Lunarian Hub", {
	SchemeColor = Color3.fromRGB(25,25,25),
	Background = Color3.fromRGB(34,34,34),
	Header = Color3.fromRGB(30,30,30),
	TextColor = Color3.fromRGB(255,255,255),
	ElementColor = Color3.fromRGB(17,17,17)
})
local floppa = workspace:FindFirstChild("Floppa") or workspace:WaitForChild("Floppa")
local globalVariables = {
	clickDetector = floppa:FindFirstChildOfClass("ClickDetector"),
	Booleans = {
		AutoclickerActive = false,
		AutoCollect = false,
		AutoFeed = false,
		AutoFeedBaby = false,
		AutoFillMilk = false,
	},
	localPlayer = game:GetService("Players").LocalPlayer,
	NormalBowl = workspace:FindFirstChild("Bowl") or workspace:WaitForChild("Bowl"),
	Services = {
		ReplicatedStorage = game:GetService("ReplicatedStorage")
	},
}

--// MAIN

local main = window:NewTab("Main")
local mainsection = main:NewSection("Main")

mainsection:NewToggle("Autoclicker", "Autoclicks floppa your you", function(state)
	globalVariables.Booleans.AutoclickerActive = state
end)
task.spawn(function()
	while true do
		if not globalVariables.Booleans.AutoclickerActive then
			repeat
				task.wait(0.1)
			until globalVariables.Booleans.AutoclickerActive
		end
		fireclickdetector(globalVariables.clickDetector)
		task.wait(1/4)
	end
end)

mainsection:NewToggle("Auto-Collect Money", "Automatically collects money for you", function(state)
	globalVariables.Booleans.AutoCollect = state
	if state then
		for _, child in next, workspace:GetChildren() do
			if child.Name == "Money" and child:FindFirstChild("Amt") then
				firetouchinterest((globalVariables.localPlayer.Character or globalVariables.localPlayer.CharacterAdded:Wait()):FindFirstChild("Left Leg"),child,0)
			end
			task.wait(.1)
		end
	end
end)

workspace.ChildAdded:Connect(function(child)
	task.wait(0.1)
	if child.Name == "Money" and child:FindFirstChild("Amt") and globalVariables.Booleans.AutoCollect then
		firetouchinterest((globalVariables.localPlayer.Character or globalVariables.localPlayer.CharacterAdded:Wait()):FindFirstChild("Left Leg"),child,0)
	end
end)

mainsection:NewToggle("Auto-Feed", "Automatically fills bowl when bowl is empty.", function(state)
	globalVariables.Booleans.AutoFeed = state
end)
globalVariables.NormalBowl:FindFirstChild("Part"):GetPropertyChangedSignal("Transparency"):Connect(function()
	if globalVariables.NormalBowl:FindFirstChild("Part").Transparency == 1 and globalVariables.Booleans.AutoFeed then
		if globalVariables.localPlayer:FindFirstChild("leaderstats2"):FindFirstChild("Money").Value < 50 then
			repeat
				task.wait(1)
			until globalVariables.localPlayer:FindFirstChild("leaderstats2"):FindFirstChild("Money").Value >= 50
		end
		globalVariables.Services.ReplicatedStorage:FindFirstChild("Purchase"):FireServer("Floppa Food")
		local oldcframe = globalVariables.localPlayer.Character:FindFirstChild("Humanoid").RootPart.CFrame
		globalVariables.localPlayer.Character:FindFirstChild("Humanoid").RootPart.CFrame = globalVariables.NormalBowl:FindFirstChild("Part").CFrame * CFrame.new(0,5,0)
		task.wait(1)
		fireproximityprompt(globalVariables.NormalBowl:FindFirstChild("Part"):FindFirstChildOfClass("ProximityPrompt"))
		task.wait(1)
		globalVariables.localPlayer.Character:FindFirstChild("Humanoid").RootPart.CFrame = oldcframe
	end
end)

mainsection:NewToggle("Auto-Feed (Baby)", "Automatically fills bowl when bowl is empty.", function(state)
	globalVariables.Booleans.AutoFeedBaby = state
end)
task.spawn(function()
	if not workspace:FindFirstChild("Baby Bowl") then
		repeat
			task.wait(1)
		until workspace:FindFirstChild("Baby Bowl")
	end
	local babybowl = workspace:FindFirstChild("Baby Bowl")
	babybowl:FindFirstChild("Part"):GetPropertyChangedSignal("Transparency"):Connect(function()
		if babybowl:FindFirstChild("Part").Transparency == 1 and globalVariables.Booleans.AutoFeedBaby then
			if globalVariables.localPlayer:FindFirstChild("leaderstats2"):FindFirstChild("Money").Value < 50 then
				repeat
					task.wait(1)
				until globalVariables.localPlayer:FindFirstChild("leaderstats2"):FindFirstChild("Money").Value >= 50
			end
			globalVariables.Services.ReplicatedStorage:FindFirstChild("Purchase"):FireServer("Floppa Food")
			local oldcframe = globalVariables.localPlayer.Character:FindFirstChild("Humanoid").RootPart.CFrame
			globalVariables.localPlayer.Character:FindFirstChild("Humanoid").RootPart.CFrame = babybowl:FindFirstChild("Part").CFrame * CFrame.new(0,5,0)
			task.wait(1)
			fireproximityprompt(babybowl:FindFirstChild("Part"):FindFirstChildOfClass("ProximityPrompt"))
			task.wait(1)
			globalVariables.localPlayer.Character:FindFirstChild("Humanoid").RootPart.CFrame = oldcframe
		end
	end)
end)

mainsection:NewToggle("Auto-Fill Milk Dish", "Automatically fills the milk dish when it's empty.", function(state)
	globalVariables.Booleans.AutoFillMilk = state
end)
task.spawn(function()
	if not workspace:FindFirstChild("Milk Dish") then
		repeat
			task.wait(1)
		until workspace:FindFirstChild("Milk Dish")
	end
	local milkdish = workspace:FindFirstChild("Milk Dish")
	milkdish:FindFirstChild("Part"):GetPropertyChangedSignal("Transparency"):Connect(function()
		if milkdish:FindFirstChild("Part").Transparency == 1 and globalVariables.Booleans.AutoFillMilk then
			if globalVariables.localPlayer:FindFirstChild("leaderstats2"):FindFirstChild("Money").Value < 25 then
				repeat
					task.wait(1)
				until globalVariables.localPlayer:FindFirstChild("leaderstats2"):FindFirstChild("Money").Value >= 25
			end
			globalVariables.Services.ReplicatedStorage:FindFirstChild("Purchase"):FireServer("Milk")
			local oldcframe = globalVariables.localPlayer.Character:FindFirstChild("Humanoid").RootPart.CFrame
			globalVariables.localPlayer.Character:FindFirstChild("Humanoid").RootPart.CFrame = milkdish:FindFirstChild("Part").CFrame * CFrame.new(0,5,0)
			task.wait(1)
			fireproximityprompt(milkdish:FindFirstChild("Part"):FindFirstChildOfClass("ProximityPrompt"))
			task.wait(1)
			globalVariables.localPlayer.Character:FindFirstChild("Humanoid").RootPart.CFrame = oldcframe
		end
	end)
end)

