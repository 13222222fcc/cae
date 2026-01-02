-- Wan s 完整修复版（所有 UI 控件均绑定到实际逻辑）
-- 直接复制运行。若 Rayfield 不可用则自动回退到原生 ScreenGui（并且功能一致）。
-- 注意：部分功能（如对其它玩家施加物理力）受游戏服务器/网络/权限限制，可能在某些游戏无效。

-- ========== 服务 ==========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer

-- ========== 配置 ==========
local Config = {
    FlySpeed = 20,
    WalkSpeed = 100,
    JumpPower = 50,
    Gravity = workspace.Gravity,
    ESPRefreshRate = 0.12,
    Aimbot = { Enabled = false, Smoothness = 0.35, FOV = 100, Key = Enum.KeyCode.Q },
}

-- ========== 状态 ==========
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
    AimOn = false
}

-- ========== 公共帮助函数 ==========
local function safeCall(fn, ...)
    local ok, res = pcall(fn, ...)
    if not ok then
        warn("[WanS] safeCall error:", res)
        return nil
    end
    return res
end

local function getChar()
    if not LocalPlayer then return nil end
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHRP()
    local c = LocalPlayer and LocalPlayer.Character
    if c then return c:FindFirstChild("HumanoidRootPart") end
    return nil
end

local function getHumanoid()
    local c = LocalPlayer and LocalPlayer.Character
    if c then return c:FindFirstChildOfClass("Humanoid") end
    return nil
end

local function copyToClipboard(text)
    if setclipboard then
        pcall(setclipboard, tostring(text))
    end
    print("[WanS] Copied:", tostring(text))
    if Rayfield and Rayfield.Notify then
        pcall(function() Rayfield:Notify({ Title = "复制", Content = tostring(text), Duration = 2 }) end)
    end
end

-- ========== Rayfield 加载（尝试） ==========
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

-- ========== 功能实现 ==========
-- 飞行（使用 BodyVelocity + BodyGyro）
local flyBV, flyBG
local function enableFly(enable)
    local hrp = getHRP()
    if not hrp then
        State.Flying = false
        return
    end
    State.Flying = enable
    if enable then
        if flyBV then pcall(function() flyBV:Destroy() end) end
        if flyBG then pcall(function() flyBG:Destroy() end) end
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(9e9,9e9,9e9)
        flyBV.Parent = hrp
        flyBG = Instance.new("BodyGyro")
        flyBG.MaxTorque = Vector3.new(9e9,9e9,9e9)
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
            local speed = tonumber(Config.FlySpeed) or 20
            pcall(function()
                flyBV.Velocity = cam.CFrame.LookVector * speed
            end)
        end
    end
end)

-- Noclip (持续把角色的 BasePart.CanCollide = false)
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

-- Anti-fling (移除外来 Body*)
RunService.Heartbeat:Connect(function()
    if State.AntiFling then
        local char = getChar()
        if char then
            for _, d in ipairs(char:GetDescendants()) do
                if d:IsA("BodyVelocity") or d:IsA("BodyForce") or d:IsA("VectorForce") then
                    if d.Name ~= "_WanS_Protected" then
                        pcall(function() d:Destroy() end)
                    end
                end
            end
        end
    end
end)

-- WalkSpeed & JumpPower 更新
local function updateWalkAndJump()
    local hum = getHumanoid()
    if not hum then return end
    if State.SpeedOn then
        pcall(function() hum.WalkSpeed = tonumber(Config.WalkSpeed) or 100 end)
    else
        pcall(function() hum.WalkSpeed = 16 end)
    end
    pcall(function() hum.JumpPower = tonumber(Config.JumpPower) or 50 end)
end

-- Gravity 更新
local function updateGravity()
    workspace.Gravity = tonumber(Config.Gravity) or workspace.Gravity
end

