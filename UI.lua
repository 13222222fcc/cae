--霖溺开源上传[假的]-Linni
repeat
    task.wait()
until game:IsLoaded()
local library = {}

local ToggleUI = false
library.currentTab = nil
library.flags = {}

local services =
    setmetatable(
    {},
    {
        __index = function(t, k)
            return game.GetService(game, k)
        end
    }
)

local mouse = services.Players.LocalPlayer:GetMouse()

local function createTween(obj, duration, easingStyle, easingDirection, properties)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle[easingStyle], Enum.EasingDirection[easingDirection])
    local tween = services.TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
    return tween
end

function Tween(obj, t, data)
    return createTween(obj, t[1], t[2], t[3], data)
end

local function createRipple(obj)
    if obj.ClipsDescendants ~= true then
        obj.ClipsDescendants = true
    end
    local Ripple = Instance.new("ImageLabel")
    Ripple.Name = "Ripple"
    Ripple.Parent = obj
    Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Ripple.BackgroundTransparency = 1.000
    Ripple.ZIndex = 8
    Ripple.Image = "rbxassetid://2708891598"
    Ripple.ImageTransparency = 0.800
    Ripple.ScaleType = Enum.ScaleType.Fit
    Ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
    return Ripple
end

function Ripple(obj)
    spawn(function()
        local ripple = createRipple(obj)
        Tween(ripple, {.3, "Linear", "InOut"}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
        Tween(obj, {0.1, "Sine", "InOut"}, {Size = UDim2.new(1.1, 0, 1.1, 0)})
        wait(0.15)
        Tween(ripple, {.3, "Linear", "InOut"}, {ImageTransparency = 1})
        Tween(obj, {0.1, "Sine", "InOut"}, {Size = UDim2.new(1, 0, 1, 0)})
        wait(.3)
        ripple:Destroy()
    end)
end

local toggled = false

local switchingTabs = false
local function tweenTabElement(element, transparency)
    services.TweenService:Create(element, TweenInfo.new(0.1), {ImageTransparency = transparency}):Play()
    services.TweenService:Create(element.TabText, TweenInfo.new(0.1), {TextTransparency = transparency}):Play()
end

function switchTab(new)

local ripple = Instance.new("Frame")
ripple.Parent = new[1]
ripple.BackgroundColor3 = Color3.fromHSV(tick()%5/5, 1, 1)
ripple.BackgroundTransparency = 0.7
ripple.Size = UDim2.new(0, 0, 0, 0)
ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
ripple.AnchorPoint = Vector2.new(0.5, 0.5)
ripple.ZIndex = 10

game:GetService("TweenService"):Create(
    ripple,
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }
):Play()

spawn(function()
    wait(0.5)
    ripple:Destroy()
end)
    if switchingTabs then
        return
    end
    local old = library.currentTab
    if old == nil then
        new[2].Visible = true
        library.currentTab = new
        tweenTabElement(new[1], 0)
        return
    end

    if old[1] == new[1] then
        return
    end
    switchingTabs = true
    library.currentTab = new

    tweenTabElement(old[1], 0.2)
    tweenTabElement(new[1], 0)

    old[2].Visible = false
    new[2].Visible = true

    task.wait(0.1)
    switchingTabs = false
end

function drag(frame, hold)
    if not hold then
        hold = frame
    end
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
    
        local delta = input.Position - dragStart
        frame.Position =
            UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    hold.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end
                )
            end
        end
    )

    frame.InputChanged:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end
    )

    services.UserInputService.InputChanged:Connect(
        function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end
    )
end

function library.new(library, name, theme)

    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "Linni" then
            v:Destroy()
        end
    end
    
MainXEColor = Color3.fromRGB(20, 20, 30)  
Background = Color3.fromRGB(40, 40, 60)  
zyColor = Color3.fromRGB(30, 30, 45)      
beijingColor = Color3.fromRGB(50, 50, 70) 

    
    local dogent = Instance.new("ScreenGui")
    
    
    local TabMainXE = Instance.new("Frame")
    local MainXEC = Instance.new("UICorner")
    local SB = Instance.new("Frame")
    local SBC = Instance.new("UICorner")
    local Side = Instance.new("Frame")
    local SideG = Instance.new("UIGradient")
    local TabBtns = Instance.new("ScrollingFrame")
    local TabBtnsL = Instance.new("UIListLayout")
    local ScriptTitle = Instance.new("TextLabel")
    local SBG = Instance.new("UIGradient")
    local Open = Instance.new("TextButton")
    local UIG = Instance.new("UIGradient")
    local DropShadowHolder = Instance.new("Frame")
    local DropShadow = Instance.new("ImageLabel")
    local UICornerMainXE = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local UIGradientTitle = Instance.new("UIGradient")
    
    local WelcomeLabel = Instance.new("TextLabel")
    
    
    
    if syn and syn.protect_gui then
        syn.protect_gui(dogent)
    end

    dogent.Name = "Linni"
    dogent.Parent = services.CoreGui

    function UiDestroy()
        dogent:Destroy()
    end   
    


    
    
    function ToggleUILib()
        if not ToggleUI then
            dogent.Enabled = false
            ToggleUI = true
        else
            ToggleUI = false
            dogent.Enabled = true
        end
    end
    local Language = {
       
        ["zh-cn"] = {
            WelcomeUI = "欢迎使用霖溺脚本",
            OpenUI = "打开UI",
            HideUI = "隐藏UI",
            Currently = "当前："
        }
    }
    local Players = game:GetService("Players")
    local XA = Players.LocalPlayer
    local userRegion = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(XA)

    local regionToLanguage = {
        ["CN"] = "zh-cn", 
    }




    local currentLanguage = Language[regionToLanguage[userRegion]] and regionToLanguage[userRegion] or "zh-cn"

local function createFrame(name, parent, anchorPoint, position, size, backgroundColor, zIndex, draggable)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Parent = parent
    frame.AnchorPoint = anchorPoint
    frame.Position = position
    frame.Size = size
    frame.BackgroundColor3 = backgroundColor
    frame.ZIndex = zIndex
    frame.Active = true
    frame.Draggable = draggable
    frame.Visible = true
    return frame
end

local MainXE = createFrame("MainXE", dogent, Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0, 0, 0, 0), MainXEColor, 1, true)  

local screenSize = services.Players.LocalPlayer:GetMouse().ViewSizeX
MainXE.Size = UDim2.new(0, math.clamp(screenSize * 0.8, 500, 800), 0, math.clamp(screenSize * 0.6, 400, 600))


local neonBorder = Instance.new("Frame")
neonBorder.Name = "NeonBorder"
neonBorder.Parent = MainXE
neonBorder.BackgroundTransparency = 1
neonBorder.Size = UDim2.new(1, 10, 1, 10)
neonBorder.Position = UDim2.new(0, -5, 0, -5)
neonBorder.ZIndex = 0

local borderGradient = Instance.new("UIGradient")
borderGradient.Parent = neonBorder
borderGradient.Rotation = 45
borderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
})

local borderTween = game:GetService("TweenService"):Create(
    borderGradient,
    TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
    {Rotation = 360}
)
borderTween:Play()

local stroke = Instance.new("UIStroke")
stroke.Parent = MainXE
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(0, 255, 255)
stroke.Transparency = 0.5
stroke.LineJoinMode = Enum.LineJoinMode.Round


local DynamicBG = Instance.new("Frame")
DynamicBG.Name = "DynamicBG"
DynamicBG.Parent = MainXE
DynamicBG.BackgroundColor3 = MainXEColor
DynamicBG.BackgroundTransparency = 0.7
DynamicBG.Size = UDim2.new(1, 0, 1, 0)
DynamicBG.ZIndex = -1  

local gridSize = 50
for y = 0, 1, 1/10 do  
    local line = Instance.new("Frame")
    line.Name = "GridLine_H_"..y
    line.Parent = DynamicBG
    line.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    line.BorderSizePixel = 0
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, y, 0)
    line.ZIndex = 0
end

local scanDot = Instance.new("Frame")
scanDot.Name = "ScanDot"
scanDot.Parent = DynamicBG
scanDot.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
scanDot.Size = UDim2.new(0, 6, 0, 6)
scanDot.Position = UDim2.new(0, 0, 0, 0)
scanDot.ZIndex = 2

