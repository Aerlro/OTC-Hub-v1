local Image = {}
function Image.Create(Tab, OTC, Settings)
    Settings=Settings or {}; local Theme=OTC._Themes[Tab.Window.Theme] or OTC._Themes[OTC.CurrentTheme] or OTC._Themes.Default
    local Frame=Instance.new("Frame"); Frame.Name="Image"; Frame.Parent=Tab.Page; Frame.Size=Settings.Size or UDim2.new(1,0,0,160); Frame.BackgroundColor3=Theme.Element; Frame.BackgroundTransparency=Theme.Transparency and Theme.Transparency.Element or 0; Frame.BorderSizePixel=0
    local Corner=Instance.new("UICorner"); Corner.CornerRadius=UDim.new(0,Theme.Corners and Theme.Corners.Element or 8); Corner.Parent=Frame
    local Picture=Instance.new("ImageLabel"); Picture.Parent=Frame; Picture.Size=UDim2.fromScale(1,1); Picture.BackgroundTransparency=1; Picture.BorderSizePixel=0; Picture.Image=tostring(Settings.Image or ""); Picture.ScaleType=Settings.ScaleType or Enum.ScaleType.Fit
    local PC=Instance.new("UICorner"); PC.CornerRadius=UDim.new(0,Theme.Corners and Theme.Corners.Element or 8); PC.Parent=Picture
    local Object={Type="Image",Instance=Frame,Image=Picture}
    function Object:SetImage(v) Picture.Image=tostring(v or "") end
    function Object:RefreshTheme() local T=OTC._Themes[Tab.Window.Theme] or OTC._Themes[OTC.CurrentTheme] or OTC._Themes.Default; Frame.BackgroundColor3=T.Element end
    function Object:Destroy() Frame:Destroy() end
    Tab:AddElement(Object); return Object
end
return Image