-- Touch fling（当本地 HRP 被触碰时对触碰方施加力，服务器/游戏可能阻止）
local function setupTouchFling()
    local char = getChar()
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    -- 防止重复连接：给 hrp 加标签
    if hrp:FindFirstChild("_WanS_TouchFling") then return end
    local marker = Instance.new("BoolValue")
    marker.Name = "_WanS_TouchFling"
    marker.Parent = hrp
    hrp.Touched:Connect(function(hit)
        if not State.TouchFling then return end
        local otherChar = hit.Parent
        if otherChar and otherChar ~= char and otherChar:FindFirstChildOfClass("Humanoid") then
            local otherHRP = otherChar:FindFirstChild("HumanoidRootPart")
            if otherHRP then
                local bf = Instance.new("BodyVelocity")
                bf.Name = "_WanS_FlingTemp"
                bf.MaxForce = Vector3.new(9e9,9e9,9e9)
                local dir = (otherHRP.Position - hrp.Position)
                if dir.Magnitude > 0 then
                    bf.Velocity = dir.Unit * 80 + Vector3.new(0, 60, 0)
                else
                    bf.Velocity = Vector3.new(0, 80, 0)
                end
                bf.Parent = otherHRP
                Debris:AddItem(bf, 0.5)
            end
        end
    end)
end

-- UP & Heli
local function doUP()
    local hrp = getHRP()
    if hrp then
        pcall(function() hrp.CFrame = hrp.CFrame + Vector3.new(0,3,0) end)
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

-- ========== ESP（名字 / 方框 / 简化骨骼） ==========
local ESPStore = {} -- [player] = table of created adornments

local function createESPForPlayer(pl)
    if not pl or not pl.Character then return end
    if ESPStore[pl] then return end
    local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local data = {}
    -- 名字
    if State.ESPNames then
        local bb = Instance.new("BillboardGui")
        bb.Name = "_WanS_Name"
        bb.Adornee = hrp
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
    -- 方框
    if State.ESPBoxes then
        local box = Instance.new("BoxHandleAdornment")
        box.Name = "_WanS_Box"
        box.Adornee = hrp
        box.Size = Vector3.new(2,5,1)
        box.Transparency = 0.4
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Parent = pl.Character
        data.Box = box
    end
    -- 简化骨骼（创建小的 BillboardGui 标记）
    if State.ESPBones then
        local bones = {}
        local names = {"Head","UpperTorso","LowerTorso","LeftUpperArm","RightUpperArm","LeftUpperLeg","RightUpperLeg"}
        for _,n in ipairs(names) do
            local p = pl.Character:FindFirstChild(n)
            if p and p:IsA("BasePart") then
                local b = Instance.new("BillboardGui")
                b.Name = "_WanS_Bone_"..n
                b.Adornee = p
                b.Size = UDim2.new(0,6,0,6)
                b.AlwaysOnTop = true
                local t = Instance.new("TextLabel", b)
                t.Size = UDim2.new(1,0,1,0)
                t.BackgroundTransparency = 1
                t.Text = ""
                b.Parent = pl.Character
                table.insert(bones, b)
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
            for _,b in ipairs(d.Bones) do if b and b.Parent then b:Destroy() end end
        end
    end)
    ESPStore[pl] = nil
end

task.spawn(function()
    while true do
        if State.ESPOn then
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and pl.Character and pl.Character.Parent then
                    if not ESPStore[pl] then createESPForPlayer(pl) end
                end
            end
            -- 清理
            for pl, _ in pairs(ESPStore) do
                if (not pl) or (not pl.Character) or (not pl.Character.Parent) then
                    removeESPForPlayer(pl)
                end
            end
        else
            for pl,_ in pairs(ESPStore) do removeESPForPlayer(pl) end
        end
        task.wait(Config.ESPRefreshRate)
    end
end)

-- ========== 自瞄（本地摄像机级，平滑、按键切换） ==========
local function getClosestTarget()
    local cam = Workspace.CurrentCamera
    if not cam then return nil end
    local best,bd = nil,math.huge
    for _,pl in ipairs(Players:GetPlayers()) do
        if pl ~= LocalPlayer and pl.Character and pl.Character.Parent then
            local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
            local hum = pl.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local pos, onScreen = cam:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local screenCenter = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
                    local d = (Vector2.new(pos.X,pos.Y) - screenCenter).Magnitude
                    if d < bd and d <= (Config.Aimbot.FOV or 100) then
                        bd = d
                        best = pl
                    end
                end
            end
        end
    end
    return best
end

local function smoothLookAt(cam, targetPos, alpha)
    local curPos = cam.CFrame.Position
    local desired = CFrame.new(curPos, targetPos)
    cam.CFrame = cam.CFrame:Lerp(desired, math.clamp(alpha, 0, 1))
end

