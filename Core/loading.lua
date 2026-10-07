local Loading = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local LOGO_ASSET = "rbxassetid://104463753775983"

local function Tween(Object, Time, Properties, Style, Direction)
    local TweenObject = TweenService:Create(
        Object,
        TweenInfo.new(
            Time or 0.25,
            Style or Enum.EasingStyle.Quint,
            Direction or Enum.EasingDirection.Out
        ),
        Properties
    )

    TweenObject:Play()

    return TweenObject
end

local function Corner(Object, Radius)
    local UI = Instance.new("UICorner")

    UI.CornerRadius = UDim.new(0, Radius)
    UI.Parent = Object

    return UI
end

local function Stroke(Object, Color, Thickness, Transparency)
    local UI = Instance.new("UIStroke")

    UI.Color = Color
    UI.Thickness = Thickness or 1
    UI.Transparency = Transparency or 0

    UI.Parent = Object

    return UI
end

local function Gradient(Object, Colors, Rotation)
    local UI = Instance.new("UIGradient")

    UI.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Colors[1]),
        ColorSequenceKeypoint.new(0.5, Colors[2]),
        ColorSequenceKeypoint.new(1, Colors[3])
    })

    UI.Rotation = Rotation or 0
    UI.Parent = Object

    return UI
end

local function CreateText(
    Parent,
    Text,
    Size,
    Position,
    TextSize,
    Color,
    Font
)
    local Label = Instance.new("TextLabel")

    Label.Size = Size
    Label.Position = Position
    Label.BackgroundTransparency = 1

    Label.Text = Text
    Label.TextColor3 = Color
    Label.TextSize = TextSize

    Label.Font = Font or Enum.Font.Gotham

    Label.TextXAlignment = Enum.TextXAlignment.Center
    Label.TextYAlignment = Enum.TextYAlignment.Center

    Label.Parent = Parent

    return Label
end

local function CreateImage(
    Parent,
    Asset,
    Size,
    Position,
    Transparency
)
    local Object = Instance.new("ImageLabel")

    Object.Size = Size
    Object.Position = Position

    Object.BackgroundTransparency = 1
    Object.Image = Asset
    Object.ImageTransparency = Transparency or 0

    Object.ScaleType = Enum.ScaleType.Fit

    Object.Parent = Parent

    return Object
end

local function FadeOutGui(Root, Time)
    local function Fade(Object)
        if Object:IsA("GuiObject") then
            local Properties = {}

            if Object.BackgroundTransparency < 1 then
                Properties.BackgroundTransparency = 1
            end

            if Object:IsA("TextLabel")
                or Object:IsA("TextButton")
                or Object:IsA("TextBox") then

                if Object.TextTransparency < 1 then
                    Properties.TextTransparency = 1
                end

                if Object.TextStrokeTransparency < 1 then
                    Properties.TextStrokeTransparency = 1
                end
            end

            if Object:IsA("ImageLabel")
                or Object:IsA("ImageButton") then

                if Object.ImageTransparency < 1 then
                    Properties.ImageTransparency = 1
                end
            end

            if next(Properties) then
                Tween(
                    Object,
                    Time,
                    Properties,
                    Enum.EasingStyle.Quint,
                    Enum.EasingDirection.Out
                )
            end
        elseif Object:IsA("UIStroke") then
            if Object.Transparency < 1 then
                Tween(
                    Object,
                    Time,
                    {
                        Transparency = 1
                    },
                    Enum.EasingStyle.Quint,
                    Enum.EasingDirection.Out
                )
            end
        end
    end

    Fade(Root)

    for _, Object in ipairs(Root:GetDescendants()) do
        Fade(Object)
    end
end