spawn(function()
    while true do
        game:GetService("TweenService"):Create(
            scanDot,
            TweenInfo.new(2, Enum.EasingStyle.Linear),
            {Position = UDim2.new(1, -6, 0, 0)}
        ):Play()
        wait(2)
        game:GetService("TweenService"):Create(
            scanDot,
            TweenInfo.new(1, Enum.EasingStyle.Linear),
            {Position = UDim2.new(1, -6, 1, -6)}
        ):Play()
        wait(1)
        game:GetService("TweenService"):Create(
            scanDot,
            TweenInfo.new(2, Enum.EasingStyle.Linear),
            {Position = UDim2.new(0, 0, 0, 0)}
        ):Play()
        wait(1)
    end
end)
    
    WelcomeLabel.Name = "WelcomeLabel"
    WelcomeLabel.Parent = MainXE
    WelcomeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    WelcomeLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
    WelcomeLabel.Text = Language[currentLanguage].WelcomeUI
    WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeLabel.TextSize = 32
    WelcomeLabel.BackgroundTransparency = 1
    WelcomeLabel.TextTransparency = 1
    WelcomeLabel.TextStrokeTransparency = 0.5
    WelcomeLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    WelcomeLabel.Font = Enum.Font.GothamBold
    WelcomeLabel.Visible = true
    
    UICornerMainXE.Parent = MainXE
    UICornerMainXE.CornerRadius = UDim.new(0, 3)
    
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainXE
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.Position = UDim2.new(1, -5, 0, 5)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "❌"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.ZIndex = 10

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.1), {TextColor3 = Color3.fromRGB(255, 50, 50)}):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.1), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)

CloseButton.MouseButton1Click:Connect(function()
    dogent:Destroy()
end)



    DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = MainXE
    DropShadowHolder.BackgroundTransparency = 1.000
    DropShadowHolder.BorderSizePixel = 0
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.BorderColor3 = Color3.fromRGB(255, 255, 255)
    DropShadowHolder.ZIndex = 0

    DropShadow.Name = "DropShadow"
DropShadow.Parent = DropShadowHolder
DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
DropShadow.BackgroundTransparency = 1.000
DropShadow.BorderSizePixel = 0
DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)

MainXE:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    DropShadow.Size = UDim2.new(1, 50, 1, 50)
end)

DropShadow.ZIndex = 0
DropShadow.Image = "rbxassetid://6015897843"
DropShadow.ImageColor3 = Color3.fromRGB(255, 255, 255)
DropShadow.ImageTransparency = 0.2
    
    
    
    DropShadow.Size = UDim2.new(1, 43, 1, 43)
    
    
    DropShadow.ZIndex = 0
    DropShadow.Image = "rbxassetid://6015897843"
    DropShadow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    DropShadow.ImageTransparency = 0
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    UIGradient.Color = ColorSequence.new {
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 162, 255)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(155, 89, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 162, 255))
}
    UIGradient.Parent = DropShadow

    local TweenService = game:GetService("TweenService")
    
    local tweeninfo = TweenInfo.new(
    3,
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.InOut,
    -1
)
    
    local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360, Offset = Vector2.new(1, 0)})
tween:Play()

    function toggleui()
        toggled = not toggled
        spawn(
            function()
                if toggled then
                    wait(0.3)
                end
            end
        )
        Tween(
            MainXE,
            {0.3, "Sine", "InOut"},
            {
                Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
            }
        )
    end

    TabMainXE.Name = "TabMainXE"
    TabMainXE.Parent = MainXE
    TabMainXE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabMainXE.BackgroundTransparency = 1.000
    TabMainXE.Position = UDim2.new(0.217000037, 0, 0, 3)
    TabMainXE.Size = UDim2.new(0, 448, 0, 353)
    TabMainXE.Visible = false

    MainXEC.CornerRadius = UDim.new(0, 5.5)
    MainXEC.Name = "MainXEC"
    MainXEC.Parent = MainXE

    SB.Name = "SB"
    SB.Parent = MainXE
    SB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SB.BorderColor3 = MainXEColor
    SB.Size = UDim2.new(0, 0, 0, 0)

    SBC.CornerRadius = UDim.new(0, 6)
    SBC.Name = "SBC"
    SBC.Parent = SB

    Side.Name = "Side"
    Side.Parent = SB
    Side.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Side.BorderColor3 = Color3.fromRGB(255, 255, 255)
    Side.BorderSizePixel = 0
    Side.ClipsDescendants = true
    Side.Position = UDim2.new(1, 0, 0, 0)
    Side.Size = UDim2.new(0, 0, 0, 0)

    SideG.Color = ColorSequence.new {ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
    SideG.Rotation = 90
    SideG.Name = "SideG"
    SideG.Parent = Side
    
    
    
MainXE.Size = UDim2.new(0, 570, 0, 358)  
Side.Size = UDim2.new(0, 110, 0, 357)
SB.Size = UDim2.new(0, 8, 0, 357)
TabMainXE.Visible = true
UIGradient.Parent = DropShadow
WelcomeLabel.Visible = false
    
    
    TabBtns.Name = "TabBtns"
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabBtns.BackgroundTransparency = 1.000
    TabBtns.BorderSizePixel = 0
    
    
    TabBtns.Position = UDim2.new(0, 0, 0.15, 0)
    TabBtns.Size = UDim2.new(0, 110, 0, 300)
    TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabBtns.ScrollBarThickness = 0

    TabBtnsL.Name = "TabBtnsL"
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 12)

local SearchContainer = Instance.new("Frame")
SearchContainer.Name = "SearchContainer"
SearchContainer.Parent = Side
SearchContainer.BackgroundTransparency = 1
SearchContainer.Size = UDim2.new(1, 0, 0, 40)
SearchContainer.Position = UDim2.new(0, 0, 0.07, 0) 
local SearchBar = Instance.new("TextBox")
SearchBar.Name = "SearchBar"
SearchBar.Parent = SearchContainer
SearchBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SearchBar.BackgroundTransparency = 0.3
SearchBar.Size = UDim2.new(0.75, 0, 0, 30)
SearchBar.Position = UDim2.new(0.05, 0, 0, 0)
SearchBar.PlaceholderText = "搜索选项区..."
SearchBar.Text = ""
SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBar.Font = Enum.Font.GothamBold
SearchBar.TextSize = 14
SearchBar.ClearTextOnFocus = false

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchBar

local SearchPadding = Instance.new("UIPadding")
SearchPadding.PaddingLeft = UDim.new(0, 10)
SearchPadding.Parent = SearchBar

local SearchIcon = Instance.new("ImageLabel")
SearchIcon.Name = "SearchIcon"
SearchIcon.Parent = SearchBar
SearchIcon.Image = "rbxassetid://3926305904" 
SearchIcon.ImageColor3 = Color3.fromRGB(180, 180, 180)
SearchIcon.AnchorPoint = Vector2.new(1, 0.5)
SearchIcon.Position = UDim2.new(1, -8, 0.5, 0)
SearchIcon.Size = UDim2.new(0, 18, 0, 18)
SearchIcon.BackgroundTransparency = 1

local ClearButton = Instance.new("TextButton")
ClearButton.Name = "ClearButton"
ClearButton.Parent = SearchContainer
ClearButton.Text = "×"
ClearButton.TextColor3 = Color3.fromRGB(255, 100, 100)
ClearButton.BackgroundTransparency = 1
ClearButton.Font = Enum.Font.GothamBold
ClearButton.TextSize = 18

ClearButton.Position = UDim2.new(0.83, 0, 0, 5)
ClearButton.Visible = false

   ClearButton.Size = UDim2.new(0, 0, 0, 0)
   game:GetService("TweenService"):Create(
       ClearButton,
       TweenInfo.new(0.3),
       {Size = UDim2.new(0, 25, 0, 25)}
   ):Play()
SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
    local searchText = string.lower(SearchBar.Text)
    ClearButton.Visible = searchText ~= ""
    
    for _, child in ipairs(TabBtns:GetChildren()) do
        if child:IsA("ImageLabel") and child:FindFirstChild("TabText") then
            local tabName = string.lower(child.TabText.Text)
            child.Visible = searchText == "" or string.find(tabName, searchText)
        end
    end
end)

ClearButton.MouseButton1Click:Connect(function()
    SearchBar.Text = ""
    ClearButton.Visible = false
end)

SearchBar.Focused:Connect(function()
    game:GetService("TweenService"):Create(
        SearchBar,
        TweenInfo.new(0.2),
        {BackgroundTransparency = 0.1}
    ):Play()
    SearchIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
end)

