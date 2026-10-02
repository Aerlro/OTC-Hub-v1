--[[
    OTC Hub v1
    Button Element
    by Aerlro
]]

local Button = {}

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

function Button.Create(Tab, OTC, Settings)

    Settings = Settings or {}

    local Theme = OTC:GetTheme()

    local Name = Settings.Name or "Button"
    local Description = Settings.Description
    local Callback = Settings.Callback or function() end

    local FrameHeight = Description and 62 or 48

    local Frame = create("Frame", {
        Name = "Button",

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

    -- Button area
    local ButtonObject = create("TextButton", {
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

        Parent = ButtonObject,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(15, Description and 10 or 0),

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

            Parent = ButtonObject,

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

    -- Execute text
    local Execute = create("TextLabel", {
        Name = "Execute",

        Parent = ButtonObject,

        BackgroundTransparency = 1,

        AnchorPoint = Vector2.new(1, 0.5),

        Position = UDim2.new(1, -15, 0.5, 0),

        Size = UDim2.fromOffset(55, 25),

        Font = Enum.Font.GothamMedium,

        Text = "EXECUTE",

        TextColor3 = Theme.Accent,

        TextSize = 10,

        TextXAlignment = Enum.TextXAlignment.Right,

        TextYAlignment = Enum.TextYAlignment.Center
    })

    -- Hover
    ButtonObject.MouseEnter:Connect(function()

        tween(Frame, 0.15, {
            BackgroundColor3 = Theme.Hover
        })

        tween(Stroke, 0.15, {
            Color = Theme.AccentDark
        })

        tween(Execute, 0.15, {
            TextColor3 = Theme.Text
        })

    end)

    ButtonObject.MouseLeave:Connect(function()

        tween(Frame, 0.15, {
            BackgroundColor3 = Theme.Element
        })

        tween(Stroke, 0.15, {
            Color = Theme.Border
        })

        tween(Execute, 0.15, {
            TextColor3 = Theme.Accent
        })

    end)

    -- Click animation
    ButtonObject.MouseButton1Down:Connect(function()

        tween(Frame, 0.08, {
            Size = UDim2.new(1, -4, 0, FrameHeight - 2)
        })

    end)

    ButtonObject.MouseButton1Up:Connect(function()

        tween(Frame, 0.12, {
            Size = UDim2.new(1, 0, 0, FrameHeight)
        })

    end)

    -- Callback
    ButtonObject.MouseButton1Click:Connect(function()

        local Success, Error = pcall(Callback)

        if not Success then
            warn("[OTC Hub] Button callback error:", Error)
        end

    end)

    local Object = {}

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
    Object.Button = ButtonObject

    Tab:AddElement(Object)

    return Object
end

return Button