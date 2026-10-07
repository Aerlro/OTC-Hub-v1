local Stat = {}

local function create(Class, Properties)
    local Object = Instance.new(Class)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    return Object
end

local function corner(Object, Radius)
    local UI = Instance.new("UICorner")
    UI.CornerRadius = UDim.new(0, Radius)
    UI.Parent = Object
end

local function stroke(Object, Theme)
    local UI = Instance.new("UIStroke")
    UI.Color = Theme.Border or Color3.new(1, 1, 1)
    UI.Thickness = Theme.Stroke and Theme.Stroke.Thickness or 1
    UI.Transparency = Theme.Stroke and Theme.Stroke.Transparency or 0
    UI.Parent = Object
end

function Stat.Create(Tab, OTC, Settings)
    Settings = Settings or {}

    local Theme = OTC._Themes[OTC.CurrentTheme]
        or OTC._Themes[Tab.Window.Theme]
        or OTC._Themes.Default

    local Frame = create("Frame", {
        Name = "Stat",
        Parent = Tab.Page,
        Size = UDim2.new(1, 0, 0, Settings.Height or 72),
        BackgroundColor3 = Theme.Element,
        BackgroundTransparency = Theme.Transparency and Theme.Transparency.Element or 0,
        BorderSizePixel = 0
    })

    corner(Frame, Theme.Corners and Theme.Corners.Element or 8)
    stroke(Frame, Theme)

    local Title = create("TextLabel", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(14, 10),
        Size = UDim2.new(1, -28, 0, 18),
        Font = Enum.Font.GothamMedium,
        Text = Settings.Name or "Stat",
        TextColor3 = Theme.SubText,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local Value = create("TextLabel", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(14, 28),
        Size = UDim2.new(1, -28, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = tostring(Settings.Value or "0"),
        TextColor3 = Theme.Text,
        TextSize = 21,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local Object = {
        Type = "Stat",
        Instance = Frame,
        Title = Title,
        Value = Value
    }

    function Object:SetValue(NewValue)
        if self.Value then
            self.Value.Text = tostring(NewValue)
        end
    end

    function Object:GetValue()
        return self.Value and self.Value.Text or ""
    end

    function Object:SetName(NewName)
        if self.Title then
            self.Title.Text = tostring(NewName or "")
        end
    end

    function Object:RefreshTheme()
        if not self.Instance or not self.Instance.Parent then
            return
        end

        local CurrentTheme = OTC._Themes[OTC.CurrentTheme]
            or OTC._Themes[Tab.Window.Theme]
            or OTC._Themes.Default

        self.Instance.BackgroundColor3 = CurrentTheme.Element
        self.Title.TextColor3 = CurrentTheme.SubText
        self.Value.TextColor3 = CurrentTheme.Text

        local UIStroke = self.Instance:FindFirstChildOfClass("UIStroke")
        if UIStroke then
            UIStroke.Color = CurrentTheme.Border
            UIStroke.Thickness = CurrentTheme.Stroke and CurrentTheme.Stroke.Thickness or 1
            UIStroke.Transparency = CurrentTheme.Stroke and CurrentTheme.Stroke.Transparency or 0
        end
    end

    function Object:Destroy()
        if self.Instance then
            self.Instance:Destroy()
        end
    end

    Tab:AddElement(Object)

    return Object
end

return Stat
