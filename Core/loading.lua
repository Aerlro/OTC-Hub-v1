local Loading = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local LOGO_ASSET = "rbxassetid://104463753775983"

local BAT_ASSET = "rbxassetid://100531600237687"
local PUMPKIN_ASSET = "rbxassetid://79838536194671"
local GHOST_ASSET = "rbxassetid://74505285697812"

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

    UI.CornerRadius =
        UDim.new(0, Radius)

    UI.Parent = Object

    return UI
end

local function Stroke(
    Object,
    Color,
    Thickness,
    Transparency
)
    local UI = Instance.new("UIStroke")

    UI.Color = Color
    UI.Thickness = Thickness or 1
    UI.Transparency =
        Transparency or 0

    UI.Parent = Object

    return UI
end

local function Gradient(
    Object,
    Colors,
    Rotation
)
    local UI = Instance.new("UIGradient")

    UI.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(
            0,
            Colors[1]
        ),
        ColorSequenceKeypoint.new(
            0.5,
            Colors[2]
        ),
        ColorSequenceKeypoint.new(
            1,
            Colors[3]
        )
    })

    UI.Rotation =
        Rotation or 0

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
    local Label =
        Instance.new("TextLabel")

    Label.Size = Size
    Label.Position = Position

    Label.BackgroundTransparency = 1

    Label.Text = Text
    Label.TextColor3 = Color
    Label.TextSize = TextSize

    Label.Font =
        Font or Enum.Font.Gotham

    Label.TextXAlignment =
        Enum.TextXAlignment.Center

    Label.TextYAlignment =
        Enum.TextYAlignment.Center

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
    local Object =
        Instance.new("ImageLabel")

    Object.Size = Size
    Object.Position = Position

    Object.BackgroundTransparency = 1

    Object.Image = Asset

    Object.ImageTransparency =
        Transparency or 0

    Object.ScaleType =
        Enum.ScaleType.Fit

    Object.Parent = Parent

    return Object
end

local function CreateBat(
    Parent,
    Position,
    Scale
)
    local Bat = CreateImage(
        Parent,
        BAT_ASSET,
        UDim2.fromOffset(
            70 * Scale,
            50 * Scale
        ),
        Position,
        0
    )

    Bat.Name = "Bat"

    return Bat
end

local function CreatePumpkin(
    Parent,
    Position,
    Scale
)
    local Pumpkin = CreateImage(
        Parent,
        PUMPKIN_ASSET,
        UDim2.fromOffset(
            55 * Scale,
            55 * Scale
        ),
        Position,
        0
    )

    Pumpkin.Name = "Pumpkin"

    return Pumpkin
end

local function CreateGhost(
    Parent,
    Position,
    Scale
)
    local Ghost = CreateImage(
        Parent,
        GHOST_ASSET,
        UDim2.fromOffset(
            60 * Scale,
            65 * Scale
        ),
        Position,
        0.15
    )

    Ghost.Name = "Ghost"

    return Ghost
end

local function CreateCloud(
    Parent,
    Position,
    Size
)
    local Cloud =
        Instance.new("Frame")

    Cloud.Size =
        UDim2.fromOffset(
            Size,
            Size * 0.45
        )

    Cloud.Position = Position

    Cloud.BackgroundColor3 =
        Color3.fromRGB(
            35,
            10,
            45
        )

    Cloud.BackgroundTransparency =
        0.25

    Cloud.BorderSizePixel = 0

    Cloud.Parent = Parent

    Corner(Cloud, 999)

    local Circle1 =
        Instance.new("Frame")

    Circle1.Size =
        UDim2.fromOffset(
            Size * 0.45,
            Size * 0.45
        )

    Circle1.Position =
        UDim2.new(
            0.12,
            0,
            -0.45,
            0
        )

    Circle1.BackgroundColor3 =
        Cloud.BackgroundColor3

    Circle1.BackgroundTransparency =
        Cloud.BackgroundTransparency

    Circle1.BorderSizePixel = 0

    Circle1.Parent = Cloud

    Corner(Circle1, 999)

    local Circle2 =
        Instance.new("Frame")

    Circle2.Size =
        UDim2.fromOffset(
            Size * 0.55,
            Size * 0.55
        )

    Circle2.Position =
        UDim2.new(
            0.48,
            0,
            -0.65,
            0
        )

    Circle2.BackgroundColor3 =
        Cloud.BackgroundColor3

    Circle2.BackgroundTransparency =
        Cloud.BackgroundTransparency

    Circle2.BorderSizePixel = 0

    Circle2.Parent = Cloud

    Corner(Circle2, 999)

    return Cloud
