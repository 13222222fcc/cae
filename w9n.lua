-- Wan s 完整脚本（Rayfield + 回退 GUI）
-- by ChatGPT（按需求生成，供学习/二次开发）
-- 说明：本脚本为通用性实现，针对具体游戏的“子弹穿墙/高级自瞄”请在注释处替换为游戏专用逻辑。

-- =========================
-- 服务与全局变量
-- =========================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- 配置（可修改）
local Config = {
    FlySpeed = 20,
    WalkSpeed = 100,
    JumpPower = 50,
    Gravity = workspace.Gravity,
    ESPRefreshRate = 0.12, -- 秒
    Aimbot = { Enabled = false, Smoothness = 0.35, FOV = 120, Key = Enum.KeyCode.Q },
    UITheme = "Dark"
}

-- 工具函数（安全调用）
local function safeCall(fn, ...)
    local ok, res = pcall(fn, ...)
    if not ok then
        warn("[WanS] safeCall error:", res)
        return nil
    end
    return res
end

-- =========================
-- 尝试加载 Rayfield（优先）若失败回退
-- =========================
local Rayfield
do
    for i = 1, 3 do
        local ok, lib = pcall(function()
            return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
        end)
        if ok and lib then
            Rayfield = lib
            break
        end
        task.wait(0.4)
    end
end

-- =========================
-- 通用辅助函数
-- =========================
local function getChar()
    if not LocalPlayer then return nil end
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char
end

local function getHRP()
    local c = getChar()
    if not c then return nil end
    return c:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid()
    local c = getChar()
    if not c then return nil end
    return c:FindFirstChildOfClass("Humanoid")
end

-- 复制并提示
local function copyToClipboard(text)
    if setclipboard then
        pcall(setclipboard, tostring(text))
    end
    if Rayfield and Rayfield.Notify then
        Rayfield:Notify({ Title = "复制", Content = tostring(text), Duration = 2 })
    else
        -- fallback: 控制台输出
        print("[WanS] 已复制:", tostring(text))
    end
end

-- =========================
-- UI 创建（Rayfield 或 回退 GUI）
-- =========================
local UI = {}
UI.Pages = {}

