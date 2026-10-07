local Keybind = {}

local UserInputService = game:GetService("UserInputService")

local function create(Class, Properties)
    local Object = Instance.new(Class)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    return Object
end

local function tween(TweenService, Object, Time, Properties)
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

function Keybind.Create(Tab, OTC, Settings)
    Settings = Settings or {}

    local TweenService = game:GetService("TweenService")

    local Theme = OTC._Themes[OTC.CurrentTheme]
        or OTC._Themes[Tab.Window.Theme]
        or OTC._Themes.Default

    local Name = Settings.Name or "Keybind"
    local Description = Settings.Description
    local Flag = Settings.Flag
    local Callback = Settings.Callback or function() end

    local CurrentKey = OTC:GetFlag(
        Flag,
        Settings.Default or Settings.CurrentKey or Enum.KeyCode.Unknown
    )

    if typeof(CurrentKey) ~= "EnumItem" then
        CurrentKey = Settings.Default or Settings.CurrentKey or Enum.KeyCode.Unknown
    end

    local Frame = create("Frame", {
        Name = "Keybind",
        Parent = Tab.Page,
        Size = UDim2.new(1, 0, 0, Description and 62 or 48),
        BackgroundColor3 = Theme.Element,
        BackgroundTransparency = Theme.Transparency and Theme.Transparency.Element or 0,
        BorderSizePixel = 0
    })

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, Theme.Corners and Theme.Corners.Element or 8)
    Corner.Parent = Frame

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Theme.Border
    Stroke.Thickness = Theme.Stroke and Theme.Stroke.Thickness or 1
    Stroke.Transparency = Theme.Stroke and Theme.Stroke.Transparency or 0
    Stroke.Parent = Frame

    local Title = create("TextLabel", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(14, Description and 9 or 0),
        Size = UDim2.new(1, -130, 0, 22),
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
            Size = UDim2.new(1, -130, 0, 18),
            Font = Enum.Font.Gotham,
            Text = Description,
            TextColor3 = Theme.SubText,
            TextSize = 9,
            TextXAlignment = Enum.TextXAlignment.Left
        })
    end

    local Button = create("TextButton", {
        Parent = Frame,
        Size = UDim2.fromOffset(92, 30),
        Position = UDim2.new(1, -106, 0.5, -15),
        BackgroundColor3 = Theme.Input or Theme.Secondary,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = "None",
        TextColor3 = Theme.Text,
        TextSize = 10,
        Font = Enum.Font.GothamMedium
    })

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, Theme.Corners and Theme.Corners.Button or 8)
    ButtonCorner.Parent = Button

    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Color = Theme.Border
    ButtonStroke.Thickness = Theme.Stroke and Theme.Stroke.Thickness or 1
    ButtonStroke.Transparency = Theme.Stroke and Theme.Stroke.Transparency or 0
    ButtonStroke.Parent = Button

    local Listening = false
    local Connection

    local function displayKey(Key)
        if not Key or Key == Enum.KeyCode.Unknown then
            return "None"
        end

        return Key.Name:gsub("Left", "L "):gsub("Right", "R ")
    end

    local function setValue(Key, RunCallback)
        if typeof(Key) ~= "EnumItem" then
            Key = Enum.KeyCode.Unknown
        end

        CurrentKey = Key
        Button.Text = displayKey(Key)

        if Flag then
            OTC:SetFlag(Flag, CurrentKey)
        end

        if RunCallback then
            task.spawn(function()
                pcall(Callback, CurrentKey)
            end)
        end
    end

    Button.MouseEnter:Connect(function()
        tween(TweenService, Button, 0.12, {
            BackgroundColor3 = Theme.InputHover or Theme.Hover
        })
    end)

    Button.MouseLeave:Connect(function()
        tween(TweenService, Button, 0.12, {
            BackgroundColor3 = Theme.Input or Theme.Secondary
        })
    end)

    Button.MouseButton1Click:Connect(function()
        if Listening then
            return
        end

        Listening = true
        Button.Text = "Press key..."

        if Connection then
            Connection:Disconnect()
        end

        Connection = UserInputService.InputBegan:Connect(function(Input, Processed)
            if Processed then
                return
            end

            if Input.UserInputType == Enum.UserInputType.Keyboard then
                if Input.KeyCode == Enum.KeyCode.Escape then
                    Listening = false
                    setValue(CurrentKey, false)
                    Connection:Disconnect()
                    Connection = nil
                    return
                end

                Listening = false
                setValue(Input.KeyCode, true)
                Connection:Disconnect()
                Connection = nil
            end
        end)
    end)

    local Object = {
        Type = "Keybind",
        Instance = Frame,
        Button = Button,
        Title = Title,
        Description = DescriptionLabel
    }

    function Object:SetValue(Key)
        setValue(Key, false)
    end

    function Object:GetValue()
        return CurrentKey
    end

    function Object:SetCallback(NewCallback)
        if type(NewCallback) == "function" then
            Callback = NewCallback
        end
    end

    function Object:SetName(NewName)
        Title.Text = tostring(NewName or "")
    end

    function Object:RefreshTheme()
        local CurrentTheme = OTC._Themes[OTC.CurrentTheme]
            or OTC._Themes[Tab.Window.Theme]
            or OTC._Themes.Default

        Frame.BackgroundColor3 = CurrentTheme.Element
        Title.TextColor3 = CurrentTheme.Text
        Button.BackgroundColor3 = CurrentTheme.Input or CurrentTheme.Secondary
        Button.TextColor3 = CurrentTheme.Text
        Stroke.Color = CurrentTheme.Border
        ButtonStroke.Color = CurrentTheme.Border

        if DescriptionLabel then
            DescriptionLabel.TextColor3 = CurrentTheme.SubText
        end
    end

    function Object:Destroy()
        if Connection then
            Connection:Disconnect()
            Connection = nil
        end

        Frame:Destroy()
    end

    setValue(CurrentKey, false)
    Tab:AddElement(Object)

    return Object
end

return Keybind
