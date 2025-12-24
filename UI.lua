-- ModernUI 库
-- 文件名: ModernUILibrary.lua

-- 等待游戏加载
repeat task.wait() until game:IsLoaded()

-- 引入服务
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 主库对象
local ModernUILibrary = {}
ModernUILibrary.__index = ModernUILibrary

-- 颜色配置
ModernUILibrary.Colors = {
    Primary = Color3.fromRGB(52, 152, 219),
    Secondary = Color3.fromRGB(41, 128, 185),
    Success = Color3.fromRGB(46, 204, 113),
    Danger = Color3.fromRGB(231, 76, 60),
    Warning = Color3.fromRGB(241, 196, 15),
    Dark = Color3.fromRGB(44, 62, 80),
    Light = Color3.fromRGB(236, 240, 241),
    Background = Color3.fromRGB(25, 25, 25),
    Card = Color3.fromRGB(35, 35, 35),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(189, 195, 199)
}

-- 全局库实例
local currentLibrary = nil

-- 创建新的UI实例
function ModernUILibrary.new(name)
    local self = setmetatable({}, ModernUILibrary)
    
    -- 配置
    self.name = name or "Modern UI"
    self.size = UDim2.new(0, 650, 0, 500)
    self.startPosition = UDim2.new(0, 20, 0.8, -25)
    
    -- 状态
    self.isOpen = false
    self.isAnimating = false
    self.isLoaded = false
    self.tabs = {}
    self.activeTab = nil
    self.components = {}
    self.connections = {}
    self.flags = {} -- 用于存储开关状态等
    
    -- 存储全局实例
    currentLibrary = self
    
    -- 创建加载界面
    self:CreateLoadingScreen()
    
    return self
end

-- 创建加载屏幕
function ModernUILibrary:CreateLoadingScreen()
    -- 主容器
    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = "ModernUI_" .. self.name
    self.screenGui.DisplayOrder = 999
    self.screenGui.ResetOnSpawn = false
    
    if syn and syn.protect_gui then
        syn.protect_gui(self.screenGui)
    end
    
    self.screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- 加载方块
    self.loadingSquare = Instance.new("Frame")
    self.loadingSquare.Name = "LoadingSquare"
    self.loadingSquare.Size = UDim2.new(0, 150, 0, 150)
    self.loadingSquare.Position = UDim2.new(0.5, -75, 0.5, -75)
    self.loadingSquare.AnchorPoint = Vector2.new(0.5, 0.5)
    self.loadingSquare.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    self.loadingSquare.BorderSizePixel = 0
    
    -- 圆角
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = self.loadingSquare
    
    -- 描边
    local stroke = Instance.new("UIStroke")
    stroke.Color = self.Colors.Primary
    stroke.Thickness = 3
    stroke.Parent = self.loadingSquare
    
    -- 加载文字
    self.loadingText = Instance.new("TextLabel")
    self.loadingText.Name = "LoadingText"
    self.loadingText.Size = UDim2.new(1, 0, 0, 40)
    self.loadingText.Position = UDim2.new(0, 0, 0.5, 10)
    self.loadingText.BackgroundTransparency = 1
    self.loadingText.Text = "加载中..."
    self.loadingText.TextColor3 = self.Colors.Text
    self.loadingText.Font = Enum.Font.GothamBold
    self.loadingText.TextSize = 20
    self.loadingText.Parent = self.loadingSquare
    
    -- 进度条
    self.loadingBar = Instance.new("Frame")
    self.loadingBar.Name = "LoadingBar"
    self.loadingBar.Size = UDim2.new(0, 0, 0, 4)
    self.loadingBar.Position = UDim2.new(0, 0, 1, -10)
    self.loadingBar.AnchorPoint = Vector2.new(0, 1)
    self.loadingBar.BackgroundColor3 = self.Colors.Primary
    self.loadingBar.BorderSizePixel = 0
    self.loadingBar.Parent = self.loadingSquare
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 2)
    barCorner.Parent = self.loadingBar
    
    self.loadingSquare.Parent = self.screenGui
    
    -- 模拟加载
    self:SimulateLoading()