SearchBar.FocusLost:Connect(function()
    game:GetService("TweenService"):Create(
        SearchBar,
        TweenInfo.new(0.2),
        {BackgroundTransparency = 0.3}
    ):Play()
    SearchIcon.ImageColor3 = Color3.fromRGB(180, 180, 180)
end)
    ScriptTitle.Name = "ScriptTitle"
    ScriptTitle.Parent = Side
    ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.BackgroundTransparency = 1.000
    ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
    ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
    ScriptTitle.Font = Enum.Font.GothamBold
    ScriptTitle.Text = name
    ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.TextSize = 14.000
    ScriptTitle.TextScaled = true
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left

    UIGradientTitle.Parent = ScriptTitle
    
ScriptTitle.TextTransparency = 0
ScriptTitle.TextStrokeTransparency = 0.5
ScriptTitle.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
ScriptTitle.ZIndex = 10

    local function NPLHKB_fake_script()
        local script = Instance.new("LocalScript", ScriptTitle)

        local button = script.Parent
        local gradient = button.UIGradient
        local ts = game:GetService("TweenService")
        local ti = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local offset = {Offset = Vector2.new(1, 0)}
        local create = ts:Create(gradient, ti, offset)
        local startingPos = Vector2.new(-1, 0)
        local list = {}
        local s, kpt = ColorSequence.new, ColorSequenceKeypoint.new
        local counter = 0
        local status = "down"
        gradient.Offset = startingPos
        local function rainbowColors()
            local sat, val = 255, 255
            for i = 1, 10 do
                local hue = i * 17
                table.insert(list, Color3.fromHSV(hue / 255, sat / 255, val / 255))
            end
        end
        rainbowColors()
        gradient.Color =
            s(
            {
                kpt(0, list[#list]),
                kpt(0.5, list[#list - 1]),
                kpt(1, list[#list - 2])
            }
        )
        counter = #list
        local function animate()
            create:Play()
            create.Completed:Wait()
            gradient.Offset = startingPos
            gradient.Rotation = 180
            if counter == #list - 1 and status == "down" then
                gradient.Color =
                    s(
                    {
                        kpt(0, gradient.Color.Keypoints[1].Value),
                        kpt(0.5, list[#list]),
                        kpt(1, list[1])
                    }
                )
                counter = 1
                status = "up"
            elseif counter == #list and status == "down" then
                gradient.Color =
                    s(
                    {
                        kpt(0, gradient.Color.Keypoints[1].Value),
                        kpt(0.5, list[1]),
                        kpt(1, list[2])
                    }
                )
                counter = 2
                status = "up"
            elseif counter <= #list - 2 and status == "down" then
                gradient.Color =
                    s(
                    {
                        kpt(0, gradient.Color.Keypoints[1].Value),
                        kpt(0.5, list[counter + 1]),
                        kpt(1, list[counter + 2])
                    }
                )
                counter = counter + 2
                status = "up"
            end
            create:Play()
            create.Completed:Wait()
            gradient.Offset = startingPos
            gradient.Rotation = 0
            if counter == #list - 1 and status == "up" then
                gradient.Color =
                    s(
                    {
                        kpt(0, list[1]),
                        kpt(0.5, list[#list]),
                        kpt(1, gradient.Color.Keypoints[3].Value)
                    }
                )
                counter = 1
                status = "down"
            elseif counter == #list and status == "up" then
                gradient.Color =
                    s(
                    {
                        kpt(0, list[2]),
                        kpt(0.5, list[1]),
                        kpt(1, gradient.Color.Keypoints[3].Value)
                    }
                )
                counter = 2
                status = "down"
            elseif counter <= #list - 2 and status == "up" then
                gradient.Color =
                    s(
                    {
                        kpt(0, list[counter + 2]),
                        kpt(0.5, list[counter + 1]),
                        kpt(1, gradient.Color.Keypoints[3].Value)
                    }
                )
                counter = counter + 2
                status = "down"
            end
            animate()
        end
        animate()
    end
    coroutine.wrap(NPLHKB_fake_script)()

    SBG.Color = ColorSequence.new {ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
    SBG.Rotation = 90
    SBG.Name = "SBG"
    SBG.Parent = SB

    TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
        function()
            TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
        end
    )
    local TweenService = game:GetService("TweenService")

Open.Name = "Open"
Open.Parent = dogent
Open.BackgroundColor3 = Color3.fromRGB(28, 33, 55)
Open.BackgroundTransparency = 0
Open.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
Open.Size = UDim2.new(0, 61, 0, 32)
Open.Transparency = 0.75
Open.Font = Enum.Font.GothamBold
Open.Text = Language[currentLanguage].HideUI
Open.TextColor3 = Color3.fromRGB(255, 255, 255)
Open.TextTransparency = 0
Open.TextSize = 28.000
Open.Active = true
Open.Draggable = true

local OpenGradient = Instance.new("UIGradient")
OpenGradient.Parent = Open
OpenGradient.Rotation = 90
OpenGradient.Color = ColorSequence.new {
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 162, 255)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(155, 89, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 162, 255))
}

local TweenService = game:GetService("TweenService")

local function startGradientTween(gradient)
    local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1)
    local tween = TweenService:Create(gradient, tweenInfo, {Rotation = 360, Offset = Vector2.new(1, 0)})
    tween:Play()
    return tween
end

    local uihide = false

    local function Fakerainbow()
        while true do
            for i = 0, 1, 0.01 do
                local hue = tick() % 10 / 10
                Open.TextColor3 = Color3.fromHSV(hue, 1, 1)
                wait(0.005)
            end
        end
    end
    
    spawn(Fakerainbow)

    Open.MouseButton1Click:Connect(function()
        if uihide == false then
            Open.Text = Language[currentLanguage].OpenUI
            TabMainXE.Position = UDim2.new(0.217000037, 0, 0, 3)
            uihide = true
            MainXE.Visible = false
        else
            Open.Text = Language[currentLanguage].HideUI
            TabMainXE.Position = UDim2.new(0.217000037, 0, 0, 3)
            MainXE.Visible = true
            uihide = false
        end
    end)

    drag(MainXE)

    UIG.Parent = Open

    local window = {}
    function window.Tab(window, name, icon)
        local Tab = Instance.new("ScrollingFrame")
        local TabIco = Instance.new("ImageLabel")
        local TabText = Instance.new("TextLabel")
        local TabBtn = Instance.new("TextButton")
        local TabL = Instance.new("UIListLayout")

        Tab.Name = "Tab"
        Tab.Parent = TabMainXE
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 2
        Tab.Visible = false

        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 24, 0, 24)
        TabIco.Image = ("rbxassetid://103514147451766"):format((icon or 4370341699))
        TabIco.ImageTransparency = 0.2

        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
        TabText.Size = UDim2.new(0, 76, 0, 24)
        TabText.Font = Enum.Font.GothamBold
        TabText.Text = name
        TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabText.TextSize = 14.000
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.2

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 110, 0, 24)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000
local SectionSearchContainer = Instance.new("Frame")
SectionSearchContainer.Name = "SectionSearchContainer"
SectionSearchContainer.Parent = Tab
SectionSearchContainer.BackgroundTransparency = 1
SectionSearchContainer.Size = UDim2.new(1, -10, 0, 40)
SectionSearchContainer.Position = UDim2.new(0, 5, 0, 5)

local SectionSearchBar = Instance.new("TextBox")
SectionSearchBar.Name = "SectionSearchBar"
SectionSearchBar.Parent = SectionSearchContainer
SectionSearchBar.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
SectionSearchBar.BackgroundTransparency = 0.3
SectionSearchBar.Size = UDim2.new(1, -60, 0, 30) 
SectionSearchBar.PlaceholderText = "搜索本页功能名..."
SectionSearchBar.Text = ""
SectionSearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
SectionSearchBar.Font = Enum.Font.GothamBold
SectionSearchBar.TextSize = 14
SectionSearchBar.ClearTextOnFocus = false

local SectionSearchCorner = Instance.new("UICorner")
SectionSearchCorner.CornerRadius = UDim.new(0, 6)
SectionSearchCorner.Parent = SectionSearchBar

local SectionSearchPadding = Instance.new("UIPadding")
SectionSearchPadding.PaddingLeft = UDim.new(0, 10)
SectionSearchPadding.Parent = SectionSearchBar

local ClearButton = Instance.new("TextButton")
ClearButton.Name = "ClearButton"
ClearButton.Parent = SectionSearchContainer
ClearButton.Text = "×"
ClearButton.TextColor3 = Color3.fromRGB(255, 100, 100)
ClearButton.BackgroundTransparency = 1
ClearButton.Font = Enum.Font.GothamBold
ClearButton.TextSize = 18
ClearButton.Size = UDim2.new(0, 25, 0, 25)
ClearButton.Position = UDim2.new(1, -30, 0, 2)
ClearButton.Visible = false

local MatchCount = Instance.new("TextLabel")
MatchCount.Name = "MatchCount"
MatchCount.Parent = SectionSearchContainer
MatchCount.Text = "0结果"
MatchCount.TextColor3 = Color3.fromRGB(180, 180, 180)
MatchCount.BackgroundTransparency = 1
MatchCount.Font = Enum.Font.GothamMedium
MatchCount.TextSize = 12
MatchCount.Size = UDim2.new(0, 50, 0, 20)
MatchCount.Position = UDim2.new(1, -55, 0, 15)
MatchCount.TextXAlignment = Enum.TextXAlignment.Right


local function updateSearch()
    local searchText = SectionSearchBar and string.lower(SectionSearchBar.Text or "") or ""
if ClearButton then
    ClearButton.Visible = searchText ~= ""
end
    
    local matchCount = 0
    for _, section in ipairs(Tab:GetChildren()) do
        if section:IsA("Frame") and section.Name == "Section" then
            local sectionMatch = false
            
            if string.find(string.lower(section.SectionText.Text), searchText) then
                sectionMatch = true
                matchCount += 1
            end
            
            local controlMatches = 0
            if section.Objs then
                for _, obj in ipairs(section.Objs:GetChildren()) do
                    if obj:IsA("Frame") then
                       
                        local found = false
                        
                        local btn = obj:FindFirstChildOfClass("TextButton")
                        if btn and btn.Text and string.find(string.lower(btn.Text), searchText) then
                            found = true
                        end
                        
                        local label = obj:FindFirstChildOfClass("TextLabel")
                        if label and label.Text and string.find(string.lower(label.Text), searchText) then
                            found = true
                        end
                        
                        local textbox = obj:FindFirstChildOfClass("TextBox")
                        if textbox and (textbox.Text or textbox.PlaceholderText) then
                            if string.find(string.lower(textbox.Text), searchText) or 
                               string.find(string.lower(textbox.PlaceholderText), searchText) then
                                found = true
                            end
                        end
                        
                        local sliderValue = obj:FindFirstChild("SliderValue")
                        if sliderValue and sliderValue.Text and string.find(string.lower(sliderValue.Text), searchText) then
                            found = true
                        end
                        
                        local dropdownText = obj:FindFirstChild("DropdownText")
                        if dropdownText and dropdownText.Text and string.find(string.lower(dropdownText.Text), searchText) then
                            found = true
                        end
                        
                        if obj.Name and string.find(string.lower(obj.Name), searchText) then
                            found = true
                        end
                        
                        obj.Visible = found or searchText == ""
                        if found then 
                            controlMatches += 1
                            matchCount += 1
                        end
                    end
                end
            end
            
            section.Visible = sectionMatch or controlMatches > 0 or searchText == ""
        end
    end
    
    MatchCount.Text = (searchText == "" and "就绪" or matchCount.."个结果")
end







SectionSearchBar:GetPropertyChangedSignal("Text"):Connect(updateSearch)

ClearButton.MouseButton1Click:Connect(function()
    SectionSearchBar.Text = ""
    ClearButton.Visible = false
    updateSearch()
end)

SectionSearchBar.Focused:Connect(function()
    game:GetService("TweenService"):Create(
        SectionSearchBar,
        TweenInfo.new(0.2),
        {BackgroundTransparency = 0.1}
    ):Play()
    MatchCount.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

SectionSearchBar.FocusLost:Connect(function()
    game:GetService("TweenService"):Create(
        SectionSearchBar,
        TweenInfo.new(0.2),
        {BackgroundTransparency = 0.3}
    ):Play()
    MatchCount.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

local TabL = Instance.new("UIListLayout")
TabL.Name = "TabL"
TabL.Parent = Tab
TabL.SortOrder = Enum.SortOrder.LayoutOrder
TabL.Padding = UDim.new(0, 4)
TabL.VerticalAlignment = Enum.VerticalAlignment.Top
TabL.Padding = UDim.new(0, 8)


        TabBtn.MouseButton1Click:Connect(
            function()
                spawn(
                    function()
                        Ripple(TabBtn)
                    end
                )
                switchTab({TabIco, Tab})
            end
        )

        if library.currentTab == nil then
            switchTab({TabIco, Tab})
        end

        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
            function()
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
            end
        )

        local tab = {}
        function tab.section(tab, name, TabVal)
            local Section = Instance.new("Frame")
            local SectionC = Instance.new("UICorner")
            local SectionText = Instance.new("TextLabel")
            local SectionOpen = Instance.new("ImageLabel")
            local SectionOpened = Instance.new("ImageLabel")
            local SectionToggle = Instance.new("ImageButton")
            local Objs = Instance.new("Frame")
            local ObjsL = Instance.new("UIListLayout")

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = zyColor
            Section.BackgroundTransparency = 1.000
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(0.981000006, 0, 0, 36)

            SectionC.CornerRadius = UDim.new(0, 6)
            SectionC.Name = "SectionC"
            SectionC.Parent = Section

            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.BackgroundTransparency = 1.000
            SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
            SectionText.Size = UDim2.new(0, 401, 0, 36)
            SectionText.Font = Enum.Font.GothamBold
            SectionText.Text = name
            SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.TextSize = 16.000
            SectionText.TextXAlignment = Enum.TextXAlignment.Left

            SectionOpen.Name = "SectionOpen"
            SectionOpen.Parent = SectionText
            SectionOpen.BackgroundTransparency = 1
            SectionOpen.BorderSizePixel = 0
            SectionOpen.Position = UDim2.new(0, -33, 0, 5)
            SectionOpen.Size = UDim2.new(0, 26, 0, 26)
            SectionOpen.Image = "http://www.roblox.com/asset/?id=6031302934"

            SectionOpened.Name = "SectionOpened"
            SectionOpened.Parent = SectionOpen
            SectionOpened.BackgroundTransparency = 1.000
            SectionOpened.BorderSizePixel = 0
            SectionOpened.Size = UDim2.new(0, 26, 0, 26)
            SectionOpened.Image = "http://www.roblox.com/asset/?id=6031302932"
            SectionOpened.ImageTransparency = 1.000

            SectionToggle.Name = "SectionToggle"
            SectionToggle.Parent = SectionOpen
            SectionToggle.BackgroundTransparency = 1
            SectionToggle.BorderSizePixel = 0
            SectionToggle.Size = UDim2.new(0, 26, 0, 26)

            Objs.Name = "Objs"
            Objs.Parent = Section
            Objs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Objs.BackgroundTransparency = 1
            Objs.BorderSizePixel = 0
            Objs.Position = UDim2.new(0, 6, 0, 36)
            Objs.Size = UDim2.new(0.986347735, 0, 0, 0)

            ObjsL.Name = "ObjsL"
            ObjsL.Parent = Objs
            ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
            ObjsL.Padding = UDim.new(0, 8)

            local open = TabVal
            if TabVal ~= false then
                Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
                SectionOpened.ImageTransparency = (open and 0 or 1)
                SectionOpen.ImageTransparency = (open and 1 or 0)
            end

            SectionToggle.MouseButton1Click:Connect(
                function()
                    open = not open
                    Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
                    SectionOpened.ImageTransparency = (open and 0 or 1)
                    SectionOpen.ImageTransparency = (open and 1 or 0)
                end
            )

            ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                function()
                    if not open then
                        return
                    end
                    Section.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 8)
                end
            )

            local section = {}
            
function section.Button(section, text, callback)

        local callback = callback or function() end

    local BtnModule = Instance.new("Frame")
    local Btn = Instance.new("TextButton")
    local BtnC = Instance.new("UICorner")

    BtnModule.Name = "BtnModule"
    BtnModule.Parent = Objs
    BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BtnModule.BackgroundTransparency = 0.2
    BtnModule.BorderSizePixel = 0
    BtnModule.Position = UDim2.new(0, 0, 0, 0)
    BtnModule.Size = UDim2.new(0, 428, 0, 38)

    Btn.Name = "Btn"
    Btn.Parent = BtnModule
    Btn.BackgroundColor3 = zyColor
    Btn.BorderSizePixel = 0
    Btn.Size = UDim2.new(0, 428, 0, 38)
    Btn.AutoButtonColor = false
    Btn.Font = Enum.Font.GothamBold
    Btn.Text = "   " .. text
    Btn.TextColor3 = Color3.fromRGB(0,255,255)
    Btn.TextSize = 16.000
    Btn.TextXAlignment = Enum.TextXAlignment.Left

    BtnC.CornerRadius = UDim.new(0, 6)
    BtnC.Name = "BtnC"
    BtnC.Parent = Btn

Btn.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        Btn,
        TweenInfo.new(0.2),
        {Size = UDim2.new(0, 438, 0, 42)}  
    ):Play()
end)

Btn.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        Btn,
        TweenInfo.new(0.2),
        {Size = UDim2.new(0, 428, 0, 38)}  
    ):Play()
end)
    Btn.MouseButton1Click:Connect(
        function()
            spawn(
                function()
                    Ripple(Btn)
                end
            )
            Tween(
                Btn,
                {0.1, "Sine", "InOut"},
                {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}
            )
            wait(0.1)
            Tween(
                Btn,
                {0.1, "Sine", "InOut"},
                {BackgroundColor3 = zyColor}
            )
            spawn(callback)
        end
    )