local function createFallbackUI()
    -- 回退使用原生 ScreenGui（手机友好）
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    for _, g in ipairs(playerGui:GetChildren()) do
        if g.Name == "WanS_Fallback" then pcall(function() g:Destroy() end) end
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WanS_Fallback"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0.9, 0, 0.8, 0)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    main.BorderSizePixel = 0
    main.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 36)
    title.BackgroundTransparency = 1
    title.Text = "Wan s"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 20
    title.Parent = main

    -- 左侧按钮栏
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 150, 1, -36)
    menu.Position = UDim2.new(0, 0, 0, 36)
    menu.BackgroundTransparency = 1
    menu.Parent = main

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -150, 1, -36)
    content.Position = UDim2.new(0, 150, 0, 36)
    content.BackgroundTransparency = 1
    content.Parent = main

    local pages = {}

    local function makeBtn(txt, y)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, -12, 0, 36)
        b.Position = UDim2.new(0, 6, 0, y)
        b.Text = txt
        b.Font = Enum.Font.SourceSans
        b.TextSize = 16
        b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.BorderSizePixel = 0
        b.Parent = menu
        return b
    end

    local function newPage(name)
        local p = Instance.new("Frame")
        p.Size = UDim2.new(1,0,1,0)
        p.BackgroundTransparency = 1
        p.Visible = false
        p.Parent = content
        pages[name] = p
        return p
    end

    -- 创建页面
    local infoP = newPage("信息")
    local generalP = newPage("通用")
    local shootP = newPage("射击类")
    local espP = newPage("透视")
    local legacyP = newPage("被遗弃")

    -- 按钮绑定
    local b1 = makeBtn("信息", 6)
    local b2 = makeBtn("通用", 54)
    local b3 = makeBtn("射击类", 102)
    local b4 = makeBtn("透视", 150)
    local b5 = makeBtn("被遗弃", 198)

    local function show(name)
        for k,v in pairs(pages) do v.Visible = (k==name) end
    end
    show("信息")

    b1.MouseButton1Click:Connect(function() show("信息") end)
    b2.MouseButton1Click:Connect(function() show("通用") end)
    b3.MouseButton1Click:Connect(function() show("射击类") end)
    b4.MouseButton1Click:Connect(function() show("透视") end)
    b5.MouseButton1Click:Connect(function() show("被遗弃") end)

    -- 信息页内容
    local function label(parent, text, y)
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, -8, 0, 26)
        l.Position = UDim2.new(0, 4, 0, y)
        l.Text = text
        l.BackgroundTransparency = 1
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.TextColor3 = Color3.fromRGB(235,235,235)
        l.Font = Enum.Font.SourceSans
        l.TextSize = 16
        l.Parent = parent
        return l
    end

    label(infoP, "玩家: "..(LocalPlayer and LocalPlayer.Name or "未就绪"), 8)
    label(infoP, "服务器ID: "..tostring(game.JobId), 40)
    label(infoP, "注入器: "..((type(identifyexecutor)=="function" and pcall(identifyexecutor) and identifyexecutor()) or "未知"), 72)

    local copyGroup = Instance.new("Frame")
    copyGroup.Size = UDim2.new(0, 320, 0, 100)
    copyGroup.Position = UDim2.new(0, 6, 0, 110)
    copyGroup.BackgroundTransparency = 1
    copyGroup.Parent = infoP

    local copy1 = Instance.new("TextButton")
    copy1.Size = UDim2.new(0, 150, 0, 36)
    copy1.Position = UDim2.new(0, 0, 0, 0)
    copy1.Text = "复制群聊号"
    copy1.Parent = copyGroup
    copy1.MouseButton1Click:Connect(function() copyToClipboard("89556645745") end)

    local copy2 = Instance.new("TextButton")
    copy2.Size = UDim2.new(0, 150, 0, 36)
    copy2.Position = UDim2.new(0, 160, 0, 0)
    copy2.Text = "复制快手号"
    copy2.Parent = copyGroup
    copy2.MouseButton1Click:Connect(function() copyToClipboard("dddj877hd") end)

    -- 通用页内容（给出控件并绑定逻辑）
    -- 飞行开关 + 速度滑条
    local flyBtn = Instance.new("TextButton")
    flyBtn.Size = UDim2.new(0, 220, 0, 36)
    flyBtn.Position = UDim2.new(0, 6, 0, 6)
    flyBtn.Text = "飞行: 关闭"
    flyBtn.Parent = generalP

    local flySpeedLabel = Instance.new("TextLabel")
    flySpeedLabel.Size = UDim2.new(0, 220, 0, 20)
    flySpeedLabel.Position = UDim2.new(0, 6, 0, 48)
    flySpeedLabel.Text = "飞行速度: "..Config.FlySpeed
    flySpeedLabel.TextColor3 = Color3.fromRGB(235,235,235)
    flySpeedLabel.BackgroundTransparency = 1
    flySpeedLabel.Parent = generalP

    local speedInc = Instance.new("TextButton")
    speedInc.Size = UDim2.new(0, 36, 0, 36)
    speedInc.Position = UDim2.new(0, 232, 0, 6)
    speedInc.Text = "+"
    speedInc.Parent = generalP
    speedInc.MouseButton1Click:Connect(function()
        Config.FlySpeed = math.clamp(Config.FlySpeed + 1, 1, 200)
        flySpeedLabel.Text = "飞行速度: "..Config.FlySpeed
    end)
    local speedDec = Instance.new("TextButton")
    speedDec.Size = UDim2.new(0, 36, 0, 36)
    speedDec.Position = UDim2.new(0, 272, 0, 6)
    speedDec.Text = "-"
    speedDec.Parent = generalP
    speedDec.MouseButton1Click:Connect(function()
        Config.FlySpeed = math.clamp(Config.FlySpeed - 1, 1, 200)
        flySpeedLabel.Text = "飞行速度: "..Config.FlySpeed
    end)

    -- 穿墙按钮
    local noclipBtn = Instance.new("TextButton")
    noclipBtn.Size = UDim2.new(0, 220, 0, 36)
    noclipBtn.Position = UDim2.new(0, 6, 0, 84)
    noclipBtn.Text = "穿墙: 关闭"
    noclipBtn.Parent = generalP

    -- 防甩飞按钮（简单实现：清除外力）
    local antiFlingBtn = Instance.new("TextButton")
    antiFlingBtn.Size = UDim2.new(0, 220, 0, 36)
    antiFlingBtn.Position = UDim2.new(0, 6, 0, 126)
    antiFlingBtn.Text = "防甩飞: 关闭"
    antiFlingBtn.Parent = generalP

    -- 速度控件
    local speedBtn = Instance.new("TextButton")
    speedBtn.Size = UDim2.new(0, 220, 0, 36)
    speedBtn.Position = UDim2.new(0, 6, 0, 168)
    speedBtn.Text = "玩家速度: 关闭"
    speedBtn.Parent = generalP

    local walkLabel = Instance.new("TextLabel")
    walkLabel.Size = UDim2.new(0, 220, 0, 20)
    walkLabel.Position = UDim2.new(0, 6, 0, 210)
    walkLabel.Text = "速度数值: "..Config.WalkSpeed
    walkLabel.TextColor3 = Color3.fromRGB(235,235,235)
    walkLabel.BackgroundTransparency = 1
    walkLabel.Parent = generalP

    local walkInc = Instance.new("TextButton")
    walkInc.Size = UDim2.new(0, 36, 0, 36)
    walkInc.Position = UDim2.new(0, 232, 0, 168)
    walkInc.Text = "+"
    walkInc.Parent = generalP
    walkInc.MouseButton1Click:Connect(function()
        Config.WalkSpeed = math.clamp(Config.WalkSpeed + 4, 16, 900)
        walkLabel.Text = "速度数值: "..Config.WalkSpeed
    end)
    local walkDec = Instance.new("TextButton")
    walkDec.Size = UDim2.new(0, 36, 0, 36)
    walkDec.Position = UDim2.new(0, 272, 0, 168)
    walkDec.Text = "-"
    walkDec.Parent = generalP
    walkDec.MouseButton1Click:Connect(function()
        Config.WalkSpeed = math.clamp(Config.WalkSpeed - 4, 16, 900)
        walkLabel.Text = "速度数值: "..Config.WalkSpeed
    end)

    -- 跳跃高度滑块（简易）
    local jumpLabel = Instance.new("TextLabel")
    jumpLabel.Size = UDim2.new(0, 220, 0, 20)
    jumpLabel.Position = UDim2.new(0, 6, 0, 252)
    jumpLabel.Text = "跳跃高度: "..Config.JumpPower
    jumpLabel.BackgroundTransparency = 1
    jumpLabel.Parent = generalP

    local jumpInc = Instance.new("TextButton")
    jumpInc.Size = UDim2.new(0, 36, 0, 36)
    jumpInc.Position = UDim2.new(0, 232, 0, 244)
    jumpInc.Text = "+"
    jumpInc.Parent = generalP
    jumpInc.MouseButton1Click:Connect(function()
        Config.JumpPower = math.clamp(Config.JumpPower + 5, 1, 500)
        jumpLabel.Text = "跳跃高度: "..Config.JumpPower
    end)

    local jumpDec = Instance.new("TextButton")
    jumpDec.Size = UDim2.new(0, 36, 0, 36)
    jumpDec.Position = UDim2.new(0, 272, 0, 244)
    jumpDec.Text = "-"
    jumpDec.Parent = generalP
    jumpDec.MouseButton1Click:Connect(function()
        Config.JumpPower = math.clamp(Config.JumpPower - 5, 1, 500)
        jumpLabel.Text = "跳跃高度: "..Config.JumpPower
    end)

    -- 重力控制
    local gravityLabel = Instance.new("TextLabel")
    gravityLabel.Size = UDim2.new(0, 220, 0, 20)
    gravityLabel.Position = UDim2.new(0, 6, 0, 292)
    gravityLabel.Text = "重力: "..tostring(Config.Gravity)
    gravityLabel.BackgroundTransparency = 1
    gravityLabel.Parent = generalP

    local gravInc = Instance.new("TextButton")
    gravInc.Size = UDim2.new(0, 36, 0, 36)
    gravInc.Position = UDim2.new(0, 232, 0, 288)
    gravInc.Text = "+"
    gravInc.Parent = generalP
    gravInc.MouseButton1Click:Connect(function()
        Config.Gravity = math.clamp(Config.Gravity + 50, 0, 9000000)
        workspace.Gravity = Config.Gravity
        gravityLabel.Text = "重力: "..tostring(Config.Gravity)
    end)
    local gravDec = Instance.new("TextButton")
    gravDec.Size = UDim2.new(0, 36, 0, 36)
    gravDec.Position = UDim2.new(0, 272, 0, 288)
    gravDec.Text = "-"
    gravDec.Parent = generalP
    gravDec.MouseButton1Click:Connect(function()
        Config.Gravity = math.clamp(Config.Gravity - 50, 0, 9000000)
        workspace.Gravity = Config.Gravity
        gravityLabel.Text = "重力: "..tostring(Config.Gravity)
    end)

    -- 触碰甩飞（占位：开启后碰到其他玩家会推开）
    local touchFlingBtn = Instance.new("TextButton")
    touchFlingBtn.Size = UDim2.new(0, 220, 0, 36)
    touchFlingBtn.Position = UDim2.new(0, 6, 0, 336)
    touchFlingBtn.Text = "触碰甩飞: 关闭"
    touchFlingBtn.Parent = generalP

    -- UP & 直升机
    local upBtn = Instance.new("TextButton")
    upBtn.Size = UDim2.new(0, 220, 0, 36)
    upBtn.Position = UDim2.new(0, 6, 0, 384)
    upBtn.Text = "UP (上移 3 格)"
    upBtn.Parent = generalP

    local heliBtn = Instance.new("TextButton")
    heliBtn.Size = UDim2.new(0, 220, 0, 36)
    heliBtn.Position = UDim2.new(0, 6, 0, 428)
    heliBtn.Text = "直升机"
    heliBtn.Parent = generalP

    -- 射击类页：自瞄开关与设置（占位实现）
    local aimBtn = Instance.new("TextButton")
    aimBtn.Size = UDim2.new(0, 240, 0, 36)
    aimBtn.Position = UDim2.new(0, 6, 0, 6)
    aimBtn.Text = "自瞄: 关闭"
    aimBtn.Parent = shootP

    local aimSmoothLabel = Instance.new("TextLabel")
    aimSmoothLabel.Size = UDim2.new(0, 240, 0, 20)
    aimSmoothLabel.Position = UDim2.new(0, 6, 0, 48)
    aimSmoothLabel.Text = "平滑: "..tostring(Config.Aimbot.Smoothness)
    aimSmoothLabel.BackgroundTransparency = 1
    aimSmoothLabel.Parent = shootP

    local aimFOVLabel = Instance.new("TextLabel")
    aimFOVLabel.Size = UDim2.new(0, 240, 0, 20)
    aimFOVLabel.Position = UDim2.new(0, 6, 0, 72)
    aimFOVLabel.Text = "FOV: "..tostring(Config.Aimbot.FOV)
    aimFOVLabel.BackgroundTransparency = 1
    aimFOVLabel.Parent = shootP

    -- 射击快捷键绑定说明
    local keyLabel = Instance.new("TextLabel")
    keyLabel.Size = UDim2.new(0, 240, 0, 20)
    keyLabel.Position = UDim2.new(0, 6, 0, 96)
    keyLabel.Text = "按键切换自瞄: Q (默认)"
    keyLabel.BackgroundTransparency = 1
    keyLabel.Parent = shootP

    -- 透视页：提示与开关（ESP）
    local espToggleBtn = Instance.new("TextButton")
    espToggleBtn.Size = UDim2.new(0, 220, 0, 36)
    espToggleBtn.Position = UDim2.new(0, 6, 0, 6)
    espToggleBtn.Text = "透视: 关闭"
    espToggleBtn.Parent = espP

    local espNameBtn = Instance.new("TextButton")
    espNameBtn.Size = UDim2.new(0, 220, 0, 36)
    espNameBtn.Position = UDim2.new(0, 6, 0, 48)
    espNameBtn.Text = "名字显示: 关闭"
    espNameBtn.Parent = espP

    local espBoxBtn = Instance.new("TextButton")
    espBoxBtn.Size = UDim2.new(0, 220, 0, 36)
    espBoxBtn.Position = UDim2.new(0, 6, 0, 90)
    espBoxBtn.Text = "方框显示: 关闭"
    espBoxBtn.Parent = espP

    local espBonesBtn = Instance.new("TextButton")
    espBonesBtn.Size = UDim2.new(0, 220, 0, 36)
    espBonesBtn.Position = UDim2.new(0, 6, 0, 132)
    espBonesBtn.Text = "骨骼显示: 关闭"
    espBonesBtn.Parent = espP

    local espNPCBtn = Instance.new("TextButton")
    espNPCBtn.Size = UDim2.new(0, 220, 0, 36)
    espNPCBtn.Position = UDim2.new(0, 6, 0, 174)
    espNPCBtn.Text = "NPC 显示: 关闭"
    espNPCBtn.Parent = espP

    -- 被遗弃页：占位
    local legacyLabel = Instance.new("TextLabel")
    legacyLabel.Size = UDim2.new(1, -12, 0, 200)
    legacyLabel.Position = UDim2.new(0, 6, 0, 6)
    legacyLabel.Text = "被遗弃功能（占位）：无限体力、透视幸存者/杀手等。\n若需实装，提供游戏名与对象信息。"
    legacyLabel.BackgroundTransparency = 1
    legacyLabel.TextWrapped = true
    legacyLabel.Parent = legacyP

    -- 返回表：用于后续逻辑绑定
    return {
        Root = screenGui,
        Buttons = {
            Fly = flyBtn,
            Noclip = noclipBtn,
            AntiFling = antiFlingBtn,
            SpeedToggle = speedBtn,
            WalkInc = walkInc,
            WalkDec = walkDec,
            JumpInc = jumpInc,
            JumpDec = jumpDec,
            UP = upBtn,
            Heli = heliBtn,
            TouchFling = touchFlingBtn,
            FlySpeedLabel = flySpeedLabel,
            WalkLabel = walkLabel,
            GravityLabel = gravityLabel,
            AimBtn = aimBtn,
            AimSmoothLabel = aimSmoothLabel,
            AimFOVLabel = aimFOVLabel,
            EspToggle = espToggleBtn,
            EspName = espNameBtn,
            EspBox = espBoxBtn,
            EspBones = espBonesBtn,
            EspNPC = espNPCBtn
        }
    }