end

-- 模拟加载过程
function ModernUILibrary:SimulateLoading()
    local steps = {
        "正在初始化...",
        "加载资源...",
        "准备界面...",
        "准备完成"
    }
    
    for i, text in ipairs(steps) do
        task.wait(0.5)
        self.loadingText.Text = text
        self.loadingBar:TweenSize(
            UDim2.new(i / #steps, 0, 0, 4),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.3,
            true
        )
    end
    
    task.wait(0.5)
    self:TransitionToToggleButton()
end

-- 过渡到开关按钮
function ModernUILibrary:TransitionToToggleButton()
    -- 创建开关按钮
    self:CreateToggleButton()
    
    -- 动画：加载方块收缩为开关按钮
    local tweenInfo = TweenInfo.new(
        0.7,
        Enum.EasingStyle.Elastic,
        Enum.EasingDirection.Out
    )
    
    local targetProps = {
        Size = UDim2.new(0, 50, 0, 50),
        Position = self.startPosition,
        BackgroundColor3 = self.Colors.Dark
    }
    
    local tween = TweenService:Create(self.loadingSquare, tweenInfo, targetProps)
    tween:Play()
    
    tween.Completed:Connect(function()
        -- 移除加载文字和进度条
        self.loadingText:Destroy()
        self.loadingBar:Destroy()
        
        -- 添加开关文字
        self.toggleText = Instance.new("TextLabel")
        self.toggleText.Name = "ToggleText"
        self.toggleText.Size = UDim2.new(1, 0, 1, 0)
        self.toggleText.BackgroundTransparency = 1
        self.toggleText.Text = "开关"
        self.toggleText.TextColor3 = self.Colors.Primary
        self.toggleText.Font = Enum.Font.GothamBold
        self.toggleText.TextSize = 14
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

-- 创建开关按钮
function ModernUILibrary:CreateToggleButton()
    -- 使方块可拖动
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    self.loadingSquare.Active = true
    
    local function update(input)
        local delta = input.Position - dragStart
        self.startPosition = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        self.loadingSquare.Position = self.startPosition
    end
    
    self.loadingSquare.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.loadingSquare.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    self.loadingSquare.InputChanged:Connect(function(input)
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

-- 创建主UI容器
function ModernUILibrary:CreateMainUIContainer()
    -- 主容器
    self.mainContainer = Instance.new("Frame")
    self.mainContainer.Name = "MainContainer"
    self.mainContainer.Size = UDim2.new(0, 50, 0, 50)
    self.mainContainer.Position = self.startPosition
    self.mainContainer.BackgroundColor3 = self.Colors.Dark
    self.mainContainer.BorderSizePixel = 0
    self.mainContainer.Visible = false
    self.mainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- 圆角
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 8)
    containerCorner.Parent = self.mainContainer
    
    -- 描边
    local containerStroke = Instance.new("UIStroke")
    containerStroke.Color = self.Colors.Primary
    containerStroke.Thickness = 2
    containerStroke.Parent = self.mainContainer
    
    -- 标题栏
    self.titleBar = Instance.new("Frame")
    self.titleBar.Name = "TitleBar"
    self.titleBar.Size = UDim2.new(1, 0, 0, 40)
    self.titleBar.BackgroundColor3 = self.Colors.Background
    self.titleBar.BorderSizePixel = 0
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = self.titleBar
    
    -- 标题
    self.titleText = Instance.new("TextLabel")
    self.titleText.Name = "TitleText"
    self.titleText.Size = UDim2.new(0, 200, 0, 40)
    self.titleText.Position = UDim2.new(0, 15, 0, 0)
    self.titleText.BackgroundTransparency = 1
    self.titleText.Text = self.name
    self.titleText.TextColor3 = self.Colors.Text
    self.titleText.Font = Enum.Font.GothamBold
    self.titleText.TextSize = 18
    self.titleText.TextXAlignment = Enum.TextXAlignment.Left
    self.titleText.Parent = self.titleBar
    
    -- 关闭按钮
    self.closeButton = Instance.new("TextButton")
    self.closeButton.Name = "CloseButton"
    self.closeButton.Size = UDim2.new(0, 30, 0, 30)
    self.closeButton.Position = UDim2.new(1, -40, 0, 5)
    self.closeButton.AnchorPoint = Vector2.new(1, 0)
    self.closeButton.BackgroundColor3 = self.Colors.Danger
    self.closeButton.Text = "×"
    self.closeButton.TextColor3 = self.Colors.Text
    self.closeButton.Font = Enum.Font.GothamBold
    self.closeButton.TextSize = 20
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = self.closeButton
    
    self.closeButton.MouseButton1Click:Connect(function()
        self:CloseUI()
    end)
    self.closeButton.Parent = self.titleBar
    
    -- 内容区域
    self.contentArea = Instance.new("Frame")
    self.contentArea.Name = "ContentArea"
    self.contentArea.Size = UDim2.new(1, 0, 1, -40)
    self.contentArea.Position = UDim2.new(0, 0, 0, 40)
    self.contentArea.BackgroundColor3 = self.Colors.Card
    self.contentArea.BorderSizePixel = 0
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 8)
    contentCorner.Parent = self.contentArea
    
    -- 左侧选项卡区域
    self.tabContainer = Instance.new("Frame")
    self.tabContainer.Name = "TabContainer"
    self.tabContainer.Size = UDim2.new(0, 180, 1, 0)
    self.tabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.tabContainer.BorderSizePixel = 0
    
    -- 右侧功能区域
    self.functionContainer = Instance.new("ScrollingFrame")
    self.functionContainer.Name = "FunctionContainer"
    self.functionContainer.Size = UDim2.new(1, -180, 1, 0)
    self.functionContainer.Position = UDim2.new(0, 180, 0, 0)
    self.functionContainer.BackgroundTransparency = 1
    self.functionContainer.BorderSizePixel = 0
    self.functionContainer.ScrollBarThickness = 4
    self.functionContainer.ScrollBarImageColor3 = self.Colors.Primary
    self.functionContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    -- 布局
    self.functionLayout = Instance.new("UIListLayout")
    self.functionLayout.Padding = UDim.new(0, 10)
    self.functionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    self.functionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.functionLayout.Parent = self.functionContainer
    
    -- 组装UI
    self.titleBar.Parent = self.mainContainer
    self.contentArea.Parent = self.mainContainer
    self.tabContainer.Parent = self.contentArea
    self.functionContainer.Parent = self.contentArea
    
    self.mainContainer.Parent = self.screenGui
end

-- 切换UI
function ModernUILibrary:ToggleUI()
    if self.isAnimating then return end
    self.isAnimating = true
    
    if self.isOpen then
        self:CloseUI()
    else
        self:OpenUI()
    end
end

-- 打开UI
function ModernUILibrary:OpenUI()
    -- 隐藏开关按钮
    self.loadingSquare.Visible = false
    
    -- 显示主容器
    self.mainContainer.Visible = true
    
    -- 第一步：移动到屏幕中心（弹跳效果）
    local moveTween = TweenService:Create(
        self.mainContainer,
        TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, -25, 0.5, -25)}
    )
    moveTween:Play()
    
    moveTween.Completed:Connect(function()
        -- 第二步：扩展为完整UI（弹性效果）
        local expandTween = TweenService:Create(
            self.mainContainer,
            TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
            {
                Size = self.size,
                Position = UDim2.new(0.5, -self.size.X.Offset/2, 0.5, -self.size.Y.Offset/2)
            }
        )
        expandTween:Play()
        
        expandTween.Completed:Connect(function()
            self.isOpen = true
            self.isAnimating = false
            
            -- 添加拖动功能
            self:MakeDraggable()
        end)
    end)
