-- WanUI 库
-- 文件名: WanUILibrary.lua

-- 等待游戏加载
repeat task.wait() until game:IsLoaded()

-- 引入服务
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- 主库对象
local WanUILibrary = {}
WanUILibrary.__index = WanUILibrary

-- 颜色配置
WanUILibrary.Colors = {
    Primary = Color3.fromRGB(0, 170, 255),
    Secondary = Color3.fromRGB(0, 140, 220),
    Success = Color3.fromRGB(46, 204, 113),
    Danger = Color3.fromRGB(231, 76, 60),
    Warning = Color3.fromRGB(241, 196, 15),
    Dark = Color3.fromRGB(15, 15, 20),
    Light = Color3.fromRGB(240, 240, 245),
    Background = Color3.fromRGB(25, 25, 30),
    Card = Color3.fromRGB(35, 35, 45),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 190)
}

-- 创建新的UI实例
function WanUILibrary.new(name)
    local self = setmetatable({}, WanUILibrary)
    
    -- 配置
    self.name = name or "风御 X制作"
    self.size = UDim2.new(0, 700, 0, 550)
    self.startPosition = UDim2.new(0, 20, 0.85, -30)
    self.theme = "dark"
    
    -- 状态
    self.isOpen = false
    self.isAnimating = false
    self.isLoaded = false
    self.WanTabs = {}
    self.activeWanTab = nil
    self.components = {}
    self.connections = {}
    self.WanFlags = {}
    self.WanPlayers = {}
    
    -- 创建加载界面
    self:CreateLoadingScreen()
    
    -- 自动加载玩家列表
    self:AutoLoadPlayers()
    
    return self
end

-- 自动加载玩家列表
function WanUILibrary:AutoLoadPlayers()
    task.spawn(function()
        repeat task.wait(1) until #game.Players:GetPlayers() > 0
        self:RefreshPlayers()
    end)
    
    -- 监听玩家加入
    game.Players.PlayerAdded:Connect(function()
        self:RefreshPlayers()
    end)
    
    game.Players.PlayerRemoving:Connect(function()
        self:RefreshPlayers()
    end)
end

-- 刷新玩家列表
function WanUILibrary:RefreshPlayers()
    self.WanPlayers = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(self.WanPlayers, player.Name)
        end
    end
    table.insert(self.WanPlayers, "所有玩家")
end

-- 创建加载屏幕
function WanUILibrary:CreateLoadingScreen()
    -- 主容器
    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = "WanUI_" .. HttpService:GenerateGUID(false)
    self.screenGui.DisplayOrder = 999
    self.screenGui.ResetOnSpawn = false
    
    if syn and syn.protect_gui then
        syn.protect_gui(self.screenGui)
    elseif get_hidden_gui then
        get_hidden_gui(self.screenGui)
    end
    
    self.screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- 加载方块
    self.loadingSquare = Instance.new("Frame")
    self.loadingSquare.Name = "LoadingSquare"
    self.loadingSquare.Size = UDim2.new(0, 150, 0, 150)
    self.loadingSquare.Position = UDim2.new(0.5, -75, 0.5, -75)
    self.loadingSquare.AnchorPoint = Vector2.new(0.5, 0.5)
    self.loadingSquare.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    self.loadingSquare.BorderSizePixel = 0
    
    -- 圆角
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = self.loadingSquare
    
    -- 渐变描边
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 170, 255)
    stroke.Thickness = 4
    stroke.Parent = self.loadingSquare
    
    -- 加载文字
    self.loadingText = Instance.new("TextLabel")
    self.loadingText.Name = "LoadingText"
    self.loadingText.Size = UDim2.new(1, 0, 0, 40)
    self.loadingText.Position = UDim2.new(0, 0, 0.5, 10)
    self.loadingText.BackgroundTransparency = 1
    self.loadingText.Text = "加载中..."
    self.loadingText.TextColor3 = Color3.fromRGB(0, 170, 255)
    self.loadingText.Font = Enum.Font.GothamBold
    self.loadingText.TextSize = 22
    self.loadingText.Parent = self.loadingSquare
    
    -- 进度条
    self.loadingBar = Instance.new("Frame")
    self.loadingBar.Name = "LoadingBar"
    self.loadingBar.Size = UDim2.new(0, 0, 0, 6)
    self.loadingBar.Position = UDim2.new(0, 0, 1, -20)
    self.loadingBar.AnchorPoint = Vector2.new(0, 1)
    self.loadingBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    self.loadingBar.BorderSizePixel = 0
    self.loadingBar.Parent = self.loadingSquare
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 3)
    barCorner.Parent = self.loadingBar
    
    self.loadingSquare.Parent = self.screenGui
    
    -- 模拟加载
    self:SimulateLoading()
end