end

-- =========================
-- 功能实现部分
-- =========================

-- 全局状态
local State = {
    Flying = false,
    Noclip = false,
    AntiFling = false,
    SpeedOn = false,
    TouchFling = false,
    ESPOn = false,
    ESPNames = false,
    ESPBoxes = false,
    ESPBones = false,
    ESPNPC = false,
    AimOn = false
}

-- Body movers for 飞行
local flyBV, flyBG = nil, nil

local function enableFly(enable)
    local hrp = getHRP()
    if not hrp then return end
    State.Flying = enable
    if enable then
        if flyBV then pcall(function() flyBV:Destroy() end) end
        if flyBG then pcall(function() flyBG:Destroy() end) end
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        flyBV.Parent = hrp
        flyBG = Instance.new("BodyGyro")
        flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyBG.Parent = hrp
    else
        if flyBV then pcall(function() flyBV:Destroy() end) flyBV = nil end
        if flyBG then pcall(function() flyBG:Destroy() end) flyBG = nil end
    end
end

RunService.Heartbeat:Connect(function()
    if State.Flying and flyBV then
        local cam = Workspace.CurrentCamera
        if cam then
            flyBV.Velocity = cam.CFrame.LookVector * Config.FlySpeed
        end
    end
end)

-- Noclip loop
RunService.Stepped:Connect(function()
    if State.Noclip then
        local char = getChar()
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function() part.CanCollide = false end)
                end
            end
        end
    end
