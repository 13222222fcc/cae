-- WANB Client-Side UI Script
-- All features are CLIENT-SIDE ONLY
-- Rayfield usage example style

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')
local Lighting = game:GetService('Lighting')
local LocalPlayer = Players.LocalPlayer

-- Window
local Window = Rayfield:CreateWindow({
    Name = 'WANB Client UI',
    LoadingTitle = 'Loading',
    LoadingSubtitle = 'Client-Side Features',
    ConfigurationSaving = { Enabled = false },
})

local TabInfo = Window:CreateTab('Information')
local TabGlobal = Window:CreateTab('Global')
local SectionInfo = TabInfo:CreateSection('Player Information')

TabInfo:CreateLabel({ Name = 'Your Name: '..LocalPlayer.Name })
TabInfo:CreateLabel({ Name = 'Your Size 78: 7891' })
TabInfo:CreateLabel({ Name = 'Server JobId: '..game.JobId })

-- States
local flying = false
local noclip = false
local nightVision = false
local espEnabled = false
local flySpeed = 50
local carFly = false
local drift = false

-- Flight
local bv, bg
local function startFly()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    if not hrp then return end
    bv = Instance.new('BodyVelocity')
    bv.MaxForce = Vector3.new(1e9,1e9,1e9)
    bv.Velocity = Vector3.zero
    bv.Parent = hrp
    bg = Instance.new('BodyGyro')
    bg.MaxTorque = Vector3.new(1e9,1e9,1e9)
    bg.CFrame = hrp.CFrame
    bg.Parent = hrp
end
local function stopFly()
    if bv then bv:Destroy() bv=nil end
    if bg then bg:Destroy() bg=nil end
end
RunService.RenderStepped:Connect(function()
    if flying and bv and bg then
        local cam = workspace.CurrentCamera
        local dir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        bv.Velocity = dir * flySpeed
        bg.CFrame = cam.CFrame
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _,v in ipairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA('BasePart') then v.CanCollide = false end
        end
    end
end)

-- Night Vision
local oldBrightness = Lighting.Brightness
local oldAmbient = Lighting.Ambient
local function setNight(on)
    if on then
        oldBrightness = Lighting.Brightness
        oldAmbient = Lighting.Ambient
        Lighting.Brightness = 5
        Lighting.Ambient = Color3.fromRGB(255,255,255)
    else
        Lighting.Brightness = oldBrightness
        Lighting.Ambient = oldAmbient
    end
end

-- ESP Highlight
local espFolder = Instance.new('Folder', workspace)
espFolder.Name = 'WANB_ESP'
local function refreshESP()
    for _,v in ipairs(espFolder:GetChildren()) do v:Destroy() end
    if not espEnabled then return end
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local h = Instance.new('Highlight')
            h.FillColor = Color3.fromRGB(255,0,0)
            h.OutlineColor = Color3.fromRGB(0,0,0)
            h.Parent = espFolder
            h.Adornee = plr.Character
        end
    end
end
Players.PlayerAdded:Connect(refreshESP)
Players.PlayerRemoving:Connect(refreshESP)

local SectionGlobal = TabGlobal:CreateSection('Common')
TabGlobal:CreateToggle({
    Name = 'Flight', CurrentValue = false, Callback = function(v)
        flying = v
        if v then startFly() else stopFly() end
    end
})
TabGlobal:CreateSlider({
    Name = 'Flight Speed', Range = {10,200}, Increment = 5, CurrentValue = 50,
    Callback = function(v) flySpeed = v end
})
TabGlobal:CreateToggle({ Name='Noclip', CurrentValue=false, Callback=function(v) noclip=v end })
TabGlobal:CreateToggle({ Name='Night Vision', CurrentValue=false, Callback=function(v) nightVision=v setNight(v) end })
TabGlobal:CreateToggle({ Name='ESP', CurrentValue=false, Callback=function(v) espEnabled=v refreshESP() end })

-- Utility Block 1
local function util_func_1(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 1
end

-- Utility Block 2
local function util_func_2(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 2
end

-- Utility Block 3
local function util_func_3(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 3
end

-- Utility Block 4
local function util_func_4(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 4
end

-- Utility Block 5
local function util_func_5(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 5
end

-- Utility Block 6
local function util_func_6(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 6
end

-- Utility Block 7
local function util_func_7(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 7
end

-- Utility Block 8
local function util_func_8(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 8
end

-- Utility Block 9
local function util_func_9(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 9
end

-- Utility Block 10
local function util_func_10(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 10
end

-- Utility Block 11
local function util_func_11(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 11
end

-- Utility Block 12
local function util_func_12(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 12
end

-- Utility Block 13
local function util_func_13(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 13
end

-- Utility Block 14
local function util_func_14(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 14
end

-- Utility Block 15
local function util_func_15(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 15
end

-- Utility Block 16
local function util_func_16(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 16
end

-- Utility Block 17
local function util_func_17(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 17
end

-- Utility Block 18
local function util_func_18(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 18
end

-- Utility Block 19
local function util_func_19(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 19
end

-- Utility Block 20
local function util_func_20(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 20
end

-- Utility Block 21
local function util_func_21(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 21
end

-- Utility Block 22
local function util_func_22(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 22
end

-- Utility Block 23
local function util_func_23(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 23
end

-- Utility Block 24
local function util_func_24(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 24
end

-- Utility Block 25
local function util_func_25(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 25
end

-- Utility Block 26
local function util_func_26(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 26
end

-- Utility Block 27
local function util_func_27(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 27
end

-- Utility Block 28
local function util_func_28(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 28
end

-- Utility Block 29
local function util_func_29(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 29
end

-- Utility Block 30
local function util_func_30(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 30
end

-- Utility Block 31
local function util_func_31(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 31
end

-- Utility Block 32
local function util_func_32(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 32
end

-- Utility Block 33
local function util_func_33(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 33
end

-- Utility Block 34
local function util_func_34(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 34
end

-- Utility Block 35
local function util_func_35(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 35
end

-- Utility Block 36
local function util_func_36(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 36
end

-- Utility Block 37
local function util_func_37(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 37
end

-- Utility Block 38
local function util_func_38(a,b,c)
    local x = a or 0
    local y = b or 0
    local z = c or 0
    return x + y + z + 38
end

-- Utility Block 39
local function ut