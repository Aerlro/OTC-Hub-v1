local Badge = {}
function Badge.Create(Tab, OTC, Settings)
    Settings=Settings or {}
    local Theme=OTC._Themes[Tab.Window.Theme] or OTC._Themes[OTC.CurrentTheme] or OTC._Themes.Default
    local Frame=Instance.new("Frame"); Frame.Name="Badge"; Frame.Parent=Tab.Page; Frame.Size=UDim2.new(1,0,0,34); Frame.BackgroundTransparency=1
    local Label=Instance.new("TextLabel"); Label.Parent=Frame; Label.Size=UDim2.new(0, math.max(60, (#tostring(Settings.Text or "Badge")*7)+24), 0, 26); Label.Position=UDim2.fromOffset(0,4); Label.BackgroundColor3=Settings.Color or Theme.Accent; Label.BorderSizePixel=0; Label.Text=tostring(Settings.Text or "Badge"); Label.TextColor3=Settings.TextColor or Theme.AccentText or Theme.Background; Label.TextSize=10; Label.Font=Enum.Font.GothamBold
    local Corner=Instance.new("UICorner"); Corner.CornerRadius=UDim.new(0,999); Corner.Parent=Label
    local Object={Type="Badge",Instance=Frame,Label=Label}
    function Object:SetValue(v) Label.Text=tostring(v or "") end
    function Object:RefreshTheme() local T=OTC._Themes[Tab.Window.Theme] or OTC._Themes[OTC.CurrentTheme] or OTC._Themes.Default; Label.BackgroundColor3=Settings.Color or T.Accent; Label.TextColor3=Settings.TextColor or T.AccentText or T.Background end
    function Object:Destroy() Frame:Destroy() end
    Tab:AddElement(Object); return Object
end
return Badge