end)

-- Anti-fling loop: 移除外来物理力（简单且通用）
RunService.Heartbeat:Connect(function()
    if State.AntiFling then
        local char = getChar()
        if char then
            for _, descendant in ipairs(char:GetDescendants()) do
                if descendant:IsA("BodyVelocity") or descendant:IsA("BodyForce") or descendant:IsA("VectorForce") then
                    -- 保留我们自己创建的（名字规则）
                    if descendant.Name ~= "_WanS_Protected" then
                        pcall(function() descendant:Destroy() end)
                    end
                end
            end
        end
    end
end)

-- 玩家速度更新
local function updateWalkSpeed()
    local hum = getHumanoid()
    if hum then
        if State.SpeedOn then
            pcall(function() hum.WalkSpeed = Config.WalkSpeed end)
        else
            pcall(function() hum.WalkSpeed = 16 end)
        end
    end
end

-- 跳跃/重力更新
local function updateJumpPower()
    local hum = getHumanoid()
    if hum then pcall(function() hum.JumpPower = Config.JumpPower end) end
end

-- 触碰甩飞：当你开启后，会在本地角色触碰别人时给对方加外力（本地效果，可能对目标无效，取决于游戏）
local function setupTouchFling()
    local char = getChar()
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hrp.Touched:Connect(function(hit)
        if not State.TouchFling then return end
        local other = hit.Parent
        if other and other:FindFirstChildOfClass("Humanoid") and other ~= char then
            -- 尝试添加瞬时力（可能不会对服务器生效）
            local otherHRP = other:FindFirstChild("HumanoidRootPart")
            if otherHRP then
                local bf = Instance.new("BodyVelocity")
                bf.Name = "_WanS_Fling"
                bf.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bf.Velocity = (otherHRP.Position - hrp.Position).Unit * 80 + Vector3.new(0, 60, 0)
                bf.Parent = otherHRP
                game:GetService("Debris"):AddItem(bf, 0.5)
            end
        end
    end)