end

-- 关闭UI
function ModernUILibrary:CloseUI()
    -- 第一步：收缩为小方块（弹性效果）
    local shrinkTween = TweenService:Create(
        self.mainContainer,
        TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
        {
            Size = UDim2.new(0, 50, 0, 50),
            Position = UDim2.new(0.5, -25, 0.5, -25)
        }
    )
    shrinkTween:Play()
    
    shrinkTween.Completed:Connect(function()
        -- 第二步：移回开关按钮位置（弹跳效果）
        local moveTween = TweenService:Create(
            self.mainContainer,
            TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
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
function ModernUILibrary:MakeDraggable()
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

-- 创建选项卡
function ModernUILibrary:Tab(name, icon)
    local tab = {}
    setmetatable(tab, {__index = ModernUILibrary.Tab})
    
    tab.id = #self.tabs + 1
    tab.name = name
    tab.icon = icon
    tab.sections = {}
    
    -- 创建选项卡按钮
    local tabButton = Instance.new("TextButton")
    tabButton.Name = "Tab_" .. name
    tabButton.Size = UDim2.new(1, -20, 0, 40)
    tabButton.Position = UDim2.new(0, 10, 0, 10 + (tab.id-1) * 50)
    tabButton.BackgroundColor3 = self.Colors.Card
    tabButton.Text = ""
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = tabButton
    
    -- 选项卡图标
    local tabIcon = Instance.new("ImageLabel")
    tabIcon.Name = "Icon"
    tabIcon.Size = UDim2.new(0, 24, 0, 24)
    tabIcon.Position = UDim2.new(0, 10, 0.5, -12)
    tabIcon.BackgroundTransparency = 1
    tabIcon.Image = icon and "rbxassetid://" .. icon or "rbxassetid://10734958979"
    tabIcon.ImageColor3 = self.Colors.TextSecondary
    tabIcon.Parent = tabButton
    
    -- 选项卡名称
    local tabName = Instance.new("TextLabel")
    tabName.Name = "Name"
    tabName.Size = UDim2.new(1, -50, 1, 0)
    tabName.Position = UDim2.new(0, 44, 0, 0)
    tabName.BackgroundTransparency = 1
    tabName.Text = name
    tabName.TextColor3 = self.Colors.TextSecondary
    tabName.Font = Enum.Font.Gotham
    tabName.TextSize = 14
    tabName.TextXAlignment = Enum.TextXAlignment.Left
    tabName.Parent = tabButton
    
    -- 选中指示器
    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0, 4, 0, 20)
    indicator.Position = UDim2.new(1, -2, 0.5, -10)
    indicator.AnchorPoint = Vector2.new(1, 0.5)
    indicator.BackgroundColor3 = self.Colors.Primary
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
        if self.activeTab ~= tab.id then
            TweenService:Create(tabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            }):Play()
        end
    end)
    
    tabButton.MouseLeave:Connect(function()
        if self.activeTab ~= tab.id then
            TweenService:Create(tabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = self.Colors.Card
            }):Play()
        end
    end)
    
    tabButton.Parent = self.tabContainer
    
    tab.button = tabButton
    tab.indicator = indicator
    tab.parent = self
    
    table.insert(self.tabs, tab)
    
    -- 如果是第一个选项卡，设置为激活状态
    if tab.id == 1 then
        self.activeTab = 1
        self:SwitchTab(1)
    end
    
    return tab
