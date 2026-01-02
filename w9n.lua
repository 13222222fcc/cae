local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 创建主窗口
local Window = Rayfield:CreateWindow({
    Name = "Wan s",
    LoadingTitle = "加载中...",
    LoadingSubtitle = "Wan s 脚本",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Wan_s_Config",
        FileName = "Settings"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false,
})

-- 创建标签页
local InfoTab = Window:CreateTab("信息")
local GeneralTab = Window:CreateTab("通用")
local ShootingTab = Window:CreateTab("射击类")
local ESPTab = Window:CreateTab("透视")
local AbandonedTab = Window:CreateTab("被遗弃")

-- ========== 信息标签页 ==========
local PlayerInfoSection = InfoTab:CreateSection("玩家信息")

local player = game:GetService("Players").LocalPlayer

local NameLabel = InfoTab:CreateLabel({
    Name = "你的名字: " .. player.Name,
})

local ServerIdLabel = InfoTab:CreateLabel({
    Name = "你的服务器id: " .. game.JobId,
})

-- 注入器检测函数
local function getExecutor()
    local executors = {
        ["Synapse X"] = "syn.x",
        ["ScriptWare"] = "sw.x",
        ["Krnl"] = "krnl.ca",
        ["Fluxus"] = "fluxus.exe",
        ["Comet"] = "comet.rb",
        ["Electron"] = "electron.rb"
    }
    
    for executor, check in pairs(executors) do
        if check then
            return executor
        end
    end
    return "未知注入器"
end

local ExecutorLabel = InfoTab:CreateLabel({
    Name = "你的注入器: " .. getExecutor(),
})

local CopyGroupButton = InfoTab:CreateButton({
    Name = "点击我获取🐸群聊号",
    Callback = function()
        setclipboard("89556645745")
        Rayfield:Notify({
            Title = "复制成功",
            Content = "已复制群聊号到剪贴板",
            Duration = 3,
        })
    end,
})

local AuthorInfoSection = InfoTab:CreateSection("作者信息")

local AuthorLabel = InfoTab:CreateLabel({
    Name = "快手脚本作者: 我哪知道",
})

local CopyKuaishouButton = InfoTab:CreateButton({
    Name = "获取脚本作者快手号",
    Callback = function()
        setclipboard("dddj877hd")
        Rayfield:Notify({
            Title = "复制成功",
            Content = "已复制快手号到剪贴板",
            Duration = 3,
        })
    end,
})

-- ========== 通用标签页 ==========
local FlightSection = GeneralTab:CreateSection("飞行设置")

local FlightToggle = GeneralTab:CreateToggle({
    Name = "飞行(开关)",
    CurrentValue = false,
    Flag = "FlightToggle",
    Callback = function(Value)
        print("飞行状态:", Value)
        -- 这里添加飞行功能代码
    end
})

local FlightSpeedSlider = GeneralTab:CreateSlider({
    Name = "飞行速度(1-50)",
    Range = {1, 50},
    Increment = 1,
    Suffix = "速度",
    CurrentValue = 16,
    Flag = "FlightSpeed",
    Callback = function(Value)
        print("飞行速度设置为:", Value)
    end,
})

local NoclipSection = GeneralTab:CreateSection("穿墙设置")

local NoclipToggle = GeneralTab:CreateToggle({
    Name = "穿墙(开关)",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(Value)
        print("穿墙状态:", Value)
        -- 这里添加穿墙功能代码
    end
})

local AntiSlingshotToggle = GeneralTab:CreateToggle({
    Name = "防甩飞(开关)",
    CurrentValue = false,
    Flag = "AntiSlingshotToggle",
    Callback = function(Value)
        print("防甩飞状态:", Value)
        -- 这里添加防甩飞功能代码
    end
})

local MovementSection = GeneralTab:CreateSection("移动设置")

local WalkSpeedToggle = GeneralTab:CreateToggle({
    Name = "玩家速度(开关)",
    CurrentValue = false,
    Flag = "WalkSpeedToggle",
    Callback = function(Value)
        print("玩家速度开关:", Value)
        -- 这里添加速度控制代码
    end
})

local WalkSpeedSlider = GeneralTab:CreateSlider({
    Name = "玩家速度(16-900)",
    Range = {16, 900},
    Increment = 1,
    Suffix = "速度",
    CurrentValue = 16,
    Flag = "WalkSpeedValue",
    Callback = function(Value)
        print("玩家速度设置为:", Value)
    end,
})

local JumpPowerSlider = GeneralTab:CreateSlider({
    Name = "跳跃高度(1-500)",
    Range = {1, 500},
    Increment = 1,
    Suffix = "高度",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        print("跳跃高度设置为:", Value)
    end,
})

local GravitySlider = GeneralTab:CreateSlider({
    Name = "重力(0-9000000)",
    Range = {0, 9000000},
    Increment = 100,
    Suffix = "重力",
    CurrentValue = 196.2,
    Flag = "Gravity",
    Callback = function(Value)
        print("重力设置为:", Value)
        workspace.Gravity = Value
    end,
})

local SlingshotSection = GeneralTab:CreateSection("甩飞设置")