-- 模拟加载过程
function WanUILibrary:SimulateLoading()
    local steps = {
        "正在初始化...",
        "加载风御UI...",
        "准备功能模块...",
        "准备完成"
    }
    
    for i, text in ipairs(steps) do
        task.wait(0.5)
        self.loadingText.Text = text
        self.loadingBar:TweenSize(
            UDim2.new(i / #steps, 0, 0, 6),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.4,
            true
        )
    end
    
    task.wait(0.8)
    self:TransitionToToggleButton()
end

-- 过渡到开关按钮
function WanUILibrary:TransitionToToggleButton()
    -- 动画：加载方块收缩为圆形开关按钮
    local tweenInfo = TweenInfo.new(
        0.8,
        Enum.EasingStyle.Elastic,
        Enum.EasingDirection.Out
    )
    
    local targetProps = {
        Size = UDim2.new(0, 60, 0, 60),  -- 圆形尺寸
        Position = self.startPosition,
        BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    }
    
    local tween = TweenService:Create(self.loadingSquare, tweenInfo, targetProps)
    tween:Play()
    
    tween.Completed:Connect(function()
        -- 移除加载文字和进度条
        self.loadingText:Destroy()
        self.loadingBar:Destroy()
        
        -- 将圆角设为完全圆形
        self.loadingSquare.UICorner.CornerRadius = UDim.new(1, 0)
        
        -- 添加彩色渐变描边
        self.loadingSquare.UIStroke:Destroy()
        
        local gradientStroke = Instance.new("UIStroke")
        gradientStroke.Thickness = 3
        gradientStroke.LineJoinMode = Enum.LineJoinMode.Round
        
        -- 创建渐变
        local gradient = Instance.new("UIGradient")
        gradient.Rotation = 0
        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 170, 255)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 85, 127)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(170, 0, 255)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 170, 255))
        }
        gradient.Parent = gradientStroke
        
        gradientStroke.Parent = self.loadingSquare
        
        -- 添加旋转动画
        local rotateTween = TweenService:Create(gradient, TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
            Rotation = 360
        })
        rotateTween:Play()
        
        -- 添加开关图标（风字）
        self.toggleText = Instance.new("TextLabel")
        self.toggleText.Name = "ToggleText"
        self.toggleText.Size = UDim2.new(1, 0, 1, 0)
        self.toggleText.BackgroundTransparency = 1
        self.toggleText.Text = "风"
        self.toggleText.TextColor3 = Color3.fromRGB(0, 170, 255)
        self.toggleText.Font = Enum.Font.GothamBold
        self.toggleText.TextSize = 28
        self.toggleText.Parent = self.loadingSquare
        
        -- 连接点击事件
        self.loadingSquare.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                self:ToggleUI()
            end
        end)
        
        self.isLoaded = true
        
        -- 创建主UI容器（初始隐藏）
        self:CreateMainUIContainer()
    end)
end

-- 创建主UI容器
function WanUILibrary:CreateMainUIContainer()
    -- 主容器
    self.mainContainer = Instance.new("Frame")
    self.mainContainer.Name = "MainContainer"
    self.mainContainer.Size = UDim2.new(0, 60, 0, 60)
    self.mainContainer.Position = self.startPosition
    self.mainContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    self.mainContainer.BorderSizePixel = 0
    self.mainContainer.Visible = false
    self.mainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- 圆形（与开关保持一致）
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(1, 0)
    containerCorner.Parent = self.mainContainer
    
    -- 渐变描边
    local containerStroke = Instance.new("UIStroke")
    containerStroke.Thickness = 3
    containerStroke.LineJoinMode = Enum.LineJoinMode.Round
    
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 0
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 170, 255)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 85, 127)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(170, 0, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 170, 255))
    }
    gradient.Parent = containerStroke
    containerStroke.Parent = self.mainContainer
    
    -- 旋转动画
    local rotateTween = TweenService:Create(gradient, TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
        Rotation = 360
    })
    rotateTween:Play()
    
    -- 标题栏
    self.titleBar = Instance.new("Frame")
    self.titleBar.Name = "TitleBar"
    self.titleBar.Size = UDim2.new(1, 0, 0, 50)
    self.titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    self.titleBar.BorderSizePixel = 0
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = self.titleBar
    
    -- 标题
    self.titleText = Instance.new("TextLabel")
    self.titleText.Name = "TitleText"
    self.titleText.Size = UDim2.new(0, 200, 0, 50)
    self.titleText.Position = UDim2.new(0, 15, 0, 0)
    self.titleText.BackgroundTransparency = 1
    self.titleText.Text = "风御 X制作"
    self.titleText.TextColor3 = Color3.fromRGB(0, 170, 255)
    self.titleText.Font = Enum.Font.GothamBold
    self.titleText.TextSize = 22
    self.titleText.TextXAlignment = Enum.TextXAlignment.Left
    self.titleText.Parent = self.titleBar
    
    -- 关闭按钮
    self.closeButton = Instance.new("TextButton")
    self.closeButton.Name = "CloseButton"
    self.closeButton.Size = UDim2.new(0, 40, 0, 40)
    self.closeButton.Position = UDim2.new(1, -50, 0, 5)
    self.closeButton.AnchorPoint = Vector2.new(1, 0)
    self.closeButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
    self.closeButton.Text = "×"
    self.closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.closeButton.Font = Enum.Font.GothamBold
    self.closeButton.TextSize = 30
    self.closeButton.AutoButtonColor = false
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = self.closeButton
    
    -- 关闭按钮悬停效果
    self.closeButton.MouseEnter:Connect(function()
        TweenService:Create(self.closeButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        }):Play()
    end)
    
    self.closeButton.MouseLeave:Connect(function()
        TweenService:Create(self.closeButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(231, 76, 60)
        }):Play()
    end)
    
    self.closeButton.MouseButton1Click:Connect(function()
        self:CloseUI()
    end)
    self.closeButton.Parent = self.titleBar
    
    -- 内容区域
    self.contentArea = Instance.new("Frame")
    self.contentArea.Name = "ContentArea"
    self.contentArea.Size = UDim2.new(1, 0, 1, -50)
    self.contentArea.Position = UDim2.new(0, 0, 0, 50)
    self.contentArea.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    self.contentArea.BorderSizePixel = 0
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 8)
    contentCorner.Parent = self.contentArea
    
    -- 左侧选项卡区域
    self.tabContainer = Instance.new("ScrollingFrame")
    self.tabContainer.Name = "TabContainer"
    self.tabContainer.Size = UDim2.new(0, 200, 1, 0)
    self.tabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    self.tabContainer.BorderSizePixel = 0
    self.tabContainer.ScrollBarThickness = 3
    self.tabContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
    self.tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    -- 选项卡布局
    self.tabLayout = Instance.new("UIListLayout")
    self.tabLayout.Padding = UDim.new(0, 5)
    self.tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.tabLayout.Parent = self.tabContainer
    
    self.tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.tabContainer.CanvasSize = UDim2.new(0, 0, 0, self.tabLayout.AbsoluteContentSize.Y + 10)
    end)
    
    -- 右侧功能区域
    self.functionContainer = Instance.new("ScrollingFrame")
    self.functionContainer.Name = "FunctionContainer"
    self.functionContainer.Size = UDim2.new(1, -210, 1, 0)
    self.functionContainer.Position = UDim2.new(0, 210, 0, 0)
    self.functionContainer.BackgroundTransparency = 1
    self.functionContainer.BorderSizePixel = 0
    self.functionContainer.ScrollBarThickness = 4
    self.functionContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
    self.functionContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    -- 功能区布局
    self.functionLayout = Instance.new("UIListLayout")
    self.functionLayout.Padding = UDim.new(0, 15)
    self.functionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    self.functionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.functionLayout.Parent = self.functionContainer
    
    -- 组装UI
    self.titleBar.Parent = self.mainContainer
    self.contentArea.Parent = self.mainContainer
    self.tabContainer.Parent = self.contentArea
    self.functionContainer.Parent = self.contentArea
    
    self.mainContainer.Parent = self.screenGui
    
    -- 更新布局
    self.functionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.functionContainer.CanvasSize = UDim2.new(0, 0, 0, self.functionLayout.AbsoluteContentSize.Y + 20)
    end)
