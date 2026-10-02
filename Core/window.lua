local Window = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local function Tween(Object, Info, Properties)
    local TweenObject = TweenService:Create(Object, Info, Properties)
    TweenObject:Play()
    return TweenObject
end

local function GetTheme(Object)
    return Object.OTC._Themes[Object.OTC.CurrentTheme]
        or Object.OTC._Themes[Object.Theme]
        or Object.OTC._Themes.Default
end

function Window.Create(Settings, OTC)
    Settings = Settings or {}

    local ThemeName = Settings.Theme
        or OTC.CurrentTheme
        or "Default"

    if not OTC._Themes[ThemeName] then
        ThemeName = "Default"
    end

    local Object = {}

    Object.OTC = OTC
    Object.Theme = ThemeName
    Object.ToggleKey = Settings.ToggleKey or Enum.KeyCode.RightControl
    Object.Tabs = {}
    Object.SelectedTab = nil
    Object.Minimized = false
    Object.Closed = false
    Object.UnloadConfirmation = nil

    local Theme = GetTheme(Object)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "OTC_Hub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true

    pcall(function()
        ScreenGui.Parent = CoreGui
    end)

    if not ScreenGui.Parent then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    Object.ScreenGui = ScreenGui

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.new(0, 560, 0, 380)
    Main.Position = UDim2.new(0.5, -280, 0.5, -190)
    Main.BackgroundColor3 = Theme.Background
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = Main

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Theme.Border
    MainStroke.Thickness = 1
    MainStroke.Parent = Main

    Object.Main = Main
    Object.MainStroke = MainStroke

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 60)
    TopBar.BackgroundColor3 = Theme.Secondary
    TopBar.BorderSizePixel = 0
    TopBar.Parent = Main

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 10)
    TopCorner.Parent = TopBar

    local BottomFix = Instance.new("Frame")
    BottomFix.Size = UDim2.new(1, 0, 0, 12)
    BottomFix.Position = UDim2.new(0, 0, 1, -12)
    BottomFix.BackgroundColor3 = Theme.Secondary
    BottomFix.BorderSizePixel = 0
    BottomFix.Parent = TopBar

    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Size = UDim2.new(0, 38, 0, 38)
    Logo.Position = UDim2.new(0, 12, 0.5, -19)
    Logo.BackgroundTransparency = 1
    Logo.Image = "rbxassetid://116094782851554"
    Logo.ScaleType = Enum.ScaleType.Fit
    Logo.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 58, 0, 9)
    Title.Size = UDim2.new(0, 300, 0, 24)
    Title.Font = Enum.Font.GothamBold
    Title.Text = Settings.Name or "OTC Hub"
    Title.TextColor3 = Theme.Text
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    local Subtitle = Instance.new("TextLabel")
    Subtitle.Name = "Subtitle"
    Subtitle.BackgroundTransparency = 1
    Subtitle.Position = UDim2.new(0, 58, 0, 32)
    Subtitle.Size = UDim2.new(0, 300, 0, 18)
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.Text = Settings.Subtitle or "by Aerlro"
    Subtitle.TextColor3 = Theme.SubText
    Subtitle.TextSize = 12
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    Subtitle.Parent = TopBar

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "Minimize"
    MinimizeButton.Size = UDim2.new(0, 34, 0, 34)
    MinimizeButton.Position = UDim2.new(1, -78, 0.5, -17)
    MinimizeButton.BackgroundColor3 = Theme.Element
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.AutoButtonColor = false
    MinimizeButton.Text = "—"
    MinimizeButton.TextColor3 = Theme.Text
    MinimizeButton.TextSize = 18
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = TopBar

    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 7)
    MinimizeCorner.Parent = MinimizeButton

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "Close"
    CloseButton.Size = UDim2.new(0, 34, 0, 34)
    CloseButton.Position = UDim2.new(1, -40, 0.5, -17)
    CloseButton.BackgroundColor3 = Theme.Element
    CloseButton.BorderSizePixel = 0
    CloseButton.AutoButtonColor = false
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Theme.Text
    CloseButton.TextSize = 22
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TopBar

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 7)
    CloseCorner.Parent = CloseButton

    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 150, 1, -60)
    Sidebar.Position = UDim2.new(0, 0, 0, 60)
    Sidebar.BackgroundColor3 = Theme.Secondary
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main

    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 10)
    SidebarCorner.Parent = Sidebar

    local SidebarFix = Instance.new("Frame")
    SidebarFix.Size = UDim2.new(0, 12, 1, 0)
    SidebarFix.Position = UDim2.new(1, -12, 0, 0)
    SidebarFix.BackgroundColor3 = Theme.Secondary
    SidebarFix.BorderSizePixel = 0
    SidebarFix.Parent = Sidebar

    local Separator = Instance.new("Frame")
    Separator.Name = "Separator"
    Separator.Size = UDim2.new(0, 1, 1, -60)
    Separator.Position = UDim2.new(0, 150, 0, 60)
    Separator.BackgroundColor3 = Theme.Border
    Separator.BorderSizePixel = 0
    Separator.Parent = Main

    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Size = UDim2.new(1, -151, 1, -60)
    Content.Position = UDim2.new(0, 151, 0, 60)
    Content.BackgroundColor3 = Theme.Background
    Content.BorderSizePixel = 0
    Content.Parent = Main

    local TabsContainer = Instance.new("ScrollingFrame")
    TabsContainer.Name = "Tabs"
    TabsContainer.Size = UDim2.new(1, -12, 1, -82)
    TabsContainer.Position = UDim2.new(0, 6, 0, 8)
    TabsContainer.BackgroundTransparency = 1
    TabsContainer.BorderSizePixel = 0
    TabsContainer.ScrollBarThickness = 2
    TabsContainer.ScrollBarImageColor3 = Theme.Border
    TabsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabsContainer.Parent = Sidebar

    local TabsLayout = Instance.new("UIListLayout")
    TabsLayout.Padding = UDim.new(0, 5)
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsLayout.Parent = TabsContainer

    TabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabsContainer.CanvasSize = UDim2.new(
            0,
            0,
            0,
            TabsLayout.AbsoluteContentSize.Y + 8
        )
    end)

    local UserCard = Instance.new("Frame")
    UserCard.Name = "UserCard"
    UserCard.Size = UDim2.new(1, -12, 0, 60)
    UserCard.Position = UDim2.new(0, 6, 1, -68)
    UserCard.BackgroundColor3 = Theme.Element
    UserCard.BorderSizePixel = 0
    UserCard.Parent = Sidebar

    local UserCorner = Instance.new("UICorner")
    UserCorner.CornerRadius = UDim.new(0, 8)
    UserCorner.Parent = UserCard

    local UserSeparator = Instance.new("Frame")
    UserSeparator.Size = UDim2.new(1, -16, 0, 1)
    UserSeparator.Position = UDim2.new(0, 8, 0, 8)
    UserSeparator.BackgroundColor3 = Theme.Border
    UserSeparator.BorderSizePixel = 0
    UserSeparator.Parent = UserCard

    local UserAvatar = Instance.new("ImageLabel")
    UserAvatar.Name = "Avatar"
    UserAvatar.Size = UDim2.new(0, 36, 0, 36)
    UserAvatar.Position = UDim2.new(0, 8, 0.5, -12)
    UserAvatar.BackgroundTransparency = 1
    UserAvatar.Parent = UserCard

    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(1, 0)
    AvatarCorner.Parent = UserAvatar

    local UserDisplay = Instance.new("TextLabel")
    UserDisplay.Name = "DisplayName"
    UserDisplay.BackgroundTransparency = 1
    UserDisplay.Position = UDim2.new(0, 52, 0, 17)
    UserDisplay.Size = UDim2.new(1, -60, 0, 18)
    UserDisplay.Font = Enum.Font.GothamSemibold
    UserDisplay.Text = LocalPlayer.DisplayName
    UserDisplay.TextColor3 = Theme.Text
    UserDisplay.TextSize = 12
    UserDisplay.TextXAlignment = Enum.TextXAlignment.Left
    UserDisplay.TextTruncate = Enum.TextTruncate.AtEnd
    UserDisplay.Parent = UserCard

    local UserName = Instance.new("TextLabel")
    UserName.Name = "Username"
    UserName.BackgroundTransparency = 1
    UserName.Position = UDim2.new(0, 52, 0, 35)
    UserName.Size = UDim2.new(1, -60, 0, 16)
    UserName.Font = Enum.Font.Gotham
    UserName.Text = "@" .. LocalPlayer.Name
    UserName.TextColor3 = Theme.SubText
    UserName.TextSize = 10
    UserName.TextXAlignment = Enum.TextXAlignment.Left
    UserName.TextTruncate = Enum.TextTruncate.AtEnd
    UserName.Parent = UserCard

    pcall(function()
        UserAvatar.Image = Players:GetUserThumbnailAsync(
            LocalPlayer.UserId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size100x100
        )
    end)

    local MiniButton = Instance.new("ImageButton")
    MiniButton.Name = "MiniButton"
    MiniButton.Size = UDim2.new(0, 70, 0, 70)
    MiniButton.Position = UDim2.new(0.5, -35, 0.5, -35)
    MiniButton.BackgroundColor3 = Theme.Background
    MiniButton.BorderSizePixel = 0
    MiniButton.Visible = false
    MiniButton.AutoButtonColor = false
    MiniButton.Image = "rbxassetid://116094782851554"
    MiniButton.ScaleType = Enum.ScaleType.Fit
    MiniButton.Parent = ScreenGui

    local MiniCorner = Instance.new("UICorner")
    MiniCorner.CornerRadius = UDim.new(1, 0)
    MiniCorner.Parent = MiniButton

    local MiniStroke = Instance.new("UIStroke")
    MiniStroke.Color = Theme.Border
    MiniStroke.Thickness = 2
    MiniStroke.Parent = MiniButton

    Object.TopBar = TopBar
    Object.BottomFix = BottomFix
    Object.Logo = Logo
    Object.Title = Title
    Object.Subtitle = Subtitle
    Object.MinimizeButton = MinimizeButton
    Object.CloseButton = CloseButton
    Object.Sidebar = Sidebar
    Object.SidebarFix = SidebarFix
    Object.Separator = Separator
    Object.Content = Content
    Object.TabsContainer = TabsContainer
    Object.UserCard = UserCard
    Object.UserSeparator = UserSeparator
    Object.UserAvatar = UserAvatar
    Object.UserDisplay = UserDisplay
    Object.UserName = UserName
    Object.MiniButton = MiniButton
    Object.MiniStroke = MiniStroke

    local Dragging = false
    local DragStart
    local StartPosition

    TopBar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then

            Dragging = true
            DragStart = Input.Position
            StartPosition = Main.Position

            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Dragging and (
            Input.UserInputType == Enum.UserInputType.MouseMovement
            or Input.UserInputType == Enum.UserInputType.Touch
        ) then
            local Delta = Input.Position - DragStart

            Main.Position = UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        end
    end)

    local MiniDragging = false
    local MiniDragStart
    local MiniStartPosition

    MiniButton.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then

            MiniDragging = true
            MiniDragStart = Input.Position
            MiniStartPosition = MiniButton.Position

            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    MiniDragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if MiniDragging and (
            Input.UserInputType == Enum.UserInputType.MouseMovement
            or Input.UserInputType == Enum.UserInputType.Touch
        ) then
            local Delta = Input.Position - MiniDragStart

            MiniButton.Position = UDim2.new(
                MiniStartPosition.X.Scale,
                MiniStartPosition.X.Offset + Delta.X,
                MiniStartPosition.Y.Scale,
                MiniStartPosition.Y.Offset + Delta.Y
            )
        end
    end)

    local function CreateUnloadConfirmation()
        if Object.UnloadConfirmation then
            return
        end

        local CurrentTheme = OTC._Themes[OTC.CurrentTheme]
            or OTC._Themes[Object.Theme]
            or OTC._Themes.Default

        local Overlay = Instance.new("Frame")
        Overlay.Name = "UnloadOverlay"
        Overlay.Size = UDim2.new(1, 0, 1, 0)
        Overlay.Position = UDim2.new(0, 0, 0, 0)
        Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Overlay.BackgroundTransparency = 0.45
        Overlay.BorderSizePixel = 0
        Overlay.ZIndex = 100
        Overlay.Parent = ScreenGui

        local Popup = Instance.new("Frame")
        Popup.Name = "UnloadConfirmation"
        Popup.Size = UDim2.new(0, 360, 0, 190)
        Popup.Position = UDim2.new(0.5, -180, 0.5, -95)
        Popup.BackgroundColor3 = CurrentTheme.Background
        Popup.BorderSizePixel = 0
        Popup.ZIndex = 101
        Popup.Parent = Overlay

        local PopupCorner = Instance.new("UICorner")
        PopupCorner.CornerRadius = UDim.new(0, 10)
        PopupCorner.Parent = Popup

        local PopupStroke = Instance.new("UIStroke")
        PopupStroke.Color = CurrentTheme.Border
        PopupStroke.Thickness = 1
        PopupStroke.Parent = Popup

        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Position = UDim2.new(0, 20, 0, 18)
        TitleLabel.Size = UDim2.new(1, -40, 0, 30)
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.Text = "Unload OTC Hub?"
        TitleLabel.TextColor3 = CurrentTheme.Text
        TitleLabel.TextSize = 20
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.ZIndex = 102
        TitleLabel.Parent = Popup

        local Description = Instance.new("TextLabel")
        Description.BackgroundTransparency = 1
        Description.Position = UDim2.new(0, 20, 0, 55)
        Description.Size = UDim2.new(1, -40, 0, 45)
        Description.Font = Enum.Font.Gotham
        Description.Text = "Are you sure you want to unload OTC Hub?"
        Description.TextColor3 = CurrentTheme.SubText
        Description.TextSize = 14
        Description.TextWrapped = true
        Description.TextXAlignment = Enum.TextXAlignment.Left
        Description.ZIndex = 102
        Description.Parent = Popup

        local CancelButton = Instance.new("TextButton")
        CancelButton.Name = "Cancel"
        CancelButton.Size = UDim2.new(0, 145, 0, 42)
        CancelButton.Position = UDim2.new(0, 20, 1, -62)
        CancelButton.BackgroundColor3 = CurrentTheme.Element
        CancelButton.BorderSizePixel = 0
        CancelButton.AutoButtonColor = false
        CancelButton.Font = Enum.Font.GothamSemibold
        CancelButton.Text = "Cancel"
        CancelButton.TextColor3 = CurrentTheme.Text
        CancelButton.TextSize = 14
        CancelButton.ZIndex = 102
        CancelButton.Parent = Popup

        local CancelCorner = Instance.new("UICorner")
        CancelCorner.CornerRadius = UDim.new(0, 7)
        CancelCorner.Parent = CancelButton

        local UnloadButton = Instance.new("TextButton")
        UnloadButton.Name = "Unload"
        UnloadButton.Size = UDim2.new(0, 145, 0, 42)
        UnloadButton.Position = UDim2.new(1, -165, 1, -62)
        UnloadButton.BackgroundColor3 = CurrentTheme.Accent
        UnloadButton.BorderSizePixel = 0
        UnloadButton.AutoButtonColor = false
        UnloadButton.Font = Enum.Font.GothamSemibold
        UnloadButton.Text = "Unload"
        UnloadButton.TextColor3 = CurrentTheme.Background
        UnloadButton.TextSize = 14
        UnloadButton.ZIndex = 102
        UnloadButton.Parent = Popup

        local UnloadCorner = Instance.new("UICorner")
        UnloadCorner.CornerRadius = UDim.new(0, 7)
        UnloadCorner.Parent = UnloadButton

        CancelButton.MouseEnter:Connect(function()
            local Current = OTC._Themes[OTC.CurrentTheme]
                or OTC._Themes.Default

            CancelButton.BackgroundColor3 = Current.Hover
        end)

        CancelButton.MouseLeave:Connect(function()
            local Current = OTC._Themes[OTC.CurrentTheme]
                or OTC._Themes.Default

            CancelButton.BackgroundColor3 = Current.Element
        end)

        UnloadButton.MouseEnter:Connect(function()
            local Current = OTC._Themes[OTC.CurrentTheme]
                or OTC._Themes.Default

            UnloadButton.BackgroundColor3 = Current.AccentDark
        end)

        UnloadButton.MouseLeave:Connect(function()
            local Current = OTC._Themes[OTC.CurrentTheme]
                or OTC._Themes.Default

            UnloadButton.BackgroundColor3 = Current.Accent
        end)

        CancelButton.MouseButton1Click:Connect(function()
            Overlay:Destroy()
            Object.UnloadConfirmation = nil
        end)

        UnloadButton.MouseButton1Click:Connect(function()
            if Object.Unload then
                Object:Unload()
            end
        end)

        Object.UnloadConfirmation = {
            Overlay = Overlay,
            Popup = Popup,
            PopupStroke = PopupStroke,
            Title = TitleLabel,
            Description = Description,
            CancelButton = CancelButton,
            UnloadButton = UnloadButton
        }

        Object:RefreshTheme()
    end

    local function Unload()
        if Object.Closed then
            return
        end

        Object.Closed = true

        if Object.UnloadConfirmation then
            Object.UnloadConfirmation.Overlay:Destroy()
            Object.UnloadConfirmation = nil
        end

        if OTC._Connections then
            for _, Connection in pairs(OTC._Connections) do
                pcall(function()
                    Connection:Disconnect()
                end)
            end

            table.clear(OTC._Connections)
        end

        if Object.ScreenGui then
            Object.ScreenGui:Destroy()
        end

        for Index, WindowObject in pairs(OTC._Windows) do
            if WindowObject == Object then
                OTC._Windows[Index] = nil
            end
        end
    end

    Object.Unload = Unload

    CloseButton.MouseButton1Click:Connect(function()
        CreateUnloadConfirmation()
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        Object:Toggle()
    end)

    MinimizeButton.MouseEnter:Connect(function()
        Tween(
            MinimizeButton,
            TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(0, 38, 0, 38),
                Position = UDim2.new(1, -80, 0.5, -19)
            }
        )
    end)

    MinimizeButton.MouseLeave:Connect(function()
        Tween(
            MinimizeButton,
            TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(0, 34, 0, 34),
                Position = UDim2.new(1, -78, 0.5, -17)
            }
        )
    end)

    CloseButton.MouseEnter:Connect(function()
        Tween(
            CloseButton,
            TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(0, 38, 0, 38),
                Position = UDim2.new(1, -42, 0.5, -19)
            }
        )
    end)

    CloseButton.MouseLeave:Connect(function()
        Tween(
            CloseButton,
            TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(0, 34, 0, 34),
                Position = UDim2.new(1, -40, 0.5, -17)
            }
        )
    end)

    MiniButton.MouseButton1Click:Connect(function()
        Object:Toggle()
    end)

    function Object:GetTheme()
        return self.OTC._Themes[self.OTC.CurrentTheme]
            or self.OTC._Themes[self.Theme]
            or self.OTC._Themes.Default
    end

    function Object:SetTheme(Name)
        if not self.OTC._Themes[Name] then
            return false
        end

        self.Theme = Name
        self:RefreshTheme()

        return true
    end

    function Object:Toggle()
        if self.Closed then
            return
        end

        if self.Minimized then
            self:Restore()
        else
            self:Minimize()
        end
    end

    function Object:Minimize()
        if self.Minimized or self.Closed then
            return
        end

        self.Minimized = true

        Main.Visible = false
        MiniButton.Visible = true

        MiniButton.Size = UDim2.new(0, 0, 0, 0)

        Tween(
            MiniButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(0, 70, 0, 70)
            }
        )
    end

    function Object:Restore()
        if not self.Minimized or self.Closed then
            return
        end

        self.Minimized = false

        Tween(
            MiniButton,
            TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {
                Size = UDim2.new(0, 0, 0, 0)
            }
        )

        task.delay(0.15, function()
            if self.Closed then
                return
            end

            MiniButton.Visible = false
            Main.Visible = true
        end)
    end

    function Object:AddTab(TabObject)
        table.insert(self.Tabs, TabObject)

        TabObject.Button.Parent = TabsContainer

        if not self.SelectedTab then
            self:SelectTab(TabObject)
        end
    end

    function Object:SelectTab(TabObject)
        if self.SelectedTab == TabObject then
            return
        end

        if self.SelectedTab and self.SelectedTab.Page then
            self.SelectedTab.Page.Visible = false
        end

        self.SelectedTab = TabObject

        if TabObject.Page then
            TabObject.Page.Visible = true
        end

        for _, Tab in ipairs(self.Tabs) do
            if Tab.SetSelected then
                Tab:SetSelected(Tab == TabObject)
            end
        end
    end

    function Object:RefreshTheme()
        local ThemeName = self.OTC.CurrentTheme

        local NewTheme = self.OTC._Themes[ThemeName]
            or self.OTC._Themes[self.Theme]
            or self.OTC._Themes.Default

        self.Theme = ThemeName

        Main.BackgroundColor3 = NewTheme.Background
        MainStroke.Color = NewTheme.Border

        TopBar.BackgroundColor3 = NewTheme.Secondary
        BottomFix.BackgroundColor3 = NewTheme.Secondary

        Logo.ImageColor3 = NewTheme.Text
        Title.TextColor3 = NewTheme.Text
        Subtitle.TextColor3 = NewTheme.SubText

        MinimizeButton.BackgroundColor3 = NewTheme.Element
        MinimizeButton.TextColor3 = NewTheme.Text

        CloseButton.BackgroundColor3 = NewTheme.Element
        CloseButton.TextColor3 = NewTheme.Text

        Sidebar.BackgroundColor3 = NewTheme.Secondary
        SidebarFix.BackgroundColor3 = NewTheme.Secondary

        Separator.BackgroundColor3 = NewTheme.Border

        Content.BackgroundColor3 = NewTheme.Background

        TabsContainer.ScrollBarImageColor3 = NewTheme.Border

        UserCard.BackgroundColor3 = NewTheme.Element
        UserSeparator.BackgroundColor3 = NewTheme.Border

        UserDisplay.TextColor3 = NewTheme.Text
        UserName.TextColor3 = NewTheme.SubText

        MiniButton.BackgroundColor3 = NewTheme.Background
        MiniStroke.Color = NewTheme.Border

        if self.UnloadConfirmation then
            local Popup = self.UnloadConfirmation

            Popup.Popup.BackgroundColor3 = NewTheme.Background
            Popup.PopupStroke.Color = NewTheme.Border

            Popup.Title.TextColor3 = NewTheme.Text
            Popup.Description.TextColor3 = NewTheme.SubText

            Popup.CancelButton.BackgroundColor3 = NewTheme.Element
            Popup.CancelButton.TextColor3 = NewTheme.Text

            Popup.UnloadButton.BackgroundColor3 = NewTheme.Accent
            Popup.UnloadButton.TextColor3 = NewTheme.Background
        end

        for _, TabObject in ipairs(self.Tabs) do
            if TabObject.RefreshTheme then
                pcall(function()
                    TabObject:RefreshTheme()
                end)
            end
        end
    end

    OTC._Windows[Object] = Object

    if OTC._InitializeInput then
        OTC._InitializeInput()
    end

    if OTC._Animation and OTC._Animation.Appear then
        pcall(function()
            OTC._Animation:Appear(
                Main,
                "Bottom",
                20,
                0.3
            )
        end)
    end

    return Object
end

return Window