end

            function section:LabelTransparency(text)
            
                local LabelModuleE = Instance.new("Frame")
                local TextLabelE = Instance.new("TextLabel")
                local LabelCE = Instance.new("UICorner")

                LabelModuleE.Name = "LabelModuleE"
                LabelModuleE.Parent = Objs
                LabelModuleE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelModuleE.BackgroundTransparency = 1.000
                LabelModuleE.BorderSizePixel = 0
                LabelModuleE.Position = UDim2.new(0, 0, NAN, 0)
                LabelModuleE.Size = UDim2.new(0, 428, 0, 19)

                TextLabel.Parent = LabelModuleE
                TextLabel.BackgroundColor3 = zyColor
                TextLabel.Size = UDim2.new(0, 428, 0, 22)
                TextLabel.Font = Enum.Font.GothamBold
                TextLabel.Transparency = 0
                TextLabel.Text = "   "..textAT
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.TextSize = 14.000
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left

                LabelC.CornerRadius = UDim.new(0, 6)
                LabelC.Name = "LabelC"
                LabelC.Parent = TextLabel
                return TextLabel
            end

function section:Label(text)
local scanner = Instance.new("Frame")
scanner.Parent = TextLabelE
scanner.BackgroundColor3 = Color3.fromRGB(0,255,255)
scanner.Size = UDim2.new(0,0,1,2)
scanner.Position = UDim2.new(0,0,0,-1)
scanner.ZIndex = -1

