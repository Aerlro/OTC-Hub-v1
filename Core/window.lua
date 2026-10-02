local Window = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local LOGO_URL = "rbxassetid://82435776198191"

local WINDOW_WIDTH = 560
local WINDOW_HEIGHT = 380
local MINI_SIZE = 58

local function create(Class, Properties)
    local Object = Instance.new(Class)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    return Object
end

local function tween(Object, Time, Properties)
    if not Object then
        return
    end

    local Animation = TweenService:Create(
        Object,
        TweenInfo.new(
            Time or 0.25,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        Properties
    )

    Animation:Play()

    return Animation
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
        Position = UDim2.new(
            0.5,
            -WINDOW_WIDTH / 2,
            0.5,
            -WINDOW_HEIGHT / 2
        ),
        Size = UDim2.fromOffset(
            WINDOW_WIDTH,
            WINDOW_HEIGHT
        ),
        ClipsDescendants = true,
        ZIndex = 1
    })

    create("UICorner", {
        Parent = Main,
        CornerRadius = UDim.new(0, 8)
    })

    Object.Main = Main

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

    Object.Logo = Logo

    local Title = create("TextLabel", {
        Name = "Title",
        Parent = TopBar,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(65, 8),
        Size = UDim2.new(1, -190, 0, 25),
        Font = Enum.Font.GothamBold,
        Text = Settings.Name or "OTC Hub",
        TextColor3 = Theme.Text,
        TextSize = 17,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6
    })

    Object.Title = Title

    local Subtitle = create("TextLabel", {
        Name = "Subtitle",
        Parent = TopBar,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(65, 32),
        Size = UDim2.new(1, -190, 0, 18),
        Font = Enum.Font.Gotham,
        Text = Settings.Subtitle or "by Aerlro",
        TextColor3 = Theme.SubText,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6
    })

    Object.Subtitle = Subtitle

    local Controls = create("Frame", {
        Name = "Controls",
        Parent = TopBar,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -90, 0, 0),
        Size = UDim2.fromOffset(90, 60),
        ZIndex = 20
    })

    local MinimizeButton = create("ImageButton", {
        Name = "Minimize",
        Parent = Controls,
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(5, 15),
        Size = UDim2.fromOffset(30, 30),
        Image = LOGO_URL,
        ScaleType = Enum.ScaleType.Fit,
        AutoButtonColor = false,
        ZIndex = 21
    })

    create("UICorner", {
        Parent = MinimizeButton,
        CornerRadius = UDim.new(0, 6)
    })

    Object.MinimizeButton = MinimizeButton

    local CloseButton = create("TextButton", {
        Name = "Close",
        Parent = Controls,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(45, 0),
        Size = UDim2.fromOffset(45, 60),
        Font = Enum.Font.GothamMedium,
        Text = "×",
        TextColor3 = Theme.SubText,
        TextSize = 23,
        AutoButtonColor = false,
        ZIndex = 21
    })

    Object.CloseButton = CloseButton

    MinimizeButton.MouseEnter:Connect(function()
        tween(MinimizeButton, 0.15, {
            BackgroundColor3 = Theme.Hover
        })
    end)

    MinimizeButton.MouseLeave:Connect(function()
        tween(MinimizeButton, 0.15, {
            BackgroundColor3 = Theme.Element
        })
    end)

    CloseButton.MouseEnter:Connect(function()
        tween(CloseButton, 0.15, {
            TextColor3 = Theme.Text
        })
    end)

    CloseButton.MouseLeave:Connect(function()
        tween(CloseButton, 0.15, {
            TextColor3 = Theme.SubText
        })
    end)

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

    local UserArea = create("Frame", {
        Name = "UserArea",
        Parent = Sidebar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(
            0,
            0,
            1,
            -USER_AREA_HEIGHT
        ),
        Size = UDim2.new(
            1,
            0,
            0,
            USER_AREA_HEIGHT
        ),
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

    function Object:AddTab(TabObject)
        if not TabObject then
            return
        end

        table.insert(self.Tabs, TabObject)

        if not self.SelectedTab then
            self:SelectTab(TabObject)
        else
            TabObject:SetSelected(false)
        end
    end

    function Object:SelectTab(TabObject)
        if not TabObject then
            return
        end

        for _, CurrentTab in ipairs(self.Tabs) do
            CurrentTab:SetSelected(CurrentTab == TabObject)
        end

        self.SelectedTab = TabObject
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

    local Dragging = false
    local DragStart
    local StartPosition

    local DragArea = create("TextButton", {
        Name = "DragArea",
        Parent = TopBar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(1, -90, 1, 0),
        Text = "",
        AutoButtonColor = false,
        ZIndex = 4
    })

    DragArea.MouseButton1Down:Connect(function()
        Dragging = true
        DragStart = UserInputService:GetMouseLocation()
        StartPosition = Main.Position
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if not Dragging then
            return
        end

        if Input.UserInputType == Enum.UserInputType.MouseMovement then
            local CurrentPosition = UserInputService:GetMouseLocation()
            local Delta = CurrentPosition - DragStart

            Main.Position = UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)

    local MiniButton = create("ImageButton", {
        Name = "OTC_Minimized",
        Parent = ScreenGui,
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        Position = Main.Position,
        Size = UDim2.fromOffset(MINI_SIZE, MINI_SIZE),
        Image = LOGO_URL,
        ScaleType = Enum.ScaleType.Fit,
        Visible = false,
        AutoButtonColor = false,
        ZIndex = 100
    })

    create("UICorner", {
        Parent = MiniButton,
        CornerRadius = UDim.new(1, 0)
    })

    Object.MinimizedButton = MiniButton

    local MiniDragging = false
    local MiniDragStart
    local MiniStartPosition
    local MiniWasDragged = false

    MiniButton.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

            MiniDragging = true
            MiniWasDragged = false
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

            if math.abs(Delta.X) > 3
            or math.abs(Delta.Y) > 3 then
                MiniWasDragged = true
            end

            MiniButton.Position = UDim2.new(
                MiniStartPosition.X.Scale,
                MiniStartPosition.X.Offset + Delta.X,
                MiniStartPosition.Y.Scale,
                MiniStartPosition.Y.Offset + Delta.Y
            )
        end
    end)

    local Minimized = false
    local Closed = false

    MinimizeButton.MouseButton1Click:Connect(function()
        if Minimized or Closed then
            return
        end

        Minimized = true

        MiniButton.Position = UDim2.new(
            Main.Position.X.Scale,
            Main.Position.X.Offset + (WINDOW_WIDTH - MINI_SIZE) / 2,
            Main.Position.Y.Scale,
            Main.Position.Y.Offset + (WINDOW_HEIGHT - MINI_SIZE) / 2
        )

        Main.ClipsDescendants = true

        tween(Main, 0.3, {
            Size = UDim2.fromOffset(
                MINI_SIZE,
                MINI_SIZE
            )
        })

        task.delay(0.3, function()
            if Closed or not Minimized then
                return
            end

            Main.Visible = false
            MiniButton.Visible = true
        end)
    end)

    MiniButton.MouseButton1Click:Connect(function()
        if MiniWasDragged then
            return
        end

        if not Minimized or Closed then
            return
        end

        Minimized = false

        Main.Position = UDim2.new(
            MiniButton.Position.X.Scale,
            MiniButton.Position.X.Offset - (WINDOW_WIDTH - MINI_SIZE) / 2,
            MiniButton.Position.Y.Scale,
            MiniButton.Position.Y.Offset - (WINDOW_HEIGHT - MINI_SIZE) / 2
        )

        MiniButton.Visible = false

        Main.Visible = true

        Main.Size = UDim2.fromOffset(
            MINI_SIZE,
            MINI_SIZE
        )

        tween(Main, 0.3, {
            Size = UDim2.fromOffset(
                WINDOW_WIDTH,
                WINDOW_HEIGHT
            )
        })
    end)

    CloseButton.MouseButton1Click:Connect(function()
        if Closed then
            return
        end

        Closed = true

        tween(Main, 0.25, {
            Size = UDim2.fromOffset(
                0,
                0
            )
        })

        task.delay(0.25, function()
            if ScreenGui then
                ScreenGui:Destroy()
            end
        end)
    end)

    function Object:RefreshTheme()
        local NewTheme = OTC:GetTheme()

        Main.BackgroundColor3 = NewTheme.Background
        TopBar.BackgroundColor3 = NewTheme.Secondary
        Sidebar.BackgroundColor3 = NewTheme.Secondary
        Content.BackgroundColor3 = NewTheme.Background

        Title.TextColor3 = NewTheme.Text
        Subtitle.TextColor3 = NewTheme.SubText

        MinimizeButton.BackgroundColor3 = NewTheme.Element
        CloseButton.TextColor3 = NewTheme.SubText
        MiniButton.BackgroundColor3 = NewTheme.Element

        UserCard.BackgroundColor3 = NewTheme.Element
        UserAvatar.BackgroundColor3 = NewTheme.Hover

        UserDisplayName.TextColor3 = NewTheme.Text
        UserUsername.TextColor3 = NewTheme.SubText

        UserSeparator.BackgroundColor3 = NewTheme.Border

        for _, TabObject in ipairs(self.Tabs) do
            if TabObject.SetSelected then
                TabObject:SetSelected(
                    TabObject == self.SelectedTab
                )
            end
        end
    end

    return Object
end

return Window