local Window = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local LOGO_URL = "rbxassetid://82435776198191"

local function create(ClassName, Properties)
    local Object = Instance.new(ClassName)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    return Object
end

local function getAvatar()
    local Success, Image = pcall(function()
        return Players:GetUserThumbnailAsync(
            LocalPlayer.UserId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size100x100
        )
    end)

    if Success then
        return Image
    end

    return ""
end

function Window.Create(Settings, OTC)
    Settings = Settings or {}

    local Theme = OTC:GetTheme()
    local Object = {}

    Object.OTC = OTC
    Object.Settings = Settings
    Object.ToggleKey = Settings.ToggleKey or Enum.KeyCode.RightControl

    Object.Tabs = {}
    Object.SelectedTab = nil

    --==================================================
    -- SCREEN GUI
    --==================================================

    local ScreenGui = create("ScreenGui", {
        Name = "OTC_Hub",
        Parent = game:GetService("CoreGui"),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    Object.ScreenGui = ScreenGui

    --==================================================
    -- MAIN
    --==================================================

    local Main = create("Frame", {
        Name = "Main",
        Parent = ScreenGui,
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -280, 0.5, -190),
        Size = UDim2.fromOffset(560, 380),
        ClipsDescendants = true,
        ZIndex = 1
    })

    create("UICorner", {
        Parent = Main,
        CornerRadius = UDim.new(0, 8)
    })

    Object.Main = Main

    --==================================================
    -- TOP BAR
    --==================================================

    local TopBar = create("Frame", {
        Name = "TopBar",
        Parent = Main,
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(1, 0, 0, 60),
        ZIndex = 5
    })

    Object.TopBar = TopBar

    local Logo = create("ImageLabel", {
        Name = "Logo",
        Parent = TopBar,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(15, 10),
        Size = UDim2.fromOffset(40, 40),
        Image = LOGO_URL,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 6
    })

    create("UICorner", {
        Parent = Logo,
        CornerRadius = UDim.new(0, 6)
    })

    local Title = create("TextLabel", {
        Name = "Title",
        Parent = TopBar,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(65, 8),
        Size = UDim2.new(1, -150, 0, 25),
        Font = Enum.Font.GothamBold,
        Text = Settings.Name or "OTC Hub",
        TextColor3 = Theme.Text,
        TextSize = 17,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6
    })

    local Subtitle = create("TextLabel", {
        Name = "Subtitle",
        Parent = TopBar,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(65, 32),
        Size = UDim2.new(1, -150, 0, 18),
        Font = Enum.Font.Gotham,
        Text = Settings.Subtitle or "by Aerlro",
        TextColor3 = Theme.SubText,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6
    })

    --==================================================
    -- MINIMIZE BUTTON
    --==================================================

    local MinimizeButton = create("ImageButton", {
        Name = "Minimize",
        Parent = TopBar,
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -45, 0, 15),
        Size = UDim2.fromOffset(30, 30),
        Image = LOGO_URL,
        ScaleType = Enum.ScaleType.Fit,
        AutoButtonColor = false,
        ZIndex = 10
    })

    create("UICorner", {
        Parent = MinimizeButton,
        CornerRadius = UDim.new(0, 6)
    })

    Object.MinimizeButton = MinimizeButton

    --==================================================
    -- SIDEBAR
    --==================================================

    local Sidebar = create("Frame", {
        Name = "Sidebar",
        Parent = Main,
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 60),
        Size = UDim2.new(0, 170, 1, -60),
        ClipsDescendants = true,
        ZIndex = 2
    })

    Object.Sidebar = Sidebar

    --==================================================
    -- TABS AREA
    --==================================================

    local USER_AREA_HEIGHT = 72

    local TabsArea = create("Frame", {
        Name = "TabsArea",
        Parent = Sidebar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(10, 15),
        Size = UDim2.new(
            1,
            -20,
            1,
            -(15 + USER_AREA_HEIGHT)
        ),
        ClipsDescendants = true,
        ZIndex = 2
    })

    Object.TabsArea = TabsArea

    local TabContainer = create("ScrollingFrame", {
        Name = "Tabs",
        Parent = TabsArea,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.fromScale(1, 1),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ClipsDescendants = true,
        ZIndex = 2
    })

    Object.TabContainer = TabContainer

    create("UIListLayout", {
        Parent = TabContainer,
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    --==================================================
    -- USER AREA
    --==================================================

    local UserArea = create("Frame", {
        Name = "UserArea",
        Parent = Sidebar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -USER_AREA_HEIGHT),
        Size = UDim2.new(1, 0, 0, USER_AREA_HEIGHT),
        ZIndex = 10
    })

    Object.UserArea = UserArea

    local UserSeparator = create("Frame", {
        Name = "UserSeparator",
        Parent = UserArea,
        BackgroundColor3 = Theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.new(1, -20, 0, 1),
        ZIndex = 11
    })

    Object.UserSeparator = UserSeparator

    --==================================================
    -- USER CARD
    --==================================================

    local UserCard = create("Frame", {
        Name = "UserCard",
        Parent = UserArea,
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(10, 10),
        Size = UDim2.new(1, -20, 0, 52),
        ZIndex = 11
    })

    create("UICorner", {
        Parent = UserCard,
        CornerRadius = UDim.new(0, 6)
    })

    Object.UserCard = UserCard

    local UserAvatar = create("ImageLabel", {
        Name = "Avatar",
        Parent = UserCard,
        BackgroundColor3 = Theme.Hover,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(7, 7),
        Size = UDim2.fromOffset(38, 38),
        Image = getAvatar(),
        ZIndex = 12
    })

    create("UICorner", {
        Parent = UserAvatar,
        CornerRadius = UDim.new(1, 0)
    })

    Object.UserAvatar = UserAvatar

    local UserDisplayName = create("TextLabel", {
        Name = "DisplayName",
        Parent = UserCard,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(52, 8),
        Size = UDim2.new(1, -59, 0, 18),
        Font = Enum.Font.GothamSemibold,
        Text = LocalPlayer.DisplayName,
        TextColor3 = Theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 12
    })

    Object.UserDisplayName = UserDisplayName

    local UserUsername = create("TextLabel", {
        Name = "Username",
        Parent = UserCard,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(52, 27),
        Size = UDim2.new(1, -59, 0, 16),
        Font = Enum.Font.Gotham,
        Text = "@" .. LocalPlayer.Name,
        TextColor3 = Theme.SubText,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 12
    })

    Object.UserUsername = UserUsername

    --==================================================
    -- CONTENT
    --==================================================

    local Content = create("Frame", {
        Name = "Content",
        Parent = Main,
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(170, 60),
        Size = UDim2.new(1, -170, 1, -60),
        ClipsDescendants = true,
        ZIndex = 1
    })

    Object.Content = Content

    --==================================================
    -- TAB MANAGEMENT
    --==================================================

    function Object:AddTab(TabObject)
        if not TabObject then
            return
        end

        table.insert(self.Tabs, TabObject)

        if not self.SelectedTab then
            self:SelectTab(TabObject)
        else
            if TabObject.Page then
                TabObject.Page.Visible = false
            end
        end
    end

    function Object:SelectTab(TabObject)
        if not TabObject then
            return
        end

        if self.SelectedTab and self.SelectedTab ~= TabObject then
            local OldTab = self.SelectedTab

            if OldTab.Page then
                OldTab.Page.Visible = false
            end

            if OldTab.Button then
                OldTab.Button.BackgroundColor3 = OTC:GetTheme().Element
            end
        end

        self.SelectedTab = TabObject

        if TabObject.Page then
            TabObject.Page.Visible = true
        end

        if TabObject.Button then
            TabObject.Button.BackgroundColor3 = OTC:GetTheme().Hover
        end
    end

    function Object:CreateTab(TabSettings)
        TabSettings = TabSettings or {}

        local TabModule = self.OTC._TabModule

        if not TabModule then
            error("[OTC Hub] Tab module is not loaded")
        end

        return TabModule.Create(
            self,
            self.OTC,
            TabSettings
        )
    end

    --==================================================
    -- DRAGGING MAIN WINDOW
    --==================================================

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
        if not Dragging then
            return
        end

        if Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch then

            local Delta = Input.Position - DragStart

            Main.Position = UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        end
    end)

    --==================================================
    -- MINIMIZED BUTTON
    --==================================================

    local MiniButton = create("ImageButton", {
        Name = "OTC_Minimized",
        Parent = ScreenGui,
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        Position = Main.Position,
        Size = UDim2.fromOffset(45, 45),
        Image = LOGO_URL,
        ScaleType = Enum.ScaleType.Fit,
        Visible = false,
        AutoButtonColor = false,
        ZIndex = 100
    })

    create("UICorner", {
        Parent = MiniButton,
        CornerRadius = UDim.new(0, 8)
    })

    Object.MinimizedButton = MiniButton

    MinimizeButton.MouseButton1Click:Connect(function()
        Main.Visible = false
        MiniButton.Visible = true

        MiniButton.Position = Main.Position
    end)

    MiniButton.MouseButton1Click:Connect(function()
        Main.Visible = true
        MiniButton.Visible = false
    end)

    --==================================================
    -- MINIMIZED BUTTON DRAG
    --==================================================

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
        if not MiniDragging then
            return
        end

        if Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch then

            local Delta = Input.Position - MiniDragStart

            MiniButton.Position = UDim2.new(
                MiniStartPosition.X.Scale,
                MiniStartPosition.X.Offset + Delta.X,
                MiniStartPosition.Y.Scale,
                MiniStartPosition.Y.Offset + Delta.Y
            )
        end
    end)

    --==================================================
    -- THEME
    --==================================================

    function Object:RefreshTheme()
        local NewTheme = OTC:GetTheme()

        Main.BackgroundColor3 = NewTheme.Background
        TopBar.BackgroundColor3 = NewTheme.Secondary
        Sidebar.BackgroundColor3 = NewTheme.Secondary
        Content.BackgroundColor3 = NewTheme.Background

        Title.TextColor3 = NewTheme.Text
        Subtitle.TextColor3 = NewTheme.SubText

        MinimizeButton.BackgroundColor3 = NewTheme.Element
        MiniButton.BackgroundColor3 = NewTheme.Element

        UserCard.BackgroundColor3 = NewTheme.Element
        UserAvatar.BackgroundColor3 = NewTheme.Hover

        UserDisplayName.TextColor3 = NewTheme.Text
        UserUsername.TextColor3 = NewTheme.SubText

        UserSeparator.BackgroundColor3 = NewTheme.Border
    end

    return Object
end

return Window