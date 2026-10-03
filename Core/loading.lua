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

local function CreateCorner(Object, Radius)
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, Radius)
    Corner.Parent = Object
    return Corner
end

local function CreateStroke(Object, Color, Thickness, Transparency)
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color
    Stroke.Thickness = Thickness or 1
    Stroke.Transparency = Transparency or 0
    Stroke.Parent = Object
    return Stroke
end

local function CreateGradient(Object, Colors, Rotation)
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Colors[1]),
        ColorSequenceKeypoint.new(0.5, Colors[2]),
        ColorSequenceKeypoint.new(1, Colors[3])
    })
    Gradient.Rotation = Rotation or 0
    Gradient.Parent = Object
    return Gradient
end

function Loading.Create(Total)
    Total = Total or 1

    local Object = {}

    Object.Total = Total
    Object.Current = 0
    Object.Closed = false

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "OTC_Loading"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

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
    Background.BackgroundColor3 = Color3.fromRGB(8, 3, 12)
    Background.BorderSizePixel = 0
    Background.Parent = ScreenGui

    Object.Background = Background

    local BackgroundGradient = CreateGradient(
        Background,
        {
            Color3.fromRGB(8, 3, 12),
            Color3.fromRGB(24, 5, 29),
            Color3.fromRGB(8, 3, 12)
        },
        45
    )

    Object.BackgroundGradient = BackgroundGradient

    local Glow = Instance.new("Frame")
    Glow.Name = "Glow"
    Glow.Size = UDim2.fromOffset(360, 360)
    Glow.Position = UDim2.new(0.5, -180, 0.5, -215)
    Glow.BackgroundColor3 = Color3.fromRGB(255, 90, 0)
    Glow.BackgroundTransparency = 0.94
    Glow.BorderSizePixel = 0
    Glow.Parent = Background

    CreateCorner(Glow, 999)

    local Glow2 = Instance.new("Frame")
    Glow2.Name = "Glow2"
    Glow2.Size = UDim2.fromOffset(280, 280)
    Glow2.Position = UDim2.new(0.5, -140, 0.5, -195)
    Glow2.BackgroundColor3 = Color3.fromRGB(155, 25, 190)
    Glow2.BackgroundTransparency = 0.92
    Glow2.BorderSizePixel = 0
    Glow2.Parent = Background

    CreateCorner(Glow2, 999)

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.fromOffset(470, 350)
    Main.Position = UDim2.new(0.5, -235, 0.5, -175)
    Main.BackgroundColor3 = Color3.fromRGB(20, 6, 25)
    Main.BackgroundTransparency = 0.08
    Main.BorderSizePixel = 0
    Main.Parent = Background

    CreateCorner(Main, 18)

    local MainStroke = CreateStroke(
        Main,
        Color3.fromRGB(255, 105, 0),
        1.5,
        0.25
    )

    CreateGradient(
        Main,
        {
            Color3.fromRGB(20, 5, 28),
            Color3.fromRGB(38, 8, 42),
            Color3.fromRGB(20, 5, 28)
        },
        35
    )

    local TopLine = Instance.new("Frame")
    TopLine.Name = "TopLine"
    TopLine.Size = UDim2.new(1, -60, 0, 2)
    TopLine.Position = UDim2.new(0, 30, 0, 18)
    TopLine.BackgroundColor3 = Color3.fromRGB(255, 105, 0)
    TopLine.BorderSizePixel = 0
    TopLine.Parent = Main

    CreateCorner(TopLine, 999)

    CreateGradient(
        TopLine,
        {
            Color3.fromRGB(120, 15, 160),
            Color3.fromRGB(255, 105, 0),
            Color3.fromRGB(255, 175, 20)
        },
        0
    )

    local RingContainer = Instance.new("Frame")
    RingContainer.Name = "RingContainer"
    RingContainer.Size = UDim2.fromOffset(150, 150)
    RingContainer.Position = UDim2.new(0.5, -75, 0, 40)
    RingContainer.BackgroundTransparency = 1
    RingContainer.Parent = Main

    local Ring = Instance.new("Frame")
    Ring.Name = "Ring"
    Ring.Size = UDim2.fromOffset(132, 132)
    Ring.Position = UDim2.new(0.5, -66, 0.5, -66)
    Ring.BackgroundTransparency = 1
    Ring.Parent = RingContainer

    local RingStroke = CreateStroke(
        Ring,
        Color3.fromRGB(255, 105, 0),
        2,
        0.05
    )

    CreateCorner(Ring, 999)

    local Ring2 = Instance.new("Frame")
    Ring2.Name = "Ring2"
    Ring2.Size = UDim2.fromOffset(108, 108)
    Ring2.Position = UDim2.new(0.5, -54, 0.5, -54)
    Ring2.BackgroundTransparency = 1
    Ring2.Parent = RingContainer

    local Ring2Stroke = CreateStroke(
        Ring2,
        Color3.fromRGB(170, 30, 210),
        1.5,
        0.2
    )

    CreateCorner(Ring2, 999)

    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Size = UDim2.fromOffset(78, 78)
    Logo.Position = UDim2.new(0.5, -39, 0.5, -39)
    Logo.BackgroundTransparency = 1
    Logo.Image = LOGO_ASSET
    Logo.ScaleType = Enum.ScaleType.Fit
    Logo.Parent = RingContainer

    local LogoGlow = Instance.new("ImageLabel")
    LogoGlow.Name = "LogoGlow"
    LogoGlow.Size = UDim2.fromOffset(92, 92)
    LogoGlow.Position = UDim2.new(0.5, -46, 0.5, -46)
    LogoGlow.BackgroundTransparency = 1
    LogoGlow.Image = LOGO_ASSET
    LogoGlow.ImageTransparency = 0.82
    LogoGlow.ImageColor3 = Color3.fromRGB(255, 100, 0)
    LogoGlow.ScaleType = Enum.ScaleType.Fit
    LogoGlow.ZIndex = 0
    LogoGlow.Parent = RingContainer

    Logo.ZIndex = 2

    local ParticleContainer = Instance.new("Frame")
    ParticleContainer.Name = "Particles"
    ParticleContainer.Size = UDim2.fromScale(1, 1)
    ParticleContainer.BackgroundTransparency = 1
    ParticleContainer.Parent = Background

    local Particles = {}

    for Index = 1, 18 do
        local Particle = Instance.new("Frame")
        Particle.Name = "Particle" .. Index

        local Size = math.random(2, 5)

        Particle.Size = UDim2.fromOffset(Size, Size)
        Particle.Position = UDim2.new(
            math.random(),
            0,
            math.random(),
            0
        )

        Particle.BackgroundColor3 =
            Index % 2 == 0
            and Color3.fromRGB(255, 105, 0)
            or Color3.fromRGB(170, 30, 210)

        Particle.BackgroundTransparency = math.random(30, 75) / 100
        Particle.BorderSizePixel = 0
        Particle.Parent = ParticleContainer

        CreateCorner(Particle, 999)

        table.insert(Particles, {
            Object = Particle,
            Start = Particle.Position,
            Offset = math.random(15, 45)
        })
    end

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -40, 0, 30)
    Title.Position = UDim2.new(0, 20, 0, 190)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = "OTC HUB"
    Title.TextColor3 = Color3.fromRGB(255, 245, 235)
    Title.TextSize = 25
    Title.TextXAlignment = Enum.TextXAlignment.Center
    Title.Parent = Main

    local Version = Instance.new("TextLabel")
    Version.Name = "Version"
    Version.Size = UDim2.new(1, -40, 0, 18)
    Version.Position = UDim2.new(0, 20, 0, 219)
    Version.BackgroundTransparency = 1
    Version.Font = Enum.Font.Gotham
    Version.Text = "VERSION 1.0.1"
    Version.TextColor3 = Color3.fromRGB(190, 125, 185)
    Version.TextSize = 10
    Version.TextXAlignment = Enum.TextXAlignment.Center
    Version.Parent = Main

    local Status = Instance.new("TextLabel")
    Status.Name = "Status"
    Status.Size = UDim2.new(1, -60, 0, 22)
    Status.Position = UDim2.new(0, 30, 0, 247)
    Status.BackgroundTransparency = 1
    Status.Font = Enum.Font.GothamMedium
    Status.Text = "Initializing OTC Hub..."
    Status.TextColor3 = Color3.fromRGB(255, 180, 100)
    Status.TextSize = 12
    Status.TextXAlignment = Enum.TextXAlignment.Center
    Status.TextTruncate = Enum.TextTruncate.AtEnd
    Status.Parent = Main

    local Percentage = Instance.new("TextLabel")
    Percentage.Name = "Percentage"
    Percentage.Size = UDim2.new(0, 60, 0, 20)
    Percentage.Position = UDim2.new(1, -80, 0, 272)
    Percentage.BackgroundTransparency = 1
    Percentage.Font = Enum.Font.GothamBold
    Percentage.Text = "0%"
    Percentage.TextColor3 = Color3.fromRGB(255, 135, 20)
    Percentage.TextSize = 11
    Percentage.TextXAlignment = Enum.TextXAlignment.Right
    Percentage.Parent = Main

    local BarBackground = Instance.new("Frame")
    BarBackground.Name = "BarBackground"
    BarBackground.Size = UDim2.new(1, -60, 0, 8)
    BarBackground.Position = UDim2.new(0, 30, 0, 298)
    BarBackground.BackgroundColor3 = Color3.fromRGB(48, 10, 52)
    BarBackground.BorderSizePixel = 0
    BarBackground.Parent = Main

    CreateCorner(BarBackground, 999)

    local Bar = Instance.new("Frame")
    Bar.Name = "Bar"
    Bar.Size = UDim2.new(0, 0, 1, 0)
    Bar.BackgroundColor3 = Color3.fromRGB(255, 105, 0)
    Bar.BorderSizePixel = 0
    Bar.Parent = BarBackground

    CreateCorner(Bar, 999)

    CreateGradient(
        Bar,
        {
            Color3.fromRGB(145, 25, 190),
            Color3.fromRGB(255, 105, 0),
            Color3.fromRGB(255, 175, 20)
        },
        0
    )

    local Detail = Instance.new("TextLabel")
    Detail.Name = "Detail"
    Detail.Size = UDim2.new(1, -60, 0, 18)
    Detail.Position = UDim2.new(0, 30, 0, 317)
    Detail.BackgroundTransparency = 1
    Detail.Font = Enum.Font.Gotham
    Detail.Text = "Preparing..."
    Detail.TextColor3 = Color3.fromRGB(130, 90, 130)
    Detail.TextSize = 9
    Detail.TextXAlignment = Enum.TextXAlignment.Center
    Detail.TextTruncate = Enum.TextTruncate.AtEnd
    Detail.Parent = Main

    Object.Main = Main
    Object.Logo = Logo
    Object.LogoGlow = LogoGlow
    Object.Ring = Ring
    Object.Ring2 = Ring2
    Object.Status = Status
    Object.Detail = Detail
    Object.Percentage = Percentage
    Object.Bar = Bar
    Object.BarBackground = BarBackground

    local RotationConnection

    RotationConnection = RunService.RenderStepped:Connect(function(Delta)
        if Object.Closed then
            RotationConnection:Disconnect()
            return
        end

        Ring.Rotation = Ring.Rotation + Delta * 55
        Ring2.Rotation = Ring2.Rotation - Delta * 35

        LogoGlow.ImageTransparency =
            0.75 + math.sin(os.clock() * 3) * 0.08

        for _, Data in ipairs(Particles) do
            local Position = Data.Object.Position

            Data.Object.Position = UDim2.new(
                Position.X.Scale,
                Position.X.Offset,
                Position.Y.Scale,
                Position.Y.Offset - Data.Offset * Delta
            )

            if Data.Object.AbsolutePosition.Y < -10 then
                Data.Object.Position = Data.Start
            end
        end
    end)

    Object.RotationConnection = RotationConnection

    Main.Size = UDim2.fromOffset(430, 320)
    Main.Position = UDim2.new(0.5, -215, 0.5, -160)

    Main.BackgroundTransparency = 1
    MainStroke.Transparency = 1
    Logo.ImageTransparency = 1
    LogoGlow.ImageTransparency = 1
    Title.TextTransparency = 1
    Version.TextTransparency = 1
    Status.TextTransparency = 1
    Percentage.TextTransparency = 1
    Detail.TextTransparency = 1
    BarBackground.BackgroundTransparency = 1

    Tween(Main, 0.45, {
        Size = UDim2.fromOffset(470, 350),
        Position = UDim2.new(0.5, -235, 0.5, -175),
        BackgroundTransparency = 0.08
    })

    Tween(MainStroke, 0.45, {
        Transparency = 0.25
    })

    Tween(Logo, 0.55, {
        ImageTransparency = 0
    })

    Tween(LogoGlow, 0.7, {
        ImageTransparency = 0.82
    })

    Tween(Title, 0.5, {
        TextTransparency = 0
    })

    Tween(Version, 0.55, {
        TextTransparency = 0
    })

    Tween(Status, 0.6, {
        TextTransparency = 0
    })

    Tween(Percentage, 0.65, {
        TextTransparency = 0
    })

    Tween(Detail, 0.7, {
        TextTransparency = 0
    })

    Tween(BarBackground, 0.5, {
        BackgroundTransparency = 0
    })

    function Object:Update(Current, StatusText, DetailText)
        if self.Closed then
            return
        end

        self.Current = math.clamp(Current or 0, 0, self.Total)

        local Progress =
            self.Current / self.Total

        self.Status.Text =
            StatusText
            or "Loading OTC Hub..."

        self.Detail.Text =
            DetailText
            or ""

        self.Percentage.Text =
            tostring(math.floor(Progress * 100))
            .. "%"

        Tween(
            self.Bar,
            0.28,
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

    function Object:Finish()
        if self.Closed then
            return
        end

        self:Update(
            self.Total,
            "OTC Hub ready!",
            "Initialization complete"
        )

        task.wait(0.35)

        self.Closed = true

        if self.RotationConnection then
            self.RotationConnection:Disconnect()
        end

        Tween(Main, 0.45, {
            Size = UDim2.fromOffset(500, 370),
            Position = UDim2.new(0.5, -250, 0.5, -185),
            BackgroundTransparency = 1
        })

        Tween(Logo, 0.3, {
            ImageTransparency = 1
        })

        Tween(LogoGlow, 0.3, {
            ImageTransparency = 1
        })

        Tween(Title, 0.25, {
            TextTransparency = 1
        })

        Tween(Version, 0.25, {
            TextTransparency = 1
        })

        Tween(Status, 0.25, {
            TextTransparency = 1
        })

        Tween(Percentage, 0.25, {
            TextTransparency = 1
        })

        Tween(Detail, 0.25, {
            TextTransparency = 1
        })

        Tween(BarBackground, 0.25, {
            BackgroundTransparency = 1
        })

        Tween(Background, 0.55, {
            BackgroundTransparency = 1
        })

        task.delay(0.6, function()
            if ScreenGui then
                ScreenGui:Destroy()
            end
        end)
    end

    function Object:Destroy()
        if self.Closed then
            return
        end

        self.Closed = true

        if self.RotationConnection then
            self.RotationConnection:Disconnect()
        end

        if ScreenGui then
            ScreenGui:Destroy()
        end
    end

    Object:Update(
        0,
        "Initializing OTC Hub...",
        "Preparing modules"
    )

    return Object
end

return Loading