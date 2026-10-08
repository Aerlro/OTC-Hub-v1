local Window = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local LOGO_ASSET =
    "rbxassetid://95900623719417"

local MINIMIZE_ASSET =
    "rbxassetid://123120037399918"

local CLOSE_ASSET =
    "rbxassetid://97642116681622"

local SEARCH_ASSET =
    "rbxassetid://122340561776969"

local function Tween(Object, Info, Properties)
    local TweenObject =
        TweenService:Create(
            Object,
            Info,
            Properties
        )

    TweenObject:Play()

    return TweenObject
end

local function GetTheme(Object)
    return Object.OTC._Themes[Object.Theme]
        or Object.OTC._Themes[Object.OTC.CurrentTheme]
        or Object.OTC._Themes.Default
end

local function IsThemeAllowed(OTC, Name)
    if OTC._ThemeModule
        and OTC._ThemeModule.IsAllowed then

        return OTC._ThemeModule:IsAllowed(
            Name,
            LocalPlayer
        )
    end

    return true
end

local function GetThemeAccessMessage(OTC, Name)
    if OTC._ThemeModule
        and OTC._ThemeModule.GetAccessMessage then

        return OTC._ThemeModule:GetAccessMessage(
            Name
        )
    end

    return "You don't have permission to use this theme."
end

local function NotifyThemeDenied(Message)
    warn("[OTC Hub] " .. tostring(Message))

    pcall(function()
        game:GetService("StarterGui"):SetCore(
            "SendNotification",
            {
                Title = "OTC Hub",
                Text = tostring(Message),
                Duration = 4
            }
        )
    end)
end

local function ApplyGradient(Object, GradientData)
    if not Object or not GradientData then
        return nil
    end

    local Existing =
        Object:FindFirstChild("OTCGradient")

    if Existing then
        Existing:Destroy()
    end

    if GradientData.Enabled ~= true then
        return nil
    end

    local UIGradient =
        Instance.new("UIGradient")

    UIGradient.Name =
        "OTCGradient"

    UIGradient.Color =
        GradientData.Colors
        or ColorSequence.new(
            Color3.new(1, 1, 1)
        )

    UIGradient.Rotation =
        GradientData.Rotation or 0

    UIGradient.Parent = Object

    return UIGradient
end

local function ApplyCorner(Object, Radius)
    if not Object or Radius == nil then
        return
    end

    local Corner =
        Object:FindFirstChildOfClass("UICorner")

    if Corner then
        Corner.CornerRadius =
            UDim.new(0, Radius)
    end
end

local function ApplyStroke(StrokeObject, ThemeData)
    if not StrokeObject or not ThemeData then
        return
    end

    local Stroke = ThemeData.Stroke

    if not Stroke then
        return
    end

    StrokeObject.Enabled =
        Stroke.Enabled ~= false

    StrokeObject.Thickness =
        Stroke.Thickness or 1

    StrokeObject.Transparency =
        Stroke.Transparency or 0
end