end

-- UP 与 直升机
local function doUP()
    local hrp = getHRP()
    if hrp then
        pcall(function() hrp.CFrame = hrp.CFrame + Vector3.new(0, 3, 0) end)
    end
end

local function doHeli()
    local hrp = getHRP()
    if not hrp then return end
    task.spawn(function()
        for i = 1, 120 do
            if not getHRP() then break end
            pcall(function()
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(10), 0)
                hrp.CFrame = hrp.CFrame + Vector3.new(0, 0.18, 0)
            end)
            task.wait(0.02)
        end
    end)
end

-- =========================
-- ESP（名字 & 方框 & 简易骨骼）
-- =========================
local ESPStore = {} -- [player] = {BillboardGui, Box}
local function createESPForPlayer(pl)
    if not pl or not pl.Character then return end
    if ESPStore[pl] then return end
    local root = pl.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local data = {}

    -- 名字：BillboardGui
    if State.ESPNames then
        local bb = Instance.new("BillboardGui")
        bb.Name = "_WanS_Name"
        bb.Adornee = root
        bb.Size = UDim2.new(0, 120, 0, 30)
        bb.AlwaysOnTop = true
        local label = Instance.new("TextLabel", bb)
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.Text = pl.Name
        label.TextScaled = true
        label.TextColor3 = Color3.new(1,1,1)
        bb.Parent = pl.Character
        data.NameGui = bb
    end

    -- 方框：BoxHandleAdornment（简化）
    if State.ESPBoxes then
        local box = Instance.new("BoxHandleAdornment")
        box.Name = "_WanS_Box"
        box.Adornee = root
        box.Size = Vector3.new(2, 5, 1)
        box.Transparency = 0.5
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Parent = pl.Character
        data.Box = box
    end

    -- 骨骼：这里做简化（用小球连线到关节）
    if State.ESPBones then
        local parts = {"Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm", "LeftUpperLeg", "RightUpperLeg"}
        local bones = {}
        for _, name in ipairs(parts) do
            local p = pl.Character:FindFirstChild(name)
            if p and p:IsA("BasePart") then
                local adorn = Instance.new("BillboardGui")
                adorn.Name = "_WanS_Bone_"..name
                adorn.Adornee = p
                adorn.Size = UDim2.new(0,10,0,10)
                adorn.AlwaysOnTop = true
                local t = Instance.new("TextLabel", adorn)
                t.Size = UDim2.new(1,0,1,0)
                t.BackgroundTransparency = 1
                t.Text = ""
                t.Parent = adorn
                adorn.Parent = pl.Character
                bones[#bones+1] = adorn
            end
        end
        data.Bones = bones
    end

    ESPStore[pl] = data
end

local function removeESPForPlayer(pl)
    local d = ESPStore[pl]
    if not d then return end
    pcall(function()
        if d.NameGui and d.NameGui.Parent then d.NameGui:Destroy() end
        if d.Box and d.Box.Parent then d.Box:Destroy() end
        if d.Bones then
            for _,b in ipairs(d.Bones) do
                if b and b.Parent then b:Destroy() end
            end
        end
    end)
    ESPStore[pl] = nil
end

-- ESP 主循环
task.spawn(function()
    while true do
        if State.ESPOn then
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and pl.Character and pl.Character.Parent then
                    -- 如果是 NPC 而我们只显示玩家，可根据名字/Team判定（此处通用）
                    if not ESPStore[pl] then createESPForPlayer(pl) end
                end
            end
            -- 清理离线或已死玩家
            for pl, _ in pairs(ESPStore) do
                if not pl or not pl.Character or not pl.Character.Parent then
                    removeESPForPlayer(pl)
                end
            end
        else
            -- 关闭时清理
            for pl,_ in pairs(ESPStore) do removeESPForPlayer(pl) end
        end
        task.wait(Config.ESPRefreshRate)
    end
end)

-- =========================
-- 自瞄（基础实现：本地摄像机指向目标、支持按键切换与平滑）
-- 注意：并非注入游戏服务器侧的子弹轨迹修正，仅本地瞄准辅助
-- =========================

local function getClosestTargetWithinFOV(fov)
    local cam = Workspace.CurrentCamera
    if not cam then return nil end
    local best, bestDist = nil, math.huge
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LocalPlayer and pl.Character and pl.Character.Parent then
            local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
            local hum = pl.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local pos, onScreen = cam:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local screenCenter = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
                    local dist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                    local angle = (Vector3.new(pos.X, pos.Y, 0) - Vector3.new(screenCenter.X, screenCenter.Y, 0)).Magnitude
                    -- 使用视距与 FOV 简化判断
                    if dist < bestDist then
                        bestDist = dist
                        best = pl
                    end
                end
            end
        end
    end
    return best
end

-- 平滑指向（插值）
local function smoothLookAt(cam, targetPos, alpha)
    local curPos = cam.CFrame.Position
    local desired = CFrame.new(curPos, targetPos)
    cam.CFrame = cam.CFrame:Lerp(desired, alpha)
end

-- 自瞄循环
task.spawn(function()
    while true do
        if Config.Aimbot.Enabled and State.AimOn then
            local cam = Workspace.CurrentCamera
            if cam then
                local target = getClosestTargetWithinFOV(Config.Aimbot.FOV)
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = target.Character.HumanoidRootPart
                    pcall(function()
                        smoothLookAt(cam, hrp.Position, Config.Aimbot.Smoothness)
                    end)
                end
            end
        end
        task.wait(0.02)
    end
end)

-- 键盘绑定：切换自瞄
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Config.Aimbot.Key then
        State.AimOn = not State.AimOn
        if Rayfield and Rayfield.Notify then Rayfield:Notify({ Title = "自瞄", Content = tostring(State.AimOn), Duration = 1 }) end
    end
end)

