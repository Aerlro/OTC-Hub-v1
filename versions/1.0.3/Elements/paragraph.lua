local Paragraph = {}
function Paragraph.Create(Tab, OTC, Settings)
    Settings = Settings or {}
    local Theme = OTC._Themes[Tab.Window.Theme] or OTC._Themes[OTC.CurrentTheme] or OTC._Themes.Default
    local Frame = Instance.new("Frame")
    Frame.Name = "Paragraph"
    Frame.Parent = Tab.Page
    Frame.Size = UDim2.new(1, 0, 0, Settings.Height or 62)
    Frame.BackgroundColor3 = Theme.Element
    Frame.BackgroundTransparency = Theme.Transparency and Theme.Transparency.Element or 0
    Frame.BorderSizePixel = 0
    local Corner = Instance.new("UICorner"); Corner.CornerRadius = UDim.new(0, Theme.Corners and Theme.Corners.Element or 8); Corner.Parent = Frame
    local Stroke = Instance.new("UIStroke"); Stroke.Color = Theme.Border; Stroke.Thickness = Theme.Stroke and Theme.Stroke.Thickness or 1; Stroke.Transparency = Theme.Stroke and Theme.Stroke.Transparency or 0; Stroke.Parent = Frame
    local Title = Instance.new("TextLabel"); Title.Parent = Frame; Title.BackgroundTransparency = 1; Title.Position = UDim2.fromOffset(14, 10); Title.Size = UDim2.new(1, -28, 0, 18); Title.Font = Enum.Font.GothamSemibold; Title.Text = tostring(Settings.Title or "Paragraph"); Title.TextColor3 = Theme.Text; Title.TextSize = 12; Title.TextXAlignment = Enum.TextXAlignment.Left
    local Content = Instance.new("TextLabel"); Content.Parent = Frame; Content.BackgroundTransparency = 1; Content.Position = UDim2.fromOffset(14, 29); Content.Size = UDim2.new(1, -28, 0, Settings.ContentHeight or 26); Content.Font = Enum.Font.Gotham; Content.Text = tostring(Settings.Content or ""); Content.TextColor3 = Theme.SubText; Content.TextSize = 10; Content.TextWrapped = true; Content.TextXAlignment = Enum.TextXAlignment.Left; Content.TextYAlignment = Enum.TextYAlignment.Top
    local Object = {Type="Paragraph", Instance=Frame, Title=Title, Content=Content}
    function Object:SetTitle(v) Title.Text=tostring(v or "") end
    function Object:SetContent(v) Content.Text=tostring(v or "") end
    function Object:RefreshTheme() local T=OTC._Themes[Tab.Window.Theme] or OTC._Themes[OTC.CurrentTheme] or OTC._Themes.Default; Frame.BackgroundColor3=T.Element; Title.TextColor3=T.Text; Content.TextColor3=T.SubText; Stroke.Color=T.Border end
    function Object:Destroy() Frame:Destroy() end
    Tab:AddElement(Object)
    return Object
end
return Paragraph
