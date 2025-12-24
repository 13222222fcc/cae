-- 文件名: ExampleWanUI.lua
-- 使用示例 - 所有变量名都使用Wan

-- 加载UI库
local Wan = loadstring(game:HttpGet("https://raw.githubusercontent.com/13222222fcc/cae/refs/heads/main/UI.lua"))()

-- 创建第一个选项卡 - 返回页面
local Wan = Wan:Tab("返回页面", "10734958979")

Wan:section("风御 X制作", true)
    :Label("返回页面", "TA")
    :Button("返回页面", "TA", function()
        print("点击了返回页面")
    end)
    :Button("修改权限", function()
        print("点击了修改权限")
    end)

-- 创建本地玩家选项卡
local Wan = Wan:Tab("本地玩家", "10734959000")

Wan:section("本地玩家", true)
    :Label("速度 (开/关)", "TA")
    :Toggle("速度设置", "SpeedToggle", false, function(state)
        print("速度设置:", state)
    end, "TA")
    :Slider("速度设置", "SpeedValue", 16, 0, 100, false, function(value)
        print("速度值:", value)
    end)
    :Label("快速跑步", "TA")
    :Button("加", function()
        print("点击了加")
    end)
    :Label("推荐键2", "TA")
    :Textbox("输入", "InputKey", "输入按键", "F", function(text)
        print("输入按键:", text)
    end)
    :Label("点击即可漂移加速关闭", "TA")

-- 创建通用选项卡
local Wan = Wan:Tab("通用", "10734959001")

Wan:section("通用", true)
    :Label("通用功能", "TA")
    :Button("刷新玩家名称", function()
        Wan:RefreshPlayers()
        print("刷新了玩家列表")
    end)
    :Button("隐藏", function()
        print("点击了隐藏")
    end)

-- 创建玩家透视选项卡
local Wan = Wan:Tab("玩家透视", "10734959002")

Wan:section("玩家透视", true)
    :Label("玩家透视设置", "TA")
    :Toggle("启用透视", "ESPToggle", false, function(state)
        print("玩家透视:", state)
    end, "TA")
    :Dropdown("透视类型", "ESPType", {"方框", "射线", "名称", "全部"}, "方框", function(option)
        print("透视类型:", option)
    end)
    :Slider("透视距离", "ESPDistance", 500, 100, 2000, false, function(value)
        print("透视距离:", value)
    end)

-- 创建自瞄选项卡
local Wan = Wan:Tab("自瞄", "10734959003")

Wan:section("自瞄设置", true)
    :Label("自瞄功能", "TA")
    :Toggle("启用自瞄", "AimToggle", false, function(state)
        print("自瞄:", state)
    end, "TA")
    :Toggle("自动开火", "AutoFire", false, function(state)
        print("自动开火:", state)
    end)
    :Slider("自瞄强度", "AimStrength", 0.5, 0.1, 1.0, true, function(value)
        print("自瞄强度:", value)
    end)
    :Dropdown("自瞄部位", "AimPart", {"头部", "胸部", "随机"}, "头部", function(option)
        print("自瞄部位:", option)
    end)

-- 创建传送与甩飞选项卡
local Wan = Wan:Tab("传送与甩飞", "10734959004")

Wan:section("传送与甩飞", true)
    :Label("传送功能", "TA")
    :Dropdown("选择玩家的名称", "TeleportPlayer", Wan.WanPlayers, "所有玩家", function(option)
        print("选择玩家:", option)
    end, "TA")
    :Button("传送到玩家旁边", function()
        print("传送到玩家旁边")
    end)
    :Button("把玩家传送过来", function()
        print("把玩家传送过来")
    end)
    :Label("甩飞功能", "TA")
    :Toggle("锁定传送", "LockTeleport", false, function(state)
        print("锁定传送:", state)
    end)

-- 创建碰撞箱选项卡
local Wan = Wan:Tab("碰撞箱", "10734959005")