end

-- 切换UI
function WanUILibrary:ToggleUI()
    if self.isAnimating then return end
    self.isAnimating = true
    
    if self.isOpen then
        self:CloseUI()
    else
        self:OpenUI()
    end
end

-- 打开UI
function WanUILibrary:OpenUI()
    -- 隐藏开关按钮
    self.loadingSquare.Visible = false
    
    -- 显示主容器
    self.mainContainer.Visible = true
    
    -- 第一步：移动到屏幕中心（弹跳效果）
    local moveTween = TweenService:Create(
        self.mainContainer,
        TweenInfo.new(0.6, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, -30, 0.5, -30)}
    )
    moveTween:Play()
    
    moveTween.Completed:Connect(function()
        -- 第二步：扩展为完整UI（弹性效果）
        local expandTween = TweenService:Create(
            self.mainContainer,
            TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
            {
                Size = self.size,
                Position = UDim2.new(0.5, -self.size.X.Offset/2, 0.5, -self.size.Y.Offset/2),
                BackgroundColor3 = Color3.fromRGB(15, 15, 20)
            }
        )
        expandTween:Play()
        
        expandTween.Completed:Connect(function()
            -- 第三步：修改圆角为方形
            TweenService:Create(self.mainContainer.UICorner, TweenInfo.new(0.3), {
                CornerRadius = UDim.new(0, 12)
            }):Play()
            
            self.isOpen = true
            self.isAnimating = false
            
            -- 添加拖动功能
            self:MakeDraggable()
        end)
    end)
end