spawn(function()
    while wait(1) do
        scanner:TweenPosition(UDim2.new(1,0,0,-1), "Out", "Linear", 0.5)
        wait(0.5)
        scanner.Position = UDim2.new(0,0,0,-1)
    end
end)
    local LabelModule = Instance.new("Frame")
    local TextLabelE = Instance.new("TextLabel")
    local LabelCE = Instance.new("UICorner")

    LabelModule.Name = "LabelModule"
    LabelModule.Parent = Objs
    LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LabelModule.BackgroundTransparency = 1.000
    LabelModule.BorderSizePixel = 0
    LabelModule.Position = UDim2.new(0, 0, NAN, 0)
    LabelModule.Size = UDim2.new(0, 428, 0, 19)

    TextLabelE.Parent = LabelModule
    TextLabelE.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    TextLabelE.Size = UDim2.new(0, 428, 0, 22)
    TextLabelE.Font = Enum.Font.GothamBold
    TextLabelE.Text = "   "..text
    TextLabelE.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabelE.TextSize = 14.000
    TextLabelE.TextXAlignment = Enum.TextXAlignment.Left

    LabelCE.CornerRadius = UDim.new(0, 6)
    LabelCE.Name = "LabelCE"
    LabelCE.Parent = TextLabelE
    return TextLabelE
end
            

            function section.Toggle(section, text, flag, enabled, callback)
                local callback = callback or function()
                    end
                local enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                library.flags[flag] = enabled

                local ToggleModule = Instance.new("Frame")
                local ToggleBtn = Instance.new("TextButton")
                local ToggleBtnC = Instance.new("UICorner")
                local ToggleDisable = Instance.new("Frame")
                local ToggleSwitch = Instance.new("Frame")
                local ToggleSwitchC = Instance.new("UICorner")
                local ToggleDisableC = Instance.new("UICorner")

                ToggleModule.Name = "ToggleModule"
                ToggleModule.Parent = Objs
                ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleModule.BackgroundTransparency = 1.000
                ToggleModule.BorderSizePixel = 0
                ToggleModule.Position = UDim2.new(0, 0, 0, 0)
                ToggleModule.Size = UDim2.new(0, 428, 0, 38)

                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = ToggleModule
                ToggleBtn.BackgroundColor3 = zyColor
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Size = UDim2.new(0, 428, 0, 38)
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Font = Enum.Font.GothamBold
                ToggleBtn.Text = "   " .. text
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleBtn.TextSize = 16.000
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left

                ToggleBtnC.CornerRadius = UDim.new(0, 6)
                ToggleBtnC.Name = "ToggleBtnC"
                ToggleBtnC.Parent = ToggleBtn

                ToggleDisable.Name = "ToggleDisable"
                ToggleDisable.Parent = ToggleBtn
                ToggleDisable.BackgroundColor3 = Background
                ToggleDisable.BorderSizePixel = 0
                ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
                ToggleDisable.Size = UDim2.new(0, 36, 0, 22)

                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = ToggleDisable
                
local toggleGradient = Instance.new("UIGradient")
toggleGradient.Parent = ToggleSwitch
toggleGradient.Rotation = 90
toggleGradient.Color = ColorSequence.new ({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 162, 255)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(155, 89, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 162, 255))
})

spawn(function()
    while wait(0.5) do
        game:GetService("TweenService"):Create(
            ToggleSwitch,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 26, 0, 22)}
        ):Play()
        wait(0.3)
        game:GetService("TweenService"):Create(
            ToggleSwitch,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 24, 0, 22)}
        ):Play()
    end
end)
                ToggleSwitch.Size = UDim2.new(0, 24, 0, 22)

                ToggleSwitchC.CornerRadius = UDim.new(0, 6)
                ToggleSwitchC.Name = "ToggleSwitchC"
                ToggleSwitchC.Parent = ToggleSwitch

                ToggleDisableC.CornerRadius = UDim.new(0, 6)
                ToggleDisableC.Name = "ToggleDisableC"
                ToggleDisableC.Parent = ToggleDisable

                local funcs = {
                    SetState = function(self, state)
                        if state == nil then
                            state = not library.flags[flag]
                        end
                        if library.flags[flag] == state then
                            return
                        end
                        services.TweenService:Create(
                            ToggleSwitch,
                            TweenInfo.new(0.2),
                            {
                                Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0),
                                BackgroundColor3 = (state and Color3.fromRGB(255, 255, 255) or beijingColor)
                            }
                        ):Play()
                        library.flags[flag] = state
                        callback(state)
                    end,
                    Module = ToggleModule
                }

                if enabled ~= false then
                    funcs:SetState(flag, true)
                end
local gradient = Instance.new("UIGradient")
    gradient.Parent = parent
    gradient.Rotation = 90
    gradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 255)),  
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 200, 255)),  
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255))   
    }

    local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1)
    local tween = TweenService:Create(gradient, tweenInfo, {Rotation = 360, Offset = Vector2.new(1, 0)})
    tween:Play()

    local stroke = Instance.new("UIStroke")
    stroke.Parent = ToggleBtn
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local borderGradient = Instance.new("UIGradient")
    borderGradient.Parent = stroke
    borderGradient.Rotation = 90
    borderGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
    }

    local borderTween = TweenService:Create(borderGradient, tweenInfo, {Rotation = 360, Offset = Vector2.new(1, 0)})
    borderTween:Play()

    ToggleBtn.MouseButton1Click:Connect(
        function()
            funcs:SetState()
        end
    )
    return funcs