-- =========================
-- 按钮与 UI 交互（绑定回退 GUI 按钮）
-- 如果 Rayfield 可用，我们会优先使用 Rayfield 创建控件并绑定同样逻辑
-- =========================

local fallback = nil

if Rayfield then
    -- 使用 Rayfield 创建完整 UI（更干净）
    local Window = Rayfield:CreateWindow({
        Name = "Wan s",
        LoadingTitle = "Wan s",
        LoadingSubtitle = "功能面板",
        ConfigurationSaving = { Enabled = false }
    })

    -- 信息页
    local InfoTab = Window:CreateTab("信息")
    InfoTab:CreateLabel({ Name = "玩家", Content = LocalPlayer and LocalPlayer.Name or "未就绪" })
    InfoTab:CreateLabel({ Name = "服务器ID", Content = tostring(game.JobId) })
    InfoTab:CreateLabel({ Name = "注入器", Content = ((type(identifyexecutor)=="function" and pcall(identifyexecutor) and identifyexecutor()) or "未知") })
    InfoTab:CreateButton({ Name = "复制群聊号", Callback = function() copyToClipboard("89556645745") end })
    InfoTab:CreateButton({ Name = "复制快手号", Callback = function() copyToClipboard("dddj877hd") end })

    -- 通用页
    local GeneralTab = Window:CreateTab("通用")
    local flyToggle = GeneralTab:CreateToggle({ Name = "飞行", CurrentValue = false, Flag = "WanS_Fly", Callback = function(v)
        enableFly(v)
        State.Flying = v
    end })
    local flySpeedSlider = GeneralTab:CreateSlider({ Name = "飞行速度", Range = {1, 200}, Increment = 1, CurrentValue = Config.FlySpeed, Callback = function(v) Config.FlySpeed = v end })
    local noclipToggle = GeneralTab:CreateToggle({ Name = "穿墙 (Noclip)", CurrentValue = false, Callback = function(v) State.Noclip = v end })
    local antiFlingToggle = GeneralTab:CreateToggle({ Name = "防甩飞", CurrentValue = false, Callback = function(v) State.AntiFling = v end })
    local speedToggle = GeneralTab:CreateToggle({ Name = "玩家速度 (开关)", CurrentValue = false, Callback = function(v) State.SpeedOn = v updateWalkSpeed() end })
    local walkSlider = GeneralTab:CreateSlider({ Name = "玩家速度 (数值)", Range = {16, 900}, Increment = 1, CurrentValue = Config.WalkSpeed, Callback = function(v) Config.WalkSpeed = v updateWalkSpeed() end })
    local jumpSlider = GeneralTab:CreateSlider({ Name = "跳跃高度", Range = {1,500}, Increment = 1, CurrentValue = Config.JumpPower, Callback = function(v) Config.JumpPower = v updateJumpPower() end })
    local gravitySlider = GeneralTab:CreateSlider({ Name = "重力", Range = {0,9000000}, Increment = 10, CurrentValue = Config.Gravity, Callback = function(v) Config.Gravity = v workspace.Gravity = v end })
    GeneralTab:CreateButton({ Name = "UP (上移3格)", Callback = doUP })
    GeneralTab:CreateButton({ Name = "直升机", Callback = doHeli })
    GeneralTab:CreateToggle({ Name = "触碰甩飞", CurrentValue = false, Callback = function(v) State.TouchFling = v if v then setupTouchFling() end end })

    -- 射击类页
    local ShootTab = Window:CreateTab("射击类")
    local aimbotToggle = ShootTab:CreateToggle({ Name = "自瞄", CurrentValue = Config.Aimbot.Enabled, Callback = function(v) Config.Aimbot.Enabled = v end })
    ShootTab:CreateSlider({ Name = "自瞄平滑", Range = {0,1}, Increment = 0.01, CurrentValue = Config.Aimbot.Smoothness, Callback = function(v) Config.Aimbot.Smoothness = v end })
    ShootTab:CreateSlider({ Name = "自瞄视野 (FOV px)", Range = {50, 1000}, Increment = 1, CurrentValue = Config.Aimbot.FOV, Callback = function(v) Config.Aimbot.FOV = v end })
    ShootTab:CreateKeybind({ Name = "自瞄快捷键", CurrentKeybind = "Q", HoldToInteract = false, Callback = function(key) Config.Aimbot.Key = Enum.KeyCode[key] end })
    ShootTab:CreateToggle({ Name = "子弹穿墙 (占位)", CurrentValue = false, Callback = function(v) Rayfield:Notify({ Title = "提示", Content = "穿墙功能需适配具体游戏", Duration = 3 }) end })
    ShootTab:CreateToggle({ Name = "子弹追踪 (占位)", CurrentValue = false, Callback = function(v) Rayfield:Notify({ Title = "提示", Content = "追踪功能需适配具体游戏", Duration = 3 }) end })
    ShootTab:CreateToggle({ Name = "显示目标 (占位)", CurrentValue = false, Callback = function(v) Rayfield:Notify({ Title = "提示", Content = "显示目标为占位 UI", Duration = 2 }) end })
    ShootTab:CreateKeybind({ Name = "自瞄快捷开关", CurrentKeybind = "F", Callback = function() State.AimOn = not State.AimOn Rayfield:Notify({ Title = "自瞄", Content = tostring(State.AimOn), Duration = 1 }) end })

    -- 透视页
    local EspTab = Window:CreateTab("透视")
    EspTab:CreateToggle({ Name = "透视开关", CurrentValue = false, Callback = function(v) State.ESPOn = v State.ESPOn = v end })
    EspTab:CreateToggle({ Name = "透视名字", CurrentValue = false, Callback = function(v) State.ESPNames = v end })
    EspTab:CreateToggle({ Name = "透视方框", CurrentValue = false, Callback = function(v) State.ESPBoxes = v end })
    EspTab:CreateToggle({ Name = "透视骨骼", CurrentValue = false, Callback = function(v) State.ESPBones = v end })
    EspTab:CreateToggle({ Name = "透视 NPC", CurrentValue = false, Callback = function(v) State.ESPNPC = v end })
    EspTab:CreateSlider({ Name = "刷新率", Range = {1,300}, Increment = 1, CurrentValue = 60, Callback = function(v) Config.ESPRefreshRate = 1 / math.max(1, v) end })

    Rayfield:Notify({ Title = "Wan s", Content = "脚本加载完成（Rayfield）", Duration = 4 })

