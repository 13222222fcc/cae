-- FT Ninja Injector Loader
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- ScreenGui
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FT_Loader"
gui.ResetOnSpawn = false

-- 黑色背景
local bg = Instance.new("Frame", gui)
bg.Size = UDim2.fromScale(1,1)
bg.BackgroundColor3 = Color3.new(0,0,0)
bg.BackgroundTransparency = 0.5

-- F 字母
local F = Instance.new("TextLabel", gui)
F.Text = "F"
F.Font = Enum.Font.GothamBlack
F.TextSize = 120
F.TextColor3 = Color3.new(1,1,1)
F.BackgroundTransparency = 1
F.Position = UDim2.fromScale(-0.2,0.4)
F.Size = UDim2.fromScale(0.2,0.2)

-- T 字母
local T = Instance.new("TextLabel", gui)
T.Text = "T"
T.Font = Enum.Font.GothamBlack
T.TextSize = 120
T.TextColor3 = Color3.new(1,1,1)
T.BackgroundTransparency = 1
T.Position = UDim2.fromScale(0.45,-0.3)
T.Size = UDim2.fromScale(0.2,0.2)

-- Tween
TweenService:Create(
	F,
	TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	{Position = UDim2.fromScale(0.35,0.4)}
):Play()

task.wait(0.2)

TweenService:Create(
	T,
	TweenInfo.new(0.4, Enum.EasingStyle.Linear),
	{Position = UDim2.fromScale(0.5,0.4)}
):Play()

task.wait(0.3)

-- 淡出
for _,v in pairs({F,T}) do
	TweenService:Create(
		v,
		TweenInfo.new(0.5),
		{TextTransparency = 1}
	):Play()
end

task.wait(0.6)
F:Destroy()
T:Destroy()

-- 卡密面板
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.fromScale(0.4,0.25)
panel.Position = UDim2.fromScale(0.3,0.35)
panel.BackgroundColor3 = Color3.fromRGB(70,70,70)
panel.BorderSizePixel = 0
panel.BackgroundTransparency = 1

TweenService:Create(panel, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()

local title = Instance.new("TextLabel", panel)
title.Size = UDim2.fromScale(1,0.3)
title.Text = "卡密系统"
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local box = Instance.new("TextBox", panel)
box.Size = UDim2.fromScale(0.8,0.25)
box.Position = UDim2.fromScale(0.1,0.4)
box.PlaceholderText = "请输入卡密"
box.Text = ""
box.Font = Enum.Font.Gotham
box.TextSize = 18
box.BackgroundColor3 = Color3.fromRGB(40,40,40)
box.TextColor3 = Color3.new(1,1,1)
box.BorderSizePixel = 0

local btn = Instance.new("TextButton", panel)
btn.Size = UDim2.fromScale(0.4,0.2)
btn.Position = UDim2.fromScale(0.3,0.7)
btn.Text = "验证"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 18
btn.BackgroundColor3 = Color3.fromRGB(100,100,100)
btn.TextColor3 = Color3.new(1,1,1)
btn.BorderSizePixel = 0

-- 验证逻辑
btn.MouseButton1Click:Connect(function()
	if box.Text == "VOMO_FT_TF_1495_" then
		btn.Text = "卡密验证成功"
		task.wait(0.6)
		gui:Destroy()
	else
		game:GetService("StarterGui"):SetCore("SendNotification",{
			Title = "错误",
			Text = "卡密错误了😂",
			Duration = 1
		})
		task.wait(1)
		player:Kick("傻子，你就不能进群吗")
	end
end)
