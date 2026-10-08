local Notification = {}

local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")

local LOGO_ASSET = "rbxassetid://95900623719417"

local DEFAULT_THEME = {
    Background = Color3.fromRGB(10, 10, 10),
    Secondary = Color3.fromRGB(15, 15, 15),
    Element = Color3.fromRGB(20, 20, 20),
    Border = Color3.fromRGB(40, 40, 40),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(160, 160, 160),
    Accent = Color3.fromRGB(255, 255, 255),
    Scrollbar = Color3.fromRGB(80, 80, 80),
    Corners = {
        Notification = 9
    },
    Stroke = {
        Enabled = true,
        Thickness = 1,
        Transparency = 0
    },
    Transparency = {
        Notification = 0
    }
}

local function tween(Object, Time, Properties)
    if not Object then
        return
    end

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

local function applyCorner(Object, Radius)
    if not Object then
        return
    end

    local Corner =
        Object:FindFirstChildOfClass("UICorner")

    if not Corner then
        Corner =
            Instance.new("UICorner")

        Corner.Parent =
            Object
    end

    Corner.CornerRadius =
        UDim.new(
            0,
            Radius or 8
        )
end

local function applyStroke(Object, Theme)
    if not Object or not Theme then
        return
    end

    local StrokeSettings =
        Theme.Stroke
        or {}

    local Stroke =
        Object:FindFirstChildOfClass("UIStroke")

    if not Stroke then
        Stroke =
            Instance.new("UIStroke")

        Stroke.Parent =
            Object
    end

    Stroke.Enabled =
        StrokeSettings.Enabled ~= false

    Stroke.Color =
        Theme.Border
        or Color3.new(1, 1, 1)

    Stroke.Thickness =
        StrokeSettings.Thickness
        or 1

    Stroke.Transparency =
        StrokeSettings.Transparency
        or 0
end

local function applyGradient(Object, GradientData)
    if not Object or not GradientData then
        return nil
    end

    local Existing =
        Object:FindFirstChild("OTCGradient")

    if Existing then
        Existing:Destroy()
    end

    if GradientData.Enabled == false then
        return nil
    end

    if not GradientData.Colors then
        return nil
    end

    local Gradient =
        Instance.new("UIGradient")

    Gradient.Name =
        "OTCGradient"

    Gradient.Color =
        GradientData.Colors

    Gradient.Rotation =
        GradientData.Rotation
        or 0

    Gradient.Parent =
        Object

    return Gradient
end

local function IsLogoValid()
    local Image =
        create(
            "ImageLabel",
            {
                Image = LOGO_ASSET,
                Size = UDim2.fromOffset(
                    1,
                    1
                ),
                BackgroundTransparency = 1
            }
        )

    local Success =
        pcall(function()
            ContentProvider:PreloadAsync({
                Image
            })
        end)

    Image:Destroy()

    return Success
end