end

            function section.Keybind(section, text, default, callback)
                local callback = callback or function()
                    end
                assert(text, "No text provided")
                assert(default, "No default key provided")

                local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
                local banned = {
                    Return = true,
                    Space = true,
                    Tab = true,
                    Backquote = true,
                    CapsLock = true,
                    Escape = true,
                    Unknown = true
                }
                local shortNames = {
                    RightControl = "Right Ctrl",
                    LeftControl = "Left Ctrl",
                    LeftShift = "Left Shift",
                    RightShift = "Right Shift",
                    Semicolon = ";",
                    Quote = '"',
                    LeftBracket = "[",
                    RightBracket = "]",
                    Equals = "=",
                    Minus = "-",
                    RightAlt = "Right Alt",
                    LeftAlt = "Left Alt"
                }

                local bindKey = default
                local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")

                local KeybindModule = Instance.new("Frame")
                local KeybindBtn = Instance.new("TextButton")
                local KeybindBtnC = Instance.new("UICorner")
                local KeybindValue = Instance.new("TextButton")
                local KeybindValueC = Instance.new("UICorner")
                local KeybindL = Instance.new("UIListLayout")
                local UIPadding = Instance.new("UIPadding")

                KeybindModule.Name = "KeybindModule"
                KeybindModule.Parent = Objs
                KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindModule.BackgroundTransparency = 1.000
                KeybindModule.BorderSizePixel = 0
                KeybindModule.Position = UDim2.new(0, 0, 0, 0)
                KeybindModule.Size = UDim2.new(0, 428, 0, 38)

                KeybindBtn.Name = "KeybindBtn"
                KeybindBtn.Parent = KeybindModule
                KeybindBtn.BackgroundColor3 = zyColor
                KeybindBtn.BorderSizePixel = 0
                KeybindBtn.Size = UDim2.new(0, 428, 0, 38)
                KeybindBtn.AutoButtonColor = false
                KeybindBtn.Font = Enum.Font.GothamBold
                KeybindBtn.Text = "   " .. text
                KeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindBtn.TextSize = 16.000
                KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left

                KeybindBtnC.CornerRadius = UDim.new(0, 6)
                KeybindBtnC.Name = "KeybindBtnC"
                KeybindBtnC.Parent = KeybindBtn

                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = KeybindBtn
                KeybindValue.BackgroundColor3 = Background
                KeybindValue.BorderSizePixel = 0
                KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                KeybindValue.Size = UDim2.new(0, 100, 0, 28)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.GothamBold
                KeybindValue.Text = keyTxt
                KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindValue.TextSize = 14.000

                KeybindValueC.CornerRadius = UDim.new(0, 6)
                KeybindValueC.Name = "KeybindValueC"
                KeybindValueC.Parent = KeybindValue

                KeybindL.Name = "KeybindL"
                KeybindL.Parent = KeybindBtn
                KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
                KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center

                UIPadding.Parent = KeybindBtn
                UIPadding.PaddingRight = UDim.new(0, 6)

                services.UserInputService.InputBegan:Connect(
                    function(inp, gpe)
                        if gpe then
                            return
                        end
                        if inp.UserInputType ~= Enum.UserInputType.Keyboard then
                            return
                        end
                        if inp.KeyCode ~= bindKey then
                            return
                        end
                        callback(bindKey.Name)
                    end
                )

                KeybindValue.MouseButton1Click:Connect(
                    function()
                        KeybindValue.Text = "..."
                        wait()
                        local key, uwu = services.UserInputService.InputEnded:Wait()
                        local keyName = tostring(key.KeyCode.Name)
                        if key.UserInputType ~= Enum.UserInputType.Keyboard then
                            KeybindValue.Text = keyTxt
                            return
                        end
                        if banned[keyName] then
                            KeybindValue.Text = keyTxt
                            return
                        end
                        wait()
                        bindKey = Enum.KeyCode[keyName]
                        KeybindValue.Text = shortNames[keyName] or keyName
                    end
                )

                KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(
                    function()
                        KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
                    end
                )
                KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
            end

                function section.Textbox(section, text, flag, default, callback)
                    local callback = callback or function() end
                    assert(text, "No text provided")
                    assert(flag, "No flag provided")
                    assert(default, "No default text provided")

                    library.flags[flag] = default

                    local TextboxModule = Instance.new("Frame")
                    local TextboxBack = Instance.new("TextButton")
                    local TextboxBackC = Instance.new("UICorner")
                    local BoxBG = Instance.new("TextButton")
                    local BoxBGC = Instance.new("UICorner")
                    local TextBox = Instance.new("TextBox")
                    local TextboxBackL = Instance.new("UIListLayout")
                    local TextboxBackP = Instance.new("UIPadding")

                    TextboxModule.Name = "TextboxModule"
        TextboxModule.Parent = Objs
        TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextboxModule.BackgroundTransparency = 1.000
        TextboxModule.BorderSizePixel = 0
        TextboxModule.Position = UDim2.new(0, 0, 0, 0)
        TextboxModule.Size = UDim2.new(0, 428, 0, 38)

        TextboxBack.Name = "TextboxBack"
        TextboxBack.Parent = TextboxModule
        TextboxBack.BackgroundColor3 = zyColor
        TextboxBack.BorderSizePixel = 0
        TextboxBack.Size = UDim2.new(0, 428, 0, 38)
        TextboxBack.AutoButtonColor = false
        TextboxBack.Font = Enum.Font.GothamBold
        TextboxBack.Text = "   " .. text
        TextboxBack.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextboxBack.TextSize = 16.000
        TextboxBack.TextXAlignment = Enum.TextXAlignment.Left

        TextboxBackC.CornerRadius = UDim.new(0, 6)
        TextboxBackC.Name = "TextboxBackC"
        TextboxBackC.Parent = TextboxBack

        BoxBG.Name = "BoxBG"
        BoxBG.Parent = TextboxBack
       
local textboxGradient = Instance.new("UIGradient")
textboxGradient.Parent = BoxBG
textboxGradient.Rotation = 90
textboxGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 120))
})

TextBox.Focused:Connect(function()
    game:GetService("TweenService"):Create(
        textboxGradient,
        TweenInfo.new(0.3),
        {Rotation = 180, Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 100, 200)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 250))
        })}
    ):Play()
end)

TextBox.FocusLost:Connect(function()
    game:GetService("TweenService"):Create(
        textboxGradient,
        TweenInfo.new(0.3),
        {Rotation = 90, Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 100)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 120))
        })}
    ):Play()
