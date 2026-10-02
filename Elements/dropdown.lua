local Dropdown = {}

local function Create(ClassName, Properties)
    local Object = Instance.new(ClassName)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    return Object
end

local function NormalizeOptions(Options)
    local Result = {}

    if type(Options) ~= "table" then
        return Result
    end

    for _, Value in ipairs(Options) do
        table.insert(Result, tostring(Value))
    end

    return Result
end

function Dropdown.Create(TabObject, OTC, Settings)
    Settings = Settings or {}

    local Name = Settings.Name or "Dropdown"
    local Options = NormalizeOptions(Settings.Options or {})
    local MultiSelect = Settings.MultiSelect == true
    local Callback = Settings.Callback or function() end

    local Theme = OTC:GetTheme()

    ----------------------------------------------------------------
    -- CONFIG
    ----------------------------------------------------------------

    local DROPDOWN_WIDTH = Settings.Width or 260
    local OPTION_HEIGHT = 32
    local SEARCH_HEIGHT = 36

    local MIN_HEIGHT = 92
    local MAX_HEIGHT = 260

    local OPEN_OFFSET = 5

    ----------------------------------------------------------------
    -- MAIN FRAME
    ----------------------------------------------------------------

    local Frame = Create("Frame", {
        Name = "Dropdown",
        Parent = TabObject.Page,

        Size = UDim2.new(1, 0, 0, 48),

        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,

        ClipsDescendants = false,

        ZIndex = 10
    })

    Create("UICorner", {
        Parent = Frame,
        CornerRadius = UDim.new(0, 6)
    })

    Create("UIStroke", {
        Parent = Frame,
        Color = Theme.Border,
        Thickness = 1
    })

    ----------------------------------------------------------------
    -- NAME
    ----------------------------------------------------------------

    local NameLabel = Create("TextLabel", {
        Name = "Name",
        Parent = Frame,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(14, 0),
        Size = UDim2.new(0.48, -14, 1, 0),

        Font = Enum.Font.GothamMedium,

        Text = Name,
        TextColor3 = Theme.Text,
        TextSize = 14,

        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,

        ZIndex = 11
    })

    ----------------------------------------------------------------
    -- VALUE
    ----------------------------------------------------------------

    local ValueLabel = Create("TextLabel", {
        Name = "Value",
        Parent = Frame,

        BackgroundTransparency = 1,

        Position = UDim2.new(0.48, 0, 0, 0),
        Size = UDim2.new(0.52, -42, 1, 0),

        Font = Enum.Font.Gotham,

        Text = "",
        TextColor3 = Theme.SubText,
        TextSize = 13,

        TextXAlignment = Enum.TextXAlignment.Right,
        TextTruncate = Enum.TextTruncate.AtEnd,

        ZIndex = 11
    })

    ----------------------------------------------------------------
    -- ARROW
    ----------------------------------------------------------------

    local Arrow = Create("TextLabel", {
        Name = "Arrow",
        Parent = Frame,

        BackgroundTransparency = 1,

        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),

        Size = UDim2.fromOffset(18, 18),

        Font = Enum.Font.GothamBold,

        Text = "⌄",
        TextColor3 = Theme.SubText,
        TextSize = 16,

        ZIndex = 11
    })

    ----------------------------------------------------------------
    -- BUTTON
    ----------------------------------------------------------------

    local Button = Create("TextButton", {
        Name = "Button",
        Parent = Frame,

        BackgroundTransparency = 1,

        Size = UDim2.fromScale(1, 1),

        Text = "",
        AutoButtonColor = false,

        ZIndex = 12
    })

    ----------------------------------------------------------------
    -- SCREEN GUI
    ----------------------------------------------------------------

    local ScreenGui

    if TabObject.Window and TabObject.Window.ScreenGui then
        ScreenGui = TabObject.Window.ScreenGui
    elseif OTC.Window and OTC.Window.ScreenGui then
        ScreenGui = OTC.Window.ScreenGui
    end

    if not ScreenGui then
        error("[OTC Hub] Dropdown could not find ScreenGui")
    end

    ----------------------------------------------------------------
    -- GLOBAL DROPDOWN OVERLAY
    ----------------------------------------------------------------

    local Overlay = ScreenGui:FindFirstChild("OTC_DropdownOverlay")

    if not Overlay then
        Overlay = Create("Frame", {
            Name = "OTC_DropdownOverlay",
            Parent = ScreenGui,

            BackgroundTransparency = 1,
            BorderSizePixel = 0,

            Position = UDim2.fromScale(0, 0),
            Size = UDim2.fromScale(1, 1),

            ClipsDescendants = false,

            ZIndex = 1000
        })
    end

    ----------------------------------------------------------------
    -- DROPDOWN FRAME
    ----------------------------------------------------------------

    local DropdownFrame = Create("Frame", {
        Name = "DropdownFrame",
        Parent = Overlay,

        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,

        Size = UDim2.fromOffset(
            DROPDOWN_WIDTH,
            MIN_HEIGHT
        ),

        Position = UDim2.fromOffset(0, 0),

        Visible = false,

        ClipsDescendants = false,

        ZIndex = 1001
    })

    Create("UICorner", {
        Parent = DropdownFrame,
        CornerRadius = UDim.new(0, 7)
    })

    Create("UIStroke", {
        Parent = DropdownFrame,
        Color = Theme.Border,
        Thickness = 1
    })

    ----------------------------------------------------------------
    -- SEARCH FRAME
    ----------------------------------------------------------------

    local SearchFrame = Create("Frame", {
        Name = "SearchFrame",
        Parent = DropdownFrame,

        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,

        Position = UDim2.fromOffset(7, 7),

        Size = UDim2.new(
            1,
            -14,
            0,
            SEARCH_HEIGHT
        ),

        ZIndex = 1002
    })

    Create("UICorner", {
        Parent = SearchFrame,
        CornerRadius = UDim.new(0, 5)
    })

    ----------------------------------------------------------------
    -- SEARCH ICON
    ----------------------------------------------------------------

    local SearchIcon = Create("TextLabel", {
        Name = "Icon",
        Parent = SearchFrame,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(8, 0),
        Size = UDim2.fromOffset(22, SEARCH_HEIGHT),

        Font = Enum.Font.Gotham,

        Text = "⌕",
        TextColor3 = Theme.SubText,
        TextSize = 18,

        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,

        ZIndex = 1003
    })

    if OTC._Lucide then
        local LucideIcon = OTC._Lucide:GetIcon("search")

        if LucideIcon then
            SearchIcon.Text = ""

            Create("ImageLabel", {
                Name = "LucideIcon",
                Parent = SearchFrame,

                BackgroundTransparency = 1,

                Position = UDim2.fromOffset(10, 9),
                Size = UDim2.fromOffset(18, 18),

                Image = LucideIcon.Url,

                ImageColor3 = Theme.SubText,

                ImageRectSize = LucideIcon.ImageRectSize,
                ImageRectOffset = LucideIcon.ImageRectOffset,

                ZIndex = 1003
            })
        end
    end

    ----------------------------------------------------------------
    -- SEARCH BOX
    ----------------------------------------------------------------

    local SearchBox = Create("TextBox", {
        Name = "SearchBox",
        Parent = SearchFrame,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(35, 0),

        Size = UDim2.new(
            1,
            -42,
            1,
            0
        ),

        Font = Enum.Font.Gotham,

        PlaceholderText = "Search...",
        PlaceholderColor3 = Theme.SubText,

        Text = "",
        TextColor3 = Theme.Text,
        TextSize = 13,

        ClearTextOnFocus = false,

        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,

        ZIndex = 1003
    })

    ----------------------------------------------------------------
    -- OPTIONS LIST
    ----------------------------------------------------------------

    local OptionsList = Create("ScrollingFrame", {
        Name = "Options",

        Parent = DropdownFrame,

        BackgroundTransparency = 1,
        BorderSizePixel = 0,

        Position = UDim2.fromOffset(
            7,
            SEARCH_HEIGHT + 14
        ),

        Size = UDim2.new(
            1,
            -14,
            1,
            -(SEARCH_HEIGHT + 21)
        ),

        CanvasSize = UDim2.new(0, 0, 0, 0),

        AutomaticCanvasSize = Enum.AutomaticSize.Y,

        ScrollBarThickness = 3,

        ScrollBarImageColor3 = Theme.SubText,

        ScrollingDirection = Enum.ScrollingDirection.Y,

        ClipsDescendants = true,

        ZIndex = 1002
    })

    Create("UIListLayout", {
        Parent = OptionsList,

        Padding = UDim.new(0, 4),

        SortOrder = Enum.SortOrder.LayoutOrder
    })

    Create("UIPadding", {
        Parent = OptionsList,

        PaddingBottom = UDim.new(0, 4)
    })

    ----------------------------------------------------------------
    -- STATE
    ----------------------------------------------------------------

    local Selected = {}

    if MultiSelect then
        if type(Settings.CurrentOption) == "table" then
            for _, Value in ipairs(Settings.CurrentOption) do
                Selected[tostring(Value)] = true
            end
        end
    else
        if Settings.CurrentOption ~= nil then
            Selected[tostring(Settings.CurrentOption)] = true
        elseif #Options > 0 then
            Selected[Options[1]] = true
        end
    end

    local OptionObjects = {}

    local Object = {}

    local Open = false
    local RenderConnection = nil

    ----------------------------------------------------------------
    -- UPDATE VALUE
    ----------------------------------------------------------------

    local function UpdateValueText()
        if MultiSelect then
            local Count = 0

            for _, Option in ipairs(Options) do
                if Selected[Option] then
                    Count += 1
                end
            end

            if Count == 0 then
                ValueLabel.Text = "None"
            else
                ValueLabel.Text = tostring(Count) .. " Selected"
            end

            return
        end

        local Current = nil

        for _, Option in ipairs(Options) do
            if Selected[Option] then
                Current = Option
                break
            end
        end

        ValueLabel.Text = Current or "None"
    end

    ----------------------------------------------------------------
    -- CALLBACK
    ----------------------------------------------------------------

    local function FireCallback()
        if MultiSelect then
            local Values = {}

            for _, Option in ipairs(Options) do
                if Selected[Option] then
                    table.insert(Values, Option)
                end
            end

            task.spawn(function()
                pcall(Callback, Values)
            end)
        else
            local Current

            for _, Option in ipairs(Options) do
                if Selected[Option] then
                    Current = Option
                    break
                end
            end

            task.spawn(function()
                pcall(Callback, Current)
            end)
        end
    end

    ----------------------------------------------------------------
    -- CALCULATE HEIGHT
    ----------------------------------------------------------------

    local function CalculateHeight()
        local SearchSpace = SEARCH_HEIGHT + 21

        local VisibleCount = 0

        for _, OptionObject in pairs(OptionObjects) do
            if OptionObject.Button.Visible then
                VisibleCount += 1
            end
        end

        if VisibleCount <= 0 then
            return MIN_HEIGHT
        end

        local ContentHeight =
            VisibleCount * OPTION_HEIGHT
            + math.max(0, VisibleCount - 1) * 4
            + 8

        local Height =
            SearchSpace
            + ContentHeight

        return math.clamp(
            Height,
            MIN_HEIGHT,
            MAX_HEIGHT
        )
    end

    ----------------------------------------------------------------
    -- UPDATE SIZE
    ----------------------------------------------------------------

    local function UpdateSize()
        local Height = CalculateHeight()

        DropdownFrame.Size = UDim2.fromOffset(
            DROPDOWN_WIDTH,
            Height
        )

        OptionsList.CanvasPosition =
            Vector2.new(
                OptionsList.CanvasPosition.X,
                0
            )
    end

    ----------------------------------------------------------------
    -- UPDATE POSITION
    ----------------------------------------------------------------

    local function UpdatePosition()
        if not Open then
            return
        end

        local Camera = workspace.CurrentCamera

        if not Camera then
            return
        end

        local Viewport = Camera.ViewportSize

        local ButtonPosition = Button.AbsolutePosition
        local ButtonSize = Button.AbsoluteSize

        local DropdownSize = DropdownFrame.AbsoluteSize

        local X = ButtonPosition.X

        local BelowY =
            ButtonPosition.Y
            + ButtonSize.Y
            + OPEN_OFFSET

        local AboveY =
            ButtonPosition.Y
            - DropdownSize.Y
            - OPEN_OFFSET

        local Y = BelowY

        ------------------------------------------------------------
        -- HORIZONTAL
        ------------------------------------------------------------

        if X + DropdownSize.X > Viewport.X - 8 then
            X = Viewport.X - DropdownSize.X - 8
        end

        if X < 8 then
            X = 8
        end

        ------------------------------------------------------------
        -- VERTICAL
        ------------------------------------------------------------

        if BelowY + DropdownSize.Y > Viewport.Y - 8 then
            Y = AboveY
        end

        if Y < 8 then
            Y = 8
        end

        DropdownFrame.Position = UDim2.fromOffset(
            math.floor(X),
            math.floor(Y)
        )
    end

    ----------------------------------------------------------------
    -- REFRESH OPTIONS
    ----------------------------------------------------------------

    local function RefreshOption(Option)
        local OptionObject = OptionObjects[Option]

        if not OptionObject then
            return
        end

        local IsSelected =
            Selected[Option] == true

        if IsSelected then
            OptionObject.Check.Text = "✓"

            OptionObject.Button.BackgroundColor3 =
                Theme.Hover
        else
            OptionObject.Check.Text = ""

            OptionObject.Button.BackgroundColor3 =
                Theme.Element
        end
    end

    ----------------------------------------------------------------
    -- CLOSE
    ----------------------------------------------------------------

    function Object:Close()
        if not Open then
            return
        end

        Open = false

        if RenderConnection then
            RenderConnection:Disconnect()
            RenderConnection = nil
        end

        if OTC._OpenDropdown == Object then
            OTC._OpenDropdown = nil
        end

        if OTC.Tween then
            OTC:Tween(
                DropdownFrame,
                0.12,
                {
                    BackgroundTransparency = 1
                }
            )

            OTC:Tween(
                Arrow,
                0.12,
                {
                    Rotation = 0
                }
            )

            task.delay(0.12, function()
                if not Open then
                    DropdownFrame.Visible = false
                    DropdownFrame.BackgroundTransparency = 0
                end
            end)
        else
            DropdownFrame.Visible = false
            Arrow.Rotation = 0
        end
    end

    ----------------------------------------------------------------
    -- OPEN
    ----------------------------------------------------------------

    function Object:Open()
        if Open then
            return
        end

        if OTC._OpenDropdown
            and OTC._OpenDropdown ~= Object then

            pcall(function()
                OTC._OpenDropdown:Close()
            end)
        end

        OTC._OpenDropdown = Object

        Open = true

        DropdownFrame.Visible = true
        DropdownFrame.BackgroundTransparency = 1

        UpdateSize()
        UpdatePosition()

        if OTC.Tween then
            OTC:Tween(
                DropdownFrame,
                0.14,
                {
                    BackgroundTransparency = 0
                }
            )

            OTC:Tween(
                Arrow,
                0.14,
                {
                    Rotation = 180
                }
            )
        else
            DropdownFrame.BackgroundTransparency = 0
            Arrow.Rotation = 180
        end

        ------------------------------------------------------------
        -- FOLLOW BUTTON
        ------------------------------------------------------------

        local RunService = game:GetService("RunService")

        RenderConnection =
            RunService.RenderStepped:Connect(function()
                if not Open then
                    return
                end

                if not Button.Parent then
                    Object:Close()
                    return
                end

                UpdatePosition()
            end)
    end

    ----------------------------------------------------------------
    -- CREATE OPTION
    ----------------------------------------------------------------

    local function CreateOption(Option)
        local OptionButton = Create("TextButton", {
            Name = "Option_" .. Option,

            Parent = OptionsList,

            BackgroundColor3 = Theme.Element,
            BorderSizePixel = 0,

            Size = UDim2.new(
                1,
                -2,
                0,
                OPTION_HEIGHT
            ),

            Font = Enum.Font.Gotham,

            Text = "",

            AutoButtonColor = false,

            ZIndex = 1003
        })

        Create("UICorner", {
            Parent = OptionButton,

            CornerRadius = UDim.new(0, 5)
        })

        local OptionLabel = Create("TextLabel", {
            Name = "Label",

            Parent = OptionButton,

            BackgroundTransparency = 1,

            Position = UDim2.fromOffset(10, 0),

            Size = UDim2.new(
                1,
                -45,
                1,
                0
            ),

            Font = Enum.Font.Gotham,

            Text = Option,

            TextColor3 = Theme.Text,

            TextSize = 13,

            TextXAlignment = Enum.TextXAlignment.Left,

            TextTruncate = Enum.TextTruncate.AtEnd,

            ZIndex = 1004
        })

        local Check = Create("TextLabel", {
            Name = "Check",

            Parent = OptionButton,

            BackgroundTransparency = 1,

            AnchorPoint = Vector2.new(1, 0.5),

            Position = UDim2.new(
                1,
                -9,
                0.5,
                0
            ),

            Size = UDim2.fromOffset(22, 22),

            Font = Enum.Font.GothamBold,

            Text = "",

            TextColor3 = Theme.Text,

            TextSize = 15,

            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,

            ZIndex = 1004
        })

        local OptionObject = {
            Button = OptionButton,
            Label = OptionLabel,
            Check = Check,
            Name = Option
        }

        OptionObjects[Option] = OptionObject

        ----------------------------------------------------------------
        -- HOVER
        ----------------------------------------------------------------

        OptionButton.MouseEnter:Connect(function()
            if OTC.Tween then
                OTC:Tween(
                    OptionButton,
                    0.08,
                    {
                        BackgroundColor3 = Theme.Hover
                    }
                )
            else
                OptionButton.BackgroundColor3 =
                    Theme.Hover
            end
        end)

        OptionButton.MouseLeave:Connect(function()
            if Selected[Option] then
                OptionButton.BackgroundColor3 =
                    Theme.Hover
            else
                OptionButton.BackgroundColor3 =
                    Theme.Element
            end
        end)

        ----------------------------------------------------------------
        -- CLICK
        ----------------------------------------------------------------

        OptionButton.MouseButton1Click:Connect(function()
            if MultiSelect then
                Selected[Option] =
                    not Selected[Option]

                RefreshOption(Option)

                UpdateValueText()

                FireCallback()

                return
            end

            ------------------------------------------------------------
            -- NORMAL DROPDOWN
            ------------------------------------------------------------

            for _, Existing in ipairs(Options) do
                Selected[Existing] = false
            end

            Selected[Option] = true

            for _, Existing in ipairs(Options) do
                RefreshOption(Existing)
            end

            UpdateValueText()

            FireCallback()

            Object:Close()
        end)

        RefreshOption(Option)

        return OptionObject
    end

    ----------------------------------------------------------------
    -- REBUILD OPTIONS
    ----------------------------------------------------------------

    local function RebuildOptions()
        for _, Child in ipairs(OptionsList:GetChildren()) do
            if Child:IsA("TextButton") then
                Child:Destroy()
            end
        end

        OptionObjects = {}

        local SearchText =
            string.lower(SearchBox.Text or "")

        for _, Option in ipairs(Options) do
            local LowerOption =
                string.lower(Option)

            local Matches =
                SearchText == ""
                or string.find(
                    LowerOption,
                    SearchText,
                    1,
                    true
                )

            if Matches then
                CreateOption(Option)
            end
        end

        UpdateValueText()
        UpdateSize()

        if Open then
            task.defer(UpdatePosition)
        end
    end

    ----------------------------------------------------------------
    -- SEARCH
    ----------------------------------------------------------------

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        RebuildOptions()
    end)

    ----------------------------------------------------------------
    -- MAIN HOVER
    ----------------------------------------------------------------

    Button.MouseEnter:Connect(function()
        if OTC.Tween then
            OTC:Tween(
                Frame,
                0.08,
                {
                    BackgroundColor3 = Theme.Hover
                }
            )
        else
            Frame.BackgroundColor3 =
                Theme.Hover
        end
    end)

    Button.MouseLeave:Connect(function()
        if OTC.Tween then
            OTC:Tween(
                Frame,
                0.08,
                {
                    BackgroundColor3 = Theme.Element
                }
            )
        else
            Frame.BackgroundColor3 =
                Theme.Element
        end
    end)

    ----------------------------------------------------------------
    -- MAIN CLICK
    ----------------------------------------------------------------

    Button.MouseButton1Click:Connect(function()
        if Open then
            Object:Close()
        else
            Object:Open()
        end
    end)

    ----------------------------------------------------------------
    -- SET VALUE
    ----------------------------------------------------------------

    function Object:SetValue(Value)
        if MultiSelect then
            if type(Value) ~= "table" then
                return
            end

            Selected = {}

            for _, Item in ipairs(Value) do
                Selected[tostring(Item)] = true
            end
        else
            Value = tostring(Value)

            Selected = {}

            if table.find(Options, Value) then
                Selected[Value] = true
            end
        end

        RebuildOptions()
        FireCallback()
    end

    ----------------------------------------------------------------
    -- GET VALUE
    ----------------------------------------------------------------

    function Object:GetValue()
        if MultiSelect then
            local Values = {}

            for _, Option in ipairs(Options) do
                if Selected[Option] then
                    table.insert(Values, Option)
                end
            end

            return Values
        end

        for _, Option in ipairs(Options) do
            if Selected[Option] then
                return Option
            end
        end

        return nil
    end

    ----------------------------------------------------------------
    -- SET OPTIONS
    ----------------------------------------------------------------

    function Object:SetOptions(NewOptions)
        Options = NormalizeOptions(NewOptions)

        local NewSelected = {}

        for _, Option in ipairs(Options) do
            if Selected[Option] then
                NewSelected[Option] = true
            end
        end

        Selected = NewSelected

        if not MultiSelect
            and not next(Selected)
            and #Options > 0 then

            Selected[Options[1]] = true
        end

        RebuildOptions()
    end

    ----------------------------------------------------------------
    -- ADD OPTION
    ----------------------------------------------------------------

    function Object:AddOption(Option)
        Option = tostring(Option)

        if table.find(Options, Option) then
            return
        end

        table.insert(Options, Option)

        RebuildOptions()
    end

    ----------------------------------------------------------------
    -- REMOVE OPTION
    ----------------------------------------------------------------

    function Object:RemoveOption(Option)
        Option = tostring(Option)

        local Index =
            table.find(Options, Option)

        if Index then
            table.remove(Options, Index)
        end

        Selected[Option] = nil

        RebuildOptions()
    end

    ----------------------------------------------------------------
    -- SET NAME
    ----------------------------------------------------------------

    function Object:SetName(NewName)
        Name = tostring(NewName)

        NameLabel.Text = Name
    end

    ----------------------------------------------------------------
    -- SET CALLBACK
    ----------------------------------------------------------------

    function Object:SetCallback(NewCallback)
        if type(NewCallback) == "function" then
            Callback = NewCallback
        end
    end

    ----------------------------------------------------------------
    -- CLEAR SEARCH
    ----------------------------------------------------------------

    function Object:ClearSearch()
        SearchBox.Text = ""
    end

    ----------------------------------------------------------------
    -- DESTROY
    ----------------------------------------------------------------

    function Object:Destroy()
        Object:Close()

        if DropdownFrame then
            DropdownFrame:Destroy()
        end

        if Frame then
            Frame:Destroy()
        end
    end

    ----------------------------------------------------------------
    -- PUBLIC REFERENCES
    ----------------------------------------------------------------

    Object.Frame = Frame
    Object.Button = Button

    Object.DropdownFrame = DropdownFrame

    Object.SearchBox = SearchBox
    Object.OptionsList = OptionsList

    Object.MultiSelect = MultiSelect

    ----------------------------------------------------------------
    -- ADD TO TAB
    ----------------------------------------------------------------

    if TabObject.AddElement then
        TabObject:AddElement(Frame)
    end

    ----------------------------------------------------------------
    -- INITIAL BUILD
    ----------------------------------------------------------------

    RebuildOptions()

    return Object
end

return Dropdown