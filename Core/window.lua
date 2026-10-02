--[[
    OTC Hub v1
    Window System
    by Aerlro
]]

local Window = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local LOGO_URL = "rbxassetid://116094782851554"

--// Create
local function create(ClassName, Properties)
    local Object = Instance.new(ClassName)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    return Object
end

--// Avatar
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

--// Create Window
function Window.Create(Settings, OTC)

    Settings = Settings or {}

    local ThemeName =
        Settings.Theme
        or OTC.CurrentTheme
        or "Default"

    if not OTC._Themes[ThemeName] then

        warn(
            "[OTC Hub] Theme does not exist:",
            ThemeName,
            "| Using Default"
        )

        ThemeName = "Default"
    end

    local Theme =
        OTC._Themes[ThemeName]

    local Animation =
        OTC._AnimationModule

    local Object = {}

    Object.OTC = OTC
    Object.Settings = Settings

    Object.Tabs = {}
    Object.SelectedTab = nil

    Object.Minimized = false
    Object.Closed = false

    Object.Theme = ThemeName

    Object.ToggleKey =
        Settings.ToggleKey
        or Enum.KeyCode.RightControl

    --==================================================
    -- ScreenGui
    --==================================================

    local ScreenGui = create("ScreenGui", {

        Name = "OTC_Hub",

        Parent = game:GetService("CoreGui"),

        ResetOnSpawn = false,

        ZIndexBehavior =
            Enum.ZIndexBehavior.Sibling
    })

    Object.ScreenGui = ScreenGui

    --==================================================
    -- Main
    --==================================================

    local Main = create("Frame", {

        Name = "Main",

        Parent = ScreenGui,

        BackgroundColor3 =
            Theme.Background,

        BorderSizePixel = 0,

        Position =
            UDim2.new(
                0.5,
                -280,
                0.5,
                -190
            ),

        Size =
            UDim2.fromOffset(
                560,
                380
            ),

        ClipsDescendants = true,

        Active = true,

        ZIndex = 1
    })

    Object.Main = Main

    create("UICorner", {
        Parent = Main,

        CornerRadius =
            UDim.new(
                0,
                10
            )
    })

    local MainStroke = create("UIStroke", {

        Parent = Main,

        Color =
            Theme.Border,

        Thickness = 1
    })

    --==================================================
    -- TopBar
    --==================================================

    local TopBar = create("Frame", {

        Name = "TopBar",

        Parent = Main,

        BackgroundColor3 =
            Theme.Secondary,

        BorderSizePixel = 0,

        Size =
            UDim2.new(
                1,
                0,
                0,
                60
            ),

        Active = true,

        ZIndex = 5
    })

    create("UICorner", {
        Parent = TopBar,

        CornerRadius =
            UDim.new(
                0,
                10
            )
    })

    local BottomFix = create("Frame", {

        Name = "BottomFix",

        Parent = TopBar,

        BackgroundColor3 =
            Theme.Secondary,

        BorderSizePixel = 0,

        Position =
            UDim2.new(
                0,
                0,
                1,
                -10
            ),

        Size =
            UDim2.new(
                1,
                0,
                0,
                10
            ),

        ZIndex = 5
    })

    --==================================================
    -- Drag Area
    --==================================================

    local DragArea = create("Frame", {

        Name = "DragArea",

        Parent = TopBar,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Position =
            UDim2.fromOffset(
                0,
                0
            ),

        Size =
            UDim2.new(
                1,
                -110,
                1,
                0
            ),

        Active = true,

        ZIndex = 6
    })

    --==================================================
    -- Logo
    --==================================================

    local Logo = create("ImageLabel", {

        Name = "Logo",

        Parent = TopBar,

        BackgroundTransparency = 1,

        Image = LOGO_URL,

        ImageColor3 =
            Theme.Text,

        Position =
            UDim2.fromOffset(
                15,
                15
            ),

        Size =
            UDim2.fromOffset(
                30,
                30
            ),

        ScaleType =
            Enum.ScaleType.Fit,

        ZIndex = 7
    })

    --==================================================
    -- Title
    --==================================================

    local Title = create("TextLabel", {

        Name = "Title",

        Parent = TopBar,

        BackgroundTransparency = 1,

        Text =
            Settings.Name
            or Settings.Title
            or "OTC Hub",

        TextColor3 =
            Theme.Text,

        Font =
            Enum.Font.GothamBold,

        TextSize = 16,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        Position =
            UDim2.fromOffset(
                55,
                9
            ),

        Size =
            UDim2.new(
                1,
                -65,
                0,
                23
            ),

        ZIndex = 7
    })

    --==================================================
    -- Subtitle
    --==================================================

    local Subtitle = create("TextLabel", {

        Name = "Subtitle",

        Parent = TopBar,

        BackgroundTransparency = 1,

        Text =
            Settings.Subtitle
            or "by Aerlro",

        TextColor3 =
            Theme.SubText,

        Font =
            Enum.Font.Gotham,

        TextSize = 11,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        Position =
            UDim2.fromOffset(
                55,
                32
            ),

        Size =
            UDim2.new(
                1,
                -65,
                0,
                18
            ),

        ZIndex = 7
    })

    --==================================================
    -- Minimize
    --==================================================

    local MinimizeButton = create("TextButton", {

        Name = "Minimize",

        Parent = TopBar,

        BackgroundColor3 =
            Theme.Element,

        BorderSizePixel = 0,

        Text = "−",

        TextColor3 =
            Theme.Text,

        Font =
            Enum.Font.GothamBold,

        TextSize = 20,

        Position =
            UDim2.new(
                1,
                -75,
                0,
                15
            ),

        Size =
            UDim2.fromOffset(
                30,
                30
            ),

        AutoButtonColor = false,

        ZIndex = 8
    })

    create("UICorner", {
        Parent = MinimizeButton,

        CornerRadius =
            UDim.new(
                0,
                8
            )
    })

    --==================================================
    -- Close
    --==================================================

    local CloseButton = create("TextButton", {

        Name = "Close",

        Parent = TopBar,

        BackgroundColor3 =
            Theme.Element,

        BorderSizePixel = 0,

        Text = "×",

        TextColor3 =
            Theme.Text,

        Font =
            Enum.Font.GothamBold,

        TextSize = 20,

        Position =
            UDim2.new(
                1,
                -40,
                0,
                15
            ),

        Size =
            UDim2.fromOffset(
                30,
                30
            ),

        AutoButtonColor = false,

        ZIndex = 8
    })

    create("UICorner", {
        Parent = CloseButton,

        CornerRadius =
            UDim.new(
                0,
                8
            )
    })

    --==================================================
    -- Body
    --==================================================

    local Body = create("Frame", {

        Name = "Body",

        Parent = Main,

        BackgroundTransparency = 1,

        Position =
            UDim2.fromOffset(
                0,
                60
            ),

        Size =
            UDim2.new(
                1,
                0,
                1,
                -60
            ),

        ZIndex = 2
    })

    --==================================================
    -- Sidebar
    --==================================================

    local Sidebar = create("Frame", {

        Name = "Sidebar",

        Parent = Body,

        BackgroundColor3 =
            Theme.Secondary,

        BorderSizePixel = 0,

        Size =
            UDim2.new(
                0,
                150,
                1,
                0
            ),

        ZIndex = 2
    })

    local SidebarSeparator = create("Frame", {

        Name = "Separator",

        Parent = Sidebar,

        BackgroundColor3 =
            Theme.Border,

        BorderSizePixel = 0,

        Position =
            UDim2.new(
                1,
                -1,
                0,
                0
            ),

        Size =
            UDim2.new(
                0,
                1,
                1,
                0
            ),

        ZIndex = 4
    })

    --==================================================
    -- Tabs
    --==================================================

    local USER_AREA_HEIGHT = 72

    local TabsArea = create("Frame", {

        Name = "TabsArea",

        Parent = Sidebar,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Position =
            UDim2.fromOffset(
                10,
                15
            ),

        Size =
            UDim2.new(
                1,
                -20,
                1,
                -(15 + USER_AREA_HEIGHT)
            ),

        ClipsDescendants = true,

        ZIndex = 2
    })

    local TabContainer = create("ScrollingFrame", {

        Name = "Tabs",

        Parent = TabsArea,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Position =
            UDim2.fromOffset(
                0,
                0
            ),

        Size =
            UDim2.fromScale(
                1,
                1
            ),

        CanvasSize =
            UDim2.new(
                0,
                0,
                0,
                0
            ),

        AutomaticCanvasSize =
            Enum.AutomaticSize.Y,

        ScrollBarThickness = 0,

        ScrollingDirection =
            Enum.ScrollingDirection.Y,

        ClipsDescendants = true,

        ZIndex = 2
    })

    create("UIListLayout", {

        Parent = TabContainer,

        Padding =
            UDim.new(
                0,
                5
            ),

        SortOrder =
            Enum.SortOrder.LayoutOrder
    })

    Object.TabContainer =
        TabContainer

    --==================================================
    -- User Area
    --==================================================

    local UserArea = create("Frame", {

        Name = "UserArea",

        Parent = Sidebar,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Position =
            UDim2.new(
                0,
                0,
                1,
                -USER_AREA_HEIGHT
            ),

        Size =
            UDim2.new(
                1,
                0,
                0,
                USER_AREA_HEIGHT
            ),

        ZIndex = 10
    })

    local UserSeparator = create("Frame", {

        Name = "UserSeparator",

        Parent = UserArea,

        BackgroundColor3 =
            Theme.Border,

        BorderSizePixel = 0,

        Position =
            UDim2.fromOffset(
                10,
                0
            ),

        Size =
            UDim2.new(
                1,
                -20,
                0,
                1
            ),

        ZIndex = 10
    })

    local UserCard = create("Frame", {

        Name = "UserCard",

        Parent = UserArea,

        BackgroundColor3 =
            Theme.Element,

        BorderSizePixel = 0,

        Position =
            UDim2.fromOffset(
                10,
                10
            ),

        Size =
            UDim2.new(
                1,
                -20,
                0,
                52
            ),

        ZIndex = 11
    })

    create("UICorner", {

        Parent = UserCard,

        CornerRadius =
            UDim.new(
                0,
                8
            )
    })

    local Avatar = create("ImageLabel", {

        Name = "Avatar",

        Parent = UserCard,

        BackgroundTransparency = 1,

        Image =
            getAvatar(
                LocalPlayer.UserId
            ),

        Position =
            UDim2.fromOffset(
                8,
                8
            ),

        Size =
            UDim2.fromOffset(
                36,
                36
            ),

        ZIndex = 12
    })

    create("UICorner", {

        Parent = Avatar,

        CornerRadius =
            UDim.new(
                1,
                0
            )
    })

    local DisplayName = create("TextLabel", {

        Name = "DisplayName",

        Parent = UserCard,

        BackgroundTransparency = 1,

        Text =
            LocalPlayer.DisplayName,

        TextColor3 =
            Theme.Text,

        Font =
            Enum.Font.GothamBold,

        TextSize = 12,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        Position =
            UDim2.fromOffset(
                52,
                8
            ),

        Size =
            UDim2.new(
                1,
                -58,
                0,
                18
            ),

        TextTruncate =
            Enum.TextTruncate.AtEnd,

        ZIndex = 12
    })

    local Username = create("TextLabel", {

        Name = "Username",

        Parent = UserCard,

        BackgroundTransparency = 1,

        Text =
            "@" .. LocalPlayer.Name,

        TextColor3 =
            Theme.SubText,

        Font =
            Enum.Font.Gotham,

        TextSize = 10,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        Position =
            UDim2.fromOffset(
                52,
                27
            ),

        Size =
            UDim2.new(
                1,
                -58,
                0,
                16
            ),

        TextTruncate =
            Enum.TextTruncate.AtEnd,

        ZIndex = 12
    })

    --==================================================
    -- Content
    --==================================================

    local Content = create("Frame", {

        Name = "Content",

        Parent = Body,

        BackgroundColor3 =
            Theme.Background,

        BorderSizePixel = 0,

        Position =
            UDim2.fromOffset(
                150,
                0
            ),

        Size =
            UDim2.new(
                1,
                -150,
                1,
                0
            ),

        ClipsDescendants = true,

        ZIndex = 2
    })

    Object.Content =
        Content

    --==================================================
    -- Mini Button
    --==================================================

    local MiniButton = create("ImageButton", {

        Name = "OTC_Minimized",

        Parent = ScreenGui,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Image = LOGO_URL,

        ImageColor3 =
            Theme.Text,

        Position =
            UDim2.new(
                0,
                20,
                0.5,
                -25
            ),

        Size =
            UDim2.fromOffset(
                50,
                50
            ),

        Visible = false,

        AutoButtonColor = false,

        Active = true,

        ZIndex = 100
    })

    Object.MiniButton =
        MiniButton

    Object.MinimizeButton =
        MinimizeButton

    Object.CloseButton =
        CloseButton

    --==================================================
    -- Animation State
    --==================================================

    local OpenPosition =
        Main.Position

    local OpenSize =
        Main.Size

    local CurrentPosition =
        OpenPosition

    local MainScale =
        Main:FindFirstChildOfClass(
            "UIScale"
        )

    if not MainScale then

        MainScale =
            Instance.new("UIScale")

        MainScale.Name =
            "AnimationScale"

        MainScale.Scale = 1

        MainScale.Parent =
            Main
    end

    --==================================================
    -- Minimize
    --==================================================

    local function Minimize()

        if Object.Minimized
            or Object.Closed then
            return
        end

        Object.Minimized = true

        CurrentPosition =
            Main.Position

        Main.Active = false

        local TargetPosition =
            CurrentPosition
            + UDim2.fromOffset(
                0,
                35
            )

        local PositionTween =
            TweenService:Create(
                Main,

                TweenInfo.new(
                    0.14,
                    Enum.EasingStyle.Quint,
                    Enum.EasingDirection.In
                ),

                {
                    Position =
                        TargetPosition
                }
            )

        local ScaleTween =
            TweenService:Create(
                MainScale,

                TweenInfo.new(
                    0.14,
                    Enum.EasingStyle.Quint,
                    Enum.EasingDirection.In
                ),

                {
                    Scale = 0.96
                }
            )

        PositionTween:Play()
        ScaleTween:Play()

        PositionTween.Completed:Once(
            function()

                if Object.Closed then
                    return
                end

                Main.Visible = false

                Main.Position =
                    CurrentPosition

                Main.Size =
                    OpenSize

                MainScale.Scale = 1

                MiniButton.Visible = true

                MiniButton.ImageTransparency =
                    1

                local MiniScale =
                    MiniButton:FindFirstChildOfClass(
                        "UIScale"
                    )

                if not MiniScale then

                    MiniScale =
                        Instance.new("UIScale")

                    MiniScale.Name =
                        "AnimationScale"

                    MiniScale.Parent =
                        MiniButton
                end

                MiniScale.Scale =
                    0.85

                local MiniFadeTween =
                    TweenService:Create(
                        MiniButton,

                        TweenInfo.new(
                            0.09,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out
                        ),

                        {
                            ImageTransparency = 0
                        }
                    )

                local MiniScaleTween =
                    TweenService:Create(
                        MiniScale,

                        TweenInfo.new(
                            0.12,
                            Enum.EasingStyle.Back,
                            Enum.EasingDirection.Out
                        ),

                        {
                            Scale = 1
                        }
                    )

                MiniFadeTween:Play()
                MiniScaleTween:Play()
            end
        )
    end

    --==================================================
    -- Restore
    --==================================================

    local function Restore()

        if not Object.Minimized
            or Object.Closed then
            return
        end

        Object.Minimized = false

        Main.Visible = true

        Main.Active = true

        Main.Position =
            CurrentPosition
            + UDim2.fromOffset(
                0,
                35
            )

        Main.Size =
            OpenSize

        MainScale.Scale =
            0.96

        local MiniFadeTween =
            TweenService:Create(
                MiniButton,

                TweenInfo.new(
                    0.08,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.In
                ),

                {
                    ImageTransparency = 1
                }
            )

        MiniFadeTween:Play()

        local PositionTween =
            TweenService:Create(
                Main,

                TweenInfo.new(
                    0.16,
                    Enum.EasingStyle.Quint,
                    Enum.EasingDirection.Out
                ),

                {
                    Position =
                        CurrentPosition
                }
            )

        local ScaleTween =
            TweenService:Create(
                MainScale,

                TweenInfo.new(
                    0.16,
                    Enum.EasingStyle.Quint,
                    Enum.EasingDirection.Out
                ),

                {
                    Scale = 1
                }
            )

        PositionTween:Play()
        ScaleTween:Play()

        MiniFadeTween.Completed:Once(
            function()

                if not Object.Closed then

                    MiniButton.Visible =
                        false

                    MiniButton.ImageTransparency =
                        0
                end
            end
        )
    end

    --==================================================
    -- Unload
    --==================================================

    local function Unload()

        if Object.Closed then
            return
        end

        Object.Closed = true

        local Scale =
            Main:FindFirstChild(
                "AnimationScale"
            )

        if Scale then

            TweenService:Create(
                Scale,

                TweenInfo.new(
                    0.14,
                    Enum.EasingStyle.Quint,
                    Enum.EasingDirection.In
                ),

                {
                    Scale = 0.92
                }
            ):Play()
        end

        TweenService:Create(
            Main,

            TweenInfo.new(
                0.14,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.In
            ),

            {
                Position =
                    Main.Position
                    + UDim2.fromOffset(
                        0,
                        20
                    )
            }
        ):Play()

        task.delay(
            0.15,
            function()

                if ScreenGui then
                    ScreenGui:Destroy()
                end
            end
        )
    end

    --==================================================
    -- Unload Confirmation
    --==================================================

    local function CreateUnloadConfirmation()

        if ScreenGui:FindFirstChild(
            "UnloadConfirmation"
        ) then
            return
        end

        local Overlay = create("Frame", {

            Name =
                "UnloadConfirmation",

            Parent =
                ScreenGui,

            BackgroundColor3 =
                Color3.fromRGB(
                    0,
                    0,
                    0
                ),

            BackgroundTransparency =
                0.45,

            BorderSizePixel = 0,

            Size =
                UDim2.fromScale(
                    1,
                    1
                ),

            ZIndex = 200
        })

        local Popup = create("Frame", {

            Name = "Popup",

            Parent = Overlay,

            AnchorPoint =
                Vector2.new(
                    0.5,
                    0.5
                ),

            BackgroundColor3 =
                Theme.Background,

            BorderSizePixel = 0,

            Position =
                UDim2.fromScale(
                    0.5,
                    0.5
                ),

            Size =
                UDim2.fromOffset(
                    360,
                    175
                ),

            ZIndex = 201
        })

        create("UICorner", {

            Parent = Popup,

            CornerRadius =
                UDim.new(
                    0,
                    10
                )
        })

        local PopupStroke =
            create("UIStroke", {

                Parent = Popup,

                Color =
                    Theme.Border,

                Thickness = 1
            })

        local PopupTitle =
            create("TextLabel", {

                Name = "Title",

                Parent = Popup,

                BackgroundTransparency = 1,

                Text =
                    "Unload OTC Hub?",

                TextColor3 =
                    Theme.Text,

                Font =
                    Enum.Font.GothamBold,

                TextSize = 18,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                Position =
                    UDim2.fromOffset(
                        20,
                        18
                    ),

                Size =
                    UDim2.new(
                        1,
                        -40,
                        0,
                        28
                    ),

                ZIndex = 202
            })

        local PopupText =
            create("TextLabel", {

                Name = "Description",

                Parent = Popup,

                BackgroundTransparency = 1,

                Text =
                    "Are you sure you want to unload the UI?",

                TextColor3 =
                    Theme.SubText,

                Font =
                    Enum.Font.Gotham,

                TextSize = 13,

                TextWrapped = true,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                Position =
                    UDim2.fromOffset(
                        20,
                        52
                    ),

                Size =
                    UDim2.new(
                        1,
                        -40,
                        0,
                        42
                    ),

                ZIndex = 202
            })

        local CancelButton =
            create("TextButton", {

                Name = "Cancel",

                Parent = Popup,

                BackgroundColor3 =
                    Theme.Element,

                BorderSizePixel = 0,

                Text = "Cancel",

                TextColor3 =
                    Theme.Text,

                Font =
                    Enum.Font.GothamBold,

                TextSize = 13,

                Position =
                    UDim2.new(
                        1,
                        -190,
                        1,
                        -48
                    ),

                Size =
                    UDim2.fromOffset(
                        80,
                        32
                    ),

                AutoButtonColor = false,

                ZIndex = 202
            })

        create("UICorner", {

            Parent = CancelButton,

            CornerRadius =
                UDim.new(
                    0,
                    7
                )
        })

        local UnloadButton =
            create("TextButton", {

                Name = "Unload",

                Parent = Popup,

                BackgroundColor3 =
                    Theme.Text,

                BorderSizePixel = 0,

                Text = "Unload",

                TextColor3 =
                    Theme.Background,

                Font =
                    Enum.Font.GothamBold,

                TextSize = 13,

                Position =
                    UDim2.new(
                        1,
                        -100,
                        1,
                        -48
                    ),

                Size =
                    UDim2.fromOffset(
                        80,
                        32
                    ),

                AutoButtonColor = false,

                ZIndex = 202
            })

        create("UICorner", {

            Parent = UnloadButton,

            CornerRadius =
                UDim.new(
                    0,
                    7
                )
        })

        local PopupScale =
            Instance.new("UIScale")

        PopupScale.Scale = 0.9

        PopupScale.Parent =
            Popup

        Overlay.BackgroundTransparency =
            1

        TweenService:Create(
            Overlay,

            TweenInfo.new(
                0.12,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),

            {
                BackgroundTransparency =
                    0.45
            }
        ):Play()

        TweenService:Create(
            PopupScale,

            TweenInfo.new(
                0.16,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out
            ),

            {
                Scale = 1
            }
        ):Play()

        CancelButton.MouseEnter:Connect(
            function()

                local CurrentTheme =
                    Object:GetTheme()

                TweenService:Create(
                    CancelButton,

                    TweenInfo.new(
                        0.1,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),

                    {
                        BackgroundColor3 =
                            CurrentTheme.Hover
                    }
                ):Play()
            end
        )

        CancelButton.MouseLeave:Connect(
            function()

                local CurrentTheme =
                    Object:GetTheme()

                TweenService:Create(
                    CancelButton,

                    TweenInfo.new(
                        0.1,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),

                    {
                        BackgroundColor3 =
                            CurrentTheme.Element
                    }
                ):Play()
            end
        )

        UnloadButton.MouseEnter:Connect(
            function()

                local CurrentTheme =
                    Object:GetTheme()

                TweenService:Create(
                    UnloadButton,

                    TweenInfo.new(
                        0.1,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),

                    {
                        BackgroundColor3 =
                            CurrentTheme.AccentDark
                    }
                ):Play()
            end
        )

        UnloadButton.MouseLeave:Connect(
            function()

                local CurrentTheme =
                    Object:GetTheme()

                TweenService:Create(
                    UnloadButton,

                    TweenInfo.new(
                        0.1,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),

                    {
                        BackgroundColor3 =
                            CurrentTheme.Text
                    }
                ):Play()
            end
        )

        CancelButton.MouseButton1Click:Connect(
            function()

                TweenService:Create(
                    PopupScale,

                    TweenInfo.new(
                        0.1,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.In
                    ),

                    {
                        Scale = 0.9
                    }
                ):Play()

                TweenService:Create(
                    Overlay,

                    TweenInfo.new(
                        0.1,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.In
                    ),

                    {
                        BackgroundTransparency = 1
                    }
                ):Play()

                task.delay(
                    0.11,
                    function()

                        if Overlay then
                            Overlay:Destroy()
                        end
                    end
                )
            end
        )

        UnloadButton.MouseButton1Click:Connect(
            function()
                Unload()
            end
        )
    end

    --==================================================
    -- Buttons
    --==================================================

    MinimizeButton.MouseButton1Click:Connect(
        function()
            Minimize()
        end
    )

    CloseButton.MouseButton1Click:Connect(
        function()

            if Object.Closed then
                return
            end

            CreateUnloadConfirmation()
        end
    )

    --==================================================
    -- Button Animations
    --==================================================

    MinimizeButton.MouseEnter:Connect(
        function()

            Animation:Scale(
                MinimizeButton,
                1.08,
                0.12
            )
        end
    )

    MinimizeButton.MouseLeave:Connect(
        function()

            Animation:Scale(
                MinimizeButton,
                1,
                0.12
            )
        end
    )

    CloseButton.MouseEnter:Connect(
        function()

            Animation:Scale(
                CloseButton,
                1.08,
                0.12
            )
        end
    )

    CloseButton.MouseLeave:Connect(
        function()

            Animation:Scale(
                CloseButton,
                1,
                0.12
            )
        end
    )

    --==================================================
    -- Main Drag
    --==================================================

    local Dragging = false
    local DragStart
    local StartPosition
    local DragInput

    local function UpdateDrag(Input)

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

        CurrentPosition =
            Main.Position
    end

    DragArea.InputBegan:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseButton1

                or Input.UserInputType ==
                Enum.UserInputType.Touch then

                Dragging = true

                DragStart =
                    Input.Position

                StartPosition =
                    Main.Position

                Input.Changed:Connect(
                    function()

                        if Input.UserInputState ==
                            Enum.UserInputState.End then

                            Dragging = false
                        end
                    end
                )
            end
        end
    )

    DragArea.InputChanged:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseMovement

                or Input.UserInputType ==
                Enum.UserInputType.Touch then

                DragInput =
                    Input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(Input)

            if Input == DragInput
                and Dragging then

                UpdateDrag(Input)
            end
        end
    )

    --==================================================
    -- Mini Button Drag
    --==================================================

    local MiniDragging = false
    local MiniMoved = false

    local MiniDragStart
    local MiniStartPosition
    local MiniDragInput

    local DRAG_THRESHOLD = 8

    local function UpdateMiniDrag(Input)

        local Delta =
            Input.Position
            - MiniDragStart

        if math.abs(Delta.X) >
            DRAG_THRESHOLD

            or math.abs(Delta.Y) >
            DRAG_THRESHOLD then

            MiniMoved = true
        end

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

    MiniButton.InputBegan:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseButton1

                or Input.UserInputType ==
                Enum.UserInputType.Touch then

                MiniDragging = true
                MiniMoved = false

                MiniDragStart =
                    Input.Position

                MiniStartPosition =
                    MiniButton.Position

                Input.Changed:Connect(
                    function()

                        if Input.UserInputState ==
                            Enum.UserInputState.End then

                            MiniDragging = false

                            if not MiniMoved then
                                Restore()
                            end
                        end
                    end
                )
            end
        end
    )

    MiniButton.InputChanged:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseMovement

                or Input.UserInputType ==
                Enum.UserInputType.Touch then

                MiniDragInput =
                    Input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(Input)

            if Input == MiniDragInput
                and MiniDragging then

                UpdateMiniDrag(Input)
            end
        end
    )

    --==================================================
    -- Tabs
    --==================================================

    function Object:AddTab(TabObject)

        table.insert(
            self.Tabs,
            TabObject
        )

        if #self.Tabs == 1 then

            self:SelectTab(
                TabObject
            )

        else

            TabObject:SetSelected(
                false
            )
        end
    end

    function Object:SelectTab(TabObject)

        for _, Tab in ipairs(
            self.Tabs
        ) do

            Tab:SetSelected(
                Tab == TabObject
            )
        end

        self.SelectedTab =
            TabObject
    end

    --==================================================
    -- Minimize / Restore
    --==================================================

    function Object:Minimize()
        Minimize()
    end

    function Object:Restore()
        Restore()
    end

    --==================================================
    -- Destroy
    --==================================================

    function Object:Destroy()

        if self.Closed then
            return
        end

        self.Closed = true

        if self.ScreenGui then
            self.ScreenGui:Destroy()
        end
    end

    --==================================================
    -- Unload
    --==================================================

    function Object:Unload()
        Unload()
    end

    --==================================================
    -- Get Theme
    --==================================================

    function Object:GetTheme()

        return self.OTC._Themes[self.Theme]
            or self.OTC._Themes.Default
    end

    --==================================================
    -- Set Theme
    --==================================================

    function Object:SetTheme(Name)

        if self.Closed then
            return false
        end

        if not self.OTC._Themes[Name] then

            warn(
                "[OTC Hub] Theme does not exist:",
                Name
            )

            return false
        end

        self.Theme =
            Name

        self:RefreshTheme()

        return true
    end

    --==================================================
    -- Refresh Theme
    --==================================================

    function Object:RefreshTheme()

        local NewTheme =
            self:GetTheme()

        --// Main
        Main.BackgroundColor3 =
            NewTheme.Background

        MainStroke.Color =
            NewTheme.Border

        --// TopBar
        TopBar.BackgroundColor3 =
            NewTheme.Secondary

        BottomFix.BackgroundColor3 =
            NewTheme.Secondary

        Logo.ImageColor3 =
            NewTheme.Text

        Title.TextColor3 =
            NewTheme.Text

        Subtitle.TextColor3 =
            NewTheme.SubText

        --// Top Buttons
        MinimizeButton.BackgroundColor3 =
            NewTheme.Element

        MinimizeButton.TextColor3 =
            NewTheme.Text

        CloseButton.BackgroundColor3 =
            NewTheme.Element

        CloseButton.TextColor3 =
            NewTheme.Text

        --// Sidebar
        Sidebar.BackgroundColor3 =
            NewTheme.Secondary

        SidebarSeparator.BackgroundColor3 =
            NewTheme.Border

        --// Content
        Content.BackgroundColor3 =
            NewTheme.Background

        --// User
        UserCard.BackgroundColor3 =
            NewTheme.Element

        UserSeparator.BackgroundColor3 =
            NewTheme.Border

        DisplayName.TextColor3 =
            NewTheme.Text

        Username.TextColor3 =
            NewTheme.SubText

        --// Mini Button
        MiniButton.ImageColor3 =
            NewTheme.Text

        --==================================================
        -- Refresh Tabs + Elements
        --==================================================

        for _, TabObject in ipairs(
            self.Tabs
        ) do

            if TabObject
                and TabObject.RefreshTheme then

                local Success, ErrorMessage =
                    pcall(
                        function()

                            TabObject:RefreshTheme()

                        end
                    )

                if not Success then

                    warn(
                        "[OTC Hub] Failed to refresh tab theme:",
                        ErrorMessage
                    )
                end
            end
        end

        --==================================================
        -- Refresh Unload Popup
        --==================================================

        local Confirmation =
            ScreenGui:FindFirstChild(
                "UnloadConfirmation"
            )

        if Confirmation then

            local Popup =
                Confirmation:FindFirstChild(
                    "Popup"
                )

            if Popup then

                Popup.BackgroundColor3 =
                    NewTheme.Background

                local Stroke =
                    Popup:FindFirstChildOfClass(
                        "UIStroke"
                    )

                if Stroke then

                    Stroke.Color =
                        NewTheme.Border
                end

                local PopupTitle =
                    Popup:FindFirstChild(
                        "Title"
                    )

                local PopupText =
                    Popup:FindFirstChild(
                        "Description"
                    )

                local CancelButton =
                    Popup:FindFirstChild(
                        "Cancel"
                    )

                local UnloadButton =
                    Popup:FindFirstChild(
                        "Unload"
                    )

                if PopupTitle then

                    PopupTitle.TextColor3 =
                        NewTheme.Text
                end

                if PopupText then

                    PopupText.TextColor3 =
                        NewTheme.SubText
                end

                if CancelButton then

                    CancelButton.BackgroundColor3 =
                        NewTheme.Element

                    CancelButton.TextColor3 =
                        NewTheme.Text
                end

                if UnloadButton then

                    UnloadButton.BackgroundColor3 =
                        NewTheme.Text

                    UnloadButton.TextColor3 =
                        NewTheme.Background
                end
            end
        end
    end

    --==================================================
    -- Appear Animation
    --==================================================

    Animation:Appear(
        Main,
        "Bottom",
        20,
        0.3
    )

    Object.MainOpenPosition =
        OpenPosition

    Object.MainOpenSize =
        OpenSize

    return Object
end

return Window