function Notification.Create(
    ScreenGui,
    Theme,
    Data
)

    Data =
        Data or {}

    Theme =
        Theme
        or DEFAULT_THEME

    local Title =
        Data.Title
        or "OTC Hub"

    local Content =
        Data.Content
        or ""

    local Duration =
        tonumber(Data.Duration)
        or 3

    local FallbackIcon =
        Data.Icon
        or "!"

    local Accent =
        Data.Accent
        or Theme.Accent

    local Corners =
        Theme.Corners
        or {}

    local StrokeSettings =
        Theme.Stroke
        or {}

    local Transparency =
        Theme.Transparency
        or {}

    local NotificationRadius =
        Corners.Notification
        or Corners.Element
        or 8

    local NotificationTransparency =
        Transparency.Notification
        or Transparency.Element
        or 0

    local Holder =
        ScreenGui:FindFirstChild(
            "OTC_Notifications"
        )

    if not Holder then

        Holder =
            create(
                "Frame",
                {
                    Name =
                        "OTC_Notifications",

                    Parent =
                        ScreenGui,

                    BackgroundTransparency =
                        1,

                    Position =
                        UDim2.new(
                            1,
                            -20,
                            0,
                            20
                        ),

                    Size =
                        UDim2.new(
                            0,
                            330,
                            1,
                            -40
                        ),

                    AnchorPoint =
                        Vector2.new(
                            1,
                            0
                        )
                }
            )

        create(
            "UIListLayout",
            {
                Parent =
                    Holder,

                Padding =
                    UDim.new(
                        0,
                        10
                    ),

                HorizontalAlignment =
                    Enum.HorizontalAlignment.Right,

                SortOrder =
                    Enum.SortOrder.LayoutOrder
            }
        )
    end

    local Frame =
        create(
            "Frame",
            {
                Name =
                    "Notification",

                Parent =
                    Holder,

                BackgroundColor3 =
                    Theme.NotificationBackground
                    or Theme.Element,

                BackgroundTransparency =
                    1,

                BorderSizePixel =
                    0,

                Size =
                    UDim2.fromOffset(
                        330,
                        75
                    )
            }
        )

    applyCorner(
        Frame,
        NotificationRadius
    )

    local Stroke =
        create(
            "UIStroke",
            {
                Parent =
                    Frame,

                Color =
                    Theme.NotificationBorder
                    or Theme.Border,

                Thickness =
                    StrokeSettings.Thickness
                    or 1,

                Transparency =
                    1,

                Enabled =
                    StrokeSettings.Enabled
                    ~= false
            }
        )

    local AccentBar =
        create(
            "Frame",
            {
                Name =
                    "Accent",

                Parent =
                    Frame,

                BackgroundColor3 =
                    Accent,

                BackgroundTransparency =
                    1,

                BorderSizePixel =
                    0,

                Position =
                    UDim2.new(
                        0,
                        0,
                        0,
                        8
                    ),

                Size =
                    UDim2.fromOffset(
                        3,
                        59
                    )
            }
        )

    applyCorner(
        AccentBar,
        999
    )

    local LogoImage =
        create(
            "ImageLabel",
            {
                Name =
                    "Logo",

                Parent =
                    Frame,

                BackgroundTransparency =
                    1,

                AnchorPoint =
                    Vector2.new(
                        0.5,
                        0.5
                    ),

                Position =
                    UDim2.new(
                        0,
                        30,
                        0.5,
                        0
                    ),

                Size =
                    UDim2.fromOffset(
                        40,
                        40
                    ),

                BorderSizePixel =
                    0,

                Image =
                    LOGO_ASSET,

                ImageTransparency =
                    1,

                ScaleType =
                    Enum.ScaleType.Fit
            }
        )

    local IconLabel =
        create(
            "TextLabel",
            {
                Name =
                    "Icon",

                Parent =
                    Frame,

                BackgroundTransparency =
                    1,

                AnchorPoint =
                    Vector2.new(
                        0.5,
                        0.5
                    ),

                Position =
                    UDim2.new(
                        0,
                        30,
                        0.5,
                        0
                    ),

                Size =
                    UDim2.fromOffset(
                        30,
                        30
                    ),

                Font =
                    Enum.Font.GothamBold,

                Text =
                    FallbackIcon,

                TextColor3 =
                    Accent,

                TextTransparency =
                    1,

                TextSize =
                    18,

                TextXAlignment =
                    Enum.TextXAlignment.Center,

                TextYAlignment =
                    Enum.TextYAlignment.Center,

                Visible =
                    false
            }
        )

    local LogoValid =
        IsLogoValid()

    if not LogoValid then
        LogoImage.Visible =
            false

        IconLabel.Visible =
            true
    end

    local TitleLabel =
        create(
            "TextLabel",
            {
                Name =
                    "Title",

                Parent =
                    Frame,

                BackgroundTransparency =
                    1,

                Position =
                    UDim2.fromOffset(
                        55,
                        9
                    ),

                Size =
                    UDim2.new(
                        1,
                        -70,
                        0,
                        22
                    ),

                Font =
                    Enum.Font.GothamBold,

                Text =
                    Title,

                TextColor3 =
                    Theme.Text,

                TextTransparency =
                    1,

                TextSize =
                    14,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                TextYAlignment =
                    Enum.TextYAlignment.Center
            }
        )

    local ContentLabel =
        create(
            "TextLabel",
            {
                Name =
                    "Content",

                Parent =
                    Frame,

                BackgroundTransparency =
                    1,

                Position =
                    UDim2.fromOffset(
                        55,
                        31
                    ),

                Size =
                    UDim2.new(
                        1,
                        -70,
                        0,
                        30
                    ),

                Font =
                    Enum.Font.Gotham,

                Text =
                    Content,

                TextColor3 =
                    Theme.SubText,

                TextTransparency =
                    1,

                TextSize =
                    12,

                TextWrapped =
                    true,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                TextYAlignment =
                    Enum.TextYAlignment.Top
            }
        )

    local ProgressBackground =
        create(
            "Frame",
            {
                Name =
                    "ProgressBackground",

                Parent =
                    Frame,

                BackgroundColor3 =
                    Theme.Border,

                BackgroundTransparency =
                    1,

                BorderSizePixel =
                    0,

                Position =
                    UDim2.new(
                        0,
                        12,
                        1,
                        -6
                    ),

                Size =
                    UDim2.new(
                        1,
                        -24,
                        0,
                        2
                    )
            }
        )

    applyCorner(
        ProgressBackground,
        999
    )

    local Progress =
        create(
            "Frame",
            {
                Name =
                    "Progress",

                Parent =
                    ProgressBackground,

                BackgroundColor3 =
                    Accent,

                BorderSizePixel =
                    0,

                Size =
                    UDim2.new(
                        1,
                        0,
                        1,
                        0
                    )
            }
        )

    applyCorner(
        Progress,
        999
    )

    Frame.Position =
        UDim2.new(
            1,
            350,
            0,
            0
        )

    local MainGradient

    if Theme.Gradients
        and Theme.Gradients.Notification then

        MainGradient =
            applyGradient(
                Frame,
                Theme.Gradients.Notification
            )

    elseif Theme.Gradients
        and Theme.Gradients.Element then

        MainGradient =
            applyGradient(
                Frame,
                Theme.Gradients.Element
            )
    end

    tween(
        Frame,
        0.35,
        {
            Position =
                UDim2.new(
                    0,
                    0,
                    0,
                    0
                ),

            BackgroundTransparency =
                NotificationTransparency
        }
    )

    tween(
        Stroke,
        0.35,
        {
            Transparency =
                StrokeSettings.Transparency
                or 0
        }
    )

    tween(
        AccentBar,
        0.35,
        {
            BackgroundTransparency =
                0
        }
    )

    if LogoValid then
        tween(
            LogoImage,
            0.35,
            {
                ImageTransparency =
                    0
            }
        )
    else
        tween(
            IconLabel,
            0.35,
            {
                TextTransparency =
                    0
            }
        )
    end

    tween(
        TitleLabel,
        0.35,
        {
            TextTransparency =
                0
        }
    )

    tween(
        ContentLabel,
        0.35,
        {
            TextTransparency =
                0
        }
    )

    tween(
        ProgressBackground,
        0.35,
        {
            BackgroundTransparency =
                0
        }
    )

    tween(
        Progress,
        Duration,
        {
            Size =
                UDim2.new(
                    0,
                    0,
                    1,
                    0
                )
        }
    )

    if Theme.Effects
        and Theme.Effects.AnimatedGradient
        and MainGradient then

        tween(
            MainGradient,
            6,
            {
                Rotation =
                    MainGradient.Rotation
                    + 360
            }
        )
    end

    local Closed =
        false

    local Object =
        {}

    function Object:Close()
        if Closed then
            return
        end

        Closed =
            true

        tween(
            Frame,
            0.25,
            {
                Position =
                    UDim2.new(
                        1,
                        350,
                        0,
                        0
                    ),

                BackgroundTransparency =
                    1
            }
        )

        tween(
            Stroke,
            0.2,
            {
                Transparency =
                    1
            }
        )

        tween(
            AccentBar,
            0.2,
            {
                BackgroundTransparency =
                    1
            }
        )

        if LogoValid then
            tween(
                LogoImage,
                0.2,
                {
                    ImageTransparency =
                        1
                }
            )
        else
            tween(
                IconLabel,
                0.2,
                {
                    TextTransparency =
                        1
                }
            )
        end

        tween(
            TitleLabel,
            0.2,
            {
                TextTransparency =
                    1
            }
        )

        tween(
            ContentLabel,
            0.2,
            {
                TextTransparency =
                    1
            }
        )

        tween(
            ProgressBackground,
            0.2,
            {
                BackgroundTransparency =
                    1
            }
        )

        task.delay(
            0.3,
            function()
                if Frame then
                    Frame:Destroy()
                end
            end
        )
    end

    function Object:SetTitle(NewTitle)
        TitleLabel.Text =
            tostring(NewTitle)
    end

    function Object:SetContent(NewContent)
        ContentLabel.Text =
            tostring(NewContent)
    end

    function Object:SetIcon(NewIcon)
        FallbackIcon =
            tostring(NewIcon)

        IconLabel.Text =
            FallbackIcon

        if not LogoValid then
            IconLabel.Visible =
                true
        end
    end

    function Object:SetAccent(NewAccent)
        Accent =
            NewAccent

        AccentBar.BackgroundColor3 =
            NewAccent

        IconLabel.TextColor3 =
            NewAccent

        Progress.BackgroundColor3 =
            NewAccent
    end

    function Object:SetTheme(NewTheme)
        if not NewTheme then
            return
        end

        Theme =
            NewTheme

        local NewTransparency =
            Theme.Transparency
            or {}

        local NewCorners =
            Theme.Corners
            or {}

        local NewStroke =
            Theme.Stroke
            or {}

        local NewRadius =
            NewCorners.Notification
            or NewCorners.Element
            or 8

        Frame.BackgroundColor3 =
            Theme.NotificationBackground
            or Theme.Element

        Stroke.Color =
            Theme.NotificationBorder
            or Theme.Border

        Stroke.Thickness =
            NewStroke.Thickness
            or 1

        Stroke.Transparency =
            NewStroke.Transparency
            or 0

        Stroke.Enabled =
            NewStroke.Enabled ~= false

        TitleLabel.TextColor3 =
            Theme.Text

        ContentLabel.TextColor3 =
            Theme.SubText

        AccentBar.BackgroundColor3 =
            Theme.Accent

        IconLabel.TextColor3 =
            Theme.Accent

        ProgressBackground.BackgroundColor3 =
            Theme.Border

        Progress.BackgroundColor3 =
            Theme.Accent

        applyCorner(
            Frame,
            NewRadius
        )

        applyCorner(
            AccentBar,
            999
        )

        applyCorner(
            ProgressBackground,
            999
        )

        applyCorner(
            Progress,
            999
        )

        local GradientData

        if Theme.Gradients then
            GradientData =
                Theme.Gradients.Notification
                or Theme.Gradients.Element
        end

        if GradientData then
            MainGradient =
                applyGradient(
                    Frame,
                    GradientData
                )
        end

        Frame.BackgroundTransparency =
            NewTransparency.Notification
            or NewTransparency.Element
            or 0
    end

    task.delay(
        Duration,
        function()
            Object:Close()
        end
    )

    return Object
end

return Notification