end

-- 选项卡方法：创建功能区段
ModernUILibrary.Tab = {}

function ModernUILibrary.Tab:section(name, defaultOpen)
    local section = {}
    setmetatable(section, {__index = ModernUILibrary.Section})
    
    defaultOpen = defaultOpen == nil and true or defaultOpen
    
    -- 创建段容器
    local sectionContainer = Instance.new("Frame")
    sectionContainer.Name = "Section_" .. name
    sectionContainer.Size = UDim2.new(1, -40, 0, 0)
    sectionContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sectionContainer.BorderSizePixel = 0
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 8)
    sectionCorner.Parent = sectionContainer
    
    -- 段标题
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Name = "Title"
    sectionTitle.Size = UDim2.new(1, 0, 0, 40)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = name
    sectionTitle.TextColor3 = self.parent.Colors.Text
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextSize = 16
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.Parent = sectionContainer
    
    local titlePadding = Instance.new("UIPadding")
    titlePadding.PaddingLeft = UDim.new(0, 15)
    titlePadding.Parent = sectionTitle
    
    -- 展开/收起按钮
    local expandButton = Instance.new("TextButton")
    expandButton.Name = "ExpandButton"
    expandButton.Size = UDim2.new(0, 30, 0, 30)
    expandButton.Position = UDim2.new(1, -40, 0, 5)
    expandButton.AnchorPoint = Vector2.new(1, 0)
    expandButton.BackgroundTransparency = 1
    expandButton.Text = defaultOpen and "−" or "+"
    expandButton.TextColor3 = self.parent.Colors.Text
    expandButton.Font = Enum.Font.GothamBold
    expandButton.TextSize = 20
    expandButton.Parent = sectionContainer
    
    -- 内容容器
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "Content"
    contentContainer.Size = UDim2.new(1, -30, 0, 0)
    contentContainer.Position = UDim2.new(0, 15, 0, 40)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Visible = defaultOpen
    
    -- 内容布局
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Parent = contentContainer
    
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        contentContainer.Size = UDim2.new(1, -30, 0, contentLayout.AbsoluteContentSize.Y)
        sectionContainer.Size = UDim2.new(1, -40, 0, contentLayout.AbsoluteContentSize.Y + (defaultOpen and 50 or 0))
    end)
    
    contentContainer.Parent = sectionContainer
    
    -- 切换展开/收起
    expandButton.MouseButton1Click:Connect(function()
        defaultOpen = not defaultOpen
        contentContainer.Visible = defaultOpen
        expandButton.Text = defaultOpen and "−" or "+"
        
        if defaultOpen then
            sectionContainer.Size = UDim2.new(1, -40, 0, contentLayout.AbsoluteContentSize.Y + 50)
        else
            sectionContainer.Size = UDim2.new(1, -40, 0, 40)
        end
    end)
    
    section.container = sectionContainer
    section.content = contentContainer
    section.parent = self.parent
    
    table.insert(self.sections, section)
    
    -- 添加到功能区域
    sectionContainer.Parent = self.parent.functionContainer
    
    -- 更新滚动区域大小
    local function updateCanvasSize()
        local totalHeight = 0
        for _, child in pairs(self.parent.functionContainer:GetChildren()) do
            if child:IsA("Frame") then
                totalHeight = totalHeight + child.AbsoluteSize.Y + 10
            end
        end
        self.parent.functionContainer.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 20)
    end
    
    updateCanvasSize()
    local connection = contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)
    table.insert(self.parent.connections, connection)
    
    return section