-- 关闭UI
function WanUILibrary:CloseUI()
    -- 第一步：修改圆角为圆形
    TweenService:Create(self.mainContainer.UICorner, TweenInfo.new(0.3), {
        CornerRadius = UDim.new(1, 0)
    }):Play()
    
    task.wait(0.3)
    
    -- 第二步：收缩为圆形（弹性效果）
    local shrinkTween = TweenService:Create(
        self.mainContainer,
        TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
        {
            Size = UDim2.new(0, 60, 0, 60),
            Position = UDim2.new(0.5, -30, 0.5, -30),
            BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        }
    )
    shrinkTween:Play()
    
    shrinkTween.Completed:Connect(function()
        -- 第三步：移回开关按钮位置（弹跳效果）
        local moveTween = TweenService:Create(
            self.mainContainer,
            TweenInfo.new(0.6, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
            {Position = self.startPosition}
        )
        moveTween:Play()
        
        moveTween.Completed:Connect(function()
            -- 隐藏主容器，显示开关按钮
            self.mainContainer.Visible = false
            self.loadingSquare.Visible = true
            
            self.isOpen = false
            self.isAnimating = false
        end)
    end)
end

-- 使主容器可拖动
function WanUILibrary:MakeDraggable()
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    self.titleBar.Active = true
    
    local function update(input)
        local delta = input.Position - dragStart
        self.mainContainer.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
    
    self.titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.mainContainer.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    self.titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- 创建数字点击特效
function WanUILibrary:CreateDigitalEffect(parent, position)
    local effectContainer = Instance.new("Frame")
    effectContainer.Name = "DigitalEffect"
    effectContainer.Size = UDim2.new(0, 100, 0, 100)
    effectContainer.Position = position
    effectContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    effectContainer.BackgroundTransparency = 1
    effectContainer.ClipsDescendants = true
    effectContainer.Parent = parent
    
    -- 创建多个数字
    local digitalBits = {"1", "0", "0", "1", "1", "0", "1"}
    local colors = {
        Color3.fromRGB(0, 170, 255),
        Color3.fromRGB(255, 85, 127),
        Color3.fromRGB(170, 0, 255),
        Color3.fromRGB(0, 255, 170),
        Color3.fromRGB(255, 170, 0),
        Color3.fromRGB(170, 255, 0),
        Color3.fromRGB(255, 0, 170)
    }
    
    for i = 1, 20 do
        for j, bit in ipairs(digitalBits) do
            local digital = Instance.new("TextLabel")
            digital.Name = "Digital_" .. i .. "_" .. j
            digital.Size = UDim2.new(0, 15, 0, 15)
            digital.Position = UDim2.new(0.5, -7.5, 0.5, -7.5)
            digital.AnchorPoint = Vector2.new(0.5, 0.5)
            digital.BackgroundTransparency = 1
            digital.Text = bit
            digital.TextColor3 = colors[math.random(1, #colors)]
            digital.Font = Enum.Font.Code
            digital.TextSize = 12 + math.random(5)
            digital.Parent = effectContainer
            
            -- 随机方向和速度
            local angle = math.rad(math.random(0, 360))
            local distance = math.random(50, 150)
            local speed = math.random(8, 15) / 10
            
            TweenService:Create(digital, TweenInfo.new(speed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(
                    0.5, math.cos(angle) * distance - 7.5,
                    0.5, math.sin(angle) * distance - 7.5
                ),
                TextTransparency = 1,
                TextSize = 0
            }):Play()
        end
    end
    
    -- 清理效果
    task.wait(1.5)
    effectContainer:Destroy()
end

-- 创建选项卡
function WanUILibrary:Tab(name, icon)
    local tab = {}
    setmetatable(tab, {__index = WanUILibrary.Tab})
    
    tab.id = #self.WanTabs + 1
    tab.name = name
    tab.icon = icon
    tab.sections = {}
    
    -- 创建选项卡按钮
    local tabButton = Instance.new("TextButton")
    tabButton.Name = "Tab_" .. name
    tabButton.Size = UDim2.new(1, -20, 0, 45)
    tabButton.Position = UDim2.new(0, 10, 0, 10 + (tab.id-1) * 55)
    tabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    tabButton.Text = ""
    tabButton.AutoButtonColor = false
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = tabButton
    
    -- 选项卡图标
    local tabIcon = Instance.new("ImageLabel")
    tabIcon.Name = "Icon"
    tabIcon.Size = UDim2.new(0, 30, 0, 30)
    tabIcon.Position = UDim2.new(0, 15, 0.5, -15)
    tabIcon.BackgroundTransparency = 1
    tabIcon.Image = icon and "rbxassetid://" .. icon or "rbxassetid://10734958979"
    tabIcon.ImageColor3 = Color3.fromRGB(180, 180, 190)
    tabIcon.Parent = tabButton
    
    -- 选项卡名称
    local tabName = Instance.new("TextLabel")
    tabName.Name = "Name"
    tabName.Size = UDim2.new(1, -60, 1, 0)
    tabName.Position = UDim2.new(0, 55, 0, 0)
    tabName.BackgroundTransparency = 1
    tabName.Text = name
    tabName.TextColor3 = Color3.fromRGB(180, 180, 190)
    tabName.Font = Enum.Font.GothamSemibold
    tabName.TextSize = 16
    tabName.TextXAlignment = Enum.TextXAlignment.Left
    tabName.Parent = tabButton
    
    -- 选中指示器
    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0, 5, 0, 25)
    indicator.Position = UDim2.new(1, -2, 0.5, -12.5)
    indicator.AnchorPoint = Vector2.new(1, 0.5)
    indicator.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    indicator.Visible = (tab.id == 1)
    
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, 2)
    indicatorCorner.Parent = indicator
    
    indicator.Parent = tabButton
    
    -- 点击事件
    tabButton.MouseButton1Click:Connect(function()
        self:SwitchTab(tab.id)
    end)
    
    -- 悬停效果
    tabButton.MouseEnter:Connect(function()
        if self.activeWanTab ~= tab.id then
            TweenService:Create(tabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            }):Play()
        end
    end)
    
    tabButton.MouseLeave:Connect(function()
        if self.activeWanTab ~= tab.id then
            TweenService:Create(tabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            }):Play()
        end
    end)
    
    -- 点击效果
    tabButton.MouseButton1Down:Connect(function()
        self:CreateDigitalEffect(tabButton, UDim2.new(0.5, 0, 0.5, 0))
    end)
    
    tabButton.Parent = self.tabContainer
    
    tab.button = tabButton
    tab.indicator = indicator
    tab.parent = self
    
    table.insert(self.WanTabs, tab)
    
    -- 如果是第一个选项卡，设置为激活状态
    if tab.id == 1 then
        self.activeWanTab = 1
        self:SwitchTab(1)
    end
    
    return tab
end

-- 选项卡方法：创建功能区段
WanUILibrary.Tab = {}

function WanUILibrary.Tab:section(name, defaultOpen)
    local section = {}
    setmetatable(section, {__index = WanUILibrary.Section})
    
    defaultOpen = defaultOpen == nil and true or defaultOpen
    
    -- 创建段容器
    local sectionContainer = Instance.new("Frame")
    sectionContainer.Name = "Section_" .. name
    sectionContainer.Size = UDim2.new(1, -30, 0, 0)
    sectionContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    sectionContainer.BorderSizePixel = 0
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 10)
    sectionCorner.Parent = sectionContainer
    
    -- 段标题
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Name = "Title"
    sectionTitle.Size = UDim2.new(1, 0, 0, 45)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = name
    sectionTitle.TextColor3 = self.parent.Colors.Text
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextSize = 18
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.Parent = sectionContainer
    
    local titlePadding = Instance.new("UIPadding")
    titlePadding.PaddingLeft = UDim.new(0, 20)
    titlePadding.Parent = sectionTitle
    
    -- 展开/收起按钮
    local expandButton = Instance.new("TextButton")
    expandButton.Name = "ExpandButton"
    expandButton.Size = UDim2.new(0, 35, 0, 35)
    expandButton.Position = UDim2.new(1, -45, 0, 5)
    expandButton.AnchorPoint = Vector2.new(1, 0)
    expandButton.BackgroundTransparency = 1
    expandButton.Text = defaultOpen and "−" or "+"
    expandButton.TextColor3 = Color3.fromRGB(0, 170, 255)
    expandButton.Font = Enum.Font.GothamBold
    expandButton.TextSize = 25
    expandButton.AutoButtonColor = false
    expandButton.Parent = sectionContainer
    
    -- 点击效果
    expandButton.MouseButton1Down:Connect(function()
        self.parent:CreateDigitalEffect(expandButton, UDim2.new(0.5, 0, 0.5, 0))
    end)
    
    -- 内容容器
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "Content"
    contentContainer.Size = UDim2.new(1, -20, 0, 0)
    contentContainer.Position = UDim2.new(0, 10, 0, 45)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Visible = defaultOpen
    
    -- 内容布局
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 12)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Parent = contentContainer
    
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        contentContainer.Size = UDim2.new(1, -20, 0, contentLayout.AbsoluteContentSize.Y)
        sectionContainer.Size = UDim2.new(1, -30, 0, contentLayout.AbsoluteContentSize.Y + (defaultOpen and 55 or 0))
    end)
    
    contentContainer.Parent = sectionContainer
    
    -- 切换展开/收起
    expandButton.MouseButton1Click:Connect(function()
        defaultOpen = not defaultOpen
        contentContainer.Visible = defaultOpen
        expandButton.Text = defaultOpen and "−" or "+"
        
        if defaultOpen then
            sectionContainer.Size = UDim2.new(1, -30, 0, contentLayout.AbsoluteContentSize.Y + 55)
        else
            sectionContainer.Size = UDim2.new(1, -30, 0, 45)
        end
    end)
    
    section.container = sectionContainer
    section.content = contentContainer
    section.parent = self.parent
    section.isOpen = defaultOpen
    
    table.insert(self.sections, section)
    
    -- 添加到功能区域
    if self.id == self.parent.activeWanTab then
        sectionContainer.Parent = self.parent.functionContainer
    end
    
    return section
