--[[
    OTC Hub v1
    Input Element
    by Aerlro
]]

local Input = {}

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

function Input.Create(Tab, OTC, Settings)

    Settings = Settings or {}

    local Theme = OTC:GetTheme()

    local Name = Settings.Name or "Input"
    local Description = Settings.Description
    local Placeholder = Settings.Placeholder or "Enter text..."
    local CurrentValue = tostring(Settings.CurrentValue or "")
    local Flag = Settings.Flag
    local ClearTextOnFocus = Settings.ClearTextOnFocus == true
    local Numeric = Settings.Numeric == true
    local MaxLength = tonumber(Settings.MaxLength)

    local Callback = Settings.Callback or function() end

    local FrameHeight = Description and 82 or 68

    local Frame = create("Frame", {
        Name = "Input",

        Parent = Tab.Page,

        BackgroundColor3 = Theme.Element,

        BorderSizePixel = 0,

        Size = UDim2.new(
            1,
            0,
            0,
            FrameHeight
        )
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

    -- Title
    local Title = create("TextLabel", {
        Name = "Title",

        Parent = Frame,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(
            15,
            8
        ),

        Size = UDim2.new(
            1,
            -30,
            0,
            20
        ),

        Font = Enum.Font.GothamMedium,

        Text = Name,

        TextColor3 = Theme.Text,

        TextSize = 13,

        TextXAlignment = Enum.TextXAlignment.Left
    })

    -- Description
    if Description then

        create("TextLabel", {
            Name = "Description",

            Parent = Frame,

            BackgroundTransparency = 1,

            Position = UDim2.fromOffset(
                15,
                28
            ),

            Size = UDim2.new(
                1,
                -30,
                0,
                18
            ),

            Font = Enum.Font.Gotham,

            Text = Description,

            TextColor3 = Theme.SubText,

            TextSize = 10,

            TextXAlignment = Enum.TextXAlignment.Left
        })

    end

    -- Input container
    local InputFrame = create("Frame", {
        Name = "InputFrame",

        Parent = Frame,

        BackgroundColor3 = Theme.Background,

        BorderSizePixel = 0,

        Position = UDim2.new(
            0,
            15,
            1,
            -40
        ),

        Size = UDim2.new(
            1,
            -30,
            0,
            32
        )
    })

    create("UICorner", {
        Parent = InputFrame,

        CornerRadius = UDim.new(0, 6)
    })

    local InputStroke = create("UIStroke", {
        Parent = InputFrame,

        Color = Theme.Border,

        Thickness = 1
    })

    local TextBox = create("TextBox", {
        Name = "TextBox",

        Parent = InputFrame,

        BackgroundTransparency = 1,

        ClearTextOnFocus = ClearTextOnFocus,

        Position = UDim2.fromOffset(
            10,
            0
        ),

        Size = UDim2.new(
            1,
            -20,
            1,
            0
        ),

        Font = Enum.Font.Gotham,

        PlaceholderText = Placeholder,

        PlaceholderColor3 = Theme.SubText,

        Text = CurrentValue,

        TextColor3 = Theme.Text,

        TextSize = 11,

        TextXAlignment = Enum.TextXAlignment.Left,

        TextYAlignment = Enum.TextYAlignment.Center
    })

    local function sanitize(Text)

        if Numeric then

            Text = Text:gsub(
                "[^%d%.%-]",
                ""
            )

        end

        if MaxLength then

            Text = string.sub(
                Text,
                1,
                MaxLength
            )

        end

        return Text

    end

    TextBox.FocusGained:Connect(
        function()

            tween(
                InputStroke,
                0.15,
                {
                    Color = Theme.Accent
                }
            )

        end
    )

    TextBox.FocusLost:Connect(
        function()

            tween(
                InputStroke,
                0.15,
                {
                    Color = Theme.Border
                }
            )

            local Text =
                sanitize(
                    TextBox.Text
                )

            TextBox.Text = Text
            CurrentValue = Text

            if Flag then

                OTC:SetFlag(
                    Flag,
                    CurrentValue
                )

            end

            local Success, Error =
                pcall(
                    Callback,
                    CurrentValue
                )

            if not Success then

                warn(
                    "[OTC Hub] Input callback error:",
                    Error
                )

            end

        end
    )

    TextBox:GetPropertyChangedSignal(
        "Text"
    ):Connect(
        function()

            local Text =
                sanitize(
                    TextBox.Text
                )

            if Text ~= TextBox.Text then
                TextBox.Text = Text
            end

        end
    )

    -- Hover
    InputFrame.MouseEnter:Connect(
        function()

            if not TextBox:IsFocused() then

                tween(
                    InputStroke,
                    0.15,
                    {
                        Color = Theme.AccentDark
                    }
                )

            end

        end
    )

    InputFrame.MouseLeave:Connect(
        function()

            if not TextBox:IsFocused() then

                tween(
                    InputStroke,
                    0.15,
                    {
                        Color = Theme.Border
                    }
                )

            end

        end
    )

    if Flag then

        OTC:SetFlag(
            Flag,
            CurrentValue
        )

    end

    local Object = {}

    function Object:SetValue(Value)

        CurrentValue =
            tostring(Value or "")

        TextBox.Text =
            CurrentValue

        if Flag then

            OTC:SetFlag(
                Flag,
                CurrentValue
            )

        end

    end

    function Object:GetValue()

        return CurrentValue

    end

    function Object:SetPlaceholder(Value)

        TextBox.PlaceholderText =
            tostring(Value or "")

    end

    function Object:SetName(NewName)

        Name = NewName
        Title.Text = NewName

    end

    function Object:SetCallback(NewCallback)

        if type(NewCallback) == "function" then
            Callback = NewCallback
        end

    end

    function Object:Focus()

        TextBox:CaptureFocus()

    end

    function Object:Clear()

        CurrentValue = ""
        TextBox.Text = ""

        if Flag then

            OTC:SetFlag(
                Flag,
                ""
            )

        end

    end

    function Object:Destroy()

        Frame:Destroy()

    end

    Object.Instance = Frame
    Object.TextBox = TextBox

    Tab:AddElement(Object)

    return Object
end

return Input