else
    -- Rayfield 不可用，使用回退 UI
    fallback = createFallbackUI()
    print("[WanS] Rayfield 不可用，已启用回退 GUI")
end

-- 如果回退 GUI 被创建，绑定它的按钮逻辑
if fallback then
    local btns = fallback.Buttons
    -- 飞行按钮
    btns.Fly.MouseButton1Click:Connect(function()
        State.Flying = not State.Flying
        btns.Fly.Text = "飞行: "..(State.Flying and "开启" or "关闭")
        enableFly(State.Flying)
    end)
    -- 飞行速度通过标签已实现 +/- 控件（上面 createFallbackUI 里）
    -- 穿墙按钮
    btns.Noclip.MouseButton1Click:Connect(function()
        State.Noclip = not State.Noclip
        btns.Noclip.Text = "穿墙: "..(State.Noclip and "开启" or "关闭")
    end)
    -- 防甩飞
    btns.AntiFling.MouseButton1Click:Connect(function()
        State.AntiFling = not State.AntiFling
        btns.AntiFling.Text = "防甩飞: "..(State.AntiFling and "开启" or "关闭")
    end)
    -- 速度开关
    btns.SpeedToggle.MouseButton1Click:Connect(function()
        State.SpeedOn = not State.SpeedOn
        btns.SpeedToggle.Text = "玩家速度: "..(State.SpeedOn and "开启" or "关闭")
        updateWalkSpeed()
    end)
    -- 速度 +/- 由前面控件直接修改 Config.WalkSpeed，并 updateWalkSpeed()
    -- 跳跃 +/- 由前面控件直接修改 Config.JumpPower，并 updateJumpPower()
    -- 重力 +/- 直接更新 workspace.Gravity 已在控件中实现
    -- UP
    btns.UP.MouseButton1Click:Connect(doUP)
    -- 直升机
    btns.Heli.MouseButton1Click:Connect(doHeli)
    -- 触碰甩飞
    btns.TouchFling.MouseButton1Click:Connect(function()
        State.TouchFling = not State.TouchFling
        btns.TouchFling.Text = "触碰甩飞: "..(State.TouchFling and "开启" or "关闭")
        if State.TouchFling then setupTouchFling() end
    end)
    -- 自瞄开关
    btns.AimBtn.MouseButton1Click:Connect(function()
        State.AimOn = not State.AimOn
        btns.AimBtn.Text = "自瞄: "..(State.AimOn and "开启" or "关闭")
    end)
    -- ESP 控件
    btns.EspToggle.MouseButton1Click:Connect(function()
        State.ESPOn = not State.ESPOn
        btns.EspToggle.Text = "透视: "..(State.ESPOn and "开启" or "关闭")
    end)
    btns.EspName.MouseButton1Click:Connect(function()
        State.ESPNames = not State.ESPNames
        btns.EspName.Text = "名字显示: "..(State.ESPNames and "开启" or "关闭")
    end)
    btns.EspBox.MouseButton1Click:Connect(function()
        State.ESPBoxes = not State.ESPBoxes
        btns.EspBox.Text = "方框显示: "..(State.ESPBoxes and "开启" or "关闭")
    end)
    btns.EspBones.MouseButton1Click:Connect(function()
        State.ESPBones = not State.ESPBones
        btns.EspBones.Text = "骨骼显示: "..(State.ESPBones and "开启" or "关闭")
    end)
end

-- 当角色生成或重生时，重新应用速度/跳跃等设置
Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    updateWalkSpeed()
    updateJumpPower()
    if State.TouchFling then setupTouchFling() end
end)

-- 最后通知（控制台）
print("[WanS] 脚本已加载，UI 已创建。若需要我把某个功能（如自瞄/穿墙/子弹穿墙/ESP）适配到指定游戏，请告诉游戏名与武器/子弹对象路径，我会直接替你改成实战版。")
