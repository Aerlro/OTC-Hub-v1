--[[
    OTC Hub v1
    Slider Element
    by Aerlro
]]

local Slider = {}

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
            Time or 0.2,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        Properties
    )

    Animation:Play()

    return Animation
end

function Slider.Create(Tab, OTC, Settings)

    Settings = Settings or {}

    local Theme = OTC:GetTheme()

    local Name = Settings.Name or "Slider"
    local Description = Settings.Description

    local Min = tonumber(Settings.Min) or 0
    local Max = tonumber(Settings.Max) or 100
    local Default = tonumber(Settings.Default) or Min
    local Increment = tonumber(Settings.Increment) or 1

    local Flag = Settings.Flag
    local Callback = Settings.Callback or function() end

    if Max < Min then
        Min, Max = Max, Min
    end

    local function round(Value)
        return math.floor(
            ((Value - Min) / Increment) + 0.5
        ) * Increment + Min
    end

    local function clamp(Value)
        return math.clamp(
            round(Value),
            Min,
            Max
        )
    end

    local CurrentValue = clamp(Default)

    local FrameHeight =
        Description and 78 or 64

    local Frame = create("Frame", {
        Name = "Slider",

        Parent = Tab.Page,

        BackgroundColor3 =
            Theme.Element,

        BorderSizePixel = 0,

        Size =
            UDim2.new(
                1,
                0,
                0,
                FrameHeight
            )
    })

    create("UICorner", {
        Parent = Frame,

        CornerRadius =
            UDim.new(0, 8)
    })

    local Stroke = create("UIStroke", {
        Parent = Frame,

        Color =
            Theme.Border,

        Thickness = 1
    })

    local Title = create("TextLabel", {
        Name = "Title",

        Parent = Frame,

        BackgroundTransparency = 1,

        Position =
            UDim2.fromOffset(
                15,
                8
            ),

        Size =
            UDim2.new(
                1,
                -90,
                0,
                22
            ),

        Font =
            Enum.Font.GothamMedium,

        Text =
            Name,

        TextColor3 =
            Theme.Text,

        TextSize = 13,

        TextXAlignment =
            Enum.TextXAlignment.Left
    })

    local ValueLabel = create("TextLabel", {
        Name = "Value",

        Parent = Frame,

        BackgroundTransparency = 1,

        AnchorPoint =
            Vector2.new(
                1,
                0
            ),

        Position =
            UDim2.new(
                1,
                -15,
                0,
                8
            ),

        Size =
            UDim2.fromOffset(
                65,
                22
            ),

        Font =
            Enum.Font.GothamMedium,

        Text =
            tostring(CurrentValue),

        TextColor3 =
            Theme.Accent,

        TextSize = 12,

        TextXAlignment =
            Enum.TextXAlignment.Right
    })

    local DescriptionLabel

    if Description then

        DescriptionLabel = create("TextLabel", {
            Name = "Description",

            Parent = Frame,

            BackgroundTransparency = 1,

            Position =
                UDim2.fromOffset(
                    15,
                    29
                ),

            Size =
                UDim2.new(
                    1,
                    -30,
                    0,
                    18
                ),

            Font =
                Enum.Font.Gotham,

            Text =
                Description,

            TextColor3 =
                Theme.SubText,

            TextSize = 10,

            TextXAlignment =
                Enum.TextXAlignment.Left
        })

    end

    local SliderBackground = create("Frame", {
        Name = "SliderBackground",

        Parent = Frame,

        BackgroundColor3 =
            Theme.Background,

        BorderSizePixel = 0,

        Position =
            UDim2.new(
                0,
                15,
                1,
                -25
            ),

        Size =
            UDim2.new(
                1,
                -30,
                0,
                6
            )
    })

    create("UICorner", {
        Parent =
            SliderBackground,

        CornerRadius =
            UDim.new(1, 0)
    })

    local Fill = create("Frame", {
        Name = "Fill",

        Parent =
            SliderBackground,

        BackgroundColor3 =
            Theme.Accent,

        BorderSizePixel = 0,

        Size =
            UDim2.new(
                0,
                0,
                1,
                0
            )
    })

    create("UICorner", {
        Parent = Fill,

        CornerRadius =
            UDim.new(1, 0)
    })

    local Knob = create("Frame", {
        Name = "Knob",

        Parent =
            SliderBackground,

        BackgroundColor3 =
            Theme.Text,

        BorderSizePixel = 0,

        AnchorPoint =
            Vector2.new(
                0.5,
                0.5
            ),

        Position =
            UDim2.new(
                0,
                0,
                0.5,
                0
            ),

        Size =
            UDim2.fromOffset(
                12,
                12
            )
    })

    create("UICorner", {
        Parent = Knob,

        CornerRadius =
            UDim.new(1, 0)
    })

    local KnobStroke = create("UIStroke", {
        Parent = Knob,

        Color =
            Theme.Accent,

        Thickness = 2
    })

    local Interaction = create("TextButton", {
        Name = "Interaction",

        Parent =
            SliderBackground,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Size =
            UDim2.new(
                1,
                0,
                1,
                0
            ),

        Text = "",

        AutoButtonColor = false
    })

    local Dragging = false

    local function getValueFromPosition(X)

        local AbsolutePosition =
            SliderBackground.AbsolutePosition.X

        local AbsoluteSize =
            SliderBackground.AbsoluteSize.X

        local Percent =
            math.clamp(
                (X - AbsolutePosition)
                    / AbsoluteSize,
                0,
                1
            )

        local Value =
            Min
                + ((Max - Min) * Percent)

        return clamp(Value)

    end

    local function update(Value, RunCallback)

        CurrentValue =
            clamp(Value)

        local Percent

        if Max == Min then

            Percent = 0

        else

            Percent =
                (CurrentValue - Min)
                / (Max - Min)

        end

        ValueLabel.Text =
            tostring(CurrentValue)

        tween(
            Fill,
            0.12,
            {
                Size =
                    UDim2.new(
                        Percent,
                        0,
                        1,
                        0
                    )
            }
        )

        tween(
            Knob,
            0.12,
            {
                Position =
                    UDim2.new(
                        Percent,
                        0,
                        0.5,
                        0
                    )
            }
        )

        if Flag then

            OTC:SetFlag(
                Flag,
                CurrentValue
            )

        end

        if RunCallback then

            local Success, Error =
                pcall(
                    Callback,
                    CurrentValue
                )

            if not Success then

                warn(
                    "[OTC Hub] Slider callback error:",
                    Error
                )

            end

        end

    end

    Interaction.MouseButton1Down:Connect(
        function()

            Dragging = true

            local Value =
                getValueFromPosition(
                    UserInputService
                        :GetMouseLocation()
                        .X
                )

            update(
                Value,
                true
            )

        end
    )

    UserInputService.InputChanged:Connect(
        function(Input)

            if not Dragging then
                return
            end

            if Input.UserInputType ==
                Enum.UserInputType.MouseMovement
                or Input.UserInputType ==
                Enum.UserInputType.Touch then

                local Value =
                    getValueFromPosition(
                        Input.Position.X
                    )

                update(
                    Value,
                    true
                )

            end

        end
    )

    UserInputService.InputEnded:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseButton1
                or Input.UserInputType ==
                Enum.UserInputType.Touch then

                Dragging = false

            end

        end
    )

    Interaction.MouseEnter:Connect(
        function()

            local CurrentTheme =
                OTC._Themes[
                    Tab.Window.Theme
                ]
                or OTC._Themes.Default

            tween(
                Knob,
                0.15,
                {
                    Size =
                        UDim2.fromOffset(
                            15,
                            15
                        )
                }
            )

            tween(
                Stroke,
                0.15,
                {
                    Color =
                        CurrentTheme.AccentDark
                }
            )

        end
    )

    Interaction.MouseLeave:Connect(
        function()

            if not Dragging then

                local CurrentTheme =
                    OTC._Themes[
                        Tab.Window.Theme
                    ]
                    or OTC._Themes.Default

                tween(
                    Knob,
                    0.15,
                    {
                        Size =
                            UDim2.fromOffset(
                                12,
                                12
                            )
                    }
                )

                tween(
                    Stroke,
                    0.15,
                    {
                        Color =
                            CurrentTheme.Border
                    }
                )

            end

        end
    )

    update(
        CurrentValue,
        false
    )

    local Object = {}

    function Object:SetValue(Value)

        update(
            Value,
            true
        )

    end

    function Object:GetValue()

        return CurrentValue

    end

    function Object:SetMin(Value)

        Min =
            tonumber(Value)
            or Min

        if Max < Min then
            Max = Min
        end

        update(
            CurrentValue,
            false
        )

    end

    function Object:SetMax(Value)

        Max =
            tonumber(Value)
            or Max

        if Max < Min then
            Min = Max
        end

        update(
            CurrentValue,
            false
        )

    end

    function Object:SetName(NewName)

        Name =
            tostring(NewName)

        Title.Text =
            Name

    end

    function Object:SetCallback(NewCallback)

        if type(NewCallback) == "function" then

            Callback =
                NewCallback

        end

    end

    function Object:RefreshTheme()

        local CurrentTheme =
            OTC._Themes[
                Tab.Window.Theme
            ]
            or OTC._Themes.Default

        Frame.BackgroundColor3 =
            CurrentTheme.Element

        Stroke.Color =
            CurrentTheme.Border

        Title.TextColor3 =
            CurrentTheme.Text

        ValueLabel.TextColor3 =
            CurrentTheme.Accent

        if DescriptionLabel then

            DescriptionLabel.TextColor3 =
                CurrentTheme.SubText

        end

        SliderBackground.BackgroundColor3 =
            CurrentTheme.Background

        Fill.BackgroundColor3 =
            CurrentTheme.Accent

        Knob.BackgroundColor3 =
            CurrentTheme.Text

        KnobStroke.Color =
            CurrentTheme.Accent

    end

    function Object:Destroy()

        Frame:Destroy()

    end

    Object.Instance =
        Frame

    Object.Interaction =
        Interaction

    Tab:AddElement(
        Object
    )

    return Object
end

return Slider