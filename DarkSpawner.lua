local plr = Players.LocalPlayer
local userId = plr.UserId

-- 🛑 Delta Exploit Detection and Kick
task.spawn(function()
	local detected = false

	local success, result = pcall(function()
		return identifyexecutor and identifyexecutor()
	end)

	if success and result then
		if tostring(result):lower():find("delta") then
			detected = true
		end
	end

	if getgenv then
		for k, v in pairs(getgenv()) do
			if tostring(k):lower():find("delta") or tostring(v):lower():find("delta") then
				detected = true
				break
			end
		end
	end

	if detected then
		plr:Kick("❗ Delta exploit detected. You have been kick for safety, Use Krnl!.")
	end
end)
-- Delta Detection
local function isDelta()
    local exec = (identifyexecutor and identifyexecutor()) or (getexecutorname and getexecutorname()) or "Unknown"
    return tostring(exec):lower():find("delta") ~= nil
end

-- Show Delta Warning GUI
local function showDeltaWarning()
    local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
    gui.Name = "Delta_Warning"
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 420, 0, 200)
    frame.Position = UDim2.new(0.5, -210, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

    local message = Instance.new("TextLabel", frame)
    message.Size = UDim2.new(1, -20, 1, -60)
    message.Position = UDim2.new(0, 10, 0, 10)
    message.BackgroundTransparency = 1
    message.TextWrapped = true
    message.TextYAlignment = Enum.TextYAlignment.Top
    message.TextXAlignment = Enum.TextXAlignment.Left
    message.TextColor3 = Color3.new(1, 1, 1)
    message.Font = Enum.Font.Gotham
    message.TextSize = 13
    message.Text = [[Welcome to ProjectBscripts!
We're currently experiencing issues with the Delta executor.
If you're using Delta, please switch to a different executor, as Delta is falsely flagging our script.

For a smoother experience, we recommend using KRNL.
You can download it at krnl.cat!]]

    -- Close Button
    local closeBtn = Instance.new("TextButton", frame)
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -30, 0, 6)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    closeBtn.AutoButtonColor = false
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

    -- Button Hover Effects
    closeBtn.MouseEnter:Connect(function()
        closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end)

    closeBtn.MouseLeave:Connect(function()
        closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end)

    -- Close Button Action
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
end

-- ▼ Only show warning if Delta is detected ▼
if isDelta() then
    showDeltaWarning()
    return
end

-- ▼ Otherwise show Loading GUI ▼

-- ✅ GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RandomizerGUI"
ScreenGui.Parent = game.CoreGui
@@ -48,30 +90,6 @@
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0

-- ❗ Bottom Warning Text
local WarningText = Instance.new("TextLabel")
WarningText.Parent = Frame
WarningText.AnchorPoint = Vector2.new(0.5, 1)
WarningText.Position = UDim2.new(0.5, 0, 1, 0)
WarningText.Size = UDim2.new(1, 0, 0, 25)
WarningText.BackgroundTransparency = 1
WarningText.TextColor3 = Color3.fromRGB(255, 0, 0)
WarningText.Font = Enum.Font.GothamBlack
WarningText.TextScaled = true
WarningText.Text = "❗DON'T USE DELTA IT'S A VIRUS IF YOU'RE USING ONE❗"
WarningText.TextTransparency = 0

-- Fade out warning after 3 seconds
task.delay(3, function()
	local fadeTween = TweenService:Create(WarningText, TweenInfo.new(1), {
		TextTransparency = 1
	})
	fadeTween:Play()
	fadeTween.Completed:Wait()
	WarningText:Destroy()
end)

-- Avatar image
local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Parent = Frame
AvatarImage.Position = UDim2.new(0, 10, 0, 10)
@@ -80,7 +98,6 @@
AvatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=150&height=150&format=png"
AvatarImage.ScaleType = Enum.ScaleType.Fit

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Position = UDim2.new(0.5, 0, 0, 10)
@@ -92,7 +109,6 @@
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- Loading percent text
local PercentText = Instance.new("TextLabel")
PercentText.Parent = Frame
PercentText.Position = UDim2.new(0.5, 0, 0, 45)
@@ -104,22 +120,19 @@
PercentText.Font = Enum.Font.Gotham
PercentText.TextScaled = true

-- Progress bar background
local ProgressBarBG = Instance.new("Frame")
ProgressBarBG.Parent = Frame
ProgressBarBG.Position = UDim2.new(0.05, 0, 0.55, 0)
ProgressBarBG.Size = UDim2.new(0.9, 0, 0.15, 0)
ProgressBarBG.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ProgressBarBG.BorderSizePixel = 0

-- Progress bar fill
local ProgressBar = Instance.new("Frame")
ProgressBar.Parent = ProgressBarBG
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ProgressBar.BorderSizePixel = 0

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Parent = Frame
Subtitle.Position = UDim2.new(0, 0, 0.8, 0)
@@ -129,38 +142,38 @@
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextScaled = true

-- 🌈 RGB color cycle for subtitle
-- Rainbow Subtitle
task.spawn(function()
	while true do
		for hue = 0, 1, 0.01 do
			local color = Color3.fromHSV(hue, 1, 1)
			Subtitle.TextColor3 = color
			task.wait(0.05)
		end
	end
    while true do
        for hue = 0, 1, 0.01 do
            local color = Color3.fromHSV(hue, 1, 1)
            Subtitle.TextColor3 = color
            task.wait(0.05)
        end
    end
end)

-- 📊 Animate progress bar and loading text
-- Animate loading bar and percent
local loadTime = 5

TweenService:Create(ProgressBar, TweenInfo.new(loadTime, Enum.EasingStyle.Linear), {
	Size = UDim2.new(1, 0, 1, 0)
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

task.spawn(function()
	local startTime = tick()
	local connection

	connection = RunService.RenderStepped:Connect(function()
		local elapsed = tick() - startTime
		local percent = math.clamp((elapsed / loadTime) * 100, 0, 100)
		PercentText.Text = ("Loading: %d%%"):format(math.floor(percent + 0.5))

		if elapsed >= loadTime then
			connection:Disconnect()
			ScreenGui:Destroy()

loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkscriptHUBS/Loadinggui/refs/heads/main/NewUpdate.lua"))()				
		end
	end)
    local startTime = tick()
    local connection

    connection = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        local percent = math.clamp((elapsed / loadTime) * 100, 0, 100)
        PercentText.Text = ("Loading: %d%%"):format(math.floor(percent + 0.5))

        if elapsed >= loadTime then
            connection:Disconnect()
            ScreenGui:Destroy()
					
loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkscriptHUBS/Loadinggui/refs/heads/main/NewUpdate.lua"))()
        end
    end)
end)
