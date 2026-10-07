local Loading = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local LOGO_ASSET = "rbxassetid://95900623719417"

local function Tween(Object, Time, Properties, Style, Direction)
    if not Object then
        return nil
    end

    local Animation = TweenService:Create(
        Object,
        TweenInfo.new(
            Time or 0.25,
            Style or Enum.EasingStyle.Quint,
            Direction or Enum.EasingDirection.Out
        ),
        Properties
    )

    Animation:Play()

    return Animation
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

local function CreateText(Parent, Text, Size, Position, TextSize, Color, Font)
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

local function CreateImage(Parent, Asset, Size, Position, Transparency)
    local Image = Instance.new("ImageLabel")

    Image.Size = Size
    Image.Position = Position
    Image.BackgroundTransparency = 1
    Image.Image = Asset
    Image.ImageTransparency = Transparency or 0
    Image.ScaleType = Enum.ScaleType.Fit
    Image.Parent = Parent

    return Image
end

local function FadeOut(Root, Time)
    local function Apply(Object)
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
            end

            if Object:IsA("ImageLabel")
                or Object:IsA("ImageButton") then

                if Object.ImageTransparency < 1 then
                    Properties.ImageTransparency = 1
                end
            end

            if next(Properties) then
                Tween(Object, Time, Properties)
            end
        elseif Object:IsA("UIStroke") then
            Tween(Object, Time, {
                Transparency = 1
            })
        end
    end

    Apply(Root)

    for _, Object in ipairs(Root:GetDescendants()) do
        Apply(Object)
    end
end

