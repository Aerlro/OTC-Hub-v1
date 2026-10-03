local Window = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local LOGO_ASSET = "rbxassetid://104463753775983"

local function Tween(Object, Info, Properties)
    local TweenObject = TweenService:Create(
        Object,
        Info,
        Properties
    )

    TweenObject:Play()

    return TweenObject
end

local function GetTheme(Object)
    return Object.OTC._Themes[Object.OTC.CurrentTheme]
        or Object.OTC._Themes[Object.Theme]
        or Object.OTC._Themes.Default
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

    UIGradient.Parent =
        Object

    return UIGradient
end

local function ApplyCorner(Object, Radius)
    if not Object or Radius == nil then
        return
    end

    local Corner =
        Object:FindFirstChildOfClass(
            "UICorner"
        )

    if Corner then
        Corner.CornerRadius =
            UDim.new(
                0,
                Radius
            )
    end
end

local function ApplyStroke(StrokeObject, ThemeData)
    if not StrokeObject
        or not ThemeData then
        return
    end

    local Stroke =
        ThemeData.Stroke

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
    Object.ThemeGradients = {}

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
        ScreenGui.Parent =
            CoreGui
    end)

    if not ScreenGui.Parent then
        ScreenGui.Parent =
            LocalPlayer:WaitForChild(
                "PlayerGui"
            )
    end

    Object.ScreenGui =
        ScreenGui

    --------------------------------------------------
    -- MAIN
    --------------------------------------------------

    local Main =
        Instance.new("Frame")

    Main.Name =
        "Main"

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

    Main.BorderSizePixel =
        0

    Main.ClipsDescendants =
        true

    Main.Parent =
        ScreenGui

    local MainCorner =
        Instance.new("UICorner")

    MainCorner.CornerRadius =
        UDim.new(
            0,
            Theme.Corners
            and Theme.Corners.Main
            or 10
        )

    MainCorner.Parent =
        Main

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

    --------------------------------------------------
    -- TOP BAR
    --------------------------------------------------

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

    Subtitle.Parent =
        TopBar

    --------------------------------------------------
    -- MINIMIZE
    --------------------------------------------------

    local MinimizeButton =
        Instance.new("TextButton")

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
            -78,
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

    MinimizeButton.Text =
        "—"

    MinimizeButton.TextColor3 =
        Theme.Text

    MinimizeButton.TextSize =
        18

    MinimizeButton.Font =
        Enum.Font.GothamBold

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

    --------------------------------------------------
    -- CLOSE
    --------------------------------------------------

    local CloseButton =
        Instance.new("TextButton")

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
            -40,
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

    CloseButton.Text =
        "×"

    CloseButton.TextColor3 =
        Theme.Text

    CloseButton.TextSize =
        22

    CloseButton.Font =
        Enum.Font.GothamBold

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

    --------------------------------------------------
    -- SIDEBAR
    --------------------------------------------------

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

    Sidebar.Parent =
        Main

    --------------------------------------------------
    -- CONTENT
    --------------------------------------------------

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

    Content.Parent =
        Main

    --------------------------------------------------
    -- TABS
    --------------------------------------------------

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

    TabsContainer.Parent =
        Sidebar

    local TabsLayout =
        Instance.new("UIListLayout")

    TabsLayout.Padding =
        UDim.new(
            0,
            5
        )

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
                TabsLayout.AbsoluteContentSize.Y
                + 8
            )

    end)

    --------------------------------------------------
    -- USER CARD
    --------------------------------------------------

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
            -60
        )

    UserCard.BackgroundColor3 =
        Theme.Element

    UserCard.BackgroundTransparency =
        Theme.Transparency
        and Theme.Transparency.Element
        or 0

    UserCard.BorderSizePixel =
        0

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

    UserAvatar.Parent =
        UserCard

    local AvatarCorner =
        Instance.new("UICorner")

    AvatarCorner.CornerRadius =
        UDim.new(
            1,
            0
        )

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

    --------------------------------------------------
    -- MINI BUTTON
    --------------------------------------------------

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

    --------------------------------------------------
    -- REFERENCES
    --------------------------------------------------

    Object.TopBar =
        TopBar

    Object.Logo =
        Logo

    Object.Title =
        Title

    Object.Subtitle =
        Subtitle

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

    --------------------------------------------------
    -- DRAG MAIN
    --------------------------------------------------

    local Dragging = false
    local DragStart
    local StartPosition

    TopBar.InputBegan:Connect(function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or Input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging = true
            DragStart = Input.Position
            StartPosition = Main.Position

            Input.Changed:Connect(function()

                if Input.UserInputState ==
                    Enum.UserInputState.End then

                    Dragging = false

                end

            end)

        end

    end)

    UserInputService.InputChanged:Connect(
        function(Input)

            if Dragging
                and (
                    Input.UserInputType ==
                        Enum.UserInputType.MouseMovement
                    or Input.UserInputType ==
                        Enum.UserInputType.Touch
                ) then

                local Delta =
                    Input.Position
                    - DragStart

                Main.Position =
                    UDim2.new(
                        StartPosition.X.Scale,
                        StartPosition.X.Offset
                            + Delta.X,
                        StartPosition.Y.Scale,
                        StartPosition.Y.Offset
                            + Delta.Y
                    )

            end

        end
    )

    --------------------------------------------------
    -- DRAG MINI
    --------------------------------------------------

    local MiniDragging = false
    local MiniDragStart
    local MiniStartPosition

    MiniButton.InputBegan:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseButton1
                or Input.UserInputType ==
                Enum.UserInputType.Touch then

                MiniDragging = true
                MiniDragStart =
                    Input.Position

                MiniStartPosition =
                    MiniButton.Position

                Input.Changed:Connect(
                    function()

                        if Input.UserInputState ==
                            Enum.UserInputState.End then

                            MiniDragging = false

                        end

                    end
                )

            end

        end
    )

    UserInputService.InputChanged:Connect(
        function(Input)

            if MiniDragging
                and (
                    Input.UserInputType ==
                        Enum.UserInputType.MouseMovement
                    or Input.UserInputType ==
                        Enum.UserInputType.Touch
                ) then

                local Delta =
                    Input.Position
                    - MiniDragStart

                MiniButton.Position =
                    UDim2.new(
                        MiniStartPosition.X.Scale,
                        MiniStartPosition.X.Offset
                            + Delta.X,
                        MiniStartPosition.Y.Scale,
                        MiniStartPosition.Y.Offset
                            + Delta.Y
                    )

            end

        end
    )

    --------------------------------------------------
    -- THEME
    --------------------------------------------------

    function Object:GetTheme()

        return self.OTC._Themes[
            self.OTC.CurrentTheme
        ]

        or self.OTC._Themes[
            self.Theme
        ]

        or self.OTC._Themes.Default

    end

    function Object:SetTheme(Name)

        if not self.OTC._Themes[Name] then
            return false
        end

        self.Theme =
            Name

        self:RefreshTheme()

        return true

    end

    --------------------------------------------------
    -- TOGGLE
    --------------------------------------------------

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

    --------------------------------------------------
    -- TABS
    --------------------------------------------------

    function Object:AddTab(TabObject)

        table.insert(
            self.Tabs,
            TabObject
        )

        TabObject.Button.Parent =
            TabsContainer

        if not self.SelectedTab then
            self:SelectTab(
                TabObject
            )
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

    --------------------------------------------------
    -- REFRESH THEME
    --------------------------------------------------

    function Object:RefreshTheme()

        local ThemeName =
            self.OTC.CurrentTheme

        local NewTheme =
            self.OTC._Themes[
                ThemeName
            ]

            or self.OTC._Themes[
                self.Theme
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

        --------------------------------------------------
        -- MAIN
        --------------------------------------------------

        Main.BackgroundColor3 =
            NewTheme.Background

        Main.BackgroundTransparency =
            Transparency.Main or 0

        MainStroke.Color =
            NewTheme.Border

        MainStroke.Thickness =
            Stroke.Thickness or 1

        MainStroke.Transparency =
            Stroke.Transparency or 0

        MainStroke.Enabled =
            Stroke.Enabled ~= false

        ApplyCorner(
            Main,
            Corners.Main or 10
        )

        --------------------------------------------------
        -- TOP BAR
        --------------------------------------------------

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
            NewTheme.Secondary

        TopBar.BackgroundTransparency =
            Transparency.Secondary or 0

        --------------------------------------------------
        -- SIDEBAR
        --------------------------------------------------

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
            NewTheme.Secondary

        Sidebar.BackgroundTransparency =
            Transparency.Secondary or 0

        --------------------------------------------------
        -- CONTENT
        --------------------------------------------------

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
            NewTheme.Background

        Content.BackgroundTransparency =
            Transparency.Main or 0

        --------------------------------------------------
        -- LOGO / TEXT
        --------------------------------------------------

        Logo.Image =
            LOGO_ASSET

        Logo.ImageTransparency =
            0

        Title.TextColor3 =
            NewTheme.Text

        Subtitle.TextColor3 =
            NewTheme.SubText

        --------------------------------------------------
        -- BUTTONS
        --------------------------------------------------

        MinimizeButton.BackgroundColor3 =
            NewTheme.Button
            or NewTheme.Element

        MinimizeButton.BackgroundTransparency =
            Transparency.Element or 0

        MinimizeButton.TextColor3 =
            NewTheme.Text

        CloseButton.BackgroundColor3 =
            NewTheme.Button
            or NewTheme.Element

        CloseButton.BackgroundTransparency =
            Transparency.Element or 0

        CloseButton.TextColor3 =
            NewTheme.Text

        ApplyCorner(
            MinimizeButton,
            Corners.Button or 7
        )

        ApplyCorner(
            CloseButton,
            Corners.Button or 7
        )

        --------------------------------------------------
        -- TABS
        --------------------------------------------------

        TabsContainer.ScrollBarImageColor3 =
            NewTheme.Scrollbar
            or NewTheme.Border

        --------------------------------------------------
        -- USER CARD
        --------------------------------------------------

        UserCard.Position =
            UDim2.new(
                0,
                8,
                1,
                -60
            )

        UserCard.Size =
            UDim2.new(
                1,
                -16,
                0,
                60
            )

        UserCard.BackgroundColor3 =
            NewTheme.Element

        UserCard.BackgroundTransparency =
            Transparency.Element or 0

        UserAvatar.BackgroundColor3 =
            NewTheme.Background

        UserAvatar.BackgroundTransparency =
            0

        UserDisplay.TextColor3 =
            NewTheme.Text

        UserName.TextColor3 =
            NewTheme.SubText

        ApplyCorner(
            UserCard,
            Corners.Element or 8
        )

        ApplyCorner(
            UserAvatar,
            999
        )

        --------------------------------------------------
        -- MINI BUTTON
        --------------------------------------------------

        MiniButton.BackgroundTransparency =
            1

        MiniButton.Image =
            LOGO_ASSET

        MiniButton.ImageTransparency =
            0

        --------------------------------------------------
        -- GRADIENTS
        --------------------------------------------------

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

        --------------------------------------------------
        -- ANIMATED GRADIENT
        --------------------------------------------------

        if Effects.AnimatedGradient then

            for _, GradientObject in pairs(
                Object.ThemeGradients
            ) do

                if GradientObject then

                    task.spawn(function()

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
                                    StartRotation + 360
                            }
                        )

                    end)

                end

            end

        end

        --------------------------------------------------
        -- REFRESH TABS
        --------------------------------------------------

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

    --------------------------------------------------
    -- CONNECTIONS
    --------------------------------------------------

    CloseButton.MouseButton1Click:Connect(
        function()

            if Object.Unload then
                Object:Unload()
            end

        end
    )

    MinimizeButton.MouseButton1Click:Connect(
        function()
            Object:Toggle()
        end
    )

    MiniButton.MouseButton1Click:Connect(
        function()
            Object:Toggle()
        end
    )

    --------------------------------------------------
    -- BUTTON HOVER
    --------------------------------------------------

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
                            -80,
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
                            -78,
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
                            -42,
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
                            -40,
                            0.5,
                            -17
                        )
                }
            )

        end
    )

    --------------------------------------------------
    -- UNLOAD
    --------------------------------------------------

    function Object:Unload()

        if self.Closed then
            return
        end

        self.Closed =
            true

        if self.ScreenGui then
            self.ScreenGui:Destroy()
        end

        for Index, WindowObject in pairs(
            OTC._Windows
        ) do

            if WindowObject == self then
                OTC._Windows[Index] = nil
            end

        end

    end

    --------------------------------------------------
    -- REGISTER WINDOW
    --------------------------------------------------

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

    return Object
end

return Window