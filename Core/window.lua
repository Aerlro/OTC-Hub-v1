--[[
    OTC Hub v1
    Window System
    by Aerlro
]]

local Window = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local function tween(Object, Time, Properties)
    local Info = TweenInfo.new(
        Time or 0.25,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    local Animation = TweenService:Create(
        Object,
        Info,
        Properties
    )

    Animation:Play()

    return Animation
end

local function create(Class, Properties)
    local Object = Instance.new(Class)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    return Object
end

function Window.Create(Settings, OTC)
    Settings = Settings or {}

    local Theme = OTC:GetTheme()

    --// ScreenGui
    local ScreenGui = create("ScreenGui", {
        Name = "OTC_Hub",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)

    if not ScreenGui.Parent then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    --// Main
    local Main = create("Frame", {
        Name = "Main",

        Parent = ScreenGui,

        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,

        Size = UDim2.fromOffset(720, 500),

        Position = UDim2.new(
            0.5,
            -360,
            0.5,
            -250
        )
    })

    create("UICorner", {
        Parent = Main,
        CornerRadius = UDim.new(0, 10)
    })

    create("UIStroke", {
        Parent = Main,

        Color = Theme.Border,
        Thickness = 1
    })

    --// Topbar
    local Topbar = create("Frame", {
        Name = "Topbar",

        Parent = Main,

        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,

        Size = UDim2.new(1, 0, 0, 60)
    })

    create("UICorner", {
        Parent = Topbar,
        CornerRadius = UDim.new(0, 10)
    })

    create("Frame", {
        Name = "BottomFix",

        Parent = Topbar,

        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,

        Position = UDim2.new(
            0,
            0,
            1,
            -10
        ),

        Size = UDim2.new(
            1,
            0,
            0,
            10
        )
    })

    --// Logo
    local Logo = create("TextLabel", {
        Name = "Logo",

        Parent = Topbar,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(18, 8),

        Size = UDim2.fromOffset(250, 25),

        Font = Enum.Font.GothamBold,

        Text = Settings.Name or "OTC Hub",

        TextColor3 = Theme.Text,

        TextSize = 18,

        TextXAlignment = Enum.TextXAlignment.Left
    })

    --// Subtitle
    local Subtitle = create("TextLabel", {
        Name = "Subtitle",

        Parent = Topbar,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(19, 32),

        Size = UDim2.fromOffset(250, 20),

        Font = Enum.Font.Gotham,

        Text = Settings.Subtitle or "by Aerlro",

        TextColor3 = Theme.SubText,

        TextSize = 11,

        TextXAlignment = Enum.TextXAlignment.Left
    })

    --// Close
    local Close = create("TextButton", {
        Name = "Close",

        Parent = Topbar,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            1,
            -45,
            0,
            15
        ),

        Size = UDim2.fromOffset(30, 30),

        Font = Enum.Font.GothamBold,

        Text = "×",

        TextColor3 = Theme.SubText,

        TextSize = 22,

        AutoButtonColor = false
    })

    --// Minimize
    local Minimize = create("TextButton", {
        Name = "Minimize",

        Parent = Topbar,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            1,
            -80,
            0,
            15
        ),

        Size = UDim2.fromOffset(30, 30),

        Font = Enum.Font.GothamBold,

        Text = "−",

        TextColor3 = Theme.SubText,

        TextSize = 20,

        AutoButtonColor = false
    })

    --// Sidebar
    local Sidebar = create("Frame", {
        Name = "Sidebar",

        Parent = Main,

        BackgroundColor3 = Theme.Secondary,

        BorderSizePixel = 0,

        Position = UDim2.fromOffset(0, 60),

        Size = UDim2.new(
            0,
            170,
            1,
            -60
        )
    })

    --// Tab Container
    local TabContainer = create("ScrollingFrame", {
        Name = "Tabs",

        Parent = Sidebar,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Position = UDim2.fromOffset(10, 15),

        Size = UDim2.new(
            1,
            -20,
            1,
            -25
        ),

        CanvasSize = UDim2.new(),

        AutomaticCanvasSize = Enum.AutomaticSize.Y,

        ScrollBarThickness = 0
    })

    create("UIListLayout", {
        Parent = TabContainer,

        Padding = UDim.new(0, 5),

        SortOrder = Enum.SortOrder.LayoutOrder
    })

    --// Content
    local Content = create("Frame", {
        Name = "Content",

        Parent = Main,

        BackgroundColor3 = Theme.Background,

        BorderSizePixel = 0,

        Position = UDim2.fromOffset(170, 60),

        Size = UDim2.new(
            1,
            -170,
            1,
            -60
        )
    })

    --// Window Object
    local Object = {
        OTC = OTC,

        ScreenGui = ScreenGui,

        Main = Main,

        Topbar = Topbar,

        Sidebar = Sidebar,

        TabContainer = TabContainer,

        Content = Content,

        Tabs = {},

        CurrentTab = nil,

        Visible = true,

        ToggleKey = Settings.ToggleKey
            or Enum.KeyCode.RightShift,

        Name = Settings.Name or "OTC Hub",

        Subtitle = Settings.Subtitle or "by Aerlro"
    }

    --// Add Tab
    function Object:AddTab(TabObject)
        if not TabObject then
            return
        end

        if table.find(self.Tabs, TabObject) then
            return TabObject
        end

        table.insert(self.Tabs, TabObject)

        return TabObject
    end

    --// Select Tab
    function Object:SelectTab(TabObject)
        if not TabObject then
            return
        end

        for _, Tab in ipairs(self.Tabs) do
            if Tab and Tab.SetSelected then
                Tab:SetSelected(Tab == TabObject)
            end
        end

        self.CurrentTab = TabObject
    end

    --// Visibility
    function Object:SetVisible(Value)
        self.Visible = Value

        if ScreenGui then
            ScreenGui.Enabled = Value
        end
    end

    --// Toggle
    function Object:Toggle()
        self:SetVisible(not self.Visible)
    end

    --// Destroy
    function Object:Destroy()
        if ScreenGui then
            ScreenGui:Destroy()
        end
    end

    --// Refresh Theme
    function Object:RefreshTheme()
        local NewTheme = self.OTC:GetTheme()

        if not NewTheme then
            return
        end

        Main.BackgroundColor3 = NewTheme.Background
        Topbar.BackgroundColor3 = NewTheme.Secondary
        Sidebar.BackgroundColor3 = NewTheme.Secondary
        Content.BackgroundColor3 = NewTheme.Background

        Logo.TextColor3 = NewTheme.Text
        Subtitle.TextColor3 = NewTheme.SubText

        Close.TextColor3 = NewTheme.SubText
        Minimize.TextColor3 = NewTheme.SubText
    end

    --// Dragging
    local Dragging = false
    local DragStart = nil
    local StartPosition = nil

    Topbar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then

            Dragging = true

            DragStart = Input.Position
            StartPosition = Main.Position
        end
    end)

    Topbar.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then

            Dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if not Dragging then
            return
        end

        if Input.UserInputType ~= Enum.UserInputType.MouseMovement
            and Input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,

            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end)

    --// Close Hover
    Close.MouseEnter:Connect(function()
        tween(Close, 0.15, {
            TextColor3 = Color3.fromRGB(
                255,
                80,
                80
            )
        })
    end)

    Close.MouseLeave:Connect(function()
        tween(Close, 0.15, {
            TextColor3 = Theme.SubText
        })
    end)

    --// Close
    Close.MouseButton1Click:Connect(function()
        tween(Main, 0.2, {
            Size = UDim2.fromOffset(
                720,
                0
            )
        })

        task.wait(0.2)

        Object:Destroy()
    end)

    --// Minimize
    local Minimized = false
    local OriginalSize = Main.Size

    Minimize.MouseButton1Click:Connect(function()
        Minimized = not Minimized

        if Minimized then
            tween(Main, 0.25, {
                Size = UDim2.fromOffset(
                    720,
                    60
                )
            })
        else
            tween(Main, 0.25, {
                Size = OriginalSize
            })
        end
    end)

    return Object
end

return Window