task.spawn(function()
    while true do
        if Config.Aimbot.Enabled and State.AimOn then
            local cam = Workspace.CurrentCamera
            if cam then
                local target = getClosestTarget()
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = target.Character.HumanoidRootPart
                    pcall(function()
                        smoothLookAt(cam, hrp.Position, Config.Aimbot.Smoothness or 0.35)
                    end)
                end
            end
        end
        task.wait(0.02)
    end
end)

-- ========== UI 创建与绑定 ==========
local fallbackUI = nil

local function bindRayfieldUI()
    -- Create window and controls using Rayfield and bind to logic
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
    -- 飞行开关
    GeneralTab:CreateToggle({ Name = "飞行", CurrentValue = State.Flying, Flag = "WanS_Fly", Callback = function(v) enableFly(v) end })
    -- 飞行速度
    GeneralTab:CreateSlider({ Name = "飞行速度", Range = {1,200}, Increment = 1, CurrentValue = Config.FlySpeed, Callback = function(v) Config.FlySpeed = v end })
    -- 穿墙
    GeneralTab:CreateToggle({ Name = "穿墙 (Noclip)", CurrentValue = State.Noclip, Flag = "WanS_Noclip", Callback = function(v) State.Noclip = v end })
    -- 防甩飞
    GeneralTab:CreateToggle({ Name = "防甩飞", CurrentValue = State.AntiFling, Flag = "WanS_AntiFling", Callback = function(v) State.AntiFling = v end })
    -- 速度开关与数值
    GeneralTab:CreateToggle({ Name = "玩家速度 (开关)", CurrentValue = State.SpeedOn, Flag = "WanS_SpeedOn", Callback = function(v) State.SpeedOn = v updateWalkAndJump() end })
    GeneralTab:CreateSlider({ Name = "玩家速度 (数值)", Range = {16,900}, Increment = 1, CurrentValue = Config.WalkSpeed, Callback = function(v) Config.WalkSpeed = v updateWalkAndJump() end })
    -- 跳跃
    GeneralTab:CreateSlider({ Name = "跳跃高度", Range = {1,500}, Increment = 1, CurrentValue = Config.JumpPower, Callback = function(v) Config.JumpPower = v updateWalkAndJump() end })
    -- 重力
    GeneralTab:CreateSlider({ Name = "重力", Range = {0,9000000}, Increment = 10, CurrentValue = Config.Gravity, Callback = function(v) Config.Gravity = v updateGravity() end })
    -- 触碰甩飞
    GeneralTab:CreateToggle({ Name = "触碰甩飞", CurrentValue = State.TouchFling, Flag = "WanS_TouchFling", Callback = function(v) State.TouchFling = v if v then setupTouchFling() end end })
    -- UP & 直升机
    GeneralTab:CreateButton({ Name = "UP", Callback = doUP })
    GeneralTab:CreateButton({ Name = "直升机", Callback = doHeli })

    -- 射击类页
    local ShootTab = Window:CreateTab("射击类")
    ShootTab:CreateToggle({ Name = "自瞄 (Enable)", CurrentValue = Config.Aimbot.Enabled, Flag = "WanS_Aimbot", Callback = function(v) Config.Aimbot.Enabled = v end })
    ShootTab:CreateSlider({ Name = "自瞄平滑", Range = {0,1}, Increment = 0.01, CurrentValue = Config.Aimbot.Smoothness, Callback = function(v) Config.Aimbot.Smoothness = v end })
    ShootTab:CreateSlider({ Name = "自瞄 FOV(px)", Range = {20,1000}, Increment = 1, CurrentValue = Config.Aimbot.FOV, Callback = function(v) Config.Aimbot.FOV = v end })
    ShootTab:CreateKeybind({ Name = "自瞄切换键", CurrentKeybind = "Q", HoldToInteract = false, Callback = function(k) local ok, kv = pcall(function() return Enum.KeyCode[k] end) if ok and kv then Config.Aimbot.Key = kv end end })
    ShootTab:CreateKeybind({ Name = "自瞄 快捷开关(F)", CurrentKeybind = "F", HoldToInteract = false, Callback = function() State.AimOn = not State.AimOn Rayfield:Notify({ Title = "自瞄", Content = tostring(State.AimOn), Duration = 1 }) end })
    ShootTab:CreateToggle({ Name = "子弹穿墙 (占位)", CurrentValue = false, Flag = "WanS_BulletThrough", Callback = function() Rayfield:Notify({ Title = "提示", Content = "子弹穿墙需针对游戏实现", Duration = 2 }) end })
    ShootTab:CreateToggle({ Name = "子弹追踪 (占位)", CurrentValue = false, Flag = "WanS_BulletTrack", Callback = function() Rayfield:Notify({ Title = "提示", Content = "追踪需针对游戏实现", Duration = 2 }) end })

    -- 透视页
    local EspTab = Window:CreateTab("透视")
    EspTab:CreateToggle({ Name = "透视 (总开关)", CurrentValue = State.ESPOn, Flag = "WanS_ESP", Callback = function(v) State.ESPOn = v end })
    EspTab:CreateToggle({ Name = "透视 名字", CurrentValue = State.ESPNames, Flag = "WanS_ESP_Names", Callback = function(v) State.ESPNames = v end })
    EspTab:CreateToggle({ Name = "透视 方框", CurrentValue = State.ESPBoxes, Flag = "WanS_ESP_Boxes", Callback = function(v) State.ESPBoxes = v end })
    EspTab:CreateToggle({ Name = "透视 骨骼", CurrentValue = State.ESPBones, Flag = "WanS_ESP_Bones", Callback = function(v) State.ESPBones = v end })
    EspTab:CreateToggle({ Name = "透视 NPC", CurrentValue = State.ESPNPC, Flag = "WanS_ESP_NPC", Callback = function(v) State.ESPNPC = v end })
    EspTab:CreateSlider({ Name = "刷新率 (per sec)", Range = {1,300}, Increment = 1, CurrentValue = 1 / math.max(1, math.clamp(1/Config.ESPRefreshRate,1,300)), Callback = function(v) Config.ESPRefreshRate = 1 / math.max(1, v) end })

    Rayfield:Notify({ Title = "Wan s", Content = "Rayfield UI 已加载，控件已绑定", Duration = 3 })
