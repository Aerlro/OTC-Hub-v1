--[[
    OTC Hub v1
    Tab System
    by Aerlro
]]

local Tab = {}

local TweenService = game:GetService("TweenService")

local function tween(Object, Time, Properties)
    if not Object then
        return
    end

    local Info = TweenInfo.new(
        Time or 0.2,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    local Animation = TweenService:Create(
        Object,
        Info,
        Properties
    )

    Animation:Play()

    return Animation
end

local function create(Class, Properties)
    local Object = Instance.new(Class)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    return Object
end

local function createIcon(
    Button,
    IconValue,
    Theme,
    OTC
)
    if IconValue == nil then
        return create("TextLabel", {
            Name = "Icon",
            Parent = Button,
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(10, 0),
            Size = UDim2.fromOffset(25, 38),
            Font = Enum.Font.GothamMedium,
            Text = "•",
            TextColor3 = Theme.SubText,
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        })
    end

    if type(IconValue) == "number" then
        IconValue =
            "rbxassetid://"
            .. tostring(IconValue)
    end

    if type(IconValue) == "string"
        and (
            IconValue:match("^rbxassetid://")
            or IconValue:match("^rbxasset://")
            or IconValue:match("^https?://")
        ) then

        return create("ImageLabel", {
            Name = "Icon",
            Parent = Button,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(12, 9),
            Size = UDim2.fromOffset(20, 20),
            Image = IconValue,
            ImageColor3 = Theme.SubText,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Fit
        })
    end

    if type(IconValue) == "string"
        and OTC
        and OTC._Lucide
        and OTC._Lucide.Available then

        local LucideIcon =
            OTC._Lucide:GetIcon(IconValue)

        if LucideIcon
            and LucideIcon.Url
            and LucideIcon.ImageRectSize
            and LucideIcon.ImageRectOffset then

            return create("ImageLabel", {
                Name = "Icon",
                Parent = Button,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.fromOffset(12, 9),
                Size = UDim2.fromOffset(20, 20),
                Image = LucideIcon.Url,
                ImageRectSize =
                    LucideIcon.ImageRectSize,
                ImageRectOffset =
                    LucideIcon.ImageRectOffset,
                ImageColor3 =
                    Theme.SubText,
                ImageTransparency = 0,
                ScaleType =
                    Enum.ScaleType.Fit
            })
        end
    end

    if type(IconValue) == "string" then
        return create("TextLabel", {
            Name = "Icon",
            Parent = Button,
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(10, 0),
            Size = UDim2.fromOffset(25, 38),
            Font = Enum.Font.GothamMedium,
            Text = IconValue,
            TextColor3 = Theme.SubText,
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        })
    end

    return create("TextLabel", {
        Name = "Icon",
        Parent = Button,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.fromOffset(25, 38),
        Font = Enum.Font.GothamMedium,
        Text = "•",
        TextColor3 = Theme.SubText,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center
    })
end

function Tab.Create(
    Window,
    OTC,
    Settings
)

    Settings = Settings or {}

    local Theme =
        OTC._Themes[Window.Theme]
        or OTC._Themes.Default

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

    local Button = create(
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

    local Icon = createIcon(
        Button,
        Settings.Icon,
        Theme,
        OTC
    )

    local Name = create(
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

    local Indicator = create(
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

    local Page = create(
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

    local function getTheme()
        return OTC._Themes[Window.Theme]
            or OTC._Themes.Default
    end

    local function setIconColor(Color)
        if not Icon then
            return
        end

        if Icon:IsA("ImageLabel")
            or Icon:IsA("ImageButton") then

            Icon.ImageColor3 = Color

        elseif Icon:IsA("TextLabel")
            or Icon:IsA("TextButton") then

            Icon.TextColor3 = Color
        end
    end

    function TabObject:SetSelected(Value)
        self.Selected = Value

        local CurrentTheme = getTheme()

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
                        CurrentTheme.Text
                }
            )

            setIconColor(
                CurrentTheme.Text
            )
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
                        CurrentTheme.SubText
                }
            )

            setIconColor(
                CurrentTheme.SubText
            )
        end
    end

    Button.MouseEnter:Connect(
        function()
            if TabObject.Selected then
                return
            end

            local CurrentTheme = getTheme()

            tween(
                Button,
                0.15,
                {
                    BackgroundTransparency = 0.7
                }
            )

            tween(
                Name,
                0.15,
                {
                    TextColor3 =
                        CurrentTheme.Text
                }
            )

            setIconColor(
                CurrentTheme.Text
            )
        end
    )

    Button.MouseLeave:Connect(
        function()
            if TabObject.Selected then
                return
            end

            local CurrentTheme = getTheme()

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
                        CurrentTheme.SubText
                }
            )

            setIconColor(
                CurrentTheme.SubText
            )
        end
    )

    Button.MouseButton1Click:Connect(
        function()
            Window:SelectTab(
                TabObject
            )
        end
    )

    function TabObject:AddElement(Element)
        if Element then
            table.insert(
                self.Elements,
                Element
            )
        end

        return Element
    end

    function TabObject:CreateSection(Text)
        local CurrentTheme = getTheme()

        local Section = create(
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
                    CurrentTheme.Text,

                TextSize = 14,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                TextYAlignment =
                    Enum.TextYAlignment.Center
            }
        )

        self:AddElement(Section)

        return Section
    end

    function TabObject:CreateText(Text)
        local CurrentTheme = getTheme()

        local Label = create(
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
                    CurrentTheme.SubText,

                TextSize = 13,

                TextWrapped = true,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                TextYAlignment =
                    Enum.TextYAlignment.Center
            }
        )

        self:AddElement(Label)

        return Label
    end

    function TabObject:CreateButton(Settings)
        Settings = Settings or {}

        local Module =
            self.OTC._Modules
            and self.OTC._Modules.Button

        if not Module then
            error(
                "[OTC Hub] Button module is not loaded"
            )
        end

        local Element = Module.Create(
            self,
            self.OTC,
            Settings
        )

        self:AddElement(Element)

        return Element
    end

    function TabObject:CreateToggle(Settings)
        Settings = Settings or {}

        local Module =
            self.OTC._Modules
            and self.OTC._Modules.Toggle

        if not Module then
            error(
                "[OTC Hub] Toggle module is not loaded"
            )
        end

        local Element = Module.Create(
            self,
            self.OTC,
            Settings
        )

        self:AddElement(Element)

        return Element
    end

    function TabObject:CreateSlider(Settings)
        Settings = Settings or {}

        local Module =
            self.OTC._Modules
            and self.OTC._Modules.Slider

        if not Module then
            error(
                "[OTC Hub] Slider module is not loaded"
            )
        end

        local Element = Module.Create(
            self,
            self.OTC,
            Settings
        )

        self:AddElement(Element)

        return Element
    end

    function TabObject:CreateDropdown(Settings)
        Settings = Settings or {}

        local Module =
            self.OTC._Modules
            and self.OTC._Modules.Dropdown

        if not Module then
            error(
                "[OTC Hub] Dropdown module is not loaded"
            )
        end

        local Element = Module.Create(
            self,
            self.OTC,
            Settings
        )

        self:AddElement(Element)

        return Element
    end

    function TabObject:CreateInput(Settings)
        Settings = Settings or {}

        local Module =
            self.OTC._Modules
            and self.OTC._Modules.Input

        if not Module then
            error(
                "[OTC Hub] Input module is not loaded"
            )
        end

        local Element = Module.Create(
            self,
            self.OTC,
            Settings
        )

        self:AddElement(Element)

        return Element
    end

    function TabObject:RefreshTheme()
        local CurrentTheme = getTheme()

        Button.BackgroundColor3 =
            CurrentTheme.Element

        Indicator.BackgroundColor3 =
            CurrentTheme.Accent

        Page.ScrollBarImageColor3 =
            CurrentTheme.Border

        if self.Selected then
            Button.BackgroundTransparency = 0

            Name.TextColor3 =
                CurrentTheme.Text

            setIconColor(
                CurrentTheme.Text
            )
        else
            Button.BackgroundTransparency = 1

            Name.TextColor3 =
                CurrentTheme.SubText

            setIconColor(
                CurrentTheme.SubText
            )
        end

        for _, Element in ipairs(
            self.Elements
        ) do
            if Element
                and Element.RefreshTheme then

                Element:RefreshTheme()
            end
        end
    end

    Window:AddTab(TabObject)

    if #Window.Tabs == 1 then
        Window:SelectTab(TabObject)
    end

    return TabObject
end

return Tab