--[[
    OTC Hub v1
    Toggle Element
    by Aerlro
]]

local Toggle = {}

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
            Time or 0.2,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        Properties
    )

    Animation:Play()

    return Animation
end

function Toggle.Create(Tab, OTC, Settings)

    Settings = Settings or {}

    local Theme = OTC:GetTheme()

    local Name = Settings.Name or "Toggle"
    local Description = Settings.Description
    local Flag = Settings.Flag
    local CurrentValue = Settings.CurrentValue == true
    local Callback = Settings.Callback or function() end

    local FrameHeight = Description and 62 or 48

    local Frame = create("Frame", {
        Name = "Toggle",

        Parent = Tab.Page,

        BackgroundColor3 = Theme.Element,

        BorderSizePixel = 0,

        Size = UDim2.new(1, 0, 0, FrameHeight)
    })

    create("UICorner", {
        Parent = Frame,

        CornerRadius = UDim.new(0, 8)
    })

    local Stroke = create("UIStroke", {
        Parent = Frame,

        Color = Theme.Border,

        Thickness = 1
    })

    local Button = create("TextButton", {
        Name = "Button",

        Parent = Frame,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Size = UDim2.new(1, 0, 1, 0),

        AutoButtonColor = false,

        Text = ""
    })

    -- Title
    local Title = create("TextLabel", {
        Name = "Title",

        Parent = Button,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(15, Description and 9 or 0),

        Size = UDim2.new(1, -90, 0, 22),

        Font = Enum.Font.GothamMedium,

        Text = Name,

        TextColor3 = Theme.Text,

        TextSize = 13,

        TextXAlignment = Enum.TextXAlignment.Left,

        TextYAlignment = Enum.TextYAlignment.Center
    })

    -- Description
    local DescriptionLabel

    if Description then

        DescriptionLabel = create("TextLabel", {
            Name = "Description",

            Parent = Button,

            BackgroundTransparency = 1,

            Position = UDim2.fromOffset(15, 31),

            Size = UDim2.new(1, -90, 0, 20),

            Font = Enum.Font.Gotham,

            Text = Description,

            TextColor3 = Theme.SubText,

            TextSize = 11,

            TextWrapped = true,

            TextXAlignment = Enum.TextXAlignment.Left,

            TextYAlignment = Enum.TextYAlignment.Center
        })

    end

    -- Toggle background
    local ToggleBackground = create("Frame", {
        Name = "ToggleBackground",

        Parent = Button,

        BackgroundColor3 = Theme.Background,

        BorderSizePixel = 0,

        AnchorPoint = Vector2.new(1, 0.5),

        Position = UDim2.new(1, -15, 0.5, 0),

        Size = UDim2.fromOffset(42, 22)
    })

    create("UICorner", {
        Parent = ToggleBackground,

        CornerRadius = UDim.new(1, 0)
    })

    local ToggleStroke = create("UIStroke", {
        Parent = ToggleBackground,

        Color = Theme.Border,

        Thickness = 1
    })

    -- Toggle circle
    local Circle = create("Frame", {
        Name = "Circle",

        Parent = ToggleBackground,

        BackgroundColor3 = Theme.SubText,

        BorderSizePixel = 0,

        Position = UDim2.fromOffset(3, 3),

        Size = UDim2.fromOffset(16, 16)
    })

    create("UICorner", {
        Parent = Circle,

        CornerRadius = UDim.new(1, 0)
    })

    local function updateVisual()

        if CurrentValue then

            tween(ToggleBackground, 0.2, {
                BackgroundColor3 = Theme.Accent
            })

            tween(ToggleStroke, 0.2, {
                Color = Theme.Accent
            })

            tween(Circle, 0.2, {
                Position = UDim2.new(1, -19, 0, 3),
                BackgroundColor3 = Theme.Background
            })

        else

            tween(ToggleBackground, 0.2, {
                BackgroundColor3 = Theme.Background
            })

            tween(ToggleStroke, 0.2, {
                Color = Theme.Border
            })

            tween(Circle, 0.2, {
                Position = UDim2.fromOffset(3, 3),
                BackgroundColor3 = Theme.SubText
            })

        end

    end

    local function setValue(Value, RunCallback)

        CurrentValue = Value == true

        updateVisual()

        if Flag then
            OTC:SetFlag(Flag, CurrentValue)
        end

        if RunCallback then

            local Success, Error = pcall(
                Callback,
                CurrentValue
            )

            if not Success then
                warn(
                    "[OTC Hub] Toggle callback error:",
                    Error
                )
            end

        end

    end

    Button.MouseEnter:Connect(function()

        tween(Frame, 0.15, {
            BackgroundColor3 = Theme.Hover
        })

    end)

    Button.MouseLeave:Connect(function()

        tween(Frame, 0.15, {
            BackgroundColor3 = Theme.Element
        })

    end)

    Button.MouseButton1Click:Connect(function()

        setValue(
            not CurrentValue,
            true
        )

    end)

    -- Initialize
    setValue(CurrentValue, false)

    local Object = {}

    function Object:SetValue(Value)

        setValue(
            Value,
            true
        )

    end

    function Object:GetValue()

        return CurrentValue

    end

    function Object:SetName(NewName)

        Name = NewName
        Title.Text = NewName

    end

    function Object:SetDescription(NewDescription)

        if DescriptionLabel then
            DescriptionLabel.Text = NewDescription
        end

    end

    function Object:SetCallback(NewCallback)

        if type(NewCallback) == "function" then
            Callback = NewCallback
        end

    end

    function Object:Destroy()

        Frame:Destroy()

    end

    Object.Instance = Frame
    Object.Button = Button

    Tab:AddElement(Object)

    return Object
end

return Toggle