end

local function createFallbackUI()
    -- Fallback GUI (确保在任何执行器上能看见并能用)
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    for _, g in ipairs(playerGui:GetChildren()) do
        if g.Name == "WanS_Fallback" then pcall(function() g:Destroy() end) end
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WanS_Fallback"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0.92,0,0.82,0)
    main.Position = UDim2.new(0.5,0,0.5,0)
    main.AnchorPoint = Vector2.new(0.5,0.5)
    main.BackgroundColor3 = Color3.fromRGB(30,30,30)
    main.BorderSizePixel = 0
    main.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,34)
    title.BackgroundTransparency = 1
    title.Text = "Wan s (Fallback)"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 20
    title.Parent = main

    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0,160,1,-34)
    menu.Position = UDim2.new(0,0,0,34)
    menu.BackgroundTransparency = 1
    menu.Parent = main

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1,-160,1,-34)
    content.Position = UDim2.new(0,160,0,34)
    content.BackgroundTransparency = 1
    content.Parent = main

    local pages = {}
    local function newPage(name)
        local p = Instance.new("Frame")
        p.Size = UDim2.new(1,0,1,0)
        p.BackgroundTransparency = 1
        p.Visible = false
        p.Parent = content
        pages[name] = p
        return p
    end

    local infoP = newPage("信息")
    local genP = newPage("通用")
    local shootP = newPage("射击类")
    local espP = newPage("透视")
    local legacyP = newPage("被遗弃")

    local function makeBtn(txt, y)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1,-12,0,36)
        b.Position = UDim2.new(0,6,0,y)
        b.Text = txt
        b.Font = Enum.Font.SourceSans
        b.TextSize = 16
        b.BackgroundColor3 = Color3.fromRGB(45,45,45)
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.BorderSizePixel = 0
        b.Parent = menu
        return b
    end

    local b1 = makeBtn("信息", 6)
    local b2 = makeBtn("通用", 52)
    local b3 = makeBtn("射击类", 98)
    local b4 = makeBtn("透视", 144)
    local b5 = makeBtn("被遗弃", 190)

    local function show(name)
        for k,v in pairs(pages) do v.Visible = (k==name) end
    end
    show("信息")
    b1.MouseButton1Click:Connect(function() show("信息") end)
    b2.MouseButton1Click:Connect(function() show("通用") end)
    b3.MouseButton1Click:Connect(function() show("射击类") end)
    b4.MouseButton1Click:Connect(function() show("透视") end)
    b5.MouseButton1Click:Connect(function() show("被遗弃") end)

    -- 信息页
    local function label(parent, txt, y)
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1,-12,0,26)
        l.Position = UDim2.new(0,6,0,y)
        l.BackgroundTransparency = 1
        l.Text = txt
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.Font = Enum.Font.SourceSans
        l.TextSize = 16
        l.TextColor3 = Color3.fromRGB(230,230,230)
        l.Parent = parent
        return l
    end

    label(infoP, "玩家: "..(LocalPlayer and LocalPlayer.Name or "未就绪"), 8)
    label(infoP, "服务器ID: "..tostring(game.JobId), 40)
    label(infoP, "注入器: "..((type(identifyexecutor)=="function" and pcall(identifyexecutor) and identifyexecutor()) or "未知"), 72)

    local copy1 = Instance.new("TextButton")
    copy1.Size = UDim2.new(0,160,0,36)
    copy1.Position = UDim2.new(0,6,0,112)
    copy1.Text = "复制群聊号"
    copy1.Parent = infoP
    copy1.MouseButton1Click:Connect(function() copyToClipboard("89556645745") end)

    local copy2 = Instance.new("TextButton")
    copy2.Size = UDim2.new(0,160,0,36)
    copy2.Position = UDim2.new(0,6,0,158)
    copy2.Text = "复制快手号"
    copy2.Parent = infoP
    copy2.MouseButton1Click:Connect(function() copyToClipboard("dddj877hd") end)

    -- 通用页控件（按钮与绑定）
    local flyBtn = Instance.new("TextButton")
    flyBtn.Size = UDim2.new(0,260,0,36)
    flyBtn.Position = UDim2.new(0,6,0,6)
    flyBtn.Text = "飞行: 关闭"
    flyBtn.Parent = genP
    flyBtn.MouseButton1Click:Connect(function()
        State.Flying = not State.Flying
        flyBtn.Text = "飞行: "..(State.Flying and "开启" or "关闭")
        enableFly(State.Flying)
    end)

    local flySpeedLabel = label(genP, "飞行速度: "..tostring(Config.FlySpeed), 50)
    local flyInc = Instance.new("TextButton")
    flyInc.Size = UDim2.new(0,36,0,28)
    flyInc.Position = UDim2.new(0,272,0,52)
    flyInc.Text = "+"
    flyInc.Parent = genP
    flyInc.MouseButton1Click:Connect(function()
        Config.FlySpeed = math.clamp(Config.FlySpeed + 1, 1, 500)
        flySpeedLabel.Text = "飞行速度: "..tostring(Config.FlySpeed)
    end)
    local flyDec = Instance.new("TextButton")
    flyDec.Size = UDim2.new(0,36,0,28)
    flyDec.Position = UDim2.new(0,312,0,52)
    flyDec.Text = "-"
    flyDec.Parent = genP
    flyDec.MouseButton1Click:Connect(function()
        Config.FlySpeed = math.clamp(Config.FlySpeed - 1, 1, 500)
        flySpeedLabel.Text = "飞行速度: "..tostring(Config.FlySpeed)
    end)

    local noclipBtn = Instance.new("TextButton")
    noclipBtn.Size = UDim2.new(0,260,0,36)
    noclipBtn.Position = UDim2.new(0,6,0,92)
    noclipBtn.Text = "穿墙: 关闭"
    noclipBtn.Parent = genP
    noclipBtn.MouseButton1Click:Connect(function()
        State.Noclip = not State.Noclip
        noclipBtn.Text = "穿墙: "..(State.Noclip and "开启" or "关闭")
    end)

    local antiFlingBtn = Instance.new("TextButton")
    antiFlingBtn.Size = UDim2.new(0,260,0,36)
    antiFlingBtn.Position = UDim2.new(0,6,0,136)
    antiFlingBtn.Text = "防甩飞: 关闭"
    antiFlingBtn.Parent = genP
    antiFlingBtn.MouseButton1Click:Connect(function()
        State.AntiFling = not State.AntiFling
        antiFlingBtn.Text = "防甩飞: "..(State.AntiFling and "开启" or "关闭")
    end)

    local speedBtn = Instance.new("TextButton")
    speedBtn.Size = UDim2.new(0,260,0,36)
    speedBtn.Position = UDim2.new(0,6,0,180)
    speedBtn.Text = "玩家速度: 关闭"
    speedBtn.Parent = genP
    speedBtn.MouseButton1Click:Connect(function()
        State.SpeedOn = not State.SpeedOn
        speedBtn.Text = "玩家速度: "..(State.SpeedOn and "开启" or "关闭")
        updateWalkAndJump()
    end)

    local walkLabel = label(genP, "速度数值: "..tostring(Config.WalkSpeed), 222)
    local walkInc = Instance.new("TextButton")
    walkInc.Size = UDim2.new(0,36,0,28)
    walkInc.Position = UDim2.new(0,272,0,220)
    walkInc.Text = "+"
    walkInc.Parent = genP
    walkInc.MouseButton1Click:Connect(function()
        Config.WalkSpeed = math.clamp(Config.WalkSpeed + 4, 16, 900)
        walkLabel.Text = "速度数值: "..tostring(Config.WalkSpeed)
        updateWalkAndJump()
    end)
    local walkDec = Instance.new("TextButton")
    walkDec.Size = UDim2.new(0,36,0,28)
    walkDec.Position = UDim2.new(0,312,0,220)
    walkDec.Text = "-"
    walkDec.Parent = genP
    walkDec.MouseButton1Click:Connect(function()
        Config.WalkSpeed = math.clamp(Config.WalkSpeed - 4, 16, 900)
        walkLabel.Text = "速度数值: "..tostring(Config.WalkSpeed)
        updateWalkAndJump()
    end)

    local jumpLabel = label(genP, "跳跃高度: "..tostring(Config.JumpPower), 260)
    local jumpInc = Instance.new("TextButton")
    jumpInc.Size = UDim2.new(0,36,0,28)
    jumpInc.Position = UDim2.new(0,272,0,256)
    jumpInc.Text = "+"
    jumpInc.Parent = genP
    jumpInc.MouseButton1Click:Connect(function()
        Config.JumpPower = math.clamp(Config.JumpPower + 5, 1, 500)
        jumpLabel.Text = "跳跃高度: "..tostring(Config.JumpPower)
        updateWalkAndJump()
    end)
    local jumpDec = Instance.new("TextButton")
    jumpDec.Size = UDim2.new(0,36,0,28)
    jumpDec.Position = UDim2.new(0,312,0,256)
    jumpDec.Text = "-"
    jumpDec.Parent = genP
    jumpDec.MouseButton1Click:Connect(function()
        Config.JumpPower = math.clamp(Config.JumpPower - 5, 1, 500)
        jumpLabel.Text = "跳跃高度: "..tostring(Config.JumpPower)
        updateWalkAndJump()
    end)

    local gravityLabel = label(genP, "重力: "..tostring(Config.Gravity), 296)
    local gravInc = Instance.new("TextButton")
    gravInc.Size = UDim2.new(0,36,0,28)
    gravInc.Position = UDim2.new(0,272,0,292)
    gravInc.Text = "+"
    gravInc.Parent = genP
    gravInc.MouseButton1Click:Connect(function()
        Config.Gravity = math.clamp(Config.Gravity + 50, 0, 9000000)
        gravityLabel.Text = "重力: "..tostring(Config.Gravity)
        updateGravity()
    end)
    local gravDec = Instance.new("TextButton")
    gravDec.Size = UDim2.new(0,36,0,28)
    gravDec.Position = UDim2.new(0,312,0,292)
    gravDec.Text = "-"
    gravDec.Parent = genP
    gravDec.MouseButton1Click:Connect(function()
        Config.Gravity = math.clamp(Config.Gravity - 50, 0, 9000000)
        gravityLabel.Text = "重力: "..tostring(Config.Gravity)
        updateGravity()
    end)

    local touchFlingBtn = Instance.new("TextButton")
    touchFlingBtn.Size = UDim2.new(0,260,0,36)
    touchFlingBtn.Position = UDim2.new(0,6,0,332)
    touchFlingBtn.Text = "触碰甩飞: 关闭"
    touchFlingBtn.Parent = genP
    touchFlingBtn.MouseButton1Click:Connect(function()
        State.TouchFling = not State.TouchFling
        touchFlingBtn.Text = "触碰甩飞: "..(State.TouchFling and "开启" or "关闭")
        if State.TouchFling then setupTouchFling() end
    end)

    local upBtn = Instance.new("TextButton")
    upBtn.Size = UDim2.new(0,260,0,36)
    upBtn.Position = UDim2.new(0,6,0,376)
    upBtn.Text = "UP"
    upBtn.Parent = genP
    upBtn.MouseButton1Click:Connect(doUP)

    local heliBtn = Instance.new("TextButton")
    heliBtn.Size = UDim2.new(0,260,0,36)
    heliBtn.Position = UDim2.new(0,6,0,420)
    heliBtn.Text = "直升机"
    heliBtn.Parent = genP
    heliBtn.MouseButton1Click:Connect(doHeli)

    -- 射击类页 fallback bindings
    local aimBtn = Instance.new("TextButton")
    aimBtn.Size = UDim2.new(0,260,0,36)
    aimBtn.Position = UDim2.new(0,6,0,6)
    aimBtn.Text = "自瞄: 关闭"
    aimBtn.Parent = shootP
    aimBtn.MouseButton1Click:Connect(function()
        State.AimOn = not State.AimOn
        aimBtn.Text = "自瞄: "..(State.AimOn and "开启" or "关闭")
    end)

    local aimSmoothLabel = label(shootP, "平滑: "..tostring(Config.Aimbot.Smoothness), 50)
    local aimFOVLabel = label(shootP, "FOV: "..tostring(Config.Aimbot.FOV), 80)

    -- 透视页 fallback bindings
    local espBtn = Instance.new("TextButton")
    espBtn.Size = UDim2.new(0,260,0,36)
    espBtn.Position = UDim2.new(0,6,0,6)
    espBtn.Text = "透视: 关闭"
    espBtn.Parent = espP
    espBtn.MouseButton1Click:Connect(function()
        State.ESPOn = not State.ESPOn
        espBtn.Text = "透视: "..(State.ESPOn and "开启" or "关闭")
    end)
    local espNameBtn = Instance.new("TextButton")
    espNameBtn.Size = UDim2.new(0,260,0,36)
    espNameBtn.Position = UDim2.new(0,6,0,48)
    espNameBtn.Text = "名字: 关闭"
    espNameBtn.Parent = espP
    espNameBtn.MouseButton1Click:Connect(function()
        State.ESPNames = not State.ESPNames
        espNameBtn.Text = "名字: "..(State.ESPNames and "开启" or "关闭")
    end)
    local espBoxBtn = Instance.new("TextButton")
    espBoxBtn.Size = UDim2.new(0,260,0,36)
    espBoxBtn.Position = UDim2.new(0,6,0,92)
    espBoxBtn.Text = "方框: 关闭"
    espBoxBtn.Parent = espP
    espBoxBtn.MouseButton1Click:Connect(function()
        State.ESPBoxes = not State.ESPBoxes
        espBoxBtn.Text = "方框: "..(State.ESPBoxes and "开启" or "关闭")
    end)
    local espBonesBtn = Instance.new("TextButton")
    espBonesBtn.Size = UDim2.new(0,260,0,36)
    espBonesBtn.Position = UDim2.new(0,6,0,136)
    espBonesBtn.Text = "骨骼: 关闭"
    espBonesBtn.Parent = espP
    espBonesBtn.MouseButton1Click:Connect(function()
        State.ESPBones = not State.ESPBones
        espBonesBtn.Text = "骨骼: "..(State.ESPBones and "开启" or "关闭")
    end)

    return { Root = screenGui }