function Window.Create(Settings, OTC)

    Settings = Settings or {}

    local ThemeName =
        Settings.Theme
        or OTC.CurrentTheme
        or "Default"

    if not OTC._Themes[ThemeName] then
        ThemeName = "Default"
    end

    if not IsThemeAllowed(OTC, ThemeName) then

        local Message =
            GetThemeAccessMessage(
                OTC,
                ThemeName
            )

        NotifyThemeDenied(Message)

        ThemeName = "Default"
    end

    local Object = {}

    Object.OTC = OTC
    Object.Theme = ThemeName

    Object.ToggleKey =
        Settings.ToggleKey
        or Enum.KeyCode.RightControl

    Object.Tabs = {}
    Object.SelectedTab = nil
    Object.Minimized = false
    Object.Closed = false
    Object.UnloadConfirmation = nil
    Object.VersionPopup = nil
    Object.ThemeGradients = {}
    Object.RomanArtwork = nil

    local Theme =
        GetTheme(Object)

    local ScreenGui =
        Instance.new("ScreenGui")

    ScreenGui.Name =
        "OTC_Hub"

    ScreenGui.ResetOnSpawn =
        false

    ScreenGui.ZIndexBehavior =
        Enum.ZIndexBehavior.Sibling

    ScreenGui.IgnoreGuiInset =
        true

    pcall(function()
        ScreenGui.Parent = CoreGui
    end)

    if not ScreenGui.Parent then
        ScreenGui.Parent =
            LocalPlayer:WaitForChild(
                "PlayerGui"
            )
    end

    Object.ScreenGui =
        ScreenGui

    local Main =
        Instance.new("Frame")

    Main.Name = "Main"

    Main.Size =
        UDim2.new(
            0,
            560,
            0,
            380
        )

    Main.Position =
        UDim2.new(
            0.5,
            -280,
            0.5,
            -190
        )

    Main.BackgroundColor3 =
        Theme.Background

    Main.BackgroundTransparency =
        Theme.Transparency
        and Theme.Transparency.Main
        or 0

    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Parent = ScreenGui

    local MainCorner =
        Instance.new("UICorner")

    MainCorner.CornerRadius =
        UDim.new(
            0,
            Theme.Corners
            and Theme.Corners.Main
            or 10
        )

    MainCorner.Parent = Main

    local MainStroke =
        Instance.new("UIStroke")

    MainStroke.Color =
        Theme.Border

    MainStroke.Thickness =
        Theme.Stroke
        and Theme.Stroke.Thickness
        or 1

    MainStroke.Transparency =
        Theme.Stroke
        and Theme.Stroke.Transparency
        or 0

    MainStroke.Parent =
        Main

    Object.Main =
        Main

    Object.MainStroke =
        MainStroke

    local RomanArtwork =
        Instance.new("ImageLabel")

    RomanArtwork.Name =
        "RomanReignsArtwork"

    RomanArtwork.Size =
        UDim2.new(
            0,
            300,
            0,
            300
        )

    RomanArtwork.Position =
        UDim2.new(
            1,
            -315,
            1,
            -315
        )

    RomanArtwork.BackgroundTransparency =
        1

    RomanArtwork.BorderSizePixel =
        0

    RomanArtwork.ImageTransparency =
        0.72

    RomanArtwork.ScaleType =
        Enum.ScaleType.Fit

    RomanArtwork.Active =
        false

    RomanArtwork.Selectable =
        false

    RomanArtwork.Visible =
        false

    RomanArtwork.ZIndex =
        1

    RomanArtwork.Parent =
        Main

    Object.RomanArtwork =
        RomanArtwork

    local function UpdateRomanArtwork(NewTheme)

        local Artwork =
            NewTheme.Artwork

        if not Artwork
            or Artwork.Enabled ~= true then

            RomanArtwork.Visible =
                false

            RomanArtwork.Image =
                ""

            return
        end

        RomanArtwork.Size =
            Artwork.Size
            or UDim2.new(
                0,
                300,
                0,
                300
            )

        RomanArtwork.Position =
            Artwork.Position
            or UDim2.new(
                1,
                -315,
                1,
                -315
            )

        RomanArtwork.ImageTransparency =
            Artwork.ImageTransparency
            or 0.72

        RomanArtwork.ZIndex =
            Artwork.ZIndex or 1

        local Image =
            Artwork.Image

        if type(Image) == "string"
            and Image ~= "" then

            RomanArtwork.Image =
                Image

            RomanArtwork.Visible =
                true
        else

            RomanArtwork.Visible =
                false

            RomanArtwork.Image =
                ""
        end
    end

    local TopBar =
        Instance.new("Frame")

    TopBar.Name =
        "TopBar"

    TopBar.Size =
        UDim2.new(
            1,
            0,
            0,
            62
        )

    TopBar.Position =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    TopBar.BackgroundColor3 =
        Theme.Secondary

    TopBar.BackgroundTransparency =
        Theme.Transparency
        and Theme.Transparency.Secondary
        or 0

    TopBar.BorderSizePixel =
        0

    TopBar.ZIndex =
        5

    TopBar.Parent =
        Main

    local Logo =
        Instance.new("ImageLabel")

    Logo.Name =
        "Logo"

    Logo.Size =
        UDim2.new(
            0,
            38,
            0,
            38
        )

    Logo.Position =
        UDim2.new(
            0,
            12,
            0.5,
            -19
        )

    Logo.BackgroundTransparency =
        1

    Logo.BorderSizePixel =
        0

    Logo.Image =
        LOGO_ASSET

    Logo.ImageTransparency =
        0

    Logo.ScaleType =
        Enum.ScaleType.Fit

    Logo.ZIndex =
        6

    Logo.Parent =
        TopBar

    local Title =
        Instance.new("TextLabel")

    Title.Name =
        "Title"

    Title.BackgroundTransparency =
        1

    Title.Position =
        UDim2.new(
            0,
            58,
            0,
            9
        )

    Title.Size =
        UDim2.new(
            0,
            300,
            0,
            24
        )

    Title.Font =
        Enum.Font.GothamBold

    Title.Text =
        Settings.Name
        or "OTC Hub"

    Title.TextColor3 =
        Theme.Text

    Title.TextSize =
        18

    Title.TextXAlignment =
        Enum.TextXAlignment.Left

    Title.ZIndex =
        6

    Title.Parent =
        TopBar

    local Subtitle =
        Instance.new("TextLabel")

    Subtitle.Name =
        "Subtitle"

    Subtitle.BackgroundTransparency =
        1

    Subtitle.Position =
        UDim2.new(
            0,
            58,
            0,
            32
        )

    Subtitle.Size =
        UDim2.new(
            0,
            300,
            0,
            18
        )

    Subtitle.Font =
        Enum.Font.Gotham

    Subtitle.Text =
        Settings.Subtitle
        or "by Aerlro"

    Subtitle.TextColor3 =
        Theme.SubText

    Subtitle.TextSize =
        12

    Subtitle.TextXAlignment =
        Enum.TextXAlignment.Left

    Subtitle.ZIndex =
        6

    Subtitle.Parent =
        TopBar

    local VersionTag =
        Instance.new("TextButton")

    VersionTag.Name =
        "VersionTag"

    VersionTag.Size =
        UDim2.new(
            0,
            62,
            0,
            22
        )

    VersionTag.Position =
        UDim2.new(
            1,
            -188,
            0.5,
            -11
        )

    VersionTag.BackgroundColor3 =
        Theme.Element

    VersionTag.BackgroundTransparency =
        Theme.Transparency
        and Theme.Transparency.Element
        or 0

    VersionTag.BorderSizePixel =
        0

    VersionTag.AutoButtonColor =
        false

    VersionTag.Text =
        "v" ..
        tostring(
            OTC.Version
            or "1.0.0"
        )

    VersionTag.TextColor3 =
        Theme.Text

    VersionTag.TextSize =
        10

    VersionTag.Font =
        Enum.Font.GothamBold

    VersionTag.ZIndex =
        10

    VersionTag.Parent =
        TopBar

    local VersionCorner =
        Instance.new("UICorner")

    VersionCorner.CornerRadius =
        UDim.new(0, 7)

    VersionCorner.Parent =
        VersionTag

    local VersionStroke =
        Instance.new("UIStroke")

    VersionStroke.Color =
        Theme.Border

    VersionStroke.Thickness =
        Theme.Stroke
        and Theme.Stroke.Thickness
        or 1

    VersionStroke.Transparency =
        Theme.Stroke
        and Theme.Stroke.Transparency
        or 0.3

    VersionStroke.Parent =
        VersionTag

    -- SEARCH

    local SearchButton =
        Instance.new("ImageButton")

    SearchButton.Name =
        "Search"

    SearchButton.Size =
        UDim2.new(
            0,
            34,
            0,
            34
        )

    SearchButton.Position =
        UDim2.new(
            1,
            -150,
            0.5,
            -17
        )

    SearchButton.BackgroundColor3 =
        Theme.Element

    SearchButton.BackgroundTransparency =
        Theme.Transparency
        and Theme.Transparency.Element
        or 0

    SearchButton.BorderSizePixel =
        0

    SearchButton.AutoButtonColor =
        false

    SearchButton.Image =
        SEARCH_ASSET

    SearchButton.ImageTransparency =
        0

    SearchButton.ScaleType =
        Enum.ScaleType.Fit

    SearchButton.ZIndex =
        10

    SearchButton.Parent =
        TopBar

    local SearchCorner =
        Instance.new("UICorner")

    SearchCorner.CornerRadius =
        UDim.new(
            0,
            Theme.Corners
            and Theme.Corners.Button
            or 7
        )

    SearchCorner.Parent =
        SearchButton

    local MinimizeButton =
        Instance.new("ImageButton")

    MinimizeButton.Name =
        "Minimize"

    MinimizeButton.Size =
        UDim2.new(
            0,
            34,
            0,
            34
        )

    MinimizeButton.Position =
        UDim2.new(
            1,
            -110,
            0.5,
            -17
        )

    MinimizeButton.BackgroundColor3 =
        Theme.Element

    MinimizeButton.BackgroundTransparency =
        Theme.Transparency
        and Theme.Transparency.Element
        or 0

    MinimizeButton.BorderSizePixel =
        0

    MinimizeButton.AutoButtonColor =
        false

    MinimizeButton.Image =
        MINIMIZE_ASSET

    MinimizeButton.ImageTransparency =
        0

    MinimizeButton.ScaleType =
        Enum.ScaleType.Fit

    MinimizeButton.ZIndex =
        10

    MinimizeButton.Parent =
        TopBar

    local MinimizeCorner =
        Instance.new("UICorner")

    MinimizeCorner.CornerRadius =
        UDim.new(
            0,
            Theme.Corners
            and Theme.Corners.Button
            or 7
        )

    MinimizeCorner.Parent =
        MinimizeButton

    local CloseButton =
        Instance.new("ImageButton")

    CloseButton.Name =
        "Close"

    CloseButton.Size =
        UDim2.new(
            0,
            34,
            0,
            34
        )

    CloseButton.Position =
        UDim2.new(
            1,
            -72,
            0.5,
            -17
        )

    CloseButton.BackgroundColor3 =
        Theme.Element

    CloseButton.BackgroundTransparency =
        Theme.Transparency
        and Theme.Transparency.Element
        or 0

    CloseButton.BorderSizePixel =
        0

    CloseButton.AutoButtonColor =
        false

    CloseButton.Image =
        CLOSE_ASSET

    CloseButton.ImageTransparency =
        0

    CloseButton.ScaleType =
        Enum.ScaleType.Fit

    CloseButton.ZIndex =
        10

    CloseButton.Parent =
        TopBar

    local CloseCorner =
        Instance.new("UICorner")

    CloseCorner.CornerRadius =
        UDim.new(
            0,
            Theme.Corners
            and Theme.Corners.Button
            or 7
        )

    CloseCorner.Parent =
        CloseButton

    local Sidebar =
        Instance.new("Frame")

    Sidebar.Name =
        "Sidebar"

    Sidebar.Size =
        UDim2.new(
            0,
            150,
            1,
            -62
        )

    Sidebar.Position =
        UDim2.new(
            0,
            0,
            0,
            62
        )

    Sidebar.BackgroundColor3 =
        Theme.Secondary

    Sidebar.BackgroundTransparency =
        Theme.Transparency
        and Theme.Transparency.Secondary
        or 0

    Sidebar.BorderSizePixel =
        0

    Sidebar.ZIndex =
        4

    Sidebar.Parent =
        Main

    local Content =
        Instance.new("Frame")

    Content.Name =
        "Content"

    Content.Size =
        UDim2.new(
            1,
            -150,
            1,
            -62
        )

    Content.Position =
        UDim2.new(
            0,
            150,
            0,
            62
        )

    Content.BackgroundColor3 =
        Theme.Background

    Content.BackgroundTransparency =
        Theme.Transparency
        and Theme.Transparency.Main
        or 0

    Content.BorderSizePixel =
        0

    Content.ZIndex =
        3

    Content.Parent =
        Main

    local TabsContainer =
        Instance.new("ScrollingFrame")

    TabsContainer.Name =
        "Tabs"

    TabsContainer.Size =
        UDim2.new(
            1,
            -16,
            1,
            -82
        )

    TabsContainer.Position =
        UDim2.new(
            0,
            8,
            0,
            8
        )

    TabsContainer.BackgroundTransparency =
        1

    TabsContainer.BorderSizePixel =
        0

    TabsContainer.ScrollBarThickness =
        2

    TabsContainer.ScrollBarImageColor3 =
        Theme.Scrollbar
        or Theme.Border

    TabsContainer.CanvasSize =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    TabsContainer.ZIndex =
        5

    TabsContainer.Parent =
        Sidebar

    local TabsLayout =
        Instance.new("UIListLayout")

    TabsLayout.Padding =
        UDim.new(0, 5)

    TabsLayout.SortOrder =
        Enum.SortOrder.LayoutOrder

    TabsLayout.Parent =
        TabsContainer

    TabsLayout:GetPropertyChangedSignal(
        "AbsoluteContentSize"
    ):Connect(function()

        TabsContainer.CanvasSize =
            UDim2.new(
                0,
                0,
                0,
                TabsLayout.AbsoluteContentSize.Y + 8
            )
    end)

    local UserCard =
        Instance.new("Frame")

    UserCard.Name =
        "UserCard"

    UserCard.Size =
        UDim2.new(
            1,
            -16,
            0,
            60
        )

    UserCard.Position =
        UDim2.new(
            0,
            8,
            1,
            -68
        )

    UserCard.BackgroundColor3 =
        Theme.Element

    UserCard.BackgroundTransparency =
        Theme.Transparency
        and Theme.Transparency.Element
        or 0

    UserCard.BorderSizePixel =
        0

    UserCard.ZIndex =
        6

    UserCard.Parent =
        Sidebar

    local UserCorner =
        Instance.new("UICorner")

    UserCorner.CornerRadius =
        UDim.new(
            0,
            Theme.Corners
            and Theme.Corners.Element
            or 8
        )

    UserCorner.Parent =
        UserCard

    local UserAvatar =
        Instance.new("ImageLabel")

    UserAvatar.Name =
        "Avatar"

    UserAvatar.Size =
        UDim2.new(
            0,
            36,
            0,
            36
        )

    UserAvatar.Position =
        UDim2.new(
            0,
            10,
            0.5,
            -18
        )

    UserAvatar.BackgroundColor3 =
        Theme.Background

    UserAvatar.BackgroundTransparency =
        0

    UserAvatar.BorderSizePixel =
        0

    UserAvatar.ZIndex =
        7

    UserAvatar.Parent =
        UserCard

    local AvatarCorner =
        Instance.new("UICorner")

    AvatarCorner.CornerRadius =
        UDim.new(1, 0)

    AvatarCorner.Parent =
        UserAvatar

    local UserDisplay =
        Instance.new("TextLabel")

    UserDisplay.Name =
        "DisplayName"

    UserDisplay.BackgroundTransparency =
        1

    UserDisplay.Position =
        UDim2.new(
            0,
            56,
            0,
            13
        )

    UserDisplay.Size =
        UDim2.new(
            1,
            -66,
            0,
            18
        )

    UserDisplay.Font =
        Enum.Font.GothamSemibold

    UserDisplay.Text =
        LocalPlayer.DisplayName

    UserDisplay.TextColor3 =
        Theme.Text

    UserDisplay.TextSize =
        12

    UserDisplay.TextXAlignment =
        Enum.TextXAlignment.Left

    UserDisplay.TextTruncate =
        Enum.TextTruncate.AtEnd

    UserDisplay.ZIndex =
        7

    UserDisplay.Parent =
        UserCard

    local UserName =
        Instance.new("TextLabel")

    UserName.Name =
        "Username"

    UserName.BackgroundTransparency =
        1

    UserName.Position =
        UDim2.new(
            0,
            56,
            0,
            33
        )

    UserName.Size =
        UDim2.new(
            1,
            -66,
            0,
            16
        )

    UserName.Font =
        Enum.Font.Gotham

    UserName.Text =
        "@" .. LocalPlayer.Name

    UserName.TextColor3 =
        Theme.SubText

    UserName.TextSize =
        10

    UserName.TextXAlignment =
        Enum.TextXAlignment.Left

    UserName.TextTruncate =
        Enum.TextTruncate.AtEnd

    UserName.ZIndex =
        7

    UserName.Parent =
        UserCard

    pcall(function()

        UserAvatar.Image =
            Players:GetUserThumbnailAsync(
                LocalPlayer.UserId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size100x100
            )

    end)

    local MiniButton =
        Instance.new("ImageButton")

    MiniButton.Name =
        "MiniButton"

    MiniButton.Size =
        UDim2.new(
            0,
            70,
            0,
            70
        )

    MiniButton.Position =
        UDim2.new(
            0.5,
            -35,
            0.5,
            -35
        )

    MiniButton.BackgroundTransparency =
        1

    MiniButton.BorderSizePixel =
        0

    MiniButton.Visible =
        false

    MiniButton.AutoButtonColor =
        false

    MiniButton.Image =
        LOGO_ASSET

    MiniButton.ImageTransparency =
        0

    MiniButton.ScaleType =
        Enum.ScaleType.Fit

    MiniButton.Parent =
        ScreenGui

    Object.TopBar =
        TopBar

    Object.Logo =
        Logo

    Object.Title =
        Title

    Object.Subtitle =
        Subtitle

    Object.VersionTag =
        VersionTag

    Object.VersionStroke =
        VersionStroke

    Object.SearchButton =
        SearchButton

    Object.MinimizeButton =
        MinimizeButton

    Object.CloseButton =
        CloseButton

    Object.Sidebar =
        Sidebar

    Object.Content =
        Content

    Object.TabsContainer =
        TabsContainer

    Object.UserCard =
        UserCard

    Object.UserAvatar =
        UserAvatar

    Object.UserDisplay =
        UserDisplay

    Object.UserName =
        UserName

    Object.MiniButton =
        MiniButton

    local Dragging =
        false

    local DragStart
    local StartPosition

    TopBar.InputBegan:Connect(function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or Input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging =
                true

            DragStart =
                Input.Position

            StartPosition =
                Main.Position

            Input.Changed:Connect(function()

                if Input.UserInputState ==
                    Enum.UserInputState.End then

                    Dragging =
                        false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)

        if Dragging
            and (
                Input.UserInputType ==
                    Enum.UserInputType.MouseMovement
                or Input.UserInputType ==
                    Enum.UserInputType.Touch
            ) then

            local Delta =
                Input.Position -
                DragStart

            Main.Position =
                UDim2.new(
                    StartPosition.X.Scale,
                    StartPosition.X.Offset +
                        Delta.X,
                    StartPosition.Y.Scale,
                    StartPosition.Y.Offset +
                        Delta.Y
                )
        end
    end)

    local MiniDragging =
        false

    local MiniDragStart
    local MiniStartPosition

    MiniButton.InputBegan:Connect(function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or Input.UserInputType ==
            Enum.UserInputType.Touch then

            MiniDragging =
                true

            MiniDragStart =
                Input.Position

            MiniStartPosition =
                MiniButton.Position

            Input.Changed:Connect(function()

                if Input.UserInputState ==
                    Enum.UserInputState.End then

                    MiniDragging =
                        false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)

        if MiniDragging
            and (
                Input.UserInputType ==
                    Enum.UserInputType.MouseMovement
                or Input.UserInputType ==
                    Enum.UserInputType.Touch
            ) then

            local Delta =
                Input.Position -
                MiniDragStart

            MiniButton.Position =
                UDim2.new(
                    MiniStartPosition.X.Scale,
                    MiniStartPosition.X.Offset +
                        Delta.X,
                    MiniStartPosition.Y.Scale,
                    MiniStartPosition.Y.Offset +
                        Delta.Y
                )
        end
    end)

    function Object:GetTheme()

        return self.OTC._Themes[
            self.Theme
        ]

        or self.OTC._Themes[
            self.OTC.CurrentTheme
        ]

        or self.OTC._Themes.Default
    end

    function Object:SetTheme(Name)

        if not self.OTC._Themes[Name] then
            return false
        end

        if not IsThemeAllowed(
            self.OTC,
            Name
        ) then

            local Message =
                GetThemeAccessMessage(
                    self.OTC,
                    Name
                )

            NotifyThemeDenied(Message)

            return false
        end

        self.Theme =
            Name

        self.OTC.CurrentTheme =
            Name

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

        if self.Minimized
            or self.Closed then

            return
        end

        self.Minimized =
            true

        Main.Visible =
            false

        MiniButton.Visible =
            true

        MiniButton.Size =
            UDim2.new(
                0,
                0,
                0,
                0
            )

        Tween(
            MiniButton,
            TweenInfo.new(
                0.2,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out
            ),
            {
                Size =
                    UDim2.new(
                        0,
                        70,
                        0,
                        70
                    )
            }
        )
    end

    function Object:Restore()

        if not self.Minimized
            or self.Closed then

            return
        end

        self.Minimized =
            false

        Tween(
            MiniButton,
            TweenInfo.new(
                0.15,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.In
            ),
            {
                Size =
                    UDim2.new(
                        0,
                        0,
                        0,
                        0
                    )
            }
        )

        task.delay(
            0.15,
            function()

                if self.Closed then
                    return
                end

                MiniButton.Visible =
                    false

                Main.Visible =
                    true
            end
        )
    end

    function Object:AddTab(TabObject)

        table.insert(
            self.Tabs,
            TabObject
        )

        TabObject.Button.Parent =
            TabsContainer

        if not self.SelectedTab then
            self:SelectTab(TabObject)
        end
    end

    function Object:SelectTab(TabObject)

        if self.SelectedTab ==
            TabObject then

            return
        end

        if self.SelectedTab
            and self.SelectedTab.Page then

            self.SelectedTab.Page.Visible =
                false
        end

        self.SelectedTab =
            TabObject

        if TabObject.Page then
            TabObject.Page.Visible =
                true
        end

        for _, Tab in ipairs(
            self.Tabs
        ) do

            if Tab.SetSelected then

                Tab:SetSelected(
                    Tab == TabObject
                )
            end
        end
    end

    local function CreateUnloadConfirmation()

        if Object.UnloadConfirmation then
            return
        end

        local CurrentTheme =
            OTC._Themes[
                Object.Theme
            ]

            or OTC._Themes[
                OTC.CurrentTheme
            ]

            or OTC._Themes.Default

        local Overlay =
            Instance.new("Frame")

        Overlay.Name =
            "UnloadOverlay"

        Overlay.Size =
            UDim2.new(
                1,
                0,
                1,
                0
            )

        Overlay.Position =
            UDim2.new(
                0,
                0,
                0,
                0
            )

        Overlay.BackgroundColor3 =
            Color3.fromRGB(
                0,
                0,
                0
            )

        Overlay.BackgroundTransparency =
            0.45

        Overlay.BorderSizePixel =
            0

        Overlay.ZIndex =
            100

        Overlay.Parent =
            ScreenGui

        local Popup =
            Instance.new("Frame")

        Popup.Name =
            "UnloadConfirmation"

        Popup.Size =
            UDim2.new(
                0,
                360,
                0,
                190
            )

        Popup.Position =
            UDim2.new(
                0.5,
                -180,
                0.5,
                -95
            )

        Popup.BackgroundColor3 =
            CurrentTheme.PopupBackground
            or CurrentTheme.Background

        Popup.BackgroundTransparency =
            CurrentTheme.Transparency
            and CurrentTheme.Transparency.Popup
            or 0

        Popup.BorderSizePixel =
            0

        Popup.ZIndex =
            101

        Popup.Parent =
            Overlay

        local PopupCorner =
            Instance.new("UICorner")

        PopupCorner.CornerRadius =
            UDim.new(
                0,
                CurrentTheme.Corners
                and CurrentTheme.Corners.Popup
                or 10
            )

        PopupCorner.Parent =
            Popup

        local PopupStroke =
            Instance.new("UIStroke")

        PopupStroke.Color =
            CurrentTheme.PopupBorder
            or CurrentTheme.Border

        PopupStroke.Thickness =
            CurrentTheme.Stroke
            and CurrentTheme.Stroke.Thickness
            or 1

        PopupStroke.Transparency =
            CurrentTheme.Stroke
            and CurrentTheme.Stroke.Transparency
            or 0

        PopupStroke.Parent =
            Popup

        local PopupTitle =
            Instance.new("TextLabel")

        PopupTitle.Name =
            "Title"

        PopupTitle.BackgroundTransparency =
            1

        PopupTitle.Position =
            UDim2.new(
                0,
                20,
                0,
                18
            )

        PopupTitle.Size =
            UDim2.new(
                1,
                -40,
                0,
                30
            )

        PopupTitle.Font =
            Enum.Font.GothamBold

        PopupTitle.Text =
            "Unload OTC Hub?"

        PopupTitle.TextColor3 =
            CurrentTheme.Text

        PopupTitle.TextSize =
            20

        PopupTitle.TextXAlignment =
            Enum.TextXAlignment.Left

        PopupTitle.ZIndex =
            102

        PopupTitle.Parent =
            Popup

        local PopupDescription =
            Instance.new("TextLabel")

        PopupDescription.Name =
            "Description"

        PopupDescription.BackgroundTransparency =
            1

        PopupDescription.Position =
            UDim2.new(
                0,
                20,
                0,
                55
            )

        PopupDescription.Size =
            UDim2.new(
                1,
                -40,
                0,
                45
            )

        PopupDescription.Font =
            Enum.Font.Gotham

        PopupDescription.Text =
            "Are you sure you want to unload OTC Hub?"

        PopupDescription.TextColor3 =
            CurrentTheme.SubText

        PopupDescription.TextSize =
            14

        PopupDescription.TextWrapped =
            true

        PopupDescription.TextXAlignment =
            Enum.TextXAlignment.Left

        PopupDescription.ZIndex =
            102

        PopupDescription.Parent =
            Popup

        local CancelButton =
            Instance.new("TextButton")

        CancelButton.Name =
            "Cancel"

        CancelButton.Size =
            UDim2.new(
                0,
                145,
                0,
                42
            )

        CancelButton.Position =
            UDim2.new(
                0,
                20,
                1,
                -62
            )

        CancelButton.BackgroundColor3 =
            CurrentTheme.Button
            or CurrentTheme.Element

        CancelButton.BorderSizePixel =
            0

        CancelButton.AutoButtonColor =
            false

        CancelButton.Font =
            Enum.Font.GothamSemibold

        CancelButton.Text =
            "Cancel"

        CancelButton.TextColor3 =
            CurrentTheme.Text

        CancelButton.TextSize =
            14

        CancelButton.ZIndex =
            102

        CancelButton.Parent =
            Popup

        local CancelCorner =
            Instance.new("UICorner")

        CancelCorner.CornerRadius =
            UDim.new(
                0,
                CurrentTheme.Corners
                and CurrentTheme.Corners.Button
                or 7
            )

        CancelCorner.Parent =
            CancelButton

        local UnloadButton =
            Instance.new("TextButton")

        UnloadButton.Name =
            "Unload"

        UnloadButton.Size =
            UDim2.new(
                0,
                145,
                0,
                42
            )

        UnloadButton.Position =
            UDim2.new(
                1,
                -165,
                1,
                -62
            )

        UnloadButton.BackgroundColor3 =
            CurrentTheme.Accent

        UnloadButton.BorderSizePixel =
            0

        UnloadButton.AutoButtonColor =
            false

        UnloadButton.Font =
            Enum.Font.GothamSemibold

        UnloadButton.Text =
            "Unload"

        UnloadButton.TextColor3 =
            CurrentTheme.AccentText
            or CurrentTheme.Background

        UnloadButton.TextSize =
            14

        UnloadButton.ZIndex =
            102

        UnloadButton.Parent =
            Popup

        local UnloadCorner =
            Instance.new("UICorner")

        UnloadCorner.CornerRadius =
            UDim.new(
                0,
                CurrentTheme.Corners
                and CurrentTheme.Corners.Button
                or 7
            )

        UnloadCorner.Parent =
            UnloadButton

        CancelButton.MouseButton1Click:Connect(
            function()

                Overlay:Destroy()

                Object.UnloadConfirmation =
                    nil
            end
        )

        UnloadButton.MouseButton1Click:Connect(
            function()
                Object:Unload()
            end
        )

        Object.UnloadConfirmation = {
            Overlay = Overlay,
            Popup = Popup,
            PopupStroke = PopupStroke,
            Title = PopupTitle,
            Description = PopupDescription,
            CancelButton = CancelButton,
            UnloadButton = UnloadButton
        }

        Object:RefreshTheme()
    end

    function Object:RefreshTheme()

        local ThemeName =
            self.Theme
            or self.OTC.CurrentTheme

        if not IsThemeAllowed(
            self.OTC,
            ThemeName
        ) then

            ThemeName =
                "Default"
        end

        local NewTheme =
            self.OTC._Themes[
                ThemeName
            ]

            or self.OTC._Themes[
                self.OTC.CurrentTheme
            ]

            or self.OTC._Themes.Default

        self.Theme =
            ThemeName

        local Transparency =
            NewTheme.Transparency
            or {}

        local Stroke =
            NewTheme.Stroke
            or {}

        local Corners =
            NewTheme.Corners
            or {}

        local Gradients =
            NewTheme.Gradients
            or {}

        local Effects =
            NewTheme.Effects
            or {}

        Main.BackgroundColor3 =
            NewTheme.Background

        Main.BackgroundTransparency =
            Transparency.Main
            or 0

        MainStroke.Color =
            NewTheme.Border

        MainStroke.Thickness =
            Stroke.Thickness
            or 1

        MainStroke.Transparency =
            Stroke.Transparency
            or 0

        MainStroke.Enabled =
            Stroke.Enabled ~= false

        ApplyCorner(
            Main,
            Corners.Main
            or 10
        )

        TopBar.BackgroundColor3 =
            NewTheme.Secondary

        TopBar.BackgroundTransparency =
            Transparency.Secondary
            or 0

        Sidebar.BackgroundColor3 =
            NewTheme.Secondary

        Sidebar.BackgroundTransparency =
            Transparency.Secondary
            or 0

        Content.BackgroundColor3 =
            NewTheme.Background

        Content.BackgroundTransparency =
            Transparency.Main
            or 0

        Title.TextColor3 =
            NewTheme.Text

        Subtitle.TextColor3 =
            NewTheme.SubText

        VersionTag.BackgroundColor3 =
            NewTheme.Element

        VersionTag.BackgroundTransparency =
            Transparency.Element
            or 0

        VersionTag.Text =
            "v" ..
            tostring(
                self.OTC.Version
                or "1.0.0"
            )

        VersionTag.TextColor3 =
            NewTheme.Text

        VersionStroke.Color =
            NewTheme.Border

        VersionStroke.Thickness =
            Stroke.Thickness
            or 1

        VersionStroke.Transparency =
            Stroke.Transparency
            or 0.3

        VersionStroke.Enabled =
            Stroke.Enabled ~= false

        ApplyCorner(
            VersionTag,
            Corners.Button
            or 7
        )

        SearchButton.BackgroundColor3 =
            NewTheme.Button
            or NewTheme.Element

        SearchButton.BackgroundTransparency =
            Transparency.Element
            or 0

        SearchButton.Image =
            SEARCH_ASSET

        SearchButton.ImageTransparency =
            0

        ApplyCorner(
            SearchButton,
            Corners.Button
            or 7
        )

        MinimizeButton.BackgroundColor3 =
            NewTheme.Button
            or NewTheme.Element

        MinimizeButton.BackgroundTransparency =
            Transparency.Element
            or 0

        MinimizeButton.Image =
            MINIMIZE_ASSET

        MinimizeButton.ImageTransparency =
            0

        CloseButton.BackgroundColor3 =
            NewTheme.Button
            or NewTheme.Element

        CloseButton.BackgroundTransparency =
            Transparency.Element
            or 0

        CloseButton.Image =
            CLOSE_ASSET

        CloseButton.ImageTransparency =
            0

        ApplyCorner(
            MinimizeButton,
            Corners.Button
            or 7
        )

        ApplyCorner(
            CloseButton,
            Corners.Button
            or 7
        )

        TabsContainer.ScrollBarImageColor3 =
            NewTheme.Scrollbar
            or NewTheme.Border

        UserCard.BackgroundColor3 =
            NewTheme.Element

        UserCard.BackgroundTransparency =
            Transparency.Element
            or 0

        UserAvatar.BackgroundColor3 =
            NewTheme.Background

        UserDisplay.TextColor3 =
            NewTheme.Text

        UserName.TextColor3 =
            NewTheme.SubText

        ApplyCorner(
            UserCard,
            Corners.Element
            or 8
        )

        ApplyCorner(
            UserAvatar,
            999
        )

        MiniButton.Image =
            LOGO_ASSET

        for _, GradientObject in pairs(
            Object.ThemeGradients
        ) do

            if GradientObject then
                GradientObject:Destroy()
            end
        end

        Object.ThemeGradients =
            {}

        if Gradients.Main then

            Object.ThemeGradients.Main =
                ApplyGradient(
                    Main,
                    Gradients.Main
                )
        end

        if Gradients.TopBar then

            Object.ThemeGradients.TopBar =
                ApplyGradient(
                    TopBar,
                    Gradients.TopBar
                )
        end

        if Gradients.Sidebar then

            Object.ThemeGradients.Sidebar =
                ApplyGradient(
                    Sidebar,
                    Gradients.Sidebar
                )
        end

        if Gradients.Element then

            Object.ThemeGradients.UserCard =
                ApplyGradient(
                    UserCard,
                    Gradients.Element
                )

            Object.ThemeGradients.Search =
                ApplyGradient(
                    SearchButton,
                    Gradients.Element
                )

            Object.ThemeGradients.Minimize =
                ApplyGradient(
                    MinimizeButton,
                    Gradients.Element
                )

            Object.ThemeGradients.Close =
                ApplyGradient(
                    CloseButton,
                    Gradients.Element
                )
        end

        ApplyStroke(
            MainStroke,
            NewTheme
        )

        UpdateRomanArtwork(
            NewTheme
        )

        if Effects.AnimatedGradient then

            for _, GradientObject in pairs(
                Object.ThemeGradients
            ) do

                if GradientObject then

                    task.spawn(
                        function()

                            local StartRotation =
                                GradientObject.Rotation

                            Tween(
                                GradientObject,
                                TweenInfo.new(
                                    6,
                                    Enum.EasingStyle.Linear,
                                    Enum.EasingDirection.In,
                                    -1
                                ),
                                {
                                    Rotation =
                                        StartRotation +
                                        360
                                }
                            )
                        end
                    )
                end
            end
        end

        if self.UnloadConfirmation then

            local Popup =
                self.UnloadConfirmation

            Popup.Popup.BackgroundColor3 =
                NewTheme.PopupBackground
                or NewTheme.Background

            Popup.Popup.BackgroundTransparency =
                Transparency.Popup
                or 0

            Popup.PopupStroke.Color =
                NewTheme.PopupBorder
                or NewTheme.Border

            Popup.PopupStroke.Thickness =
                Stroke.Thickness
                or 1

            Popup.PopupStroke.Transparency =
                Stroke.Transparency
                or 0

            Popup.Title.TextColor3 =
                NewTheme.Text

            Popup.Description.TextColor3 =
                NewTheme.SubText

            Popup.CancelButton.BackgroundColor3 =
                NewTheme.Button
                or NewTheme.Element

            Popup.CancelButton.TextColor3 =
                NewTheme.Text

            Popup.UnloadButton.BackgroundColor3 =
                NewTheme.Accent

            Popup.UnloadButton.TextColor3 =
                NewTheme.AccentText
                or NewTheme.Background
        end

        for _, TabObject in ipairs(
            self.Tabs
        ) do

            if TabObject.RefreshTheme then

                pcall(function()

                    TabObject:RefreshTheme()

                end)
            end
        end
    end

    SearchButton.MouseButton1Click:Connect(
        function()

            if Object.OpenSearch then

                Object:OpenSearch()

            elseif OTC._OpenSearch then

                pcall(function()
                    OTC._OpenSearch(Object)
                end)

            else

                if Object.SearchOverlay then

                    Object.SearchOverlay.Visible =
                        not Object.SearchOverlay.Visible
                end
            end
        end
    )

    SearchButton.MouseEnter:Connect(
        function()

            Tween(
                SearchButton,
                TweenInfo.new(
                    0.12,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                ),
                {
                    Size =
                        UDim2.new(
                            0,
                            38,
                            0,
                            38
                        ),
                    Position =
                        UDim2.new(
                            1,
                            -152,
                            0.5,
                            -19
                        )
                }
            )
        end
    )

    SearchButton.MouseLeave:Connect(
        function()

            Tween(
                SearchButton,
                TweenInfo.new(
                    0.12,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                ),
                {
                    Size =
                        UDim2.new(
                            0,
                            34,
                            0,
                            34
                        ),
                    Position =
                        UDim2.new(
                            1,
                            -150,
                            0.5,
                            -17
                        )
                }
            )
        end
    )

    MinimizeButton.MouseButton1Click:Connect(
        function()
            Object:Toggle()
        end
    )

    CloseButton.MouseButton1Click:Connect(
        function()
            CreateUnloadConfirmation()
        end
    )

    MiniButton.MouseButton1Click:Connect(
        function()
            Object:Toggle()
        end
    )

    MinimizeButton.MouseEnter:Connect(
        function()

            Tween(
                MinimizeButton,
                TweenInfo.new(
                    0.12,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                ),
                {
                    Size =
                        UDim2.new(
                            0,
                            38,
                            0,
                            38
                        ),
                    Position =
                        UDim2.new(
                            1,
                            -112,
                            0.5,
                            -19
                        )
                }
            )
        end
    )

    MinimizeButton.MouseLeave:Connect(
        function()

            Tween(
                MinimizeButton,
                TweenInfo.new(
                    0.12,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                ),
                {
                    Size =
                        UDim2.new(
                            0,
                            34,
                            0,
                            34
                        ),
                    Position =
                        UDim2.new(
                            1,
                            -110,
                            0.5,
                            -17
                        )
                }
            )
        end
    )

    CloseButton.MouseEnter:Connect(
        function()

            Tween(
                CloseButton,
                TweenInfo.new(
                    0.12,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                ),
                {
                    Size =
                        UDim2.new(
                            0,
                            38,
                            0,
                            38
                        ),
                    Position =
                        UDim2.new(
                            1,
                            -74,
                            0.5,
                            -19
                        )
                }
            )
        end
    )

    CloseButton.MouseLeave:Connect(
        function()

            Tween(
                CloseButton,
                TweenInfo.new(
                    0.12,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                ),
                {
                    Size =
                        UDim2.new(
                            0,
                            34,
                            0,
                            34
                        ),
                    Position =
                        UDim2.new(
                            1,
                            -72,
                            0.5,
                            -17
                        )
                }
            )
        end
    )

    function Object:Unload()

        if self.Closed then
            return
        end

        self.Closed =
            true

        if self.UnloadConfirmation then

            if self.UnloadConfirmation.Overlay then

                self.UnloadConfirmation.Overlay:Destroy()

            end

            self.UnloadConfirmation =
                nil
        end

        if self.VersionPopup then

            if self.VersionPopup.Overlay then

                self.VersionPopup.Overlay:Destroy()

            end

            self.VersionPopup =
                nil
        end

        if self.ScreenGui then
            self.ScreenGui:Destroy()
        end

        for Index, WindowObject in pairs(
            OTC._Windows
        ) do

            if WindowObject == self then
                OTC._Windows[Index] =
                    nil
            end
        end
    end

    OTC._Windows[Object] =
        Object

    if OTC._InitializeInput then
        OTC._InitializeInput()
    end

    if OTC._Animation
        and OTC._Animation.Appear then

        pcall(function()

            OTC._Animation:Appear(
                Main,
                "Bottom",
                20,
                0.3
            )

        end)
    end

    Object:RefreshTheme()

    return Object
end

return Window