end

-- 功能区段方法
WanUILibrary.Section = {}

function WanUILibrary.Section:Label(text, hasTA)
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = self.parent.Colors.Text
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = hasTA and 18 or 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = self.content
    
    -- 如果有TA标记，添加颜色变化效果
    if hasTA then
        task.spawn(function()
            local colors = {
                Color3.fromRGB(0, 170, 255),
                Color3.fromRGB(255, 85, 127),
                Color3.fromRGB(170, 0, 255),
                Color3.fromRGB(0, 255, 170),
                Color3.fromRGB(255, 170, 0)
            }
            local currentIndex = 1
            while label and label.Parent do
                label.TextColor3 = colors[currentIndex]
                currentIndex = currentIndex % #colors + 1
                task.wait(1)
            end
        end)
    end
    
    return self
end

function WanUILibrary.Section:Button(text, hasTA, callback)
    local button = Instance.new("TextButton")
    button.Name = "Button_" .. text
    button.Size = UDim2.new(1, 0, 0, 45)
    button.BackgroundColor3 = self.parent.Colors.Card
    button.Text = text
    button.TextColor3 = hasTA and Color3.fromRGB(0, 170, 255) or self.parent.Colors.Text
    button.Font = hasTA and Enum.Font.GothamBold or Enum.Font.GothamSemibold
    button.TextSize = hasTA and 18 or 16
    button.AutoButtonColor = false
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    -- 如果有TA标记，添加颜色变化效果
    if hasTA then
        task.spawn(function()
            local colors = {
                Color3.fromRGB(0, 170, 255),
                Color3.fromRGB(255, 85, 127),
                Color3.fromRGB(170, 0, 255),
                Color3.fromRGB(0, 255, 170),
                Color3.fromRGB(255, 170, 0)
            }
            local currentIndex = 1
            while button and button.Parent do
                TweenService:Create(button, TweenInfo.new(1), {
                    TextColor3 = colors[currentIndex]
                }):Play()
                currentIndex = currentIndex % #colors + 1
                task.wait(1)
            end
        end)
    end
    
    -- 悬停效果
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = self.parent.Colors.Card
        }):Play()
    end)
    
    -- 点击效果
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(1, -5, 0, 40)
        }):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(1, 0, 0, 45)
        }):Play()
    end)
    
    -- 数字点击特效
    button.MouseButton1Click:Connect(function()
        self.parent:CreateDigitalEffect(button, UDim2.new(0.5, 0, 0.5, 0))
        if callback then
            callback()
        end
    end)
    
    button.Parent = self.content
    
    return self
end

function WanUILibrary.Section:Toggle(name, flag, defaultValue, callback, hasTA)
    defaultValue = defaultValue or false
    flag = flag or name
    
    -- 存储状态
    self.parent.WanFlags[flag] = defaultValue
    
    local toggleContainer = Instance.new("Frame")
    toggleContainer.Name = "Toggle_" .. name
    toggleContainer.Size = UDim2.new(1, 0, 0, 45)
    toggleContainer.BackgroundTransparency = 1
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Name = "Label"
    toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = name
    toggleLabel.TextColor3 = hasTA and Color3.fromRGB(0, 170, 255) or self.parent.Colors.Text
    toggleLabel.Font = hasTA and Enum.Font.GothamBold or Enum.Font.GothamSemibold
    toggleLabel.TextSize = hasTA and 18 or 16
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.Parent = toggleContainer
    
    -- 如果有TA标记，添加颜色变化效果
    if hasTA then
        task.spawn(function()
            local colors = {
                Color3.fromRGB(0, 170, 255),
                Color3.fromRGB(255, 85, 127),
                Color3.fromRGB(170, 0, 255),
                Color3.fromRGB(0, 255, 170),
                Color3.fromRGB(255, 170, 0)
            }
            local currentIndex = 1
            while toggleLabel and toggleLabel.Parent do
                TweenService:Create(toggleLabel, TweenInfo.new(1), {
                    TextColor3 = colors[currentIndex]
                }):Play()
                currentIndex = currentIndex % #colors + 1
                task.wait(1)
            end
        end)
    end
    
    local toggleSwitch = Instance.new("Frame")
    toggleSwitch.Name = "Switch"
    toggleSwitch.Size = UDim2.new(0, 60, 0, 30)
    toggleSwitch.Position = UDim2.new(1, 0, 0.5, -15)
    toggleSwitch.AnchorPoint = Vector2.new(1, 0.5)
    toggleSwitch.BackgroundColor3 = self.parent.Colors.Card
    
    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(0, 15)
    switchCorner.Parent = toggleSwitch
    
    local toggleKnob = Instance.new("Frame")
    toggleKnob.Name = "Knob"
    toggleKnob.Size = UDim2.new(0, 26, 0, 26)
    toggleKnob.Position = UDim2.new(0, 2, 0, 2)
    toggleKnob.BackgroundColor3 = Color3.fromRGB(200, 200, 210)
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 13)
    knobCorner.Parent = toggleKnob
    
    toggleKnob.Parent = toggleSwitch
    toggleSwitch.Parent = toggleContainer
    
    -- 更新状态
    local function updateState()
        TweenService:Create(toggleSwitch, TweenInfo.new(0.3), {
            BackgroundColor3 = self.parent.WanFlags[flag] and Color3.fromRGB(0, 170, 255) or self.parent.Colors.Card
        }):Play()
        
        TweenService:Create(toggleKnob, TweenInfo.new(0.3), {
            Position = UDim2.new(0, self.parent.WanFlags[flag] and 32 or 2, 0, 2)
        }):Play()
        
        if callback then
            callback(self.parent.WanFlags[flag])
        end
    end
    
    -- 点击事件
    toggleSwitch.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.parent.WanFlags[flag] = not self.parent.WanFlags[flag]
            updateState()
            self.parent:CreateDigitalEffect(toggleSwitch, UDim2.new(0.5, 0, 0.5, 0))
        end
    end)
    
    -- 初始化状态
    updateState()
    
    toggleContainer.Parent = self.content
    
    return self
