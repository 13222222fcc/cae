local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 创建主窗口
local Window = Rayfield:CreateWindow({
    Name = "UI 示例窗口",
    LoadingTitle = "加载中...",
    LoadingSubtitle = "UI 元素示例",
    ConfigurationSaving = {
        Enabled = false,
    },
})

-- 创建标签页
local 不知道啊 = Window:CreateTab("标签页1")
local Tab2 = Window:CreateTab("标签页2")
local Tab3 = Window:CreateTab("标签页3")

-- 1. 切换开关(Toggle)示例
local ToggleExample = 不知道啊:CreateToggle({
    Name = "切换开关示例",
    CurrentValue = false,
    Flag = "ToggleExample",
    Callback = function(Value)
        print("切换开关状态:", Value)
    end
})
