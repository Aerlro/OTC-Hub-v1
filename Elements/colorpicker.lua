local Colorpicker = {}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local function create(Class, Properties)
    local Object = Instance.new(Class)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    return Object
end

local function tween(Object, Time, Properties)
    local Animation = TweenService:Create(
        Object,
        TweenInfo.new(
            Time or 0.15,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        Properties
    )

    Animation:Play()

    return Animation
end

local function corner(Object, Radius)
    local UI = Instance.new("UICorner")
    UI.CornerRadius = UDim.new(0, Radius)
    UI.Parent = Object
end

local function stroke(Object, Theme, Transparency)
    local UI = Instance.new("UIStroke")
    UI.Color = Theme.Border or Color3.new(1, 1, 1)
    UI.Thickness = Theme.Stroke and Theme.Stroke.Thickness or 1
    UI.Transparency = Transparency or (Theme.Stroke and Theme.Stroke.Transparency or 0)
    UI.Parent = Object
    return UI
end

local function gradient(Object, Colors, Rotation)
    local UI = Instance.new("UIGradient")
    UI.Color = ColorSequence.new(Colors)
    UI.Rotation = Rotation or 0
    UI.Parent = Object
    return UI
end

function Colorpicker.Create(Tab, OTC, Settings)
    Settings = Settings or {}

    local Theme = OTC._Themes[Tab.Window.Theme]
        or OTC._Themes[OTC.CurrentTheme]
        or OTC._Themes.Default

    local Name = Settings.Name or "Color"
    local Description = Settings.Description
    local Flag = Settings.Flag
    local Callback = Settings.Callback or function() end

    local Default = Settings.Default
        or Settings.CurrentColor
        or Color3.fromRGB(255, 255, 255)

    if typeof(Default) ~= "Color3" then
        Default = Color3.fromRGB(255, 255, 255)
    end

    local CurrentColor = Default

    local Frame = create("Frame", {
        Name = "Colorpicker",
        Parent = Tab.Page,
        Size = UDim2.new(1, 0, 0, Description and 62 or 48),
        BackgroundColor3 = Theme.Element,
        BackgroundTransparency = Theme.Transparency and Theme.Transparency.Element or 0,
        BorderSizePixel = 0
    })

    corner(Frame, Theme.Corners and Theme.Corners.Element or 8)
    local FrameStroke = stroke(Frame, Theme)

    local Title = create("TextLabel", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(14, Description and 9 or 0),
        Size = UDim2.new(1, -120, 0, 22),
        Font = Enum.Font.GothamMedium,
        Text = Name,
        TextColor3 = Theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })

    local DescriptionLabel

    if Description then
        DescriptionLabel = create("TextLabel", {
            Parent = Frame,
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(14, 31),
            Size = UDim2.new(1, -120, 0, 18),
            Font = Enum.Font.Gotham,
            Text = Description,
            TextColor3 = Theme.SubText,
            TextSize = 9,
            TextXAlignment = Enum.TextXAlignment.Left
        })
    end

    local Preview = create("TextButton", {
        Parent = Frame,
        Size = UDim2.fromOffset(54, 30),
        Position = UDim2.new(1, -68, 0.5, -15),
        BackgroundColor3 = CurrentColor,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false
    })

    corner(Preview, Theme.Corners and Theme.Corners.Button or 8)
    local PreviewStroke = stroke(Preview, Theme, 0.2)

    local Popup = create("Frame", {
        Name = "ColorPopup",
        Parent = Tab.Window.ScreenGui,
        Size = UDim2.fromOffset(235, 235),
        Position = UDim2.fromOffset(0, 0),
        BackgroundColor3 = Theme.PopupBackground or Theme.Background,
        BackgroundTransparency = Theme.Transparency and Theme.Transparency.Popup or 0,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 300
    })

    corner(Popup, Theme.Corners and Theme.Corners.Popup or 12)
    local PopupStroke = stroke(Popup, Theme, 0.1)

    local Saturation = create("Frame", {
        Parent = Popup,
        Size = UDim2.fromOffset(200, 145),
        Position = UDim2.fromOffset(12, 12),
        BackgroundColor3 = Color3.fromRGB(255, 0, 0),
        BorderSizePixel = 0,
        ZIndex = 301
    })

    corner(Saturation, 8)

    gradient(Saturation, {
        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    }, 0)

    local Black = create("Frame", {
        Parent = Saturation,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 302
    })

    corner(Black, 8)

    gradient(Black, {
        ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
    }, 90).Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    })

    local SatKnob = create("Frame", {
        Parent = Saturation,
        Size = UDim2.fromOffset(10, 10),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        ZIndex = 304
    })

    corner(SatKnob, 999)
    stroke(SatKnob, {Border = Color3.new(0, 0, 0), Stroke = {Thickness = 1, Transparency = 0}}, 0)

    local Hue = create("Frame", {
        Parent = Popup,
        Size = UDim2.fromOffset(200, 12),
        Position = UDim2.fromOffset(12, 166),
        BorderSizePixel = 0,
        ZIndex = 301
    })

    corner(Hue, 999)

    gradient(Hue, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.166, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.666, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    }, 0)

    local HueKnob = create("Frame", {
        Parent = Hue,
        Size = UDim2.fromOffset(8, 16),
        Position = UDim2.new(0, -4, 0.5, -8),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        ZIndex = 303
    })

    corner(HueKnob, 999)

    local Hex = create("TextLabel", {
        Parent = Popup,
        Size = UDim2.fromOffset(200, 22),
        Position = UDim2.fromOffset(12, 190),
        BackgroundTransparency = 1,
        TextColor3 = Theme.SubText,
        TextSize = 9,
        Font = Enum.Font.Gotham,
        Text = "#FFFFFF",
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 302
    })

    local HueValue, SaturationValue, Value = Color3.toHSV(CurrentColor)
    local DragConnection

    local function updateColor(RunCallback)
        CurrentColor = Color3.fromHSV(
            HueValue,
            SaturationValue,
            Value
        )

        Preview.BackgroundColor3 = CurrentColor
        Saturation.BackgroundColor3 = Color3.fromHSV(HueValue, 1, 1)

        SatKnob.Position = UDim2.new(
            SaturationValue,
            -5,
            1 - Value,
            -5
        )

        HueKnob.Position = UDim2.new(
            HueValue,
            -4,
            0.5,
            -8
        )

        local R = math.floor(CurrentColor.R * 255 + 0.5)
        local G = math.floor(CurrentColor.G * 255 + 0.5)
        local B = math.floor(CurrentColor.B * 255 + 0.5)

        Hex.Text = string.format("#%02X%02X%02X", R, G, B)

        if Flag then
            OTC:SetFlag(Flag, CurrentColor)
        end

        if RunCallback then
            task.spawn(function()
                pcall(Callback, CurrentColor)
            end)
        end
    end

    local function pointFrom(inputPosition, Object)
        local RelativeX = math.clamp(
            inputPosition.X - Object.AbsolutePosition.X,
            0,
            Object.AbsoluteSize.X
        )

        local RelativeY = math.clamp(
            inputPosition.Y - Object.AbsolutePosition.Y,
            0,
            Object.AbsoluteSize.Y
        )

        return RelativeX / Object.AbsoluteSize.X,
            RelativeY / Object.AbsoluteSize.Y
    end

    local function startDrag(Object, CallbackFunction)
        if DragConnection then
            DragConnection:Disconnect()
        end

        local MoveConnection
        local EndConnection

        local function move(Input)
            if Input.UserInputType ~= Enum.UserInputType.MouseMovement
                and Input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end

            local X, Y = pointFrom(Input.Position, Object)
            CallbackFunction(X, Y)
        end

        MoveConnection = UserInputService.InputChanged:Connect(move)
        EndConnection = UserInputService.InputEnded:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1
                or Input.UserInputType == Enum.UserInputType.Touch then
                if MoveConnection then
                    MoveConnection:Disconnect()
                end
                if EndConnection then
                    EndConnection:Disconnect()
                end
            end
        end)

        DragConnection = EndConnection
    end

    Saturation.InputBegan:Connect(function(Input)
        if Input.UserInputType ~= Enum.UserInputType.MouseButton1
            and Input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local X, Y = pointFrom(Input.Position, Saturation)
        SaturationValue = X
        Value = 1 - Y
        updateColor(true)
        startDrag(Saturation, function(NewX, NewY)
            SaturationValue = NewX
            Value = 1 - NewY
            updateColor(true)
        end)
    end)

    Hue.InputBegan:Connect(function(Input)
        if Input.UserInputType ~= Enum.UserInputType.MouseButton1
            and Input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local X = pointFrom(Input.Position, Hue)
        HueValue = math.clamp(X, 0, 1)
        updateColor(true)
        startDrag(Hue, function(NewX)
            HueValue = math.clamp(NewX, 0, 1)
            updateColor(true)
        end)
    end)

    local Open = false

    local function positionPopup()
        local Absolute = Preview.AbsolutePosition
        local Size = Preview.AbsoluteSize
        local Camera = workspace.CurrentCamera
        local Viewport = Camera and Camera.ViewportSize or Vector2.new(1920, 1080)

        local X = Absolute.X + Size.X - 235
        local Y = Absolute.Y + Size.Y + 8

        if X < 8 then
            X = 8
        end

        if X + 235 > Viewport.X - 8 then
            X = Viewport.X - 243
        end

        if Y + 235 > Viewport.Y - 8 then
            Y = Absolute.Y - 243
        end

        Popup.Position = UDim2.fromOffset(X, Y)
    end

    local function close()
        Open = false
        tween(Popup, 0.15, {
            BackgroundTransparency = 1
        })
        task.delay(0.16, function()
            if not Open and Popup then
                Popup.Visible = false
            end
        end)
    end

    Preview.MouseButton1Click:Connect(function()
        Open = not Open

        if Open then
            positionPopup()
            Popup.Visible = true
            Popup.BackgroundTransparency = 1
            tween(Popup, 0.18, {
                BackgroundTransparency = Theme.Transparency and Theme.Transparency.Popup or 0
            })
        else
            close()
        end
    end)

    UserInputService.InputBegan:Connect(function(Input, Processed)
        if Processed or not Open then
            return
        end

        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            local Position = Input.Position
            local P = Popup.AbsolutePosition
            local S = Popup.AbsoluteSize

            if Position.X < P.X
                or Position.X > P.X + S.X
                or Position.Y < P.Y
                or Position.Y > P.Y + S.Y then
                close()
            end
        end
    end)

    local Object = {
        Type = "Colorpicker",
        Instance = Frame,
        Preview = Preview,
        Popup = Popup,
        Title = Title,
        Description = DescriptionLabel
    }

    function Object:SetValue(Color)
        if typeof(Color) ~= "Color3" then
            return
        end

        CurrentColor = Color
        HueValue, SaturationValue, Value = Color3.toHSV(Color)
        updateColor(false)
    end

    function Object:GetValue()
        return CurrentColor
    end

    function Object:SetCallback(NewCallback)
        if type(NewCallback) == "function" then
            Callback = NewCallback
        end
    end

    function Object:RefreshTheme()
        local CurrentTheme = OTC._Themes[Tab.Window.Theme]
            or OTC._Themes[OTC.CurrentTheme]
            or OTC._Themes.Default

        Frame.BackgroundColor3 = CurrentTheme.Element
        Title.TextColor3 = CurrentTheme.Text
        PreviewStroke.Color = CurrentTheme.Border
        FrameStroke.Color = CurrentTheme.Border
        Popup.BackgroundColor3 = CurrentTheme.PopupBackground or CurrentTheme.Background
        PopupStroke.Color = CurrentTheme.PopupBorder or CurrentTheme.Border

        if DescriptionLabel then
            DescriptionLabel.TextColor3 = CurrentTheme.SubText
        end
    end

    function Object:Destroy()
        if DragConnection then
            DragConnection:Disconnect()
            DragConnection = nil
        end

        if Popup then
            Popup:Destroy()
        end

        Frame:Destroy()
    end

    updateColor(false)
    Tab:AddElement(Object)

    return Object
end

return Colorpicker
