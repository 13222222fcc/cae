-- 文件名: ExampleUsage.lua
-- 使用示例

-- 加载UI库
local ModernUILibrary = loadstring(game:HttpGet('https://raw.githubusercontent.com/your-repo/ModernUILibrary.lua'))()()

-- 创建UI实例
local library = ModernUILibrary:new("高级脚本菜单")

-- 创建选项卡和功能区段
local mainTab = library:Tab("主界面", "10734958979")
local mainSection = mainTab:section("玩家功能", true)

-- 使用链式调用添加组件
mainSection:Label("玩家控制")
        :Button("飞行模式", function()
            print("飞行模式已开启")
        end)
        :Toggle("无敌模式", "GodMode", false, function(state)
            print("无敌模式:", state)
        end)
        :Slider("移动速度", "Speed", 16, 0, 100, false, function(value)
            print("移动速度:", value)
        end)
        :Dropdown("武器选择", "Weapon", {"剑", "枪", "弓", "法杖"}, "剑", function(option, index)
            print("选择的武器:", option)
        end)
        :Textbox("玩家名称", "PlayerName", "输入玩家名", LocalPlayer.Name, function(text)
            print("玩家名称:", text)
        end)

-- 创建第二个功能区段
local teleportSection = mainTab:section("传送功能", false)

teleportSection:Label("传送地点")
        :Button("传送到出生点", function()
            print("传送到出生点")
        end)
        :Button("传送到商店", function()
            print("传送到商店")
        end)
        :Button("传送到BOSS", function()
            print("传送到BOSS")
        end)

-- 创建第二个选项卡
local settingsTab = library:Tab("设置", "10734959054")
local uiSection = settingsTab:section("UI设置", true)

uiSection:Label("界面设置")
        :Toggle("显示FPS", "ShowFPS", true, function(state)
            print("显示FPS:", state)
        end)
        :Toggle("显示玩家列表", "ShowPlayers", true, function(state)
            print("显示玩家列表:", state)
        end)
        :Slider("UI透明度", "UITransparency", 0, 0, 100, false, function(value)
            print("UI透明度:", value)
        end)
        :Dropdown("主题颜色", "Theme", {"蓝色", "红色", "绿色", "紫色"}, "蓝色", function(option)
            print("主题颜色:", option)
        end)

-- 创建第三个选项卡
local aboutTab = library:Tab("关于", "10734959129")
local infoSection = aboutTab:section("脚本信息", true)

infoSection:Label("脚本版本: v1.0.0")
        :Label("作者: YourName")
        :Label("更新日期: 2024年1月")
        :Button("检查更新", function()
            print("检查更新中...")
        end)
        :Button("捐赠支持", function()
            print("感谢支持!")
        end)
        :Button("打开子窗口", function()
            -- 创建并显示子窗口
            local subWindow = library:CreateSubWindow("设置详情", UDim2.new(0, 350, 0, 250))
            
            subWindow:AddButton("保存设置", function()
                print("设置已保存")
                subWindow:Hide()
            end)
            
            subWindow:AddButton("重置设置", function()
                print("设置已重置")
            end)
            
            subWindow:AddButton("关闭", function()
                subWindow:Hide()
            end)
            
            subWindow:Show()
        end)

-- 添加快捷键切换UI（示例）
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        library:ToggleUI()
    end
end)

print("Modern UI 已加载完成！点击右下角的'开关'按钮或按RightShift键打开/关闭UI")