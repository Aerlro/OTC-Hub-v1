--[[
    OTC Hub v1
    Button Element
    by Aerlro
]]

local Button = {}

local TweenService = game:GetService("TweenService")

--// Create
local function create(Class, Properties)

    local Object = Instance.new(Class)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    return Object
end

--// Tween
local function tween(Object, Time, Properties)

    if not Object
        or not Object.Parent then
        return
    end

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

--// Create Button
function Button.Create(
    Tab,
    OTC,
    Settings
)

    Settings = Settings or {}

    local Name =
        Settings.Name
        or "Button"

    local Description =
        Settings.Description

    local Callback =
        Settings.Callback
        or function()
        end

    --// Current Theme
    local function getTheme()

        return OTC._Themes[Tab.Window.Theme]
            or OTC._Themes.Default

    end

    local Theme =
        getTheme()

    --// State
    local Hovered = false
    local Pressed = false

    --// Height
    local FrameHeight =
        Description
        and 62
        or 48

    --// Main Frame
    local Frame = create(
        "Frame",
        {
            Name = "Button",

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
        }
    )

    create(
        "UICorner",
        {
            Parent = Frame,

            CornerRadius =
                UDim.new(
                    0,
                    8
                )
        }
    )

    --// Stroke
    local Stroke = create(
        "UIStroke",
        {
            Parent = Frame,

            Color =
                Theme.Border,

            Thickness = 1
        }
    )

    --// Scale
    local Scale = create(
        "UIScale",
        {
            Parent = Frame,

            Scale = 1
        }
    )

    --// Button
    local ButtonObject = create(
        "TextButton",
        {
            Name = "Button",

            Parent = Frame,

            BackgroundTransparency = 1,

            BorderSizePixel = 0,

            Size =
                UDim2.fromScale(
                    1,
                    1
                ),

            AutoButtonColor = false,

            Text = ""
        }
    )

    --// Title
    local Title

    if Description then

        Title = create(
            "TextLabel",
            {
                Name = "Title",

                Parent = ButtonObject,

                BackgroundTransparency = 1,

                Position =
                    UDim2.fromOffset(
                        15,
                        7
                    ),

                Size =
                    UDim2.new(
                        1,
                        -90,
                        0,
                        24
                    ),

                Font =
                    Enum.Font.GothamMedium,

                Text = Name,

                TextColor3 =
                    Theme.Text,

                TextSize = 13,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                TextYAlignment =
                    Enum.TextYAlignment.Center,

                TextTruncate =
                    Enum.TextTruncate.AtEnd
            }
        )

    else

        Title = create(
            "TextLabel",
            {
                Name = "Title",

                Parent = ButtonObject,

                BackgroundTransparency = 1,

                AnchorPoint =
                    Vector2.new(
                        0,
                        0.5
                    ),

                Position =
                    UDim2.new(
                        0,
                        15,
                        0.5,
                        0
                    ),

                Size =
                    UDim2.new(
                        1,
                        -90,
                        0,
                        24
                    ),

                Font =
                    Enum.Font.GothamMedium,

                Text = Name,

                TextColor3 =
                    Theme.Text,

                TextSize = 13,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                TextYAlignment =
                    Enum.TextYAlignment.Center,

                TextTruncate =
                    Enum.TextTruncate.AtEnd
            }
        )
    end

    --// Description
    local DescriptionLabel

    if Description then

        DescriptionLabel = create(
            "TextLabel",
            {
                Name = "Description",

                Parent = ButtonObject,

                BackgroundTransparency = 1,

                Position =
                    UDim2.fromOffset(
                        15,
                        31
                    ),

                Size =
                    UDim2.new(
                        1,
                        -90,
                        0,
                        20
                    ),

                Font =
                    Enum.Font.Gotham,

                Text = Description,

                TextColor3 =
                    Theme.SubText,

                TextSize = 11,

                TextWrapped = true,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                TextYAlignment =
                    Enum.TextYAlignment.Center,

                TextTruncate =
                    Enum.TextTruncate.AtEnd
            }
        )
    end

    --// Execute
    local Execute = create(
        "TextLabel",
        {
            Name = "Execute",

            Parent = ButtonObject,

            BackgroundTransparency = 1,

            AnchorPoint =
                Vector2.new(
                    1,
                    0.5
                ),

            Position =
                UDim2.new(
                    1,
                    -15,
                    0.5,
                    0
                ),

            Size =
                UDim2.fromOffset(
                    55,
                    25
                ),

            Font =
                Enum.Font.GothamMedium,

            Text = "EXECUTE",

            TextColor3 =
                Theme.Accent,

            TextSize = 10,

            TextXAlignment =
                Enum.TextXAlignment.Right,

            TextYAlignment =
                Enum.TextYAlignment.Center
        }
    )

    --// Apply State
    local function applyState(Animated)

        local CurrentTheme =
            getTheme()

        local BackgroundColor
        local StrokeColor
        local ExecuteColor

        if Pressed then

            BackgroundColor =
                CurrentTheme.Hover

            StrokeColor =
                CurrentTheme.Accent

            ExecuteColor =
                CurrentTheme.Text

        elseif Hovered then

            BackgroundColor =
                CurrentTheme.Hover

            StrokeColor =
                CurrentTheme.AccentDark

            ExecuteColor =
                CurrentTheme.Text

        else

            BackgroundColor =
                CurrentTheme.Element

            StrokeColor =
                CurrentTheme.Border

            ExecuteColor =
                CurrentTheme.Accent
        end

        if Animated then

            tween(
                Frame,
                0.15,
                {
                    BackgroundColor3 =
                        BackgroundColor
                }
            )

            tween(
                Stroke,
                0.15,
                {
                    Color =
                        StrokeColor
                }
            )

            tween(
                Execute,
                0.15,
                {
                    TextColor3 =
                        ExecuteColor
                }
            )

        else

            Frame.BackgroundColor3 =
                BackgroundColor

            Stroke.Color =
                StrokeColor

            Execute.TextColor3 =
                ExecuteColor
        end
    end

    --// Mouse Enter
    ButtonObject.MouseEnter:Connect(
        function()

            Hovered = true

            applyState(true)

        end
    )

    --// Mouse Leave
    ButtonObject.MouseLeave:Connect(
        function()

            Hovered = false
            Pressed = false

            applyState(true)

        end
    )

    --// Mouse Down
    ButtonObject.MouseButton1Down:Connect(
        function()

            Pressed = true

            tween(
                Scale,
                0.08,
                {
                    Scale = 0.985
                }
            )

            applyState(true)

        end
    )

    --// Mouse Up
    ButtonObject.MouseButton1Up:Connect(
        function()

            Pressed = false

            tween(
                Scale,
                0.12,
                {
                    Scale = 1
                }
            )

            applyState(true)

        end
    )

    --// Click
    ButtonObject.MouseButton1Click:Connect(
        function()

            tween(
                Scale,
                0.06,
                {
                    Scale = 0.975
                }
            )

            task.delay(
                0.06,
                function()

                    if Scale
                        and Scale.Parent then

                        tween(
                            Scale,
                            0.1,
                            {
                                Scale = 1
                            }
                        )

                    end
                end
            )

            local Success, Error =
                pcall(
                    Callback
                )

            if not Success then

                warn(
                    "[OTC Hub] Button callback error:",
                    Error
                )

            end
        end
    )

    --// Object
    local Object = {}

    Object.Type =
        "Button"

    Object.Instance =
        Frame

    Object.Button =
        ButtonObject

    Object.Title =
        Title

    Object.Description =
        DescriptionLabel

    Object.Execute =
        Execute

    --// Set Name
    function Object:SetName(NewName)

        Name =
            tostring(
                NewName
            )

        if Title
            and Title.Parent then

            Title.Text =
                Name
        end
    end

    --// Set Description
    function Object:SetDescription(
        NewDescription
    )

        Description =
            NewDescription

        if DescriptionLabel
            and DescriptionLabel.Parent then

            DescriptionLabel.Text =
                tostring(
                    NewDescription
                )
        end
    end

    --// Set Callback
    function Object:SetCallback(
        NewCallback
    )

        if type(NewCallback)
            == "function" then

            Callback =
                NewCallback
        end
    end

    --// Refresh Theme
    function Object:RefreshTheme()

        if not Frame
            or not Frame.Parent then
            return
        end

        local CurrentTheme =
            getTheme()

        --// Title
        if Title
            and Title.Parent then

            Title.TextColor3 =
                CurrentTheme.Text
        end

        --// Description
        if DescriptionLabel
            and DescriptionLabel.Parent then

            DescriptionLabel.TextColor3 =
                CurrentTheme.SubText
        end

        --// Execute
        if Execute
            and Execute.Parent then

            Execute.TextColor3 =
                CurrentTheme.Accent
        end

        --// Main colors
        --// Respect current hover/pressed state
        applyState(false)

    end

    --// Destroy
    function Object:Destroy()

        if Frame
            and Frame.Parent then

            Frame:Destroy()

        end
    end

    --// Register
    Tab:AddElement(
        Object
    )

    return Object
end

return Button