end)
        BoxBG.BorderSizePixel = 0
        BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
        BoxBG.Size = UDim2.new(0, 100, 0, 28)
        BoxBG.AutoButtonColor = false
        BoxBG.Font = Enum.Font.GothamBold
        BoxBG.Text = ""
        BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
        BoxBG.TextSize = 14.000

        BoxBGC.CornerRadius = UDim.new(0, 6)
        BoxBGC.Name = "BoxBGC"
        BoxBGC.Parent = BoxBG

        TextBox.Parent = BoxBG
        TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.BackgroundTransparency = 1.000
        TextBox.BorderSizePixel = 0
        TextBox.Size = UDim2.new(1, 0, 1, 0) 
        TextBox.Font = Enum.Font.GothamBold
        TextBox.Text = default
        TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.TextSize = 14.000
        TextBox.TextXAlignment = Enum.TextXAlignment.Left

        TextboxBackL.Name = "TextboxBackL"
        TextboxBackL.Parent = TextboxBack
        TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
        TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
        TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center

        TextboxBackP.Name = "TextboxBackP"
        TextboxBackP.Parent = TextboxBack
        TextboxBackP.PaddingRight = UDim.new(0, 6)


            TextBox.FocusLost:Connect(function()
                if TextBox.Text == "" then
                    TextBox.Text = default
                end
                library.flags[flag] = TextBox.Text
                callback(TextBox.Text)
            end)

            TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
                local newWidth = TextBox.TextBounds.X + 30 
                local maxWidth = 325
                local minWidth = 100

                BoxBG.Size = UDim2.new(0, math.clamp(newWidth, minWidth, maxWidth), 0, 28)
        
                TextBox.TextXAlignment = Enum.TextXAlignment.Left
            end)

            BoxBG.Size = UDim2.new(0, math.clamp(TextBox.TextBounds.X + 30, 100, 325), 0, 28)
        end


            function section.Slider(section, text, flag, default, min, max, precise, callback)
                local callback = callback or function()
                    end
                local min = min or 1
                local max = max or 10
                local default = default or min
                local precise = precise or false

                library.flags[flag] = default

                assert(text, "No text provided")
                assert(flag, "No flag provided")
                assert(default, "No default value provided")

                local SliderModule = Instance.new("Frame")
                local SliderBack = Instance.new("TextButton")
                local SliderBackC = Instance.new("UICorner")
                local SliderBar = Instance.new("Frame")
                local SliderBarC = Instance.new("UICorner")
                local SliderPart = Instance.new("Frame")
                local SliderPartC = Instance.new("UICorner")
                local SliderValBG = Instance.new("TextButton")
                local SliderValBGC = Instance.new("UICorner")
                local SliderValue = Instance.new("TextBox")
                local MinSlider = Instance.new("TextButton")
                local AddSlider = Instance.new("TextButton")

                SliderModule.Name = "SliderModule"
                SliderModule.Parent = Objs
                SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderModule.BackgroundTransparency = 1.000
                SliderModule.BorderSizePixel = 0
                SliderModule.Position = UDim2.new(0, 0, 0, 0)
                SliderModule.Size = UDim2.new(0, 428, 0, 38)

                SliderBack.Name = "SliderBack"
                SliderBack.Parent = SliderModule
                SliderBack.BackgroundColor3 = zyColor
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(0, 428, 0, 38)
                SliderBack.AutoButtonColor = false
                SliderBack.Font = Enum.Font.GothamBold
                SliderBack.Text = "   " .. text
                SliderBack.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderBack.TextSize = 16.000
                SliderBack.TextXAlignment = Enum.TextXAlignment.Left

                SliderBackC.CornerRadius = UDim.new(0, 6)
                SliderBackC.Name = "SliderBackC"
                SliderBackC.Parent = SliderBack

                SliderBar.Name = "SliderBar"
    SliderBar.Parent = SliderBack
    SliderBar.AnchorPoint = Vector2.new(0, 0.5)
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    SliderBar.BorderSizePixel = 0
    SliderBar.Position = UDim2.new(0.35, 0, 0.5, 0)  
    SliderBar.Size = UDim2.new(0, 180, 0, 6)  
    local barGlow = Instance.new("UIStroke")
    barGlow.Parent = SliderBar
    barGlow.Color = Color3.fromRGB(0, 200, 255)
    barGlow.Thickness = 1
    barGlow.Transparency = 0.7

    SliderBarC.CornerRadius = UDim.new(1, 0)  
    SliderBarC.Name = "SliderBarC"
    SliderBarC.Parent = SliderBar

                SliderPart.Name = "SliderPart"
    SliderPart.Parent = SliderBar
    SliderPart.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    SliderPart.BorderSizePixel = 0
    SliderPart.Size = UDim2.new(0, 0, 1, 0)  
    local sliderGradient = Instance.new("UIGradient")
    sliderGradient.Parent = SliderPart
    sliderGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
    }
    sliderGradient.Rotation = 0
    
    local sliderHandle = Instance.new("Frame")
    sliderHandle.Name = "SliderHandle"
    sliderHandle.Parent = SliderPart
    sliderHandle.AnchorPoint = Vector2.new(0.5, 0.5)
    sliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderHandle.BorderSizePixel = 0
    sliderHandle.Position = UDim2.new(1, 0, 0.5, 0)
    sliderHandle.Size = UDim2.new(0, 12, 0, 12)
    
    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(1, 0)
    handleCorner.Parent = sliderHandle
    
    local handleGlow = Instance.new("UIStroke")
    handleGlow.Parent = sliderHandle
    handleGlow.Color = Color3.fromRGB(0, 255, 255)
    handleGlow.Thickness = 2
    handleGlow.Transparency = 0.5

                SliderPartC.CornerRadius = UDim.new(0, 4)
                SliderPartC.Name = "SliderPartC"
                SliderPartC.Parent = SliderPart

                SliderValBG.Name = "SliderValBG"
                SliderValBG.Parent = SliderBack
                SliderValBG.BackgroundColor3 = Background
                SliderValBG.BorderSizePixel = 0
                SliderValBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
                SliderValBG.Size = UDim2.new(0, 44, 0, 28)
                SliderValBG.AutoButtonColor = false
                SliderValBG.Font = Enum.Font.GothamBold
                SliderValBG.Text = ""
                SliderValBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValBG.TextSize = 14.000

                SliderValBGC.CornerRadius = UDim.new(0, 6)
                SliderValBGC.Name = "SliderValBGC"
                SliderValBGC.Parent = SliderValBG

                SliderValue.Name = "SliderValue"
                SliderValue.Parent = SliderValBG
                SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.BackgroundTransparency = 1.000
                SliderValue.BorderSizePixel = 0
                SliderValue.Size = UDim2.new(1, 0, 1, 0)
                SliderValue.Font = Enum.Font.GothamBold
                SliderValue.Text = "1000"
                SliderValue.TextColor3 = Color3.fromRGB(255, 0, 0) 
                SliderValue.TextSize = 14.000

                MinSlider.Name = "MinSlider"
                MinSlider.Parent = SliderModule
                MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.BackgroundTransparency = 1.000
                MinSlider.BorderSizePixel = 0
                MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
                MinSlider.Size = UDim2.new(0, 20, 0, 20)
                MinSlider.Font = Enum.Font.GothamBold
                MinSlider.Text = ""
                MinSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.TextSize = 24.000
                MinSlider.TextWrapped = true

                AddSlider.Name = "AddSlider"
                AddSlider.Parent = SliderModule
                AddSlider.AnchorPoint = Vector2.new(0, 0.5)
                AddSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                AddSlider.BackgroundTransparency = 1.000
                AddSlider.BorderSizePixel = 0
                AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
                AddSlider.Size = UDim2.new(0, 20, 0, 20)
                AddSlider.Font = Enum.Font.GothamBold
                AddSlider.Text = ""
                AddSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                AddSlider.TextSize = 24.000
                AddSlider.TextWrapped = true

 local funcs = {
        SetValue = function(self, value)
            local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
            if value then
                percent = (value - min) / (max - min)
            end
            percent = math.clamp(percent, 0, 1)
            if precise then
                value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
            else
                value = value or math.floor(min + (max - min) * percent)
            end
            library.flags[flag] = tonumber(value)
            SliderValue.Text = tostring(value)
            SliderPart.Size = UDim2.new(percent, 0, 1, 0)
            
            game:GetService("TweenService"):Create(
                sliderHandle,
                TweenInfo.new(0.1),
                {Position = UDim2.new(percent, 0, 0.5, 0)}
            ):Play()
            
            callback(tonumber(value))
        end
    }

                MinSlider.MouseButton1Click:Connect(
                    function()
                        local currentValue = library.flags[flag]
                        currentValue = math.clamp(currentValue - 1, min, max)
                        funcs:SetValue(currentValue)
                    end
                )

                AddSlider.MouseButton1Click:Connect(
                    function()
                        local currentValue = library.flags[flag]
                        currentValue = math.clamp(currentValue + 1, min, max)
                        funcs:SetValue(currentValue)
                    end
                )

                funcs:SetValue(default)

                local dragging, boxFocused, allowed =
                    false,
                    false,
                    {
                        [""] = true,
                        ["-"] = true
                    }

                SliderBar.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            funcs:SetValue()
                            dragging = true
                        end
                    end
                )

                services.UserInputService.InputEnded:Connect(
                    function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end
                )

                services.UserInputService.InputChanged:Connect(
                    function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            funcs:SetValue()
                        end
                    end
                )

                SliderBar.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            funcs:SetValue()
                            dragging = true
                        end
                    end
                )

                services.UserInputService.InputEnded:Connect(
                    function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                        end
                    end
                )

                services.UserInputService.InputChanged:Connect(
                    function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.Touch then
                            funcs:SetValue()
                        end
                    end
                )

                SliderValue.Focused:Connect(
                    function()
                        boxFocused = true
                    end
                )

                SliderValue.FocusLost:Connect(
                    function()
                        boxFocused = false
                        if SliderValue.Text == "" then
                            funcs:SetValue(default)
                        end
                    end
                )

                SliderValue:GetPropertyChangedSignal("Text"):Connect(
                    function()
                        if not boxFocused then
                            return
                        end
                        SliderValue.Text = SliderValue.Text:gsub("%D+", "")

                        local text = SliderValue.Text

                        if not tonumber(text) then
                            SliderValue.Text = SliderValue.Text:gsub("%D+", "")
                        elseif not allowed[text] then
                            if tonumber(text) > max then
                                text = max
                                SliderValue.Text = tostring(max)
                            end
                            funcs:SetValue(tonumber(text))
                        end
                    end
                )

                return funcs
            end
                function section.Dropdown(section, text, flag, options, callback) 
            local callback = callback or function() end
            local options = options or {}
            assert(text, "No text provided")
            assert(flag, "No flag provided")

            library.flags[flag] = nil

            local DropdownModule = Instance.new("Frame")
            local DropdownTop = Instance.new("TextButton")
            local DropdownTopC = Instance.new("UICorner")
            local DropdownOpen = Instance.new("TextButton")
            local DropdownText = Instance.new("TextBox")
            local DropdownModuleL = Instance.new("UIListLayout")
            local Option = Instance.new("TextButton")
            local OptionC = Instance.new("UICorner")

            DropdownModule.Name = "DropdownModule"
            DropdownModule.Parent = Objs
            DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownModule.BackgroundTransparency = 1.000
            DropdownModule.BorderSizePixel = 0
            DropdownModule.ClipsDescendants = true
            DropdownModule.Position = UDim2.new(0, 0, 0, 0)
            DropdownModule.Size = UDim2.new(0, 428, 0, 38)