Wan:section("碰撞箱设置", true)
    :Label("碰撞箱调整", "TA")
    :Toggle("启用碰撞箱", "HitboxToggle", false, function(state)
        print("碰撞箱:", state)
    end, "TA")
    :Slider("碰撞箱大小", "HitboxSize", 5, 1, 20, false, function(value)
        print("碰撞箱大小:", value)
    end)
    :Dropdown("碰撞箱类型", "HitboxType", {"头部", "身体", "全身", "自定义"}, "全身", function(option)
        print("碰撞箱类型:", option)
    end)

-- 创建甩飞功能选项卡
local Wan = Wan:Tab("甩飞功能", "10734959006")

Wan:section("甩飞功能", true)
    :Label("甩飞设置", "TA")
    :Toggle("启用甩飞", "ThrowToggle", false, function(state)
        print("甩飞功能:", state)
    end, "TA")
    :Slider("甩飞力度", "ThrowPower", 100, 50, 500, false, function(value)
        print("甩飞力度:", value)
    end)
    :Dropdown("甩飞方向", "ThrowDirection", {"向上", "向前", "随机", "自定义"}, "向上", function(option)
        print("甩飞方向:", option)
    end)
    :Button("快速甩飞", function()
        print("执行快速甩飞")
    end)

-- 创建其他脚本选项卡
local Wan = Wan:Tab("其他脚本中", "10734959007")

Wan:section("其他脚本", true)
    :Label("脚本集合", "TA")
    :Button("南瓜 🍺", function()
        print("加载南瓜脚本")
    end)
    :Button("小款 🍺", function()
        print("加载小款脚本")
    end)
    :Label("🔥 人物特征：", "TA")
    :Toggle("无敌模式", "GodMode", false, function(state)
        print("无敌模式:", state)
    end, "TA")
    :Toggle("穿墙模式", "Noclip", false, function(state)
        print("穿墙模式:", state)
    end)

-- 创建情绪/免费摄像头选项卡
local Wan = Wan:Tab("情绪/摄像头", "10734959008")

Wan:section("摄像头设置", true)
    :Label("免费摄像头", "TA")
    :Toggle("启用摄像头", "CameraToggle", false, function(state)
        print("摄像头:", state)
    end, "TA")
    :Slider("视角距离", "CameraDistance", 50, 10, 200, false, function(value)
        print("视角距离:", value)
    end)
    :Dropdown("摄像头模式", "CameraMode", {"第一人称", "第三人称", "自由视角", "上帝视角"}, "第三人称", function(option)
        print("摄像头模式:", option)
    end)
    :WanK("131231007815032", function()
        print("点击了自定义图片按钮")
    end)

-- 创建子窗口示例选项卡
local Wan = Wan:Tab("子窗口示例", "10734959009")

Wan:section("子窗口功能", true)
    :Label("子窗口演示", "TA")
    :Button("打开设置子窗口", function()
        local Wan = Wan:CreateSubWindow("设置详情", UDim2.new(0, 350, 0, 250))
        
        Wan:AddButton("保存设置", function()
            print("设置已保存")
            Wan:Hide()
        end)
        
        Wan:AddButton("重置设置", function()
            print("设置已重置")
        end)
        
        Wan:AddButton("关闭", function()
            Wan:Hide()
        end)
        
        Wan:Show()
    end, "TA")
    :Button("打开玩家列表子窗口", function()
        local Wan = Wan:CreateSubWindow("玩家列表", UDim2.new(0, 400, 0, 300))
        
        for _, Wan in pairs(Wan.WanPlayers) do
            Wan:AddButton(Wan, function()
                print("选择了玩家:", Wan)
            end)
        end
        
        Wan:Show()
    end)

-- 添加快捷键切换UI
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        Wan:ToggleUI()
    end
end)

-- 显示加载完成信息
task.wait(3)
print("=================================")
print("风御 UI 已加载完成！")
print("开关按钮位置：屏幕右下角圆形按钮")
print("快捷键：Insert 键切换显示/隐藏")
print("当前玩家列表:", #Wan.WanPlayers, "个玩家")
print("=================================")
