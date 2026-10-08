local Progress = {}
function Progress.Create(Tab, OTC, Settings)
    Settings=Settings or {}; local Theme=OTC._Themes[Tab.Window.Theme] or OTC._Themes[OTC.CurrentTheme] or OTC._Themes.Default
    local Frame=Instance.new("Frame"); Frame.Name="Progress"; Frame.Parent=Tab.Page; Frame.Size=UDim2.new(1,0,0,54); Frame.BackgroundTransparency=1
    local Title=Instance.new("TextLabel"); Title.Parent=Frame; Title.BackgroundTransparency=1; Title.Size=UDim2.new(1,-50,0,18); Title.Font=Enum.Font.GothamMedium; Title.Text=tostring(Settings.Name or "Progress"); Title.TextColor3=Theme.Text; Title.TextSize=11; Title.TextXAlignment=Enum.TextXAlignment.Left
    local ValueLabel=Instance.new("TextLabel"); ValueLabel.Parent=Frame; ValueLabel.BackgroundTransparency=1; ValueLabel.Position=UDim2.new(1,-50,0,0); ValueLabel.Size=UDim2.fromOffset(50,18); ValueLabel.Font=Enum.Font.GothamBold; ValueLabel.TextColor3=Theme.SubText; ValueLabel.TextSize=10; ValueLabel.TextXAlignment=Enum.TextXAlignment.Right
    local Back=Instance.new("Frame"); Back.Parent=Frame; Back.Position=UDim2.fromOffset(0,25); Back.Size=UDim2.new(1,0,0,10); Back.BackgroundColor3=Theme.SliderBackground or Theme.Secondary; Back.BorderSizePixel=0; local C=Instance.new("UICorner"); C.CornerRadius=UDim.new(0,999); C.Parent=Back
    local Fill=Instance.new("Frame"); Fill.Parent=Back; Fill.BackgroundColor3=Theme.SliderFill or Theme.Accent; Fill.BorderSizePixel=0; local FC=Instance.new("UICorner"); FC.CornerRadius=UDim.new(0,999); FC.Parent=Fill
    local Max=tonumber(Settings.Max) or 100; local Current=math.clamp(tonumber(Settings.Value) or 0,0,Max)
    local function update() local ratio=Max>0 and Current/Max or 0; Fill.Size=UDim2.new(ratio,0,1,0); ValueLabel.Text=string.format("%d%%",math.floor(ratio*100+0.5)) end
    local Object={Type="Progress",Instance=Frame,Title=Title,Fill=Fill}
    function Object:SetValue(v) Current=math.clamp(tonumber(v) or 0,0,Max); update() end
    function Object:GetValue() return Current end
    function Object:SetMax(v) Max=math.max(1,tonumber(v) or Max); Current=math.clamp(Current,0,Max); update() end
    function Object:RefreshTheme() local T=OTC._Themes[Tab.Window.Theme] or OTC._Themes[OTC.CurrentTheme] or OTC._Themes.Default; Title.TextColor3=T.Text; ValueLabel.TextColor3=T.SubText; Back.BackgroundColor3=T.SliderBackground or T.Secondary; Fill.BackgroundColor3=T.SliderFill or T.Accent end
    function Object:Destroy() Frame:Destroy() end
    update(); Tab:AddElement(Object); return Object
end
return Progress