local dataStream = Instance.new("Frame")
dataStream.Parent = DropdownModule
dataStream.BackgroundColor3 = Color3.fromRGB(0,200,255)
dataStream.Size = UDim2.new(1,-20,0,2)
dataStream.Position = UDim2.new(0,10,1,-5)
dataStream.Visible = false

DropdownOpen.MouseEnter:Connect(function()
    dataStream.Visible = true
    game:GetService("TweenService"):Create(
        dataStream,
        TweenInfo.new(0.3),
        {BackgroundTransparency = 0}
    ):Play()
end)
            DropdownTop.Name = "DropdownTop"
            DropdownTop.Parent = DropdownModule
           
local dropdownGradient = Instance.new("UIGradient")
dropdownGradient.Parent = DropdownTop
dropdownGradient.Rotation = 90
dropdownGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
})

local dropdownStroke = Instance.new("UIStroke")
dropdownStroke.Parent = DropdownTop
dropdownStroke.Thickness = 2
dropdownStroke.Color = Color3.fromRGB(255, 255, 255)
dropdownStroke.Transparency = 0.5

spawn(function()
    while wait(0.1) do
        dropdownStroke.Color = Color3.fromHSV(tick()%5/5, 1, 1)
    end
end)
            DropdownTop.BorderSizePixel = 0
            DropdownTop.Size = UDim2.new(0, 428, 0, 38)
            DropdownTop.AutoButtonColor = false
            DropdownTop.Font = Enum.Font.GothamBold
            DropdownTop.Text = ""
            DropdownTop.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTop.TextSize = 16.000
            DropdownTop.TextXAlignment = Enum.TextXAlignment.Left

            DropdownTopC.CornerRadius = UDim.new(0, 6)
            DropdownTopC.Name = "DropdownTopC"
            DropdownTopC.Parent = DropdownTop

            DropdownOpen.Name = "DropdownOpen"
            DropdownOpen.Parent = DropdownTop
            DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
            DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownOpen.BackgroundTransparency = 1.000
            DropdownOpen.BorderSizePixel = 0
            DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
            DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
            DropdownOpen.Font = Enum.Font.GothamBold
            DropdownOpen.Text = "+"
            DropdownOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownOpen.TextSize = 24.000
            DropdownOpen.TextWrapped = true


            DropdownText.Name = "DropdownText"
            DropdownText.Parent = DropdownTop
            DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownText.BackgroundTransparency = 1.000
            DropdownText.BorderSizePixel = 0
            DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
            DropdownText.Size = UDim2.new(0, 184, 0, 38)
            DropdownText.Font = Enum.Font.GothamBold
            DropdownText.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
            DropdownText.PlaceholderText = text
            DropdownText.Text = text .. "｜" .. Language[currentLanguage].Currently
            DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownText.TextSize = 16.000
            DropdownText.TextXAlignment = Enum.TextXAlignment.Left

            DropdownModuleL.Name = "DropdownModuleL"
            DropdownModuleL.Parent = DropdownModule
            DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
            DropdownModuleL.Padding = UDim.new(0, 4)

            local setAllVisible = function()
                local options = DropdownModule:GetChildren()
                for i = 1, #options do
                    local option = options[i]
                    if option:IsA("TextButton") and option.Name:match("Option_") then
                        option.Visible = true
                    end
                end
            end

            local searchDropdown = function(text)
                local options = DropdownModule:GetChildren()
                for i = 1, #options do
                    local option = options[i]
                    if text == "" then
                        setAllVisible()
                    else
                        if option:IsA("TextButton") and option.Name:match("Option_") then
                            if option.Text:lower():match(text:lower()) then
                                option.Visible = true
                            else
                                option.Visible = false
                            end
                        end
                    end
                end
            end

    local open = false
    local ToggleDropVis = function()
        open = not open
        if open then
            setAllVisible()
        end
        DropdownOpen.Text = (open and "-" or "+")
        DropdownModule.Size =
            UDim2.new(0, 428, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 4 or 38))
    end

local gradient = Instance.new("UIGradient")
    gradient.Parent = parent
    gradient.Rotation = 90
    gradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 255)),  
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 200, 255)),  
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255))   
    }

    local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1)
    local tween = TweenService:Create(gradient, tweenInfo, {Rotation = 360, Offset = Vector2.new(1, 0)})
    tween:Play()

    local stroke = Instance.new("UIStroke")
    stroke.Parent = DropdownTop
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local borderGradient = Instance.new("UIGradient")
    borderGradient.Parent = stroke
    borderGradient.Rotation = 90
    borderGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
    }

    local borderTween = TweenService:Create(borderGradient, tweenInfo, {Rotation = 360, Offset = Vector2.new(1, 0)})
    borderTween:Play()

    DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
    DropdownText.Focused:Connect(
        function()
            if open then
                return
            end
            ToggleDropVis()
        end
    )

    DropdownText:GetPropertyChangedSignal("Text"):Connect(
        function()
            if not open then
                return
            end
            searchDropdown(DropdownText.Text)
        end
    )

    DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
        function()
            if not open then
                return
            end
            DropdownModule.Size = UDim2.new(0, 428, 0, (DropdownModuleL.AbsoluteContentSize.Y + 4))
        end
    )

    local funcs = {}
    funcs.AddOption = function(self, option)
        local Option = Instance.new("TextButton")
        local OptionC = Instance.new("UICorner")

        Option.Name = "Option_" .. option
        Option.Parent = DropdownModule
        Option.BackgroundColor3 = zyColor
        Option.BorderSizePixel = 0
        Option.Position = UDim2.new(0, 0, 0.328125, 0)
        Option.Size = UDim2.new(0, 428, 0, 26)
        Option.AutoButtonColor = false
        Option.Font = Enum.Font.GothamBold
        Option.Text = option
        Option.TextColor3 = Color3.fromRGB(255, 255, 255)
        Option.TextSize = 14.000

        OptionC.CornerRadius = UDim.new(0, 6)
        OptionC.Name = "OptionC"
        OptionC.Parent = Option

        Option.MouseButton1Click:Connect(
            function()
                ToggleDropVis()
                callback(Option.Text)
                DropdownText.Text = text .. "｜".. Language[currentLanguage].Currently .. "" .. Option.Text
                library.flags[flag] = Option.Text
            end
        )
    end

    funcs.RemoveOption = function(self, option)
        local option = DropdownModule:FindFirstChild("Option_" .. option)
        if option then
            option:Destroy()
        end
    end

    funcs.SetOptions = function(self, options)
        for _, v in next, DropdownModule:GetChildren() do
            if v.Name:match("Option_") then
                v:Destroy()
            end
        end
        for _, v in next, options do
            funcs:AddOption(v)
        end
    end

        funcs:SetOptions(options)
                    return funcs
                end
                return section
            end
            return tab
        end
        return window
    end



return library
