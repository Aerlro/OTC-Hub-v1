--[[
    OTC Hub v1
    Notification System
    by Aerlro
]]

local Notification = {}

local TweenService = game:GetService("TweenService")

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

function Notification.Create(ScreenGui, Theme, Data)
    Data = Data or {}

    Theme = Theme or {
        Background = Color3.fromRGB(10, 10, 10),
        Secondary = Color3.fromRGB(15, 15, 15),
        Element = Color3.fromRGB(20, 20, 20),
        Border = Color3.fromRGB(40, 40, 40),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(160, 160, 160),
        Accent = Color3.fromRGB(255, 255, 255)
    }

    local Title = Data.Title or "OTC Hub"
    local Content = Data.Content or ""
    local Duration = Data.Duration or 3
    local Icon = Data.Icon or "!"
    local Accent = Data.Accent or Theme.Accent

    --// Holder
    local Holder = ScreenGui:FindFirstChild("OTC_Notifications")

    if not Holder then
        Holder = create("Frame", {
            Name = "OTC_Notifications",
            Parent = ScreenGui,

            BackgroundTransparency = 1,

            Position = UDim2.new(
                1,
                -20,
                0,
                20
            ),

            Size = UDim2.new(
                0,
                330,
                1,
                -40
            ),

            AnchorPoint = Vector2.new(1, 0)
        })

        create("UIListLayout", {
            Parent = Holder,

            Padding = UDim.new(0, 10),

            HorizontalAlignment = Enum.HorizontalAlignment.Right,

            SortOrder = Enum.SortOrder.LayoutOrder
        })
    end

    --// Notification
    local Frame = create("Frame", {
        Name = "Notification",

        Parent = Holder,

        BackgroundColor3 = Theme.Element,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Size = UDim2.fromOffset(
            330,
            75
        )
    })

    create("UICorner", {
        Parent = Frame,

        CornerRadius = UDim.new(
            0,
            8
        )
    })

    local Stroke = create("UIStroke", {
        Parent = Frame,

        Color = Theme.Border,

        Thickness = 1,

        Transparency = 1
    })

    --// Accent
    local AccentBar = create("Frame", {
        Name = "Accent",

        Parent = Frame,

        BackgroundColor3 = Accent,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Position = UDim2.new(
            0,
            0,
            0,
            8
        ),

        Size = UDim2.fromOffset(
            3,
            59
        )
    })

    create("UICorner", {
        Parent = AccentBar,

        CornerRadius = UDim.new(
            1,
            0
        )
    })

    --// Icon
    local IconLabel = create("TextLabel", {
        Name = "Icon",

        Parent = Frame,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(
            15,
            10
        ),

        Size = UDim2.fromOffset(
            30,
            30
        ),

        Font = Enum.Font.GothamBold,

        Text = Icon,

        TextColor3 = Accent,

        TextTransparency = 1,

        TextSize = 16,

        TextXAlignment = Enum.TextXAlignment.Center,

        TextYAlignment = Enum.TextYAlignment.Center
    })

    --// Title
    local TitleLabel = create("TextLabel", {
        Name = "Title",

        Parent = Frame,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(
            55,
            9
        ),

        Size = UDim2.new(
            1,
            -70,
            0,
            22
        ),

        Font = Enum.Font.GothamBold,

        Text = Title,

        TextColor3 = Theme.Text,

        TextTransparency = 1,

        TextSize = 14,

        TextXAlignment = Enum.TextXAlignment.Left,

        TextYAlignment = Enum.TextYAlignment.Center
    })

    --// Content
    local ContentLabel = create("TextLabel", {
        Name = "Content",

        Parent = Frame,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(
            55,
            31
        ),

        Size = UDim2.new(
            1,
            -70,
            0,
            30
        ),

        Font = Enum.Font.Gotham,

        Text = Content,

        TextColor3 = Theme.SubText,

        TextTransparency = 1,

        TextSize = 12,

        TextWrapped = true,

        TextXAlignment = Enum.TextXAlignment.Left,

        TextYAlignment = Enum.TextYAlignment.Top
    })

    --// Progress
    local ProgressBackground = create("Frame", {
        Name = "ProgressBackground",

        Parent = Frame,

        BackgroundColor3 = Theme.Border,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Position = UDim2.new(
            0,
            12,
            1,
            -6
        ),

        Size = UDim2.new(
            1,
            -24,
            0,
            2
        )
    })

    create("UICorner", {
        Parent = ProgressBackground,

        CornerRadius = UDim.new(
            1,
            0
        )
    })

    local Progress = create("Frame", {
        Name = "Progress",

        Parent = ProgressBackground,

        BackgroundColor3 = Accent,

        BorderSizePixel = 0,

        Size = UDim2.new(
            1,
            0,
            1,
            0
        )
    })

    create("UICorner", {
        Parent = Progress,

        CornerRadius = UDim.new(
            1,
            0
        )
    })

    --// Open animation
    Frame.Position = UDim2.new(
        1,
        350,
        0,
        0
    )

    tween(Frame, 0.35, {
        Position = UDim2.new(
            0,
            0,
            0,
            0
        ),

        BackgroundTransparency = 0
    })

    tween(Stroke, 0.35, {
        Transparency = 0
    })

    tween(AccentBar, 0.35, {
        BackgroundTransparency = 0
    })

    tween(IconLabel, 0.35, {
        TextTransparency = 0
    })

    tween(TitleLabel, 0.35, {
        TextTransparency = 0
    })

    tween(ContentLabel, 0.35, {
        TextTransparency = 0
    })

    tween(ProgressBackground, 0.35, {
        BackgroundTransparency = 0
    })

    --// Progress animation
    tween(Progress, Duration, {
        Size = UDim2.new(
            0,
            0,
            1,
            0
        )
    })

    local Closed = false

    local Object = {}

    function Object:Close()
        if Closed then
            return
        end

        Closed = true

        tween(Frame, 0.25, {
            Position = UDim2.new(
                1,
                350,
                0,
                0
            ),

            BackgroundTransparency = 1
        })

        tween(Stroke, 0.2, {
            Transparency = 1
        })

        tween(AccentBar, 0.2, {
            BackgroundTransparency = 1
        })

        tween(IconLabel, 0.2, {
            TextTransparency = 1
        })

        tween(TitleLabel, 0.2, {
            TextTransparency = 1
        })

        tween(ContentLabel, 0.2, {
            TextTransparency = 1
        })

        task.delay(0.3, function()
            if Frame then
                Frame:Destroy()
            end
        end)
    end

    function Object:SetTitle(NewTitle)
        TitleLabel.Text = tostring(NewTitle)
    end

    function Object:SetContent(NewContent)
        ContentLabel.Text = tostring(NewContent)
    end

    function Object:SetIcon(NewIcon)
        IconLabel.Text = tostring(NewIcon)
    end

    task.delay(Duration, function()
        Object:Close()
    end)

    return Object
end

return Notification