end

-- 功能区段方法
ModernUILibrary.Section = {}

function ModernUILibrary.Section:Label(text)
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = self.parent.Colors.Text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = self.content
    
    return self
end

function ModernUILibrary.Section:Button(text, callback)
    local button = Instance.new("TextButton")
    button.Name = "Button_" .. text
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = self.parent.Colors.Primary
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.AutoButtonColor = false
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    -- 悬停效果
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = self.parent.Colors.Secondary
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = self.parent.Colors.Primary
        }):Play()
    end)
    
    -- 点击效果
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(1, -5, 0, 35)
        }):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(1, 0, 0, 40)
        }):Play()
    end)
    
    -- 点击事件
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    button.Parent = self.content
    
    return self
end

function ModernUILibrary.Section:Toggle(name, flag, defaultValue, callback)
    defaultValue = defaultValue or false
    flag = flag or name
    
    -- 存储状态
    self.parent.flags[flag] = defaultValue
    
    local toggleContainer = Instance.new("Frame")
    toggleContainer.Name = "Toggle_" .. name
    toggleContainer.Size = UDim2.new(1, 0, 0, 40)
    toggleContainer.BackgroundTransparency = 1
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Name = "Label"
    toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = name
    toggleLabel.TextColor3 = self.parent.Colors.Text
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextSize = 14
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.Parent = toggleContainer
    
    local toggleSwitch = Instance.new("Frame")
    toggleSwitch.Name = "Switch"
    toggleSwitch.Size = UDim2.new(0, 50, 0, 25)
    toggleSwitch.Position = UDim2.new(1, 0, 0.5, -12.5)
    toggleSwitch.AnchorPoint = Vector2.new(1, 0.5)
    toggleSwitch.BackgroundColor3 = self.parent.Colors.Card
    
    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(0, 12)
    switchCorner.Parent = toggleSwitch
    
    local toggleKnob = Instance.new("Frame")
    toggleKnob.Name = "Knob"
    toggleKnob.Size = UDim2.new(0, 21, 0, 21)
    toggleKnob.Position = UDim2.new(0, 2, 0, 2)
    toggleKnob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 10)
    knobCorner.Parent = toggleKnob
    
    toggleKnob.Parent = toggleSwitch
    toggleSwitch.Parent = toggleContainer
    
    -- 更新状态
    local function updateState()
        TweenService:Create(toggleSwitch, TweenInfo.new(0.3), {
            BackgroundColor3 = self.parent.flags[flag] and self.parent.Colors.Success or self.parent.Colors.Card
        }):Play()
        
        TweenService:Create(toggleKnob, TweenInfo.new(0.3), {
            Position = UDim2.new(0, self.parent.flags[flag] and 27 or 2, 0, 2)
        }):Play()
        
        if callback then
            callback(self.parent.flags[flag])
        end
    end
    
    -- 点击事件
    toggleSwitch.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.parent.flags[flag] = not self.parent.flags[flag]
            updateState()
        end
    end)
    
    -- 初始化状态
    updateState()
    
    toggleContainer.Parent = self.content
    
    return self