end

function WanUILibrary.Section:Slider(name, flag, defaultValue, minValue, maxValue, precise, callback, hasTA)
    minValue = minValue or 0
    maxValue = maxValue or 100
    defaultValue = defaultValue or minValue
    precise = precise or false
    flag = flag or name
    
    -- 存储状态
    self.parent.WanFlags[flag] = defaultValue
    
    local sliderContainer = Instance.new("Frame")
    sliderContainer.Name = "Slider_" .. name
    sliderContainer.Size = UDim2.new(1, 0, 0, 65)
    sliderContainer.BackgroundTransparency = 1
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Name = "Label"
    sliderLabel.Size = UDim2.new(1, 0, 0, 25)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = name
    sliderLabel.TextColor3 = hasTA and Color3.fromRGB(0, 170, 255) or self.parent.Colors.Text
    sliderLabel.Font = hasTA and Enum.Font.GothamBold or Enum.Font.GothamSemibold
    sliderLabel.TextSize = hasTA and 18 or 16
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.Parent = sliderContainer
    
    -- 如果有TA标记，添加颜色变化效果
    if hasTA then
        task.spawn(function()
            local colors = {
                Color3.fromRGB(0, 170, 255),
                Color3.fromRGB(255, 85, 127),
                Color3.fromRGB(170, 0, 255),
                Color3.fromRGB(0, 255, 170),
                Color3.fromRGB(255, 170, 0)
            }
            local currentIndex = 1
            while sliderLabel and sliderLabel.Parent do
                TweenService:Create(sliderLabel, TweenInfo.new(1), {
                    TextColor3 = colors[currentIndex]
                }):Play()
                currentIndex = currentIndex % #colors + 1
                task.wait(1)
            end
        end)
    end
    
    local sliderBar = Instance.new("Frame")
    sliderBar.Name = "Bar"
    sliderBar.Size = UDim2.new(1, 0, 0, 8)
    sliderBar.Position = UDim2.new(0, 0, 0, 35)
    sliderBar.BackgroundColor3 = self.parent.Colors.Card
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 4)
    barCorner.Parent = sliderBar
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = sliderFill
    
    sliderFill.Parent = sliderBar
    
    local sliderKnob = Instance.new("Frame")
    sliderKnob.Name = "Knob"
    sliderKnob.Size = UDim2.new(0, 20, 0, 20)
    sliderKnob.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -10, 0.5, -10)
    sliderKnob.AnchorPoint = Vector2.new(0, 0.5)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderKnob.BorderSizePixel = 2
    sliderKnob.BorderColor3 = Color3.fromRGB(0, 170, 255)
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 10)
    knobCorner.Parent = sliderKnob
    
    sliderKnob.Parent = sliderContainer
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Size = UDim2.new(0, 60, 0, 25)
    valueLabel.Position = UDim2.new(1, -60, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultValue)
    valueLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 16
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = sliderContainer
    
    sliderBar.Parent = sliderContainer
    
    -- 滑块交互
    local dragging = false
    
    local function updateValue(xPosition)
        local relativeX = (xPosition - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X
        relativeX = math.clamp(relativeX, 0, 1)
        
        local value
        if precise then
            value = minValue + (maxValue - minValue) * relativeX
            value = math.floor(value * 10) / 10
        else
            value = minValue + (maxValue - minValue) * relativeX
            value = math.floor(value)
        end
        
        sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
        sliderKnob.Position = UDim2.new(relativeX, -10, 0.5, -10)
        valueLabel.Text = tostring(value)
        
        self.parent.WanFlags[flag] = value
        
        if callback then
            callback(value)
        end
    end
    
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateValue(input.Position.X)
            self.parent:CreateDigitalEffect(sliderBar, UDim2.new(
                (sliderKnob.Position.X.Scale + sliderKnob.Position.X.Offset / sliderBar.AbsoluteSize.X),
                0,
                0.5, 0
            ))
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateValue(input.Position.X)
        end
    end)
    
    sliderContainer.Parent = self.content
    
    return self
end