local TouchSlingshotToggle = GeneralTab:CreateToggle({
    Name = "触碰甩飞(开关)",
    CurrentValue = false,
    Flag = "TouchSlingshotToggle",
    Callback = function(Value)
        print("触碰甩飞状态:", Value)
        -- 这里添加触碰甩飞功能代码
    end
})

local UpButton = GeneralTab:CreateButton({
    Name = "UP",
    Callback = function()
        local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and root then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            wait(0.1)
            root.CFrame = root.CFrame * CFrame.new(0, 3, 0)
            Rayfield:Notify({
                Title = "UP",
                Content = "已向上移动3格",
                Duration = 2,
            })
        end
    end,
})

local HelicopterButton = GeneralTab:CreateButton({
    Name = "直升机",
    Callback = function()
        Rayfield:Notify({
            Title = "直升机",
            Content = "直升机功能已激活",
            Duration = 3,
        })
        -- 这里添加直升机功能代码
    end,
})

-- ========== 射击类标签页 ==========
local ShootingSection = ShootingTab:CreateSection("子弹设置")

local BulletTrackToggle = ShootingTab:CreateToggle({
    Name = "子弹追踪",
    CurrentValue = false,
    Flag = "BulletTrackToggle",
    Callback = function(Value)
        print("子弹追踪:", Value)
    end
})

local BulletNoclipToggle = ShootingTab:CreateToggle({
    Name = "子弹穿墙",
    CurrentValue = false,
    Flag = "BulletNoclipToggle",
    Callback = function(Value)
        print("子弹穿墙:", Value)
    end
})

local ShowTargetToggle = ShootingTab:CreateToggle({
    Name = "显示目标",
    CurrentValue = false,
    Flag = "ShowTargetToggle",
    Callback = function(Value)
        print("显示目标:", Value)
    end
})

local QuickToggle = ShootingTab:CreateToggle({
    Name = "快捷开关",
    CurrentValue = false,
    Flag = "QuickToggle",
    Callback = function(Value)
        print("快捷开关:", Value)
    end
})

local AimBotSection = ShootingTab:CreateSection("自瞄设置")

local AimBotToggle = ShootingTab:CreateToggle({
    Name = "自瞄",
    CurrentValue = false,
    Flag = "AimBotToggle",
    Callback = function(Value)
        print("自瞄:", Value)
    end
})

local FastToggle = ShootingTab:CreateToggle({
    Name = "快速开关",
    CurrentValue = false,
    Flag = "FastToggle",
    Callback = function(Value)
        print("快速开关:", Value)
    end
})

-- ========== 透视标签页 ==========
local ESPMainSection = ESPTab:CreateSection("ESP主开关")

local ESPToggle = ESPTab:CreateToggle({
    Name = "透视开关",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(Value)
        print("透视开关:", Value)
    end
})

local ESPOptionsSection = ESPTab:CreateSection("ESP选项")

local ESPNameToggle = ESPTab:CreateToggle({
    Name = "透视名字",
    CurrentValue = true,
    Flag = "ESPNameToggle",
    Callback = function(Value)
        print("透视名字:", Value)
    end
})

local ESPBoxToggle = ESPTab:CreateToggle({
    Name = "透视方框",
    CurrentValue = true,
    Flag = "ESPBoxToggle",
    Callback = function(Value)
        print("透视方框:", Value)
    end
})

local ESPBonesToggle = ESPTab:CreateToggle({
    Name = "透视骨骼",
    CurrentValue = false,
    Flag = "ESPBonesToggle",
    Callback = function(Value)
        print("透视骨骼:", Value)
    end
})

local ESPNPCToggle = ESPTab:CreateToggle({
    Name = "透视NPC",
    CurrentValue = false,
    Flag = "ESPNPCToggle",
    Callback = function(Value)
        print("透视NPC:", Value)
    end
})

local ESPSettingsSection = ESPTab:CreateSection("ESP设置")

local ESPRefreshSlider = ESPTab:CreateSlider({
    Name = "刷新率(0-300)",
    Range = {0, 300},
    Increment = 1,
    Suffix = "FPS",
    CurrentValue = 60,
    Flag = "ESPRefresh",
    Callback = function(Value)
        print("ESP刷新率设置为:", Value)
    end,
})

-- ========== 被遗弃标签页 ==========
local AbandonedSection = AbandonedTab:CreateSection("被遗弃功能")

local InfiniteStaminaToggle = AbandonedTab:CreateToggle({
    Name = "无限体力",
    CurrentValue = false,
    Flag = "InfiniteStaminaToggle",
    Callback = function(Value)
        print("无限体力:", Value)
    end
})

local ESPTargetsSection = AbandonedTab:CreateSection("目标透视")

local ESPAssassinsToggle = AbandonedTab:CreateToggle({
    Name = "透视幸存者(透视名叫幸存者(English)的东西)",
    CurrentValue = false,
    Flag = "ESPSurvivorsToggle",
    Callback = function(Value)
        print("透视幸存者:", Value)
    end
})

local ESPKillersToggle = AbandonedTab:CreateToggle({
    Name = "透视杀手(透视名叫杀手(English)的东西)",
    CurrentValue = false,
    Flag = "ESPAssassinsToggle",
    Callback = function(Value)
        print("透视杀手:", Value)
    end
})

-- 加载保存的设置
Rayfield:LoadConfiguration()
