--[[
    OTC Hub v1
    Tab System
    by Aerlro
]]

local Tab = {}

local TweenService =
    game:GetService("TweenService")

local function tween(
    Object,
    Time,
    Properties
)

    local Info = TweenInfo.new(
        Time or 0.2,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    local Animation =
        TweenService:Create(
            Object,
            Info,
            Properties
        )

    Animation:Play()

    return Animation
end

local function create(
    Class,
    Properties
)

    local Object =
        Instance.new(Class)

    for Property, Value in pairs(
        Properties or {}
    ) do

        Object[Property] = Value
    end

    return Object
end

--// Detect Roblox Asset
local function isAsset(
    Icon
)

    if type(Icon) ~= "string" then
        return false
    end

    return Icon:match(
        "^rbxassetid://"
    )
    or Icon:match(
        "^rbxasset://"
    )
    or Icon:match(
        "^https?://"
    )
end

--// Detect emoji / unicode
local function isEmoji(
    Icon
)

    if type(Icon) ~= "string"
        or Icon == "" then

        return false
    end

    if isAsset(Icon) then
        return false
    end

    -- Lucide names normally only
    -- contain letters, numbers and -
    if Icon:match(
        "^[%w%-_]+$"
    ) then

        return false
    end

    return true
end

--// Create Icon
local function createIcon(
    Button,
    OTC,
    IconValue,
    Theme
)

    --// No icon
    if not IconValue then

        return create(
            "TextLabel",
            {
                Name = "Icon",

                Parent = Button,

                BackgroundTransparency = 1,

                Position =
                    UDim2.fromOffset(
                        10,
                        0
                    ),

                Size =
                    UDim2.fromOffset(
                        25,
                        38
                    ),

                Font =
                    Enum.Font.GothamMedium,

                Text = "•",

                TextColor3 =
                    Theme.SubText,

                TextSize = 15,

                TextXAlignment =
                    Enum.TextXAlignment.Center,

                TextYAlignment =
                    Enum.TextYAlignment.Center
            }
        )
    end

    --// Roblox Asset
    if isAsset(IconValue) then

        local Icon =
            create(
                "ImageLabel",
                {
                    Name = "Icon",

                    Parent = Button,

                    BackgroundTransparency = 1,

                    Position =
                        UDim2.fromOffset(
                            12,
                            9
                        ),

                    Size =
                        UDim2.fromOffset(
                            20,
                            20
                        ),

                    Image = IconValue,

                    ImageColor3 =
                        Theme.SubText,

                    ScaleType =
                        Enum.ScaleType.Fit
                }
            )

        return Icon
    end

    --// Emoji
    if isEmoji(IconValue) then

        return create(
            "TextLabel",
            {
                Name = "Icon",

                Parent = Button,

                BackgroundTransparency = 1,

                Position =
                    UDim2.fromOffset(
                        10,
                        0
                    ),

                Size =
                    UDim2.fromOffset(
                        25,
                        38
                    ),

                Font =
                    Enum.Font.GothamMedium,

                Text = IconValue,

                TextColor3 =
                    Theme.SubText,

                TextSize = 15,

                TextXAlignment =
                    Enum.TextXAlignment.Center,

                TextYAlignment =
                    Enum.TextYAlignment.Center
            }
        )
    end

    --// Lucide
    local Lucide =
        OTC._Lucide

    if not Lucide then

        warn(
            "[OTC Hub] Lucide module not loaded"
        )

        return create(
            "TextLabel",
            {
                Name = "Icon",

                Parent = Button,

                BackgroundTransparency = 1,

                Position =
                    UDim2.fromOffset(
                        10,
                        0
                    ),

                Size =
                    UDim2.fromOffset(
                        25,
                        38
                    ),

                Font =
                    Enum.Font.GothamMedium,

                Text = "•",

                TextColor3 =
                    Theme.SubText,

                TextSize = 15,

                TextXAlignment =
                    Enum.TextXAlignment.Center,

                TextYAlignment =
                    Enum.TextYAlignment.Center
            }
        )
    end

    local Icon =
        Lucide.Create(
            Button,
            IconValue,
            20,
            {
                Name = "Icon",

                Position =
                    UDim2.fromOffset(
                        12,
                        9
                    ),

                Size =
                    UDim2.fromOffset(
                        20,
                        20
                    ),

                ImageColor3 =
                    Theme.SubText
            }
        )

    --// Invalid Lucide icon
    if not Icon then

        Icon = create(
            "TextLabel",
            {
                Name = "Icon",

                Parent = Button,

                BackgroundTransparency = 1,

                Position =
                    UDim2.fromOffset(
                        10,
                        0
                    ),

                Size =
                    UDim2.fromOffset(
                        25,
                        38
                    ),

                Font =
                    Enum.Font.GothamMedium,

                Text = "•",

                TextColor3 =
                    Theme.SubText,

                TextSize = 15,

                TextXAlignment =
                    Enum.TextXAlignment.Center,

                TextYAlignment =
                    Enum.TextYAlignment.Center
            }
        )
    end

    return Icon
end

function Tab.Create(
    Window,
    OTC,
    Settings
)

    Settings = Settings or {}

    local Theme =
        OTC:GetTheme()

    local TabObject = {

        Window = Window,

        OTC = OTC,

        Name =
            Settings.Name
            or "Tab",

        Icon =
            Settings.Icon,

        Elements = {},

        Selected = false
    }

    --// Sidebar Button
    local Button =
        create(
            "TextButton",
            {
                Name =
                    TabObject.Name
                    .. "_Button",

                Parent =
                    Window.TabContainer,

                BackgroundColor3 =
                    Theme.Element,

                BackgroundTransparency = 1,

                BorderSizePixel = 0,

                Size =
                    UDim2.new(
                        1,
                        0,
                        0,
                        38
                    ),

                AutoButtonColor = false,

                Text = "",

                TextColor3 =
                    Theme.Text
            }
        )

    create(
        "UICorner",
        {
            Parent = Button,

            CornerRadius =
                UDim.new(
                    0,
                    7
                )
        }
    )

    --// Icon
    local Icon =
        createIcon(
            Button,
            OTC,
            Settings.Icon,
            Theme
        )

    --// Name
    local Name =
        create(
            "TextLabel",
            {
                Name = "Name",

                Parent = Button,

                BackgroundTransparency = 1,

                Position =
                    UDim2.fromOffset(
                        42,
                        0
                    ),

                Size =
                    UDim2.new(
                        1,
                        -48,
                        1,
                        0
                    ),

                Font =
                    Enum.Font.GothamMedium,

                Text =
                    TabObject.Name,

                TextColor3 =
                    Theme.SubText,

                TextSize = 13,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                TextYAlignment =
                    Enum.TextYAlignment.Center
            }
        )

    --// Selected Indicator
    local Indicator =
        create(
            "Frame",
            {
                Name = "Indicator",

                Parent = Button,

                BackgroundColor3 =
                    Theme.Accent,

                BorderSizePixel = 0,

                Position =
                    UDim2.new(
                        0,
                        0,
                        0.5,
                        -9
                    ),

                Size =
                    UDim2.fromOffset(
                        3,
                        18
                    ),

                Visible = false
            }
        )

    create(
        "UICorner",
        {
            Parent = Indicator,

            CornerRadius =
                UDim.new(
                    1,
                    0
                )
        }
    )

    --// Content Page
    local Page =
        create(
            "ScrollingFrame",
            {
                Name =
                    TabObject.Name
                    .. "_Page",

                Parent =
                    Window.Content,

                BackgroundTransparency = 1,

                BorderSizePixel = 0,

                Size =
                    UDim2.new(
                        1,
                        0,
                        1,
                        0
                    ),

                CanvasSize =
                    UDim2.new(),

                AutomaticCanvasSize =
                    Enum.AutomaticSize.Y,

                ScrollBarThickness = 3,

                ScrollBarImageColor3 =
                    Theme.Border,

                Visible = false
            }
        )

    create(
        "UIPadding",
        {
            Parent = Page,

            PaddingTop =
                UDim.new(
                    0,
                    18
                ),

            PaddingBottom =
                UDim.new(
                    0,
                    18
                ),

            PaddingLeft =
                UDim.new(
                    0,
                    18
                ),

            PaddingRight =
                UDim.new(
                    0,
                    18
                )
        }
    )

    create(
        "UIListLayout",
        {
            Parent = Page,

            Padding =
                UDim.new(
                    0,
                    8
                ),

            SortOrder =
                Enum.SortOrder.LayoutOrder
        }
    )

    TabObject.Button =
        Button

    TabObject.Page =
        Page

    TabObject.Indicator =
        Indicator

    TabObject.IconLabel =
        Icon

    TabObject.NameLabel =
        Name

    --// Selected
    function TabObject:SetSelected(
        Value
    )

        self.Selected = Value

        if Value then

            Page.Visible = true

            Indicator.Visible = true

            tween(
                Button,
                0.2,
                {
                    BackgroundTransparency = 0
                }
            )

            tween(
                Name,
                0.2,
                {
                    TextColor3 =
                        Theme.Text
                }
            )

            if Icon:IsA(
                "ImageLabel"
            ) then

                tween(
                    Icon,
                    0.2,
                    {
                        ImageColor3 =
                            Theme.Text
                    }
                )

            else

                tween(
                    Icon,
                    0.2,
                    {
                        TextColor3 =
                            Theme.Text
                    }
                )
            end

        else

            Page.Visible = false

            Indicator.Visible = false

            tween(
                Button,
                0.2,
                {
                    BackgroundTransparency = 1
                }
            )

            tween(
                Name,
                0.2,
                {
                    TextColor3 =
                        Theme.SubText
                }
            )

            if Icon:IsA(
                "ImageLabel"
            ) then

                tween(
                    Icon,
                    0.2,
                    {
                        ImageColor3 =
                            Theme.SubText
                    }
                )

            else

                tween(
                    Icon,
                    0.2,
                    {
                        TextColor3 =
                            Theme.SubText
                    }
                )
            end
        end
    end

    --// Hover
    Button.MouseEnter:Connect(
        function()

            if not TabObject.Selected then

                tween(
                    Button,
                    0.15,
                    {
                        BackgroundTransparency =
                            0.7
                    }
                )

                tween(
                    Name,
                    0.15,
                    {
                        TextColor3 =
                            Theme.Text
                    }
                )

                if Icon:IsA(
                    "ImageLabel"
                ) then

                    tween(
                        Icon,
                        0.15,
                        {
                            ImageColor3 =
                                Theme.Text
                        }
                    )

                else

                    tween(
                        Icon,
                        0.15,
                        {
                            TextColor3 =
                                Theme.Text
                        }
                    )
                end
            end
        end
    )

    Button.MouseLeave:Connect(
        function()

            if not TabObject.Selected then

                tween(
                    Button,
                    0.15,
                    {
                        BackgroundTransparency = 1
                    }
                )

                tween(
                    Name,
                    0.15,
                    {
                        TextColor3 =
                            Theme.SubText
                    }
                )

                if Icon:IsA(
                    "ImageLabel"
                ) then

                    tween(
                        Icon,
                        0.15,
                        {
                            ImageColor3 =
                                Theme.SubText
                        }
                    )

                else

                    tween(
                        Icon,
                        0.15,
                        {
                            TextColor3 =
                                Theme.SubText
                        }
                    )
                end
            end
        end
    )

    --// Click
    Button.MouseButton1Click:Connect(
        function()

            Window:SelectTab(
                TabObject
            )
        end
    )

    --// Add Element
    function TabObject:AddElement(
        Element
    )

        if Element then

            table.insert(
                self.Elements,
                Element
            )
        end

        return Element
    end

    --// Section
    function TabObject:CreateSection(
        Text
    )

        local Section =
            create(
                "TextLabel",
                {
                    Name = "Section",

                    Parent = Page,

                    BackgroundTransparency = 1,

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            28
                        ),

                    Font =
                        Enum.Font.GothamBold,

                    Text =
                        Text
                        or "Section",

                    TextColor3 =
                        Theme.Text,

                    TextSize = 14,

                    TextXAlignment =
                        Enum.TextXAlignment.Left,

                    TextYAlignment =
                        Enum.TextYAlignment.Center
                }
            )

        self:AddElement(
            Section
        )

        return Section
    end

    --// Text
    function TabObject:CreateText(
        Text
    )

        local Label =
            create(
                "TextLabel",
                {
                    Name = "Text",

                    Parent = Page,

                    BackgroundTransparency = 1,

                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            24
                        ),

                    Font =
                        Enum.Font.Gotham,

                    Text =
                        Text
                        or "",

                    TextColor3 =
                        Theme.SubText,

                    TextSize = 13,

                    TextWrapped = true,

                    TextXAlignment =
                        Enum.TextXAlignment.Left,

                    TextYAlignment =
                        Enum.TextYAlignment.Center
                }
            )

        self:AddElement(
            Label
        )

        return Label
    end

    --// Button
    function TabObject:CreateButton(
        Settings
    )

        Settings = Settings or {}

        local Module =
            self.OTC._Modules
            and self.OTC._Modules.Button

        if not Module then

            error(
                "[OTC Hub] Button module is not loaded"
            )
        end

        return Module.Create(
            self,
            self.OTC,
            Settings
        )
    end

    --// Toggle
    function TabObject:CreateToggle(
        Settings
    )

        Settings = Settings or {}

        local Module =
            self.OTC._Modules
            and self.OTC._Modules.Toggle

        if not Module then

            error(
                "[OTC Hub] Toggle module is not loaded"
            )
        end

        return Module.Create(
            self,
            self.OTC,
            Settings
        )
    end

    --// Slider
    function TabObject:CreateSlider(
        Settings
    )

        Settings = Settings or {}

        local Module =
            self.OTC._Modules
            and self.OTC._Modules.Slider

        if not Module then

            error(
                "[OTC Hub] Slider module is not loaded"
            )
        end

        return Module.Create(
            self,
            self.OTC,
            Settings
        )
    end

    --// Dropdown
    function TabObject:CreateDropdown(
        Settings
    )

        Settings = Settings or {}

        local Module =
            self.OTC._Modules
            and self.OTC._Modules.Dropdown

        if not Module then

            error(
                "[OTC Hub] Dropdown module is not loaded"
            )
        end

        return Module.Create(
            self,
            self.OTC,
            Settings
        )
    end

    --// Input
    function TabObject:CreateInput(
        Settings
    )

        Settings = Settings or {}

        local Module =
            self.OTC._Modules
            and self.OTC._Modules.Input

        if not Module then

            error(
                "[OTC Hub] Input module is not loaded"
            )
        end

        return Module.Create(
            self,
            self.OTC,
            Settings
        )
    end

    --// Register Tab
    Window:AddTab(
        TabObject
    )

    --// First Tab
    if #Window.Tabs == 1 then

        Window:SelectTab(
            TabObject
        )
    end

    return TabObject
end

return Tab