function WanUILibrary.Section:Dropdown(name, flag, options, defaultValue, callback, hasTA)
    options = options or {}
    flag = flag or name
    
    local defaultOption = defaultValue or options[1]
    self.parent.WanFlags[flag] = defaultOption
    
    local dropdownContainer = Instance.new("Frame")
    dropdownContainer.Name = "Dropdown_" .. name
    dropdownContainer.Size = UDim2.new(1, 0, 0, 45)
    dropdownContainer.BackgroundTransparency = 1
    
    local dropdownLabel = Instance.new("TextLabel")
    dropdownLabel.Name = "Label"
    dropdownLabel.Size = UDim2.new(0.6, 0, 1, 0)
    dropdownLabel.BackgroundTransparency = 1
    dropdownLabel.Text = name
    dropdownLabel.TextColor3 = hasTA and Color3.fromRGB(0, 170, 255) or self.parent.Colors.Text
    dropdownLabel.Font = hasTA and Enum.Font.GothamBold or Enum.Font.GothamSemibold
    dropdownLabel.TextSize = hasTA and 18 or 16
    dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    dropdownLabel.Parent = dropdownContainer
    
    -- 如果有TA标记，添加颜色变化效果
    if hasTA then
        task.spawn(function()
            local colors = {
                Color3.fromRGB(0, 170, 255),
                Color3.fromRGB(255, 85, 127),
                Color3.fromRGB(170, 0, 255),
                Color3.fromRGB(0, 255, 170),
                Color3.fromRGB(255, 170, 0)
            }
            local currentIndex = 1
            while dropdownLabel and dropdownLabel.Parent do
                TweenService:Create(dropdownLabel, TweenInfo.new(1), {
                    TextColor3 = colors[currentIndex]
                }):Play()
                currentIndex = currentIndex % #colors + 1
                task.wait(1)
            end
        end)
    end
    
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Name = "Button"
    dropdownButton.Size = UDim2.new(0.4, 0, 1, 0)
    dropdownButton.Position = UDim2.new(0.6, 0, 0, 0)
    dropdownButton.BackgroundColor3 = self.parent.Colors.Card
    dropdownButton.Text = defaultOption or "选择..."
    dropdownButton.TextColor3 = self.parent.Colors.Text
    dropdownButton.Font = Enum.Font.GothamSemibold
    dropdownButton.TextSize = 16
    dropdownButton.AutoButtonColor = false
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = dropdownButton
    
    dropdownButton.Parent = dropdownContainer
    
    -- 点击效果
    dropdownButton.MouseButton1Down:Connect(function()
        TweenService:Create(dropdownButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0.4, -5, 1, -5)
        }):Play()
    end)
    
    dropdownButton.MouseButton1Up:Connect(function()
        TweenService:Create(dropdownButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0.4, 0, 1, 0)
        }):Play()
    end)
    
    -- 创建选项列表
    local optionsFrame = Instance.new("Frame")
    optionsFrame.Name = "Options"
    optionsFrame.Size = UDim2.new(0.4, 0, 0, 0)
    optionsFrame.Position = UDim2.new(0.6, 0, 1, 5)
    optionsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    optionsFrame.BorderSizePixel = 0
    optionsFrame.ClipsDescendants = true
    optionsFrame.Visible = false
    
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = UDim.new(0, 8)
    optionsCorner.Parent = optionsFrame
    
    local optionsLayout = Instance.new("UIListLayout")
    optionsLayout.Padding = UDim.new(0, 1)
    optionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    optionsLayout.Parent = optionsFrame
    
    optionsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        optionsFrame.Size = UDim2.new(0.4, 0, 0, optionsLayout.AbsoluteContentSize.Y)
    end)
    
    optionsFrame.Parent = dropdownContainer
    
    -- 添加选项
    for i, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = "Option_" .. i
        optionButton.Size = UDim2.new(1, 0, 0, 35)
        optionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        optionButton.Text = option
        optionButton.TextColor3 = self.parent.Colors.Text
        optionButton.Font = Enum.Font.Gotham
        optionButton.TextSize = 14
        optionButton.AutoButtonColor = false
        
        local optionCorner = Instance.new("UICorner")
        optionCorner.CornerRadius = UDim.new(0, 6)
        optionCorner.Parent = optionButton
        
        -- 悬停效果
        optionButton.MouseEnter:Connect(function()
            TweenService:Create(optionButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            }):Play()
        end)
        
        optionButton.MouseLeave:Connect(function()
            TweenService:Create(optionButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            }):Play()
        end)
        
        -- 点击事件
        optionButton.MouseButton1Click:Connect(function()
            dropdownButton.Text = option
            optionsFrame.Visible = false
            self.parent.WanFlags[flag] = option
            self.parent:CreateDigitalEffect(optionButton, UDim2.new(0.5, 0, 0.5, 0))
            
            if callback then
                callback(option, i)
            end
        end)
        
        optionButton.Parent = optionsFrame
    end
    
    -- 切换选项列表显示
    local isOpen = false
    dropdownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        optionsFrame.Visible = isOpen
        if isOpen then
            self.parent:CreateDigitalEffect(dropdownButton, UDim2.new(0.5, 0, 0.5, 0))
        end
    end)
    
    -- 点击其他地方关闭
    local connection
    connection = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if isOpen then
                local mousePos = input.Position
                local buttonPos = dropdownButton.AbsolutePosition
                local buttonSize = dropdownButton.AbsoluteSize
                
                if not (mousePos.X >= buttonPos.X and mousePos.X <= buttonPos.X + buttonSize.X and
                       mousePos.Y >= buttonPos.Y and mousePos.Y <= buttonPos.Y + buttonSize.Y + optionsFrame.AbsoluteSize.Y) then
                    isOpen = false
                    optionsFrame.Visible = false
                end
            end
        end
    end)
    
    table.insert(self.parent.connections, connection)
    
    dropdownContainer.Parent = self.content
    
    return self
