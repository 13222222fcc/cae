local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "UI 示例窗口",
    LoadingTitle = "加载中...",
    LoadingSubtitle = "UI 元素示例",
    ConfigurationSaving = {
        Enabled = false,
    },
})

local 测试 = Window:CreateTab("测试")

测试:CreateSection("测试信息")

测试:CreateLabel("欢迎使用Wan!")

测试:CreateLabel("用户名: " .. game.Players.LocalPlayer.Name)

测试:CreateLabel("服务器ID: " .. game.JobId)

测试:CreateButton({
    Name = "测试按钮",
    Callback = function()
        print("按钮被点击!")
    end
})