end

local function CreateHauntedHouse(
    Parent,
    Position,
    Scale
)
    local House =
        Instance.new("Frame")

    House.Size =
        UDim2.fromOffset(
            155 * Scale,
            115 * Scale
        )

    House.Position = Position
    House.BackgroundTransparency = 1

    House.Parent = Parent

    local Body =
        Instance.new("Frame")

    Body.Size =
        UDim2.new(
            0.72,
            0,
            0.62,
            0
        )

    Body.Position =
        UDim2.new(
            0.14,
            0,
            0.38,
            0
        )

    Body.BackgroundColor3 =
        Color3.fromRGB(
            17,
            5,
            22
        )

    Body.BorderSizePixel = 0

    Body.Parent = House

    Stroke(
        Body,
        Color3.fromRGB(
            95,
            35,
            105
        ),
        1,
        0.35
    )

    local Roof =
        Instance.new("TextLabel")

    Roof.Size =
        UDim2.fromScale(
            1,
            0.5
        )

    Roof.Position =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    Roof.BackgroundTransparency = 1

    Roof.Text = "▲"

    Roof.TextColor3 =
        Color3.fromRGB(
            12,
            3,
            16
        )

    Roof.TextSize =
        95 * Scale

    Roof.Font =
        Enum.Font.GothamBold

    Roof.Parent = House

    local Window1 =
        Instance.new("Frame")

    Window1.Size =
        UDim2.fromOffset(
            25 * Scale,
            32 * Scale
        )

    Window1.Position =
        UDim2.new(
            0.20,
            0,
            0.49,
            0
        )

    Window1.BackgroundColor3 =
        Color3.fromRGB(
            255,
            125,
            10
        )

    Window1.BorderSizePixel = 0

    Window1.Parent = House

    Corner(Window1, 4)

    local Window2 =
        Window1:Clone()

    Window2.Position =
        UDim2.new(
            0.62,
            0,
            0.49,
            0
        )

    Window2.Parent = House

    local Door =
        Instance.new("Frame")

    Door.Size =
        UDim2.fromOffset(
            30 * Scale,
            48 * Scale
        )

    Door.Position =
        UDim2.new(
            0.43,
            0,
            0.58,
            0
        )

    Door.BackgroundColor3 =
        Color3.fromRGB(
            8,
            3,
            10
        )

    Door.BorderSizePixel = 0

    Door.Parent = House

    Corner(Door, 4)

    return House
end