end

function WanUILibrary.Section:Textbox(name, flag, placeholder, defaultValue, callback, hasTA)
    defaultValue = defaultValue or ""
    placeholder = placeholder or "请输入..."
    flag = flag or name
    
    self.parent.WanFlags[flag] = defaultValue
    
    local textboxContainer = Instance.new("Frame")
    textboxContainer.Name = "Textbox_" .. name
    textboxContainer.Size = UDim2.new(1, 0, 0, 45)
    textboxContainer.BackgroundTransparency = 1
    
    local textboxLabel = Instance.new("TextLabel")
    textboxLabel.Name = "Label"
    textboxLabel.Size = UDim2.new(0.6, 0, 1, 0)
    textboxLabel.BackgroundTransparency = 1
    textboxLabel.Text = name
    textboxLabel.TextColor3 = hasTA and Color3.fromRGB(0, 170, 255) or self.parent.Colors.Text
    textboxLabel.Font = hasTA and Enum.Font.GothamBold or Enum.Font.GothamSemibold
    textboxLabel.TextSize = hasTA and 18 or 16
    textboxLabel.TextXAlignment = Enum.TextXAlignment.Left
    textboxLabel.Parent = textboxContainer
    
    -- 如果有TA标记，添加颜色变化效果
    if hasTA then
        task.spawn(function()
            local colors = {
                Color3.fromRGB(0, 170, 255),
                Color3.fromRGB(255, 85, 127),
                Color3.fromRGB(170, 0, 255),
                Color3.fromRGB(0, 255, 170),
                Color3.fromRGB(255, 170, 0)
            }
            local currentIndex = 1
            while textboxLabel and textboxLabel.Parent do
                TweenService:Create(textboxLabel, TweenInfo.new(1), {
                    TextColor3 = colors[currentIndex]
                }):Play()
                currentIndex = currentIndex % #colors + 1
                task.wait(1)
            end
        end)
    end
    
    local textboxInput = Instance.new("TextBox")
    textboxInput.Name = "Input"
    textboxInput.Size = UDim2.new(0.4, 0, 1, 0)
    textboxInput.Position = UDim2.new(0.6, 0, 0, 0)
    textboxInput.BackgroundColor3 = self.parent.Colors.Card
    textboxInput.PlaceholderText = placeholder
    textboxInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
    textboxInput.Text = defaultValue
    textboxInput.TextColor3 = self.parent.Colors.Text
    textboxInput.Font = Enum.Font.Gotham
    textboxInput.TextSize = 14
    textboxInput.ClearTextOnFocus = false
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = textboxInput
    
    textboxInput.Focused:Connect(function()
        TweenService:Create(textboxInput, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        }):Play()
    end)
    
    textboxInput.FocusLost:Connect(function()
        TweenService:Create(textboxInput, TweenInfo.new(0.2), {
            BackgroundColor3 = self.parent.Colors.Card
        }):Play()
        
        self.parent.WanFlags[flag] = textboxInput.Text
        
        if callback then
            callback(textboxInput.Text)
        end
    end)
    
    textboxInput.Parent = textboxContainer
    textboxContainer.Parent = self.content
    
    return self
end

-- 自定义按键组件
function WanUILibrary.Section:WanK(imageId, callback, hasTA)
    local button = Instance.new("ImageButton")
    button.Name = "WanK_" .. imageId
    button.Size = UDim2.new(0, 100, 0, 100)
    button.BackgroundColor3 = self.parent.Colors.Card
    button.Image = "rbxassetid://" .. imageId
    button.ScaleType = Enum.ScaleType.Crop
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = button
    
    -- 悬停效果
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = self.parent.Colors.Card
        }):Play()
    end)
    
    -- 点击效果
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 95, 0, 95)
        }):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 100, 0, 100)
        }):Play()
    end)
    
    -- 数字点击特效
    button.MouseButton1Click:Connect(function()
        self.parent:CreateDigitalEffect(button, UDim2.new(0.5, 0, 0.5, 0))
        if callback then
            callback()
        end
    end)
    
    button.Parent = self.content
    
    return self
end

-- 切换选项卡
function WanUILibrary:SwitchTab(tabId)
    if self.activeWanTab == tabId then return end
    
    -- 更新激活状态
    if self.activeWanTab then
        local oldTab = self.WanTabs[self.activeWanTab]
        TweenService:Create(oldTab.button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        }):Play()
        TweenService:Create(oldTab.button.Icon, TweenInfo.new(0.2), {
            ImageColor3 = Color3.fromRGB(180, 180, 190)
        }):Play()
        TweenService:Create(oldTab.button.Name, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(180, 180, 190)
        }):Play()
        oldTab.indicator.Visible = false
        
        -- 隐藏旧选项卡的区段
        for _, section in ipairs(oldTab.sections) do
            if section.container then
                section.container:Destroy()
            end
        end
    end
    
    local newTab = self.WanTabs[tabId]
    TweenService:Create(newTab.button, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    }):Play()
    TweenService:Create(newTab.button.Icon, TweenInfo.new(0.2), {
        ImageColor3 = Color3.fromRGB(0, 170, 255)
    }):Play()
    TweenService:Create(newTab.button.Name, TweenInfo.new(0.2), {
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
    newTab.indicator.Visible = true
    
    self.activeWanTab = tabId
    
    -- 显示新选项卡的区段
    for _, section in ipairs(newTab.sections) do
        section.container.Parent = self.functionContainer
    end
end

-- 销毁UI
function WanUILibrary:Destroy()
    -- 断开所有连接
    for _, connection in ipairs(self.connections) do
        if connection.Disconnect then
            connection:Disconnect()
        end
    end
    
    -- 销毁UI元素
    if self.screenGui then
        self.screenGui:Destroy()
    end
end

-- 返回库对象
return function()
    return WanUILibrary
end
