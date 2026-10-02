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

local function getAvatar(UserId)
    local Success, Content = pcall(function()
        return Players:GetUserThumbnailAsync(
            UserId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size100x100
        )
    end)

    if Success then
        return Content
    end

    return ""
end

function Window.Create(Settings, OTC)
    Settings = Settings or {}

    local Theme = OTC:GetTheme()
    local Animation = OTC._AnimationModule

    local Object = {}

    Object.OTC = OTC
    Object.Settings = Settings
    Object.Tabs = {}
    Object.SelectedTab = nil
    Object.Minimized = false
    Object.Closed = false

    Object.ToggleKey = Settings.ToggleKey or Enum.KeyCode.RightControl

    local ScreenGui = create("ScreenGui", {
        Name = "OTC_Hub",
        Parent = game:GetService("CoreGui"),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    Object.ScreenGui = ScreenGui

    local Main = create("Frame", {
        Name = "Main",
        Parent = ScreenGui,
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -280, 0.5, -190),
        Size = UDim2.fromOffset(560, 380),
        ClipsDescendants = true,
        Active = true,
        ZIndex = 1
    })

    Object.Main = Main

    local MainCorner = create("UICorner", {
        Parent = Main,
        CornerRadius = UDim.new(0, 10)
    })

    local MainStroke = create("UIStroke", {
        Parent = Main,
        Color = Theme.Border,
        Thickness = 1,
        Transparency = 0
    })

    local TopBar = create("Frame", {
        Name = "TopBar",
        Parent = Main,
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 60),
        Active = true,
        ZIndex = 5
    })

    local TopBarCorner = create("UICorner", {
        Parent = TopBar,
        CornerRadius = UDim.new(0, 10)
    })

    local TopBarFix = create("Frame", {
        Name = "BottomFix",
        Parent = TopBar,
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -10),
        Size = UDim2.new(1, 0, 0, 10),
        ZIndex = 5
    })

    local DragArea = create("Frame", {
        Name = "DragArea",
        Parent = TopBar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(1, -105, 1, 0),
        Active = true,
        ZIndex = 6
    })

    local Logo = create("ImageLabel", {
        Name = "Logo",
        Parent = TopBar,
        BackgroundTransparency = 1,
        Image = LOGO_URL,
        ImageColor3 = Theme.Text,
        Position = UDim2.fromOffset(15, 15),
        Size = UDim2.fromOffset(30, 30),
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 7
    })

    local Title = create("TextLabel", {
        Name = "Title",
        Parent = TopBar,
        BackgroundTransparency = 1,
        Text = Settings.Name or Settings.Title or "OTC Hub",
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Position = UDim2.fromOffset(55, 10),
        Size = UDim2.new(1, -65, 0, 22),
        ZIndex = 7
    })

    local Subtitle = create("TextLabel", {
        Name = "Subtitle",
        Parent = TopBar,
        BackgroundTransparency = 1,
        Text = Settings.Subtitle or Settings.SubtitleText or "by Aerlro",
        TextColor3 = Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        Position = UDim2.fromOffset(55, 32),
        Size = UDim2.new(1, -65, 0, 18),
        ZIndex = 7
    })

    local MinimizeButton = create("ImageButton", {
        Name = "Minimize",
        Parent = TopBar,
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        Image = LOGO_URL,
        ImageColor3 = Theme.Text,
        Position = UDim2.new(1, -75, 0, 15),
        Size = UDim2.fromOffset(30, 30),
        AutoButtonColor = false,
        ZIndex = 8
    })

    create("UICorner", {
        Parent = MinimizeButton,
        CornerRadius = UDim.new(0, 8)
    })

    local CloseButton = create("TextButton", {
        Name = "Close",
        Parent = TopBar,
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        Text = "×",
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        Position = UDim2.new(1, -40, 0, 15),
        Size = UDim2.fromOffset(30, 30),
        AutoButtonColor = false,
        ZIndex = 8
    })

    create("UICorner", {
        Parent = CloseButton,
        CornerRadius = UDim.new(0, 8)
    })

    local Body = create("Frame", {
        Name = "Body",
        Parent = Main,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 60),
        Size = UDim2.new(1, 0, 1, -60),
        ZIndex = 2
    })

    local Sidebar = create("Frame", {
        Name = "Sidebar",
        Parent = Body,
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 150, 1, 0),
        ZIndex = 2
    })

    local SidebarLine = create("Frame", {
        Name = "Separator",
        Parent = Sidebar,
        BackgroundColor3 = Theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -1, 0, 0),
        Size = UDim2.new(0, 1, 1, 0),
        ZIndex = 4
    })

    local USER_AREA_HEIGHT = 72

    local TabsArea = create("Frame", {
        Name = "TabsArea",
        Parent = Sidebar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(10, 15),
        Size = UDim2.new(1, -20, 1, -(15 + USER_AREA_HEIGHT)),
        ClipsDescendants = true,
        ZIndex = 2
    })

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

    create("UIListLayout", {
        Parent = TabContainer,
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    Object.TabContainer = TabContainer

    local UserArea = create("Frame", {
        Name = "UserArea",
        Parent = Sidebar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -USER_AREA_HEIGHT),
        Size = UDim2.new(1, 0, 0, USER_AREA_HEIGHT),
        ZIndex = 10
    })

    local UserSeparator = create("Frame", {
        Name = "UserSeparator",
        Parent = UserArea,
        BackgroundColor3 = Theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.new(1, -20, 0, 1),
        ZIndex = 10
    })

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
        CornerRadius = UDim.new(0, 8)
    })

    local Avatar = create("ImageLabel", {
        Name = "Avatar",
        Parent = UserCard,
        BackgroundTransparency = 1,
        Image = getAvatar(LocalPlayer.UserId),
        Position = UDim2.fromOffset(8, 8),
        Size = UDim2.fromOffset(36, 36),
        ZIndex = 12
    })

    create("UICorner", {
        Parent = Avatar,
        CornerRadius = UDim.new(1, 0)
    })

    local DisplayName = create("TextLabel", {
        Name = "DisplayName",
        Parent = UserCard,
        BackgroundTransparency = 1,
        Text = LocalPlayer.DisplayName,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Position = UDim2.fromOffset(52, 8),
        Size = UDim2.new(1, -58, 0, 18),
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 12
    })

    local Username = create("TextLabel", {
        Name = "Username",
        Parent = UserCard,
        BackgroundTransparency = 1,
        Text = "@" .. LocalPlayer.Name,
        TextColor3 = Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        Position = UDim2.fromOffset(52, 27),
        Size = UDim2.new(1, -58, 0, 16),
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 12
    })

    local Content = create("Frame", {
        Name = "Content",
        Parent = Body,
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(150, 0),
        Size = UDim2.new(1, -150, 1, 0),
        ClipsDescendants = true,
        ZIndex = 2
    })

    Object.Content = Content

    local MiniButton = create("ImageButton", {
        Name = "OTC_Minimized",
        Parent = ScreenGui,
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        Image = LOGO_URL,
        ImageColor3 = Theme.Text,
        Position = UDim2.new(0, 20, 0.5, -25),
        Size = UDim2.fromOffset(50, 50),
        Visible = false,
        AutoButtonColor = false,
        Active = true,
        ZIndex = 100
    })

    create("UICorner", {
        Parent = MiniButton,
        CornerRadius = UDim.new(0, 12)
    })

    create("UIStroke", {
        Parent = MiniButton,
        Color = Theme.Border,
        Thickness = 1
    })

    Object.MiniButton = MiniButton
    Object.MinimizeButton = MinimizeButton
    Object.CloseButton = CloseButton

    local MainOpenPosition = Main.Position
    local MainOpenSize = Main.Size

    local function restoreMainVisuals()
        Main.Visible = true
        Main.Position = MainOpenPosition
        Main.Size = MainOpenSize

        Main.BackgroundTransparency = 0

        TopBar.BackgroundTransparency = 0
        Sidebar.BackgroundTransparency = 0
        Content.BackgroundTransparency = 0

        Logo.ImageTransparency = 0
        Title.TextTransparency = 0
        Subtitle.TextTransparency = 0

        MinimizeButton.Visible = true
        CloseButton.Visible = true
    end

    local function minimize()
        if Object.Minimized or Object.Closed then
            return
        end

        Object.Minimized = true

        Animation:Scale(Main, 0.85, 0.18)

        task.delay(0.05, function()
            Animation:FadeOut(Logo, 0.12)
            Animation:FadeOut(Title, 0.12)
            Animation:FadeOut(Subtitle, 0.12)
            Animation:FadeOut(MinimizeButton, 0.12)
            Animation:FadeOut(CloseButton, 0.12)

            task.wait(0.12)

            Animation:Scale(Main, 0.01, 0.22)

            task.delay(0.18, function()
                Main.Visible = false
                Main.Size = MainOpenSize
                Main.Position = MainOpenPosition

                restoreMainVisuals()

                Main.Visible = false

                MiniButton.Visible = true
                MiniButton.ImageTransparency = 1

                Animation:Scale(MiniButton, 0.75, 0)
                Animation:FadeIn(MiniButton, 0.22)
                Animation:Scale(MiniButton, 1, 0.22)
            end)
        end)
    end

    local function restore()
        if not Object.Minimized or Object.Closed then
            return
        end

        Object.Minimized = false

        MiniButton.Visible = false

        Main.Size = MainOpenSize
        Main.Position = MainOpenPosition
        Main.Visible = true

        Animation:Scale(Main, 0.85, 0)
        Animation:FadeIn(Main, 0.2)

        task.delay(0.04, function()
            Animation:Scale(Main, 1, 0.25)

            Animation:Appear(Logo, "Left", 12, 0.2)
            Animation:Appear(Title, "Left", 12, 0.2)
            Animation:Appear(Subtitle, "Left", 12, 0.2)
            Animation:Appear(MinimizeButton, "Right", 12, 0.2)
            Animation:Appear(CloseButton, "Right", 12, 0.2)
        end)
    end

    MinimizeButton.MouseButton1Click:Connect(function()
        minimize()
    end)

    MiniButton.MouseButton1Click:Connect(function()
        restore()
    end)

    CloseButton.MouseButton1Click:Connect(function()
        if Object.Closed then
            return
        end

        Object.Closed = true

        Animation:Scale(Main, 0.85, 0.18)
        Animation:FadeOut(Main, 0.18)

        task.delay(0.2, function()
            if ScreenGui then
                ScreenGui:Destroy()
            end
        end)
    end)

    MinimizeButton.MouseEnter:Connect(function()
        Animation:Scale(MinimizeButton, 1.08, 0.12)
    end)

    MinimizeButton.MouseLeave:Connect(function()
        Animation:Scale(MinimizeButton, 1, 0.12)
    end)

    CloseButton.MouseEnter:Connect(function()
        Animation:Scale(CloseButton, 1.08, 0.12)
    end)

    CloseButton.MouseLeave:Connect(function()
        Animation:Scale(CloseButton, 1, 0.12)
    end)

    local Dragging = false
    local DragStart
    local StartPosition
    local DragInput

    local function updateDrag(Input)
        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end

    DragArea.InputBegan:Connect(function(Input)
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

    DragArea.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement
            or Input.UserInputType == Enum.UserInputType.Touch then

            DragInput = Input
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Input == DragInput and Dragging then
            updateDrag(Input)
        end
    end)

    local MiniDragging = false
    local MiniDragStart
    local MiniStartPosition
    local MiniDragInput

    local function updateMiniDrag(Input)
        local Delta = Input.Position - MiniDragStart

        MiniButton.Position = UDim2.new(
            MiniStartPosition.X.Scale,
            MiniStartPosition.X.Offset + Delta.X,
            MiniStartPosition.Y.Scale,
            MiniStartPosition.Y.Offset + Delta.Y
        )
    end

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

    MiniButton.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement
            or Input.UserInputType == Enum.UserInputType.Touch then

            MiniDragInput = Input
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Input == MiniDragInput and MiniDragging then
            updateMiniDrag(Input)
        end
    end)

    function Object:AddTab(TabObject)
        table.insert(self.Tabs, TabObject)

        if #self.Tabs == 1 then
            self:SelectTab(TabObject)
        else
            TabObject:SetSelected(false)
        end
    end

    function Object:SelectTab(TabObject)
        for _, Tab in ipairs(self.Tabs) do
            Tab:SetSelected(Tab == TabObject)
        end

        self.SelectedTab = TabObject
    end

    function Object:CreateTab(TabSettings)
        if not self.OTC._TabModule then
            error("OTC._TabModule is missing")
        end

        return self.OTC._TabModule.Create(
            self,
            self.OTC,
            TabSettings
        )
    end

    function Object:Minimize()
        minimize()
    end

    function Object:Restore()
        restore()
    end

    function Object:Destroy()
        if self.Closed then
            return
        end

        self.Closed = true

        if self.ScreenGui then
            self.ScreenGui:Destroy()
        end
    end

    function Object:RefreshTheme()
        local NewTheme = self.OTC:GetTheme()

        Main.BackgroundColor3 = NewTheme.Background
        MainStroke.Color = NewTheme.Border

        TopBar.BackgroundColor3 = NewTheme.Secondary
        TopBarFix.BackgroundColor3 = NewTheme.Secondary

        Sidebar.BackgroundColor3 = NewTheme.Secondary
        SidebarLine.BackgroundColor3 = NewTheme.Border

        Content.BackgroundColor3 = NewTheme.Background

        UserCard.BackgroundColor3 = NewTheme.Element
        UserSeparator.BackgroundColor3 = NewTheme.Border

        Logo.ImageColor3 = NewTheme.Text

        Title.TextColor3 = NewTheme.Text
        Subtitle.TextColor3 = NewTheme.SubText

        MinimizeButton.BackgroundColor3 = NewTheme.Element
        MinimizeButton.ImageColor3 = NewTheme.Text

        CloseButton.BackgroundColor3 = NewTheme.Element
        CloseButton.TextColor3 = NewTheme.Text

        MiniButton.BackgroundColor3 = NewTheme.Element
        MiniButton.ImageColor3 = NewTheme.Text
    end

    Animation:Appear(Main, "Bottom", 25, 0.3)

    Object.MainOpenPosition = MainOpenPosition
    Object.MainOpenSize = MainOpenSize

    return Object
end

return Window