local function FadeOutGui(
    Root,
    Time
)
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
                    Properties
                )
            end
        elseif Object:IsA("UIStroke") then
            if Object.Transparency < 1 then
                Tween(
                    Object,
                    Time,
                    {
                        Transparency = 1
                    }
                )
            end
        end
    end

    Fade(Root)

    for _, Object in ipairs(
        Root:GetDescendants()
    ) do
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

    Object.StartTime =
        os.clock()

    Object.MinimumDuration = 1.35

    local ScreenGui =
        Instance.new("ScreenGui")

    ScreenGui.Name =
        "OTC_Loading"

    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false

    ScreenGui.ZIndexBehavior =
        Enum.ZIndexBehavior.Sibling

    ScreenGui.DisplayOrder =
        999999

    pcall(function()
        ScreenGui.Parent = CoreGui
    end)

    if not ScreenGui.Parent then
        ScreenGui.Parent =
            LocalPlayer:WaitForChild(
                "PlayerGui"
            )
    end

    Object.ScreenGui = ScreenGui

    local Background =
        Instance.new("Frame")

    Background.Name =
        "Background"

    Background.Size =
        UDim2.fromScale(
            1,
            1
        )

    Background.BackgroundColor3 =
        Color3.fromRGB(
            7,
            2,
            11
        )

    Background.BorderSizePixel = 0

    Background.ClipsDescendants =
        true

    Background.ZIndex = 1

    Background.Parent =
        ScreenGui

    Object.Background =
        Background

    Gradient(
        Background,
        {
            Color3.fromRGB(
                7,
                2,
                12
            ),
            Color3.fromRGB(
                35,
                7,
                43
            ),
            Color3.fromRGB(
                12,
                2,
                18
            )
        },
        45
    )

    local MoonGlow =
        Instance.new("Frame")

    MoonGlow.Size =
        UDim2.fromOffset(
            270,
            270
        )

    MoonGlow.Position =
        UDim2.new(
            0.82,
            -45,
            0.06,
            -35
        )

    MoonGlow.BackgroundColor3 =
        Color3.fromRGB(
            255,
            145,
            25
        )

    MoonGlow.BackgroundTransparency =
        0.92

    MoonGlow.BorderSizePixel = 0

    MoonGlow.ZIndex = 2

    MoonGlow.Parent =
        Background

    Corner(
        MoonGlow,
        999
    )

    local Moon =
        Instance.new("Frame")

    Moon.Size =
        UDim2.fromOffset(
            175,
            175
        )

    Moon.Position =
        UDim2.new(
            0.82,
            0,
            0.06,
            0
        )

    Moon.BackgroundColor3 =
        Color3.fromRGB(
            255,
            220,
            145
        )

    Moon.BorderSizePixel = 0

    Moon.ZIndex = 3

    Moon.Parent =
        Background

    Corner(
        Moon,
        999
    )

    local Clouds = {}

    for Index = 1, 6 do
        local Cloud =
            CreateCloud(
                Background,
                UDim2.new(
                    math.random(
                        -10,
                        90
                    ) / 100,
                    0,
                    math.random(
                        8,
                        65
                    ) / 100,
                    0
                ),
                math.random(
                    90,
                    170
                )
            )

        Cloud.ZIndex = 4

        table.insert(
            Clouds,
            {
                Object = Cloud,
                Speed = math.random(
                    2,
                    5
                )
            }
        )
    end

    local HouseContainer =
        Instance.new("Frame")

    HouseContainer.Name =
        "HauntedHouses"

    HouseContainer.Size =
        UDim2.fromScale(
            1,
            0.28
        )

    HouseContainer.Position =
        UDim2.new(
            0,
            0,
            0.72,
            0
        )

    HouseContainer.BackgroundTransparency =
        1

    HouseContainer.ZIndex = 5

    HouseContainer.Parent =
        Background

    CreateHauntedHouse(
        HouseContainer,
        UDim2.new(
            -0.02,
            0,
            0.15,
            0
        ),
        0.75
    )

    CreateHauntedHouse(
        HouseContainer,
        UDim2.new(
            0.13,
            0,
            0.02,
            0
        ),
        0.95
    )

    CreateHauntedHouse(
        HouseContainer,
        UDim2.new(
            0.78,
            0,
            0.08,
            0
        ),
        0.9
    )

    CreateHauntedHouse(
        HouseContainer,
        UDim2.new(
            0.91,
            0,
            0.18,
            0
        ),
        0.65
    )

    local Cemetery =
        Instance.new("Frame")

    Cemetery.Size =
        UDim2.new(
            1,
            0,
            0.15,
            0
        )

    Cemetery.Position =
        UDim2.new(
            0,
            0,
            0.85,
            0
        )

    Cemetery.BackgroundColor3 =
        Color3.fromRGB(
            5,
            2,
            7
        )

    Cemetery.BorderSizePixel = 0

    Cemetery.ZIndex = 6

    Cemetery.Parent =
        Background

    local GravePositions = {
        0.05,
        0.19,
        0.31,
        0.68,
        0.76,
        0.88
    }

    for _, X in ipairs(
        GravePositions
    ) do
        local Grave =
            Instance.new("Frame")

        Grave.Size =
            UDim2.fromOffset(
                30,
                38
            )

        Grave.Position =
            UDim2.new(
                X,
                0,
                0.18,
                0
            )

        Grave.BackgroundColor3 =
            Color3.fromRGB(
                35,
                30,
                40
            )

        Grave.BorderSizePixel = 0

        Grave.ZIndex = 6

        Grave.Parent =
            Cemetery

        Corner(
            Grave,
            12
        )

        local Cross =
            Instance.new("Frame")

        Cross.Size =
            UDim2.fromOffset(
                4,
                28
            )

        Cross.Position =
            UDim2.new(
                0.5,
                -2,
                0.1,
                0
            )

        Cross.BackgroundColor3 =
            Color3.fromRGB(
                55,
                45,
                60
            )

        Cross.BorderSizePixel = 0

        Cross.ZIndex = 7

        Cross.Parent =
            Grave

        local Cross2 =
            Cross:Clone()

        Cross2.Size =
            UDim2.fromOffset(
                18,
                4
            )

        Cross2.Position =
            UDim2.new(
                0.5,
                -9,
                0.25,
                0
            )

        Cross2.Parent =
            Grave
    end

    local DecorationContainer =
        Instance.new("Frame")

    DecorationContainer.Name =
        "HalloweenDecorations"

    DecorationContainer.Size =
        UDim2.fromScale(
            1,
            1
        )

    DecorationContainer.BackgroundTransparency =
        1

    DecorationContainer.ZIndex =
        15

    DecorationContainer.Parent =
        Background

    local Bats = {}
    local Pumpkins = {}
    local Ghosts = {}

    for Index = 1, 16 do
        local Y =
            math.random(
                5,
                88
            ) / 100

        local StartX

        if Index % 2 == 0 then
            StartX =
                math.random(
                    -20,
                    25
                ) / 100
        else
            StartX =
                math.random(
                    75,
                    120
                ) / 100
        end

        local Bat =
            CreateBat(
                DecorationContainer,
                UDim2.new(
                    StartX,
                    0,
                    Y,
                    0
                ),
                math.random(
                    65,
                    105
                ) / 100
            )

        Bat.ZIndex = 15

        table.insert(
            Bats,
            {
                Object = Bat,
                Speed = math.random(
                    35,
                    75
                ) / 1000,
                WaveSpeed =
                    math.random(
                        15,
                        30
                    ) / 10,
                WaveAmount =
                    math.random(
                        8,
                        18
                    ) / 1000,
                RotationAmount =
                    math.random(
                        5,
                        12
                    ),
                Direction =
                    Index % 2 == 0
                    and 1
                    or -1
            }
        )
    end

    for Index = 1, 12 do
        local Side =
            Index % 2

        local X

        if Side == 0 then
            X =
                math.random(
                    2,
                    22
                ) / 100
        else
            X =
                math.random(
                    78,
                    96
                ) / 100
        end

        local Pumpkin =
            CreatePumpkin(
                DecorationContainer,
                UDim2.new(
                    X,
                    0,
                    math.random(
                        65,
                        91
                    ) / 100,
                    0
                ),
                math.random(
                    65,
                    105
                ) / 100
            )

        Pumpkin.ZIndex = 15

        table.insert(
            Pumpkins,
            {
                Object = Pumpkin,
                Base = Pumpkin.Position,
                Offset =
                    math.random() * 20,
                FloatSpeed =
                    math.random(
                        8,
                        16
                    ) / 10,
                FloatAmount =
                    math.random(
                        4,
                        9
                    ) / 1000
            }
        )
    end

    for Index = 1, 10 do
        local X

        if Index % 2 == 0 then
            X =
                math.random(
                    0,
                    20
                ) / 100
        else
            X =
                math.random(
                    80,
                    100
                ) / 100
        end

        local Ghost =
            CreateGhost(
                DecorationContainer,
                UDim2.new(
                    X,
                    0,
                    math.random(
                        12,
                        82
                    ) / 100,
                    0
                ),
                math.random(
                    65,
                    100
                ) / 100
            )

        Ghost.ZIndex = 15

        table.insert(
            Ghosts,
            {
                Object = Ghost,
                Base = Ghost.Position,
                Offset =
                    math.random() * 20,
                FloatSpeed =
                    math.random(
                        7,
                        14
                    ) / 10,
                FloatAmount =
                    math.random(
                        10,
                        20
                    ) / 1000,
                TransparencySpeed =
                    math.random(
                        10,
                        20
                    ) / 10
            }
        )
    end

    local ParticleContainer =
        Instance.new("Frame")

    ParticleContainer.Name =
        "Particles"

    ParticleContainer.Size =
        UDim2.fromScale(
            1,
            1
        )

    ParticleContainer.BackgroundTransparency =
        1

    ParticleContainer.ZIndex = 8

    ParticleContainer.Parent =
        Background

    local Particles = {}

    for Index = 1, 35 do
        local Particle =
            Instance.new("Frame")

        local Size =
            math.random(
                2,
                5
            )

        Particle.Size =
            UDim2.fromOffset(
                Size,
                Size
            )

        Particle.Position =
            UDim2.new(
                math.random(),
                0,
                math.random(),
                0
            )

        Particle.BackgroundColor3 =
            Index % 3 == 0
            and Color3.fromRGB(
                255,
                105,
                0
            )
            or Color3.fromRGB(
                175,
                35,
                210
            )

        Particle.BackgroundTransparency =
            math.random(
                35,
                80
            ) / 100

        Particle.BorderSizePixel = 0
        Particle.ZIndex = 8

        Particle.Parent =
            ParticleContainer

        Corner(
            Particle,
            999
        )

        table.insert(
            Particles,
            {
                Object = Particle,
                Speed = math.random(
                    8,
                    25
                )
            }
        )
    end

    local Glow =
        Instance.new("Frame")

    Glow.Size =
        UDim2.fromOffset(
            500,
            500
        )

    Glow.Position =
        UDim2.new(
            0.5,
            -250,
            0.5,
            -250
        )

    Glow.BackgroundColor3 =
        Color3.fromRGB(
            255,
            80,
            0
        )

    Glow.BackgroundTransparency =
        0.95

    Glow.BorderSizePixel = 0

    Glow.ZIndex = 9

    Glow.Parent =
        Background

    Corner(
        Glow,
        999
    )

    local PurpleGlow =
        Instance.new("Frame")

    PurpleGlow.Size =
        UDim2.fromOffset(
            400,
            400
        )

    PurpleGlow.Position =
        UDim2.new(
            0.5,
            -200,
            0.5,
            -220
        )

    PurpleGlow.BackgroundColor3 =
        Color3.fromRGB(
            165,
            25,
            210
        )

    PurpleGlow.BackgroundTransparency =
        0.94

    PurpleGlow.BorderSizePixel = 0

    PurpleGlow.ZIndex = 9

    PurpleGlow.Parent =
        Background

    Corner(
        PurpleGlow,
        999
    )

    local Main =
        Instance.new("Frame")

    Main.Name = "Main"

    Main.Size =
        UDim2.fromOffset(
            470,
            350
        )

    Main.Position =
        UDim2.new(
            0.5,
            -235,
            0.5,
            -175
        )

    Main.BackgroundColor3 =
        Color3.fromRGB(
            20,
            6,
            25
        )

    Main.BackgroundTransparency =
        0.08

    Main.BorderSizePixel = 0

    Main.ZIndex = 30

    Main.Parent =
        Background

    Corner(
        Main,
        18
    )

    local MainStroke =
        Stroke(
            Main,
            Color3.fromRGB(
                255,
                105,
                0
            ),
            1.5,
            0.25
        )

    Gradient(
        Main,
        {
            Color3.fromRGB(
                20,
                5,
                28
            ),
            Color3.fromRGB(
                45,
                8,
                48
            ),
            Color3.fromRGB(
                20,
                5,
                28
            )
        },
        35
    )

    local TopLine =
        Instance.new("Frame")

    TopLine.Size =
        UDim2.new(
            1,
            -60,
            0,
            2
        )

    TopLine.Position =
        UDim2.new(
            0,
            30,
            0,
            18
        )

    TopLine.BackgroundColor3 =
        Color3.fromRGB(
            255,
            105,
            0
        )

    TopLine.BorderSizePixel = 0
    TopLine.ZIndex = 31
    TopLine.Parent = Main

    Corner(
        TopLine,
        999
    )

    Gradient(
        TopLine,
        {
            Color3.fromRGB(
                125,
                15,
                170
            ),
            Color3.fromRGB(
                255,
                105,
                0
            ),
            Color3.fromRGB(
                255,
                175,
                20
            )
        },
        0
    )

    local RingContainer =
        Instance.new("Frame")

    RingContainer.Size =
        UDim2.fromOffset(
            150,
            150
        )

    RingContainer.Position =
        UDim2.new(
            0.5,
            -75,
            0,
            40
        )

    RingContainer.BackgroundTransparency =
        1

    RingContainer.ZIndex = 32

    RingContainer.Parent =
        Main

    local Ring =
        Instance.new("Frame")

    Ring.Size =
        UDim2.fromOffset(
            132,
            132
        )

    Ring.Position =
        UDim2.new(
            0.5,
            -66,
            0.5,
            -66
        )

    Ring.BackgroundTransparency =
        1

    Ring.ZIndex = 32

    Ring.Parent =
        RingContainer

    Stroke(
        Ring,
        Color3.fromRGB(
            255,
            105,
            0
        ),
        2,
        0.05
    )

    Corner(
        Ring,
        999
    )

    local Ring2 =
        Instance.new("Frame")

    Ring2.Size =
        UDim2.fromOffset(
            108,
            108
        )

    Ring2.Position =
        UDim2.new(
            0.5,
            -54,
            0.5,
            -54
        )

    Ring2.BackgroundTransparency =
        1

    Ring2.ZIndex = 32

    Ring2.Parent =
        RingContainer

    Stroke(
        Ring2,
        Color3.fromRGB(
            175,
            35,
            210
        ),
        1.5,
        0.2
    )

    Corner(
        Ring2,
        999
    )

    local LogoGlow =
        CreateImage(
            RingContainer,
            LOGO_ASSET,
            UDim2.fromOffset(
                96,
                96
            ),
            UDim2.new(
                0.5,
                -48,
                0.5,
                -48
            ),
            0.82
        )

    LogoGlow.ImageColor3 =
        Color3.fromRGB(
            255,
            95,
            0
        )

    LogoGlow.ZIndex = 33

    local Logo =
        CreateImage(
            RingContainer,
            LOGO_ASSET,
            UDim2.fromOffset(
                78,
                78
            ),
            UDim2.new(
                0.5,
                -39,
                0.5,
                -39
            ),
            0
        )

    Logo.ZIndex = 34

    local Title =
        CreateText(
            Main,
            "OTC HUB",
            UDim2.new(
                1,
                -40,
                0,
                30
            ),
            UDim2.new(
                0,
                20,
                0,
                190
            ),
            25,
            Color3.fromRGB(
                255,
                245,
                235
            ),
            Enum.Font.GothamBold
        )

    Title.ZIndex = 35

    local Version =
        CreateText(
            Main,
            "VERSION 1.0.1 • HALLOWEEN EDITION",
            UDim2.new(
                1,
                -40,
                0,
                18
            ),
            UDim2.new(
                0,
                20,
                0,
                219
            ),
            10,
            Color3.fromRGB(
                205,
                125,
                195
            ),
            Enum.Font.Gotham
        )

    Version.ZIndex = 35

    local Status =
        CreateText(
            Main,
            "Initializing OTC Hub...",
            UDim2.new(
                1,
                -60,
                0,
                22
            ),
            UDim2.new(
                0,
                30,
                0,
                247
            ),
            12,
            Color3.fromRGB(
                255,
                180,
                100
            ),
            Enum.Font.GothamMedium
        )

    Status.TextTruncate =
        Enum.TextTruncate.AtEnd

    Status.ZIndex = 35

    local Percentage =
        CreateText(
            Main,
            "0%",
            UDim2.new(
                0,
                60,
                0,
                20
            ),
            UDim2.new(
                1,
                -80,
                0,
                272
            ),
            11,
            Color3.fromRGB(
                255,
                135,
                20
            ),
            Enum.Font.GothamBold
        )

    Percentage.TextXAlignment =
        Enum.TextXAlignment.Right

    Percentage.ZIndex = 35

    local BarBackground =
        Instance.new("Frame")

    BarBackground.Size =
        UDim2.new(
            1,
            -60,
            0,
            8
        )

    BarBackground.Position =
        UDim2.new(
            0,
            30,
            0,
            298
        )

    BarBackground.BackgroundColor3 =
        Color3.fromRGB(
            48,
            10,
            52
        )

    BarBackground.BorderSizePixel = 0

    BarBackground.ZIndex = 35

    BarBackground.Parent =
        Main

    Corner(
        BarBackground,
        999
    )

    local Bar =
        Instance.new("Frame")

    Bar.Size =
        UDim2.new(
            0,
            0,
            1,
            0
        )

    Bar.BackgroundColor3 =
        Color3.fromRGB(
            255,
            105,
            0
        )

    Bar.BorderSizePixel = 0

    Bar.ZIndex = 36

    Bar.Parent =
        BarBackground

    Corner(
        Bar,
        999
    )

    Gradient(
        Bar,
        {
            Color3.fromRGB(
                145,
                25,
                190
            ),
            Color3.fromRGB(
                255,
                105,
                0
            ),
            Color3.fromRGB(
                255,
                175,
                20
            )
        },
        0
    )

    local Detail =
        CreateText(
            Main,
            "Preparing...",
            UDim2.new(
                1,
                -60,
                0,
                18
            ),
            UDim2.new(
                0,
                30,
                0,
                317
            ),
            9,
            Color3.fromRGB(
                145,
                95,
                145
            ),
            Enum.Font.Gotham
        )

    Detail.TextTruncate =
        Enum.TextTruncate.AtEnd

    Detail.ZIndex = 35

    Object.Main = Main
    Object.Logo = Logo
    Object.LogoGlow = LogoGlow
    Object.Ring = Ring
    Object.Ring2 = Ring2
    Object.Status = Status
    Object.Detail = Detail
    Object.Percentage = Percentage
    Object.Bar = Bar
    Object.BarBackground =
        BarBackground

    local RotationConnection

    RotationConnection =
        RunService.RenderStepped:Connect(
            function(Delta)
                if Object.Closed
                    or Object.Finishing then
                    return
                end

                local Time =
                    os.clock()

                Ring.Rotation =
                    Ring.Rotation
                    + Delta * 55

                Ring2.Rotation =
                    Ring2.Rotation
                    - Delta * 35

                LogoGlow.ImageTransparency =
                    0.75
                    + math.sin(
                        Time * 3
                    ) * 0.08

                Glow.BackgroundTransparency =
                    0.93
                    + math.sin(
                        Time * 2
                    ) * 0.025

                PurpleGlow.BackgroundTransparency =
                    0.92
                    + math.sin(
                        Time * 1.7
                    ) * 0.025

                MoonGlow.BackgroundTransparency =
                    0.88
                    + math.sin(
                        Time * 1.5
                    ) * 0.04

                for _, Data in ipairs(
                    Bats
                ) do
                    local Bat =
                        Data.Object

                    local Position =
                        Bat.Position

                    local Direction =
                        Data.Direction

                    local NewX =
                        Position.X.Scale
                        + Delta
                        * Data.Speed
                        * Direction

                    local NewY =
                        Position.Y.Scale
                        + math.sin(
                            Time
                            * Data.WaveSpeed
                        )
                        * Data.WaveAmount

                    if Direction > 0 then
                        if NewX > 1.15 then
                            NewX = -0.15
                        end
                    else
                        if NewX < -0.15 then
                            NewX = 1.15
                        end
                    end

                    Bat.Position =
                        UDim2.new(
                            NewX,
                            0,
                            NewY,
                            0
                        )

                    Bat.Rotation =
                        math.sin(
                            Time
                            * Data.WaveSpeed
                        )
                        * Data.RotationAmount
                end

                for _, Data in ipairs(
                    Pumpkins
                ) do
                    local Pumpkin =
                        Data.Object

                    local Y =
                        Data.Base.Y.Scale
                        + math.sin(
                            Time
                            * Data.FloatSpeed
                            + Data.Offset
                        )
                        * Data.FloatAmount

                    Pumpkin.Position =
                        UDim2.new(
                            Data.Base.X.Scale,
                            0,
                            Y,
                            0
                        )

                    Pumpkin.Rotation =
                        math.sin(
                            Time * 1.1
                            + Data.Offset
                        ) * 7
                end

                for _, Data in ipairs(
                    Ghosts
                ) do
                    local Ghost =
                        Data.Object

                    local Y =
                        Data.Base.Y.Scale
                        + math.sin(
                            Time
                            * Data.FloatSpeed
                            + Data.Offset
                        )
                        * Data.FloatAmount

                    local X =
                        Data.Base.X.Scale
                        + math.cos(
                            Time * 0.65
                            + Data.Offset
                        ) * 0.008

                    Ghost.Position =
                        UDim2.new(
                            X,
                            0,
                            Y,
                            0
                        )

                    Ghost.Rotation =
                        math.sin(
                            Time * 0.8
                            + Data.Offset
                        ) * 5

                    Ghost.ImageTransparency =
                        0.25
                        + math.sin(
                            Time
                            * Data.TransparencySpeed
                            + Data.Offset
                        ) * 0.12
                end

                for _, Data in ipairs(
                    Particles
                ) do
                    local Position =
                        Data.Object.Position

                    local NewY =
                        Position.Y.Scale
                        - Delta
                        * (
                            Data.Speed
                            / 1000
                        )

                    if NewY < -0.05 then
                        NewY = 1.05
                    end

                    Data.Object.Position =
                        UDim2.new(
                            Position.X.Scale,
                            0,
                            NewY,
                            0
                        )
                end

                for _, Data in ipairs(
                    Clouds
                ) do
                    local Position =
                        Data.Object.Position

                    local NewX =
                        Position.X.Scale
                        + Delta
                        * (
                            Data.Speed
                            / 10000
                        )

                    if NewX > 1.15 then
                        NewX = -0.2
                    end

                    Data.Object.Position =
                        UDim2.new(
                            NewX,
                            0,
                            Position.Y.Scale,
                            0
                        )
                end
            end
        )

    Object.RotationConnection =
        RotationConnection

    Main.Size =
        UDim2.fromOffset(
            430,
            320
        )

    Main.Position =
        UDim2.new(
            0.5,
            -215,
            0.5,
            -160
        )

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

    Tween(
        Main,
        0.45,
        {
            Size = UDim2.fromOffset(
                470,
                350
            ),
            Position = UDim2.new(
                0.5,
                -235,
                0.5,
                -175
            ),
            BackgroundTransparency = 0.08
        }
    )

    Tween(
        MainStroke,
        0.45,
        {
            Transparency = 0.25
        }
    )

    Tween(
        Logo,
        0.55,
        {
            ImageTransparency = 0
        }
    )

    Tween(
        LogoGlow,
        0.7,
        {
            ImageTransparency = 0.82
        }
    )

    Tween(
        Title,
        0.5,
        {
            TextTransparency = 0
        }
    )

    Tween(
        Version,
        0.55,
        {
            TextTransparency = 0
        }
    )

    Tween(
        Status,
        0.6,
        {
            TextTransparency = 0
        }
    )

    Tween(
        Percentage,
        0.65,
        {
            TextTransparency = 0
        }
    )

    Tween(
        Detail,
        0.7,
        {
            TextTransparency = 0
        }
    )

    Tween(
        BarBackground,
        0.5,
        {
            BackgroundTransparency = 0
        }
    )

    function Object:Update(
        Current,
        StatusText,
        DetailText
    )
        if self.Closed then
            return
        end

        self.Current =
            math.clamp(
                Current or 0,
                0,
                self.Total
            )

        local Progress =
            self.Current
            / self.Total

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
            )
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
            "OTC Hub ready!",
            "Initialization complete"
        )

        task.wait(0.25)

        if self.RotationConnection then
            self.RotationConnection:Disconnect()
            self.RotationConnection = nil
        end

        local FadeOverlay =
            Instance.new("Frame")

        FadeOverlay.Name =
            "FinalFade"

        FadeOverlay.Size =
            UDim2.fromScale(
                1,
                1
            )

        FadeOverlay.Position =
            UDim2.fromScale(
                0,
                0
            )

        FadeOverlay.BackgroundColor3 =
            Color3.fromRGB(
                0,
                0,
                0
            )

        FadeOverlay.BackgroundTransparency =
            1

        FadeOverlay.BorderSizePixel = 0

        FadeOverlay.ZIndex =
            999999

        FadeOverlay.Parent =
            ScreenGui

        Tween(
            FadeOverlay,
            0.65,
            {
                BackgroundTransparency = 0
            },
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        )

        task.wait(0.7)

        self.Closed = true

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

        if ScreenGui then
            ScreenGui:Destroy()
        end
    end

    Object:Update(
        0,
        "Initializing OTC Hub...",
        "Summoning Halloween modules..."
    )

    return Object
end

return Loading