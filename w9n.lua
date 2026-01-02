-- Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId
local JobId = game.JobId

-- 主窗口
local Window = Rayfield:CreateWindow({
    Name = "Wan s",
    LoadingTitle = "Wan s",
    LoadingSubtitle = "by Rayfield UI",
    ConfigurationSaving = {
        Enabled = false
    }
})

----------------------------------------------------------------
-- 标签页：信息
----------------------------------------------------------------
local InfoTab = Window:CreateTab("信息", 4483362458)

InfoTab:CreateLabel("你的名字: "..LocalPlayer.Name)
InfoTab:CreateLabel("你的服务器ID: "..JobId)
InfoTab:CreateLabel("你的注入器: 未知")

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

InfoTab:CreateLabel("快手脚本作者: 我哪知道")

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

----------------------------------------------------------------
-- 标签页：通用
----------------------------------------------------------------
local GeneralTab = Window:CreateTab("通用", 4483362458)

GeneralTab:CreateToggle({
    Name = "飞行",
    CurrentValue = false,
    Callback = function(v)
        print("飞行:", v)
    end
})

GeneralTab:CreateSlider({
    Name = "飞行速度",
    Range = {1, 50},
    CurrentValue = 10,
    Callback = function(v)
        print("飞行速度:", v)
    end
})

GeneralTab:CreateToggle({
    Name = "穿墙",
    CurrentValue = false,
    Callback = function(v)
        print("穿墙:", v)
    end
})

GeneralTab:CreateToggle({
    Name = "防甩飞",
    CurrentValue = false,
    Callback = function(v)
        print("防甩飞:", v)
    end
})

GeneralTab:CreateToggle({
    Name = "玩家速度开关",
    CurrentValue = false,
    Callback = function(v)
        print("速度开关:", v)
    end
})

GeneralTab:CreateSlider({
    Name = "玩家速度",
    Range = {16, 900},
    CurrentValue = 16,
    Callback = function(v)
        print("速度值:", v)
    end
})

GeneralTab:CreateSlider({
    Name = "跳跃高度",
    Range = {1, 500},
    CurrentValue = 50,
    Callback = function(v)
        print("跳跃高度:", v)
    end
})

GeneralTab:CreateSlider({
    Name = "重力",
    Range = {0, 9000000},
    CurrentValue = workspace.Gravity,
    Callback = function(v)
        workspace.Gravity = v
    end
})

GeneralTab:CreateToggle({
    Name = "触碰甩飞",
    CurrentValue = false,
    Callback = function(v)
        print("触碰甩飞:", v)
    end
})

GeneralTab:CreateButton({
    Name = "UP",
    Callback = function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
        end
    end
})

GeneralTab:CreateButton({
    Name = "直升机",
    Callback = function()
        print("直升机模式")
    end
})

----------------------------------------------------------------
-- 标签页：射击类
----------------------------------------------------------------
local ShootTab = Window:CreateTab("射击类", 4483362458)

ShootTab:CreateToggle({ Name = "子弹追踪", CurrentValue = false, Callback = function(v) print(v) end })
ShootTab:CreateToggle({ Name = "子弹穿墙", CurrentValue = false, Callback = function(v) print(v) end })
ShootTab:CreateToggle({ Name = "显示目标", CurrentValue = false, Callback = function(v) print(v) end })
ShootTab:CreateKeybind({
    Name = "快捷开关",
    CurrentKeybind = "F",
    Callback = function()
        print("快捷键触发")
    end
})
ShootTab:CreateToggle({ Name = "自瞄", CurrentValue = false, Callback = function(v) print(v) end })
ShootTab:CreateKeybind({
    Name = "快速开关",
    CurrentKeybind = "G",
    Callback = function()
        print("快速开关")
    end
})

----------------------------------------------------------------
-- 标签页：透视
----------------------------------------------------------------
local EspTab = Window:CreateTab("透视", 4483362458)

EspTab:CreateToggle({ Name = "透视开关", CurrentValue = false, Callback = function(v) print(v) end })
EspTab:CreateToggle({ Name = "透视名字", CurrentValue = false, Callback = function(v) print(v) end })
EspTab:CreateToggle({ Name = "透视方框", CurrentValue = false, Callback = function(v) print(v) end })
EspTab:CreateToggle({ Name = "透视骨骼", CurrentValue = false, Callback = function(v) print(v) end })
EspTab:CreateToggle({ Name = "透视NPC", CurrentValue = false, Callback = function(v) print(v) end })

EspTab:CreateSlider({
    Name = "刷新率",
    Range = {0, 300},
    CurrentValue = 60,
    Callback = function(v)
        print("刷新率:", v)
    end
})

----------------------------------------------------------------
-- 标签页：被遗弃
----------------------------------------------------------------
local LegacyTab = Window:CreateTab("被遗弃", 4483362458)

LegacyTab:CreateToggle({ Name = "无限体力", CurrentValue = false, Callback = function(v) print(v) end })
LegacyTab:CreateToggle({ Name = "透视幸存者", CurrentValue = false, Callback = function(v) print(v) end })
LegacyTab:CreateToggle({ Name = "透视杀手", CurrentValue = false, Callback = function(v) print(v) end })

Rayfield:Notify({
    Title = "加载完成",
    Content = "Wan s UI 已成功加载",
    Duration = 5
})
