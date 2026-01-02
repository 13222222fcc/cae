--==================================================
-- Wan s | Rayfield 完整脚本
--==================================================

--========== 服务 ==========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

--========== 加载 Rayfield ==========
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--========== 基本信息 ==========
local PlayerName = LocalPlayer.Name
local ServerId = game.JobId
local Executor = identifyexecutor and identifyexecutor() or "未知注入器"

--========== 窗口 ==========
local Window = Rayfield:CreateWindow({
    Name = "Wan s",
    LoadingTitle = "Wan s Script",
    LoadingSubtitle = "加载中...",
    ConfigurationSaving = { Enabled = false }
})

--==================================================
-- 信息
--==================================================
local InfoTab = Window:CreateTab("信息")

InfoTab:CreateLabel({ Name="你的名字", Content=PlayerName })
InfoTab:CreateLabel({ Name="服务器ID", Content=ServerId })
InfoTab:CreateLabel({ Name="你的注入器", Content=Executor })

InfoTab:CreateButton({
    Name="点击我获取🐸群聊号",
    Callback=function()
        if setclipboard then setclipboard("89556645745") end
        Rayfield:Notify({Title="已复制",Content="89556645745",Duration=2})
    end
})

InfoTab:CreateLabel({ Name="快手脚本作者", Content="我哪知道" })

InfoTab:CreateButton({
    Name="获取脚本作者快手号",
    Callback=function()
        if setclipboard then setclipboard("dddj877hd") end
        Rayfield:Notify({Title="已复制",Content="dddj877hd",Duration=2})
    end
})

--==================================================
-- 通用
--==================================================
local GeneralTab = Window:CreateTab("通用")

local function getChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- 飞行
local Fly = false
local FlySpeed = 20
local BV, BG

GeneralTab:CreateToggle({
    Name="飞行",
    CurrentValue=false,
    Callback=function(v)
        Fly = v
        local hrp = getChar():WaitForChild("HumanoidRootPart")
        if v then
            BV = Instance.new("BodyVelocity", hrp)
            BV.MaxForce = Vector3.new(9e9,9e9,9e9)
            BG = Instance.new("BodyGyro", hrp)
            BG.MaxTorque = Vector3.new(9e9,9e9,9e9)
        else
            if BV then BV:Destroy() end
            if BG then BG:Destroy() end
        end
    end
})

GeneralTab:CreateSlider({
    Name="飞行速度",
    Range={1,50},
    Increment=1,
    CurrentValue=20,
    Callback=function(v) FlySpeed=v end
})

RunService.RenderStepped:Connect(function()
    if Fly and BV then
        BV.Velocity = Workspace.CurrentCamera.CFrame.LookVector * FlySpeed
    end
end)

-- 穿墙
local Noclip=false
GeneralTab:CreateToggle({
    Name="穿墙",
    Callback=function(v) Noclip=v end
})

RunService.Stepped:Connect(function()
    if Noclip then
        for _,p in pairs(getChar():GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide=false end
        end
    end
end)

-- 防甩飞
GeneralTab:CreateToggle({
    Name="防甩飞",
    Callback=function(v)
        local hrp=getChar():FindFirstChild("HumanoidRootPart")
        if v and hrp then hrp.AssemblyLinearVelocity=Vector3.zero end
    end
})

-- 速度
GeneralTab:CreateToggle({
    Name="玩家速度",
    Callback=function(v)
        getChar():FindFirstChildOfClass("Humanoid").WalkSpeed = v and 100 or 16
    end
})

GeneralTab:CreateSlider({
    Name="玩家速度数值",
    Range={16,900},
    Increment=1,
    CurrentValue=16,
    Callback=function(v)
        getChar():FindFirstChildOfClass("Humanoid").WalkSpeed=v
    end
})

-- 跳跃
GeneralTab:CreateSlider({
    Name="跳跃高度",
    Range={1,500},
    Increment=1,
    CurrentValue=50,
    Callback=function(v)
        getChar():FindFirstChildOfClass("Humanoid").JumpPower=v
    end
})

-- 重力
GeneralTab:CreateSlider({
    Name="重力",
    Range={0,9000000},
    Increment=50,
    CurrentValue=Workspace.Gravity,
    Callback=function(v) Workspace.Gravity=v end
})

-- UP
GeneralTab:CreateButton({
    Name="UP",
    Callback=function()
        getChar().HumanoidRootPart.CFrame += Vector3.new(0,3,0)
    end
})

-- 直升机
GeneralTab:CreateButton({
    Name="直升机",
    Callback=function()
        local hrp=getChar().HumanoidRootPart
        for i=1,120 do
            hrp.CFrame=hrp.CFrame*CFrame.Angles(0,math.rad(15),0)
            hrp.CFrame+=Vector3.new(0,0.2,0)
            task.wait()
        end
    end
})

--==================================================
-- 射击类（通用占位）
--==================================================
local ShootTab = Window:CreateTab("射击类")

local Aimbot=false
ShootTab:CreateToggle({Name="自瞄",Callback=function(v)Aimbot=v end})
ShootTab:CreateToggle({Name="子弹穿墙",Callback=function()end})
ShootTab:CreateToggle({Name="子弹追踪",Callback=function()end})
ShootTab:CreateToggle({Name="显示目标",Callback=function()end})

ShootTab:CreateKeybind({
    Name="快捷开关",
    CurrentKeybind="F",
    Callback=function()
        Aimbot=not Aimbot
        Rayfield:Notify({Title="自瞄",Content=tostring(Aimbot),Duration=1})
    end
})

RunService.RenderStepped:Connect(function()
    if Aimbot then
        local cam=Workspace.CurrentCamera
        local closest,dist=nil,math.huge
        for _,p in pairs(Players:GetPlayers()) do
            if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pos,_=cam:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                local d=(Vector2.new(pos.X,pos.Y)-cam.ViewportSize/2).Magnitude
                if d<dist then dist=d closest=p end
            end
        end
        if closest then
            cam.CFrame=CFrame.new(cam.CFrame.Position,closest.Character.HumanoidRootPart.Position)
        end
    end
end)

--==================================================
-- 透视（基础）
--==================================================
local ESPTab = Window:CreateTab("透视")
local ESP=false

ESPTab:CreateToggle({Name="透视开关",Callback=function(v)ESP=v end})
ESPTab:CreateToggle({Name="透视名字",Callback=function()end})
ESPTab:CreateToggle({Name="透视方框",Callback=function()end})
ESPTab:CreateToggle({Name="透视骨骼",Callback=function()end})
ESPTab:CreateToggle({Name="透视NPC",Callback=function()end})

ESPTab:CreateSlider({
    Name="刷新率",
    Range={0,300},
    Increment=1,
    CurrentValue=60,
    Callback=function()end
})

--==================================================
-- 被遗弃
--==================================================
local OldTab = Window:CreateTab("被遗弃")
OldTab:CreateToggle({Name="无限体力",Callback=function()end})
OldTab:CreateToggle({Name="透视幸存者 (English)",Callback=function()end})
OldTab:CreateToggle({Name="透视杀手 (English)",Callback=function()end})

--==================================================
Rayfield:Notify({
    Title="Wan s",
    Content="脚本加载完成",
    Duration=4
})