end

function ModernUILibrary.Section:Slider(name, flag, defaultValue, minValue, maxValue, precise, callback)
    minValue = minValue or 0
    maxValue = maxValue or 100
    defaultValue = defaultValue or minValue
    precise = precise or false
    flag = flag or name
    
    -- 存储状态
    self.parent.flags[flag] = defaultValue
    
    local sliderContainer = Instance.new("Frame")
    sliderContainer.Name = "Slider_" .. name
    sliderContainer.Size = UDim2.new(1, 0, 0, 60)
    sliderContainer.BackgroundTransparency = 1
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Name = "Label"
    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = name
    sliderLabel.TextColor3 = self.parent.Colors.Text
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.TextSize = 14
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.Parent = sliderContainer
    
    local sliderBar = Instance.new("Frame")
    sliderBar.Name = "Bar"
    sliderBar.Size = UDim2.new(1, 0, 0, 6)
    sliderBar.Position = UDim2.new(0, 0, 0, 30)
    sliderBar.BackgroundColor3 = self.parent.Colors.Card
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 3)
    barCorner.Parent = sliderBar
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
    sliderFill.BackgroundColor3 = self.parent.Colors.Primary
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 3)
    fillCorner.Parent = sliderFill
    
    sliderFill.Parent = sliderBar
    
    local sliderKnob = Instance.new("Frame")
    sliderKnob.Name = "Knob"
    sliderKnob.Size = UDim2.new(0, 16, 0, 16)
    sliderKnob.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -8, 0.5, -8)
    sliderKnob.AnchorPoint = Vector2.new(0, 0.5)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderKnob.BorderSizePixel = 2
    sliderKnob.BorderColor3 = self.parent.Colors.Primary
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 8)
    knobCorner.Parent = sliderKnob
    
    sliderKnob.Parent = sliderContainer
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Size = UDim2.new(0, 50, 0, 20)
    valueLabel.Position = UDim2.new(1, -50, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultValue)
    valueLabel.TextColor3 = self.parent.Colors.TextSecondary
    valueLabel.Font = Enum.Font.Gotham
    valueLabel.TextSize = 14
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
        slider