function Loading.Create(Total)
    Total = math.max(1, tonumber(Total) or 1)

    local Object = {
        Total = Total,
        Current = 0,
        Closed = false,
        Finishing = false,
        StartTime = os.clock(),
        MinimumDuration = 1.25
    }

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

    local Overlay = Instance.new("Frame")
    Overlay.Name = "Overlay"
    Overlay.Size = UDim2.fromScale(1, 1)
    Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    Overlay.BackgroundTransparency = 0.58
    Overlay.BorderSizePixel = 0
    Overlay.ZIndex = 1
    Overlay.Parent = ScreenGui

    Object.Overlay = Overlay

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.new(0.73, 0, 0.56, 0)
    Main.Position = UDim2.new(0.135, 0, 0.22, 0)
    Main.BackgroundTransparency = 1
    Main.BorderSizePixel = 0
    Main.ZIndex = 10
    Main.Parent = ScreenGui

    local function CreateCornerLine(Position, Size)
        local Line = Instance.new("Frame")
        Line.Size = Size
        Line.Position = Position
        Line.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
        Line.BackgroundTransparency = 0.52
        Line.BorderSizePixel = 0
        Line.ZIndex = 11
        Line.Parent = Main
        return Line
    end

    CreateCornerLine(
        UDim2.fromScale(0, 0),
        UDim2.fromOffset(70, 1)
    )

    CreateCornerLine(
        UDim2.fromScale(0, 0),
        UDim2.fromOffset(1, 22)
    )

    CreateCornerLine(
        UDim2.new(1, -70, 0, 0),
        UDim2.fromOffset(70, 1)
    )

    CreateCornerLine(
        UDim2.new(1, -1, 0, 0),
        UDim2.fromOffset(1, 22)
    )

    CreateCornerLine(
        UDim2.new(0, 0, 1, -1),
        UDim2.fromOffset(70, 1)
    )

    CreateCornerLine(
        UDim2.new(0, 0, 1, -22),
        UDim2.fromOffset(1, 22)
    )

    CreateCornerLine(
        UDim2.new(1, -70, 1, -1),
        UDim2.fromOffset(70, 1)
    )

    CreateCornerLine(
        UDim2.new(1, -1, 1, -22),
        UDim2.fromOffset(1, 22)
    )

    local Center = Instance.new("Frame")
    Center.Name = "Center"
    Center.Size = UDim2.fromOffset(500, 300)
    Center.Position = UDim2.new(0.5, -250, 0.5, -150)
    Center.BackgroundTransparency = 1
    Center.ZIndex = 20
    Center.Parent = ScreenGui

    local LogoGlow = CreateImage(
        Center,
        LOGO_ASSET,
        UDim2.fromOffset(145, 145),
        UDim2.new(0.5, -72.5, 0, -2),
        0.94
    )

    LogoGlow.ImageColor3 = Color3.new(1, 1, 1)
    LogoGlow.ZIndex = 20

    local Logo = CreateImage(
        Center,
        LOGO_ASSET,
        UDim2.fromOffset(108, 108),
        UDim2.new(0.5, -54, 0, 16),
        0
    )

    Logo.ZIndex = 21

    local LeftLine = Instance.new("Frame")
    LeftLine.Size = UDim2.fromOffset(100, 1)
    LeftLine.Position = UDim2.new(0.5, -245, 0, 112)
    LeftLine.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    LeftLine.BackgroundTransparency = 0.35
    LeftLine.BorderSizePixel = 0
    LeftLine.ZIndex = 21
    LeftLine.Parent = Center

    local RightLine = LeftLine:Clone()
    RightLine.Position = UDim2.new(0.5, 145, 0, 112)
    RightLine.Parent = Center

    local Title = CreateText(
        Center,
        "OTC HUB",
        UDim2.fromOffset(500, 45),
        UDim2.new(0.5, -250, 0, 134),
        29,
        Color3.fromRGB(245, 245, 245),
        Enum.Font.GothamBlack
    )

    local Subtitle = CreateText(
        Center,
        "YOUR HUB. YOUR CONTROL.",
        UDim2.fromOffset(500, 20),
        UDim2.new(0.5, -250, 0, 177),
        9,
        Color3.fromRGB(125, 125, 125),
        Enum.Font.Gotham
    )

    local BarBackground = Instance.new("Frame")
    BarBackground.Size = UDim2.fromOffset(325, 3)
    BarBackground.Position = UDim2.new(0.5, -162.5, 0, 218)
    BarBackground.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    BarBackground.BackgroundTransparency = 0.2
    BarBackground.BorderSizePixel = 0
    BarBackground.ZIndex = 22
    BarBackground.Parent = Center
    Corner(BarBackground, 999)

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(0, 0, 1, 0)
    Bar.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    Bar.BorderSizePixel = 0
    Bar.ZIndex = 23
    Bar.Parent = BarBackground
    Corner(Bar, 999)

    local Percentage = CreateText(
        Center,
        "0%",
        UDim2.fromOffset(325, 18),
        UDim2.new(0.5, -162.5, 0, 232),
        8,
        Color3.fromRGB(150, 150, 150),
        Enum.Font.Gotham
    )

    local Status = CreateText(
        ScreenGui,
        "Initializing OTC Hub...",
        UDim2.fromOffset(600, 22),
        UDim2.new(0.5, -300, 0.79, 0),
        10,
        Color3.fromRGB(165, 165, 165),
        Enum.Font.Gotham
    )

    Status.TextTruncate = Enum.TextTruncate.AtEnd
    Status.ZIndex = 25

    local Detail = CreateText(
        ScreenGui,
        "Preparing modules...",
        UDim2.fromOffset(600, 18),
        UDim2.new(0.5, -300, 0.82, 0),
        8,
        Color3.fromRGB(105, 105, 105),
        Enum.Font.Gotham
    )

    Detail.TextTruncate = Enum.TextTruncate.AtEnd
    Detail.ZIndex = 25

    local Skip = Instance.new("TextButton")
    Skip.Size = UDim2.fromOffset(70, 25)
    Skip.Position = UDim2.new(1, -82, 1, -32)
    Skip.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Skip.BackgroundTransparency = 0.15
    Skip.BorderSizePixel = 0
    Skip.Text = "SKIP"
    Skip.TextColor3 = Color3.fromRGB(220, 220, 220)
    Skip.TextSize = 8
    Skip.Font = Enum.Font.GothamMedium
    Skip.AutoButtonColor = false
    Skip.ZIndex = 31
    Skip.Parent = ScreenGui
    Corner(Skip, 3)
    local SkipStroke = Stroke(Skip, Color3.fromRGB(100, 100, 100), 1, 0.5)

    Object.Main = Main
    Object.Center = Center
    Object.Logo = Logo
    Object.LogoGlow = LogoGlow
    Object.Title = Title
    Object.Subtitle = Subtitle
    Object.Status = Status
    Object.Detail = Detail
    Object.Percentage = Percentage
    Object.Bar = Bar
    Object.BarBackground = BarBackground
    Object.SkipButton = Skip

    Center.Position = UDim2.new(0.5, -250, 0.5, -130)

    Logo.ImageTransparency = 1
    LogoGlow.ImageTransparency = 1
    Title.TextTransparency = 1
    Subtitle.TextTransparency = 1
    LeftLine.BackgroundTransparency = 1
    RightLine.BackgroundTransparency = 1
    BarBackground.BackgroundTransparency = 1
    Percentage.TextTransparency = 1
    Status.TextTransparency = 1
    Detail.TextTransparency = 1
    Skip.BackgroundTransparency = 1
    Skip.TextTransparency = 1
    SkipStroke.Transparency = 1

    Tween(Center, 0.7, {
        Position = UDim2.new(0.5, -250, 0.5, -150)
    })

    Tween(Logo, 0.65, {ImageTransparency = 0})
    Tween(LogoGlow, 0.8, {ImageTransparency = 0.92})
    Tween(LeftLine, 0.65, {BackgroundTransparency = 0.35})
    Tween(RightLine, 0.65, {BackgroundTransparency = 0.35})
    Tween(Title, 0.65, {TextTransparency = 0})
    Tween(Subtitle, 0.75, {TextTransparency = 0})
    Tween(BarBackground, 0.75, {BackgroundTransparency = 0.2})
    Tween(Percentage, 0.8, {TextTransparency = 0})
    Tween(Status, 0.8, {TextTransparency = 0})
    Tween(Detail, 0.85, {TextTransparency = 0})
    Tween(Skip, 0.8, {
        BackgroundTransparency = 0.15,
        TextTransparency = 0
    })
    Tween(SkipStroke, 0.8, {Transparency = 0.5})

    Object.Connection = RunService.RenderStepped:Connect(function()
        if Object.Closed then
            return
        end

        local Time = os.clock()

        LogoGlow.ImageTransparency =
            0.91 + math.sin(Time * 2.5) * 0.025

        LogoGlow.Rotation =
            math.sin(Time * 0.45) * 2
    end)

    function Object:Update(Current, StatusText, DetailText)
        if self.Closed then
            return
        end

        self.Current = math.clamp(
            tonumber(Current) or 0,
            0,
            self.Total
        )

        local Progress = self.Current / self.Total

        self.Status.Text =
            StatusText or "Loading OTC Hub..."

        self.Detail.Text =
            DetailText or ""

        self.Percentage.Text =
            tostring(math.floor(Progress * 100)) .. "%"

        Tween(self.Bar, 0.3, {
            Size = UDim2.new(
                Progress,
                0,
                1,
                0
            )
        })
    end

    local SkipConnection

    SkipConnection = Skip.MouseButton1Click:Connect(function()
        if not Object.Closed and not Object.Finishing then
            Object:Finish()
        end
    end)

    Object.SkipConnection = SkipConnection

    function Object:Finish()
        if self.Closed or self.Finishing then
            return
        end

        self.Finishing = true

        local Remaining =
            self.MinimumDuration
            - (os.clock() - self.StartTime)

        if Remaining > 0 then
            task.wait(Remaining)
        end

        self:Update(
            self.Total,
            "OTC Hub ready!",
            "Initialization complete"
        )

        task.wait(0.2)

        if self.Connection then
            self.Connection:Disconnect()
            self.Connection = nil
        end

        if self.SkipConnection then
            self.SkipConnection:Disconnect()
            self.SkipConnection = nil
        end

        FadeOut(ScreenGui, 0.55)

        task.wait(0.65)

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

        if self.Connection then
            self.Connection:Disconnect()
            self.Connection = nil
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
