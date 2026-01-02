-- Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- 服务
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

-- 基本信息
local PlayerName = LocalPlayer.Name
local ServerId = game.JobId
local Executor = identifyexecutor and identifyexecutor() or "未知注入器"

-- 窗口
local Window = Rayfield:CreateWindow({
    Name = "Wan s",
    LoadingTitle = "Wan s Script",
    LoadingSubtitle = "Rayfield UI",
    ConfigurationSaving = {
        Enabled = false
    }
})

-------------------------------------------------
-- 标签页：信息（带子标签页）
-------------------------------------------------
local InfoTab = Window:CreateTab("信息")

local InfoSub = InfoTab:CreateSection("玩家信息")

InfoTab:CreateLabel({
    Name = "你的名字",
    Content = PlayerName
})

InfoTab:CreateLabel({
    Name = "你的服务器ID",
    Content = ServerId
})

InfoTab:CreateLabel({
    Name = "你的注入器",
    Content = Executor
})

InfoTab:CreateButton({
    Name = "点击我获取🐸群聊号",
    Callback = function()
        setclipboard("89556645745")
        Rayfield:Notify({
            Title = "已复制",
            Content = "群聊号已复制到剪贴板",
            Duration = 3
        })
    end
})

InfoTab:CreateLabel({
    Name = "快手脚本作者",
    Content = "我哪知道"
})

InfoTab:CreateButton({
    Name = "获取脚本作者快手号",
    Callback = function()
        setclipboard("dddj877hd")
        Rayfield:Notify({
            Title = "已复制",
            Content = "快手号已复制",
            Duration = 3
        })
    end
})

-------------------------------------------------
-- 标签页：通用
-------------------------------------------------
local GeneralTab = Window:CreateTab("通用")

-- 飞行
local Flying = false
local FlySpeed = 20
local BodyVelocity, BodyGyro

GeneralTab:CreateToggle({
    Name = "飞行",
    CurrentValue = false,
    Callback = function(Value)
        Flying = Value
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        if Value then
            BodyVelocity = Instance.new("BodyVelocity", hrp)
            BodyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)
            BodyGyro = Instance.new("BodyGyro", hrp)
            BodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
        else
            if BodyVelocity then BodyVelocity:Destroy() end
            if BodyGyro then BodyGyro:Destroy() end
        end
    end
})

GeneralTab:CreateSlider({
    Name = "飞行速度",
    Range = {1,50},
    Increment = 1,
    CurrentValue = 20,
    Callback = function(Value)
        FlySpeed = Value
    end
})

RunService.RenderStepped:Connect(function()
    if Flying and BodyVelocity then
        local cam = workspace.CurrentCamera
        BodyVelocity.Velocity = cam.CFrame.LookVector * FlySpeed
    end
end)

-- 穿墙
GeneralTab:CreateToggle({
    Name = "穿墙",
    CurrentValue = false,
    Callback = function(Value)
        for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = not Value
            end
        end
    end
})

-- 防甩飞
GeneralTab:CreateToggle({
    Name = "防甩飞",
    CurrentValue = false,
    Callback = function(Value)
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Physics)
        end
    end
})

-- 玩家速度
GeneralTab:CreateToggle({
    Name = "玩家速度",
    CurrentValue = false,
    Callback = function(Value)
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = Value and 100 or 16
        end
    end
})

GeneralTab:CreateSlider({
    Name = "玩家速度数值",
    Range = {16,900},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Value end
    end
})

-- 跳跃
GeneralTab:CreateSlider({
    Name = "跳跃高度",
    Range = {1,500},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = Value end
    end
})

-- 重力
GeneralTab:CreateSlider({
    Name = "重力",
    Range = {0,9000000},
    Increment = 100,
    CurrentValue = workspace.Gravity,
    Callback = function(Value)
        workspace.Gravity = Value
    end
})

-- UP
GeneralTab:CreateButton({
    Name = "UP",
    Callback = function()
        local hrp = LocalPlayer.Character.HumanoidRootPart
        hrp.CFrame = hrp.CFrame + Vector3.new(0,3,0)
    end
})

-- 直升机
GeneralTab:CreateButton({
    Name = "直升机",
    Callback = function()
        local hrp = LocalPlayer.Character.HumanoidRootPart
        for i = 1,200 do
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(20), 0)
            hrp.CFrame = hrp.CFrame + Vector3.new(0,0.3,0)
            task.wait()
        end
    end
})

-------------------------------------------------
-- 标签页：射击类
-------------------------------------------------
local ShootTab = Window:CreateTab("射击类")

ShootTab:CreateToggle({ Name="子弹追踪", CurrentValue=false, Callback=function() end })
ShootTab:CreateToggle({ Name="子弹穿墙", CurrentValue=false, Callback=function() end })
ShootTab:CreateToggle({ Name="显示目标", CurrentValue=false, Callback=function() end })
ShootTab:CreateKeybind({
    Name="快捷开关",
    CurrentKeybind="F",
    Callback=function() print("快捷键触发") end
})
ShootTab:CreateToggle({ Name="自瞄", CurrentValue=false, Callback=function() end })
ShootTab:CreateKeybind({
    Name="快速开关",
    CurrentKeybind="Q",
    Callback=function() end
})

-------------------------------------------------
-- 标签页：透视
-------------------------------------------------
local ESPTab = Window:CreateTab("透视")

ESPTab:CreateToggle({ Name="透视开关", CurrentValue=false, Callback=function() end })
ESPTab:CreateToggle({ Name="透视名字", CurrentValue=false, Callback=function() end })
ESPTab:CreateToggle({ Name="透视方框", CurrentValue=false, Callback=function() end })
ESPTab:CreateToggle({ Name="透视骨骼", CurrentValue=false, Callback=function() end })
ESPTab:CreateToggle({ Name="透视NPC", CurrentValue=false, Callback=function() end })

ESPTab:CreateSlider({
    Name="刷新率",
    Range={0,300},
    Increment=1,
    CurrentValue=60,
    Callback=function(Value) end
})

-------------------------------------------------
-- 标签页：被遗弃
-------------------------------------------------
local ForsakenTab = Window:CreateTab("被遗弃")

ForsakenTab:CreateToggle({ Name="无限体力", CurrentValue=false, Callback=function() end })
ForsakenTab:CreateToggle({ Name="透视幸存者 (English)", CurrentValue=false, Callback=function() end })
ForsakenTab:CreateToggle({ Name="透视杀手 (English)", CurrentValue=false, Callback=function() end })

Rayfield:Notify({
    Title = "Wan s",
    Content = "脚本加载完成",
    Duration = 5
})
