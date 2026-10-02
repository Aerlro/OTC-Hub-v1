--[[
    OTC Hub v1
    Tab System
    by Aerlro
]]

local Tab = {}

local TweenService = game:GetService("TweenService")

local function tween(Object, Time, Properties)
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

function Tab.Create(Window, OTC, Settings)
    Settings = Settings or {}

    local Theme = OTC:GetTheme()

    local TabObject = {
        Window = Window,
        OTC = OTC,
        Name = Settings.Name or "Tab",
        Icon = Settings.Icon,
        Elements = {},
        Selected = false
    }

    --// Sidebar Button
    local Button = create("TextButton", {
        Name = TabObject.Name .. "_Button",
        Parent = Window.TabContainer,

        BackgroundColor3 = Theme.Element,
        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Size = UDim2.new(1, 0, 0, 38),

        AutoButtonColor = false,

        Font = Enum.Font.GothamMedium,
        Text = "",
        TextColor3 = Theme.Text
    })

    create("UICorner", {
        Parent = Button,
        CornerRadius = UDim.new(0, 7)
    })

    --// Icon
    local Icon = create("TextLabel", {
        Name = "Icon",
        Parent = Button,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.fromOffset(25, 38),

        Font = Enum.Font.GothamMedium,

        Text = Settings.Icon or "•",

        TextColor3 = Theme.SubText,
        TextSize = 15,

        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center
    })

    --// Name
    local Name = create("TextLabel", {
        Name = "Name",
        Parent = Button,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(42, 0),
        Size = UDim2.new(1, -48, 1, 0),

        Font = Enum.Font.GothamMedium,

        Text = TabObject.Name,

        TextColor3 = Theme.SubText,
        TextSize = 13,

        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })

    --// Selected Indicator
    local Indicator = create("Frame", {
        Name = "Indicator",
        Parent = Button,

        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,

        Position = UDim2.new(0, 0, 0.5, -9),
        Size = UDim2.fromOffset(3, 18),

        Visible = false
    })

    create("UICorner", {
        Parent = Indicator,
        CornerRadius = UDim.new(1, 0)
    })

    --// Content Page
    local Page = create("ScrollingFrame", {
        Name = TabObject.Name .. "_Page",
        Parent = Window.Content,

        BackgroundTransparency = 1,
        BorderSizePixel = 0,

        Size = UDim2.new(1, 0, 1, 0),

        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,

        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Theme.Border,

        Visible = false
    })

    create("UIPadding", {
        Parent = Page,

        PaddingTop = UDim.new(0, 18),
        PaddingBottom = UDim.new(0, 18),
        PaddingLeft = UDim.new(0, 18),
        PaddingRight = UDim.new(0, 18)
    })

    create("UIListLayout", {
        Parent = Page,

        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    TabObject.Button = Button
    TabObject.Page = Page
    TabObject.Indicator = Indicator
    TabObject.IconLabel = Icon
    TabObject.NameLabel = Name

    --// Select
    function TabObject:SetSelected(Value)
        self.Selected = Value

        if Value then
            Page.Visible = true
            Indicator.Visible = true

            tween(Button, 0.2, {
                BackgroundTransparency = 0
            })

            tween(Name, 0.2, {
                TextColor3 = Theme.Text
            })

            tween(Icon, 0.2, {
                TextColor3 = Theme.Text
            })
        else
            Page.Visible = false
            Indicator.Visible = false

            tween(Button, 0.2, {
                BackgroundTransparency = 1
            })

            tween(Name, 0.2, {
                TextColor3 = Theme.SubText
            })

            tween(Icon, 0.2, {
                TextColor3 = Theme.SubText
            })
        end
    end

    --// Hover
    Button.MouseEnter:Connect(function()
        if not TabObject.Selected then
            tween(Button, 0.15, {
                BackgroundTransparency = 0.7
            })

            tween(Name, 0.15, {
                TextColor3 = Theme.Text
            })

            tween(Icon, 0.15, {
                TextColor3 = Theme.Text
            })
        end
    end)

    Button.MouseLeave:Connect(function()
        if not TabObject.Selected then
            tween(Button, 0.15, {
                BackgroundTransparency = 1
            })

            tween(Name, 0.15, {
                TextColor3 = Theme.SubText
            })

            tween(Icon, 0.15, {
                TextColor3 = Theme.SubText
            })
        end
    end)

    --// Click
    Button.MouseButton1Click:Connect(function()
        Window:SelectTab(TabObject)
    end)

    --// Add Element
    function TabObject:AddElement(Element)
        table.insert(self.Elements, Element)
        return Element
    end

    --// Section
    function TabObject:CreateSection(Text)
        local Section = create("TextLabel", {
            Name = "Section",
            Parent = Page,

            BackgroundTransparency = 1,

            Size = UDim2.new(1, 0, 0, 28),

            Font = Enum.Font.GothamBold,

            Text = Text or "Section",

            TextColor3 = Theme.Text,
            TextSize = 14,

            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        self:AddElement(Section)

        return Section
    end

    --// Text
    function TabObject:CreateText(Text)
        local Label = create("TextLabel", {
            Name = "Text",
            Parent = Page,

            BackgroundTransparency = 1,

            Size = UDim2.new(1, 0, 0, 24),

            Font = Enum.Font.Gotham,

            Text = Text or "",

            TextColor3 = Theme.SubText,
            TextSize = 13,

            TextWrapped = true,

            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        self:AddElement(Label)

        return Label
    end

    --// Register Tab
    Window:AddTab(TabObject)

    --// Select First Tab
    if #Window.Tabs == 1 then
        Window:SelectTab(TabObject)
    end

    return TabObject
end

return Tab