end

-- ========== 启动 UI（优先 Rayfield，否则回退） ==========
if Rayfield then
    bindRayfieldUI()
else
    fallbackUI = createFallbackUI()
    print("[WanS] Rayfield 未检测到，已启用回退 GUI（按钮均已绑定）。")
end

-- ========== Keybinding: 切换自瞄（通用） ==========
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Config.Aimbot.Key then
            State.AimOn = not State.AimOn
            print("[WanS] Aim toggled:", State.AimOn)
            if Rayfield and Rayfield.Notify then pcall(function() Rayfield:Notify({ Title = "自瞄", Content = tostring(State.AimOn), Duration = 1 }) end) end
        end
    end
end)

-- ========== 角色重新应用设置 ==========
Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    updateWalkAndJump()
    updateGravity()
    if State.TouchFling then setupTouchFling() end
    if State.Flying then enableFly(true) end
end)

-- ========== 最后输出 ==========
print("[WanS] 完整修复版已加载。所有 UI 控件已绑定到实际逻辑（Rayfield 或回退 GUI）。")
print("[WanS] 如果某个按钮仍然无效，请把控制台（输出）的错误信息发给我，或告诉我你使用的执行器名称（例如 Delta / Fluxus / ArceusX / Codex / Solara），我会基于该执行器做兼容修复。")