function Loading.Create(Total)
    Total = Total or 1

    local Object = {}

    Object.Total = Total
    Object.Current = 0
    Object.Closed = false
    Object.Finishing = false
    Object.StartTime = os.clock()

    Object.MinimumDuration = 1.35

    local ScreenGui = Instance.new("ScreenGui")

    ScreenGui.Name = "OTC_Loading"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999999

    pcall(function()
        ScreenGui.Parent = CoreGui
    end)

    if not ScreenGui.Parent then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    Object.ScreenGui = ScreenGui

    local Background = Instance.new("Frame")

    Background.Name = "Background"
    Background.Size = UDim2.fromScale(1, 1)

    Background.BackgroundColor3 = Color3.fromRGB(
        8,
        8,
        8
    )

    Background.BorderSizePixel = 0
    Background.ClipsDescendants = true
    Background.ZIndex = 1

    Background.Parent = ScreenGui

    Object.Background = Background

    Gradient(
        Background,
        {
            Color3.fromRGB(5, 5, 5),
            Color3.fromRGB(15, 15, 15),
            Color3.fromRGB(4, 4, 4)
        },
        90
    )

    local Pattern = Instance.new("Frame")

    Pattern.Name = "Pattern"
    Pattern.Size = UDim2.fromScale(1, 1)
    Pattern.BackgroundTransparency = 1
    Pattern.BorderSizePixel = 0
    Pattern.ZIndex = 2

    Pattern.Parent = Background

    local PatternImages = {}

    local PatternColumns = 8
    local PatternRows = 4

    for Row = 1, PatternRows do
        for Column = 1, PatternColumns do
            local Image = Instance.new("ImageLabel")

            Image.Name = "PatternLogo"

            Image.Size = UDim2.fromOffset(
                145,
                145
            )

            Image.Position = UDim2.new(
                (Column - 1) / PatternColumns - 0.025,
                0,
                (Row - 1) / PatternRows - 0.025,
                0
            )

            Image.BackgroundTransparency = 1
            Image.Image = LOGO_ASSET
            Image.ImageTransparency = 0.955
            Image.ImageColor3 = Color3.fromRGB(
                255,
                255,
                255
            )

            Image.ScaleType = Enum.ScaleType.Fit
            Image.ZIndex = 2

            Image.Parent = Pattern

            table.insert(
                PatternImages,
                {
                    Object = Image,
                    Offset = math.random() * 10
                }
            )
        end
    end

    local Vignette = Instance.new("Frame")

    Vignette.Name = "Vignette"
    Vignette.Size = UDim2.fromScale(1, 1)

    Vignette.BackgroundColor3 = Color3.fromRGB(
        0,
        0,
        0
    )

    Vignette.BackgroundTransparency = 0.72
    Vignette.BorderSizePixel = 0
    Vignette.ZIndex = 3

    Vignette.Parent = Background

    Gradient(
        Vignette,
        {
            Color3.fromRGB(0, 0, 0),
            Color3.fromRGB(20, 20, 20),
            Color3.fromRGB(0, 0, 0)
        },
        0
    )

    local CenterGlow = Instance.new("Frame")

    CenterGlow.Name = "CenterGlow"

    CenterGlow.Size = UDim2.fromOffset(
        500,
        300
    )

    CenterGlow.Position = UDim2.new(
        0.5,
        -250,
        0.5,
        -150
    )

    CenterGlow.BackgroundColor3 = Color3.fromRGB(
        255,
        255,
        255
    )

    CenterGlow.BackgroundTransparency = 0.985
    CenterGlow.BorderSizePixel = 0
    CenterGlow.ZIndex = 4

    CenterGlow.Parent = Background

    Corner(
        CenterGlow,
        999
    )

    local Main = Instance.new("Frame")

    Main.Name = "Main"

    Main.Size = UDim2.fromScale(
        1,
        1
    )

    Main.Position = UDim2.fromScale(
        0,
        0
    )

    Main.BackgroundTransparency = 1
    Main.BorderSizePixel = 0
    Main.ZIndex = 10

    Main.Parent = Background

    Object.Main = Main

    local Logo = CreateImage(
        Main,
        LOGO_ASSET,
        UDim2.fromOffset(
            190,
            190
        ),
        UDim2.new(
            0.5,
            -95,
            0.5,
            -125
        ),
        0
    )

    Logo.ImageTransparency = 1
    Logo.ZIndex = 12

    local LogoGlow = CreateImage(
        Main,
        LOGO_ASSET,
        UDim2.fromOffset(
            245,
            245
        ),
        UDim2.new(
            0.5,
            -122,
            0.5,
            -152
        ),
        0.95
    )

    LogoGlow.ImageColor3 = Color3.fromRGB(
        255,
        255,
        255
    )

    LogoGlow.ZIndex = 11

    local Title = CreateText(
        Main,
        "OTC HUB",
        UDim2.new(
            0,
            300,
            0,
            55
        ),
        UDim2.new(
            0.5,
            -150,
            0.5,
            -20
        ),
        28,
        Color3.fromRGB(
            245,
            245,
            245
        ),
        Enum.Font.Garamond
    )

    Title.Font = Enum.Font.Garamond
    Title.TextTransparency = 1
    Title.ZIndex = 13

    local Version = CreateText(
        Main,
        "VERSION 1.0.1",
        UDim2.new(
            0,
            220,
            0,
            20
        ),
        UDim2.new(
            0.5,
            -110,
            0.5,
            15
        ),
        9,
        Color3.fromRGB(
            125,
            125,
            125
        ),
        Enum.Font.Gotham
    )

    Version.TextTransparency = 1
    Version.ZIndex = 13

    local Status = CreateText(
        Main,
        "Initializing OTC Hub...",
        UDim2.new(
            0,
            700,
            0,
            24
        ),
        UDim2.new(
            0.5,
            -350,
            1,
            -145
        ),
        11,
        Color3.fromRGB(
            165,
            165,
            165
        ),
        Enum.Font.Gotham
    )

    Status.TextTransparency = 1
    Status.TextTruncate = Enum.TextTruncate.AtEnd
    Status.ZIndex = 13

    local BarContainer = Instance.new("Frame")

    BarContainer.Name = "ProgressContainer"

    BarContainer.Size = UDim2.new(
        0.72,
        0,
        0,
        3
    )

    BarContainer.Position = UDim2.new(
        0.14,
        0,
        1,
        -118
    )

    BarContainer.BackgroundColor3 = Color3.fromRGB(
        70,
        70,
        70
    )

    BarContainer.BackgroundTransparency = 1
    BarContainer.BorderSizePixel = 0
    BarContainer.ZIndex = 14

    BarContainer.Parent = Main

    Corner(
        BarContainer,
        999
    )

    local Bar = Instance.new("Frame")

    Bar.Name = "Progress"

    Bar.Size = UDim2.new(
        0,
        0,
        1,
        0
    )

    Bar.Position = UDim2.fromScale(
        0,
        0
    )

    Bar.BackgroundColor3 = Color3.fromRGB(
        235,
        235,
        235
    )

    Bar.BackgroundTransparency = 0
    Bar.BorderSizePixel = 0
    Bar.ZIndex = 15

    Bar.Parent = BarContainer

    Corner(
        Bar,
        999
    )

    Gradient(
        Bar,
        {
            Color3.fromRGB(175, 175, 175),
            Color3.fromRGB(255, 255, 255),
            Color3.fromRGB(185, 185, 185)
        },
        0
    )

    local Percentage = CreateText(
        Main,
        "0%",
        UDim2.new(
            0,
            50,
            0,
            18
        ),
        UDim2.new(
            0.86,
            0,
            1,
            -137
        ),
        9,
        Color3.fromRGB(
            150,
            150,
            150
        ),
        Enum.Font.Gotham
    )

    Percentage.TextXAlignment =
        Enum.TextXAlignment.Right

    Percentage.TextTransparency = 1
    Percentage.ZIndex = 15

    local Detail = CreateText(
        Main,
        "Preparing...",
        UDim2.new(
            0,
            600,
            0,
            18
        ),
        UDim2.new(
            0.5,
            -300,
            1,
            -92
        ),
        8,
        Color3.fromRGB(
            105,
            105,
            105
        ),
        Enum.Font.Gotham
    )

    Detail.TextTransparency = 1
    Detail.TextTruncate = Enum.TextTruncate.AtEnd
    Detail.ZIndex = 13

    local SkipButton = Instance.new("TextButton")

    SkipButton.Name = "Skip"

    SkipButton.Size = UDim2.fromOffset(
        74,
        30
    )

    SkipButton.Position = UDim2.new(
        1,
        -100,
        1,
        -82
    )

    SkipButton.BackgroundColor3 = Color3.fromRGB(
        15,
        15,
        15
    )

    SkipButton.BackgroundTransparency = 1

    SkipButton.BorderSizePixel = 0

    SkipButton.Text = "SKIP"

    SkipButton.TextColor3 = Color3.fromRGB(
        210,
        210,
        210
    )

    SkipButton.TextSize = 9
    SkipButton.Font = Enum.Font.GothamMedium

    SkipButton.AutoButtonColor = false
    SkipButton.TextTransparency = 1

    SkipButton.ZIndex = 20
    SkipButton.Parent = Main

    Corner(
        SkipButton,
        4
    )

    local SkipStroke = Stroke(
        SkipButton,
        Color3.fromRGB(
            120,
            120,
            120
        ),
        1,
        0.35
    )

    SkipStroke.Transparency = 1

    local BottomIndicator = Instance.new("Frame")

    BottomIndicator.Name = "BottomIndicator"

    BottomIndicator.Size = UDim2.fromOffset(
        55,
        55
    )

    BottomIndicator.Position = UDim2.new(
        0.5,
        -27,
        1,
        -62
    )

    BottomIndicator.BackgroundColor3 = Color3.fromRGB(
        12,
        12,
        12
    )

    BottomIndicator.BackgroundTransparency = 1
    BottomIndicator.BorderSizePixel = 0
    BottomIndicator.ZIndex = 15

    BottomIndicator.Parent = Main

    Corner(
        BottomIndicator,
        3
    )

    local BottomLogo = CreateImage(
        BottomIndicator,
        LOGO_ASSET,
        UDim2.fromOffset(
            38,
            38
        ),
        UDim2.new(
            0.5,
            -19,
            0.5,
            -19
        ),
        1
    )

    BottomLogo.ZIndex = 16

    local BottomNumber = CreateText(
        Main,
        "1",
        UDim2.fromOffset(
            20,
            15
        ),
        UDim2.new(
            0.5,
            -37,
            1,
            -61
        ),
        8,
        Color3.fromRGB(
            155,
            155,
            155
        ),
        Enum.Font.Gotham
    )

    BottomNumber.TextTransparency = 1
    BottomNumber.ZIndex = 17

    Object.Logo = Logo
    Object.LogoGlow = LogoGlow
    Object.Title = Title
    Object.Version = Version
    Object.Status = Status
    Object.Detail = Detail
    Object.Percentage = Percentage
    Object.Bar = Bar
    Object.BarContainer = BarContainer
    Object.SkipButton = SkipButton

    local RotationConnection

    RotationConnection = RunService.RenderStepped:Connect(
        function(Delta)
            if Object.Closed then
                return
            end

            local Time = os.clock()

            LogoGlow.ImageTransparency =
                0.92
                + math.sin(Time * 2.5) * 0.035

            CenterGlow.BackgroundTransparency =
                0.982
                + math.sin(Time * 1.8) * 0.006

            for _, Data in ipairs(PatternImages) do
                local Image = Data.Object

                Image.ImageTransparency =
                    0.95
                    + math.sin(
                        Time * 0.45
                        + Data.Offset
                    ) * 0.008
            end
        end
    )

    Object.RotationConnection =
        RotationConnection

    local IntroScale = Instance.new("UIScale")

    IntroScale.Scale = 0.92
    IntroScale.Parent = Main

    Tween(
        IntroScale,
        0.75,
        {
            Scale = 1
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    Tween(
        Logo,
        0.65,
        {
            ImageTransparency = 0
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    Tween(
        LogoGlow,
        0.8,
        {
            ImageTransparency = 0.94
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    Tween(
        Title,
        0.65,
        {
            TextTransparency = 0
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    Tween(
        Version,
        0.75,
        {
            TextTransparency = 0
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    Tween(
        Status,
        0.8,
        {
            TextTransparency = 0
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    Tween(
        Detail,
        0.9,
        {
            TextTransparency = 0
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    Tween(
        Percentage,
        0.85,
        {
            TextTransparency = 0
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    Tween(
        BarContainer,
        0.7,
        {
            BackgroundTransparency = 0
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    Tween(
        BottomIndicator,
        0.8,
        {
            BackgroundTransparency = 0
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    Tween(
        BottomLogo,
        0.9,
        {
            ImageTransparency = 0.15
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    Tween(
        BottomNumber,
        0.9,
        {
            TextTransparency = 0
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    function Object:Update(
        Current,
        StatusText,
        DetailText
    )
        if self.Closed then
            return
        end

        self.Current = math.clamp(
            Current or 0,
            0,
            self.Total
        )

        local Progress =
            self.Current / self.Total

        self.Status.Text =
            StatusText
            or "Loading OTC Hub..."

        self.Detail.Text =
            DetailText
            or ""

        self.Percentage.Text =
            tostring(
                math.floor(
                    Progress * 100
                )
            ) .. "%"

        Tween(
            self.Bar,
            0.3,
            {
                Size = UDim2.new(
                    Progress,
                    0,
                    1,
                    0
                )
            },
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        )
    end

    local SkipConnection

    SkipConnection =
        SkipButton.MouseButton1Click:Connect(
            function()
                if Object.Closed
                    or Object.Finishing then
                    return
                end

                Object:Finish()
            end
        )

    Object.SkipConnection =
        SkipConnection

    function Object:Finish()
        if self.Closed
            or self.Finishing then
            return
        end

        self.Finishing = true

        local Elapsed =
            os.clock()
            - self.StartTime

        local Remaining =
            self.MinimumDuration
            - Elapsed

        if Remaining > 0 then
            task.wait(Remaining)
        end

        self:Update(
            self.Total,
            "Done!",
            "Initialization complete"
        )

        Tween(
            SkipButton,
            0.35,
            {
                BackgroundTransparency = 0.05,
                TextTransparency = 0
            },
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        )

        Tween(
            SkipStroke,
            0.35,
            {
                Transparency = 0.2
            },
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        )

        task.wait(0.35)

        if self.RotationConnection then
            self.RotationConnection:Disconnect()
            self.RotationConnection = nil
        end

        task.wait(0.25)

        local FadeOverlay = Instance.new("Frame")

        FadeOverlay.Name = "FinalFade"

        FadeOverlay.Size = UDim2.fromScale(
            1,
            1
        )

        FadeOverlay.Position = UDim2.fromScale(
            0,
            0
        )

        FadeOverlay.BackgroundColor3 =
            Color3.fromRGB(
                0,
                0,
                0
            )

        FadeOverlay.BackgroundTransparency = 1
        FadeOverlay.BorderSizePixel = 0
        FadeOverlay.ZIndex = 999999

        FadeOverlay.Parent = ScreenGui

        Tween(
            FadeOverlay,
            0.7,
            {
                BackgroundTransparency = 0
            },
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        )

        task.wait(0.75)

        self.Closed = true

        if self.SkipConnection then
            self.SkipConnection:Disconnect()
            self.SkipConnection = nil
        end

        if ScreenGui then
            ScreenGui:Destroy()
        end
    end

    function Object:Destroy()
        if self.Closed then
            return
        end

        self.Closed = true
        self.Finishing = true

        if self.RotationConnection then
            self.RotationConnection:Disconnect()
            self.RotationConnection = nil
        end

        if self.SkipConnection then
            self.SkipConnection:Disconnect()
            self.SkipConnection = nil
        end

        if ScreenGui then
            ScreenGui:Destroy()
        end
    end

    Object:Update(
        0,
        "Initializing OTC Hub...",
        "Preparing modules..."
    )

    return Object
end

return Loading