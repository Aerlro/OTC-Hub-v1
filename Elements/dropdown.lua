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
    -- MAIN ELEMENT
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
        Thickness = 1,
        Transparency = 0
    })

    ----------------------------------------------------------------
    -- NAME
    ----------------------------------------------------------------

    local NameLabel = Create("TextLabel", {
        Name = "Name",
        Parent = Frame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(0.5, -14, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = Name,
        TextColor3 = Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 11
    })

    ----------------------------------------------------------------
    -- VALUE
    ----------------------------------------------------------------

    local ValueLabel = Create("TextLabel", {
        Name = "Value",
        Parent = Frame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0, 0),
        Size = UDim2.new(0.5, -38, 1, 0),
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
        Size = UDim2.new(0, 18, 0, 18),
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
    -- FLOATING OVERLAY
    --
    -- IMPORTANT:
    -- DropdownFrame NU mai este copilul lui Frame.
    -- Este pus direct în ScreenGui pentru a nu fi afectat
    -- de UIListLayout / ScrollingFrame / ClipsDescendants.
    ----------------------------------------------------------------

    local ScreenGui = TabObject.Window and TabObject.Window.ScreenGui

    if not ScreenGui then
        ScreenGui = OTC.Window and OTC.Window.ScreenGui
    end

    if not ScreenGui then
        error("[OTC Hub] Could not find ScreenGui for dropdown overlay")
    end

    local Overlay = ScreenGui:FindFirstChild("OTC_DropdownOverlay")

    if not Overlay then
        Overlay = Create("Frame", {
            Name = "OTC_DropdownOverlay",
            Parent = ScreenGui,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(0, 0),
            Size = UDim2.fromScale(1, 1),
            ZIndex = 1000,
            ClipsDescendants = false
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
        Size = UDim2.fromOffset(260, 220),
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
    -- SEARCH
    ----------------------------------------------------------------

    local SearchFrame = Create("Frame", {
        Name = "SearchFrame",
        Parent = DropdownFrame,
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(7, 7),
        Size = UDim2.new(1, -14, 0, 36),
        ZIndex = 1002
    })

    Create("UICorner", {
        Parent = SearchFrame,
        CornerRadius = UDim.new(0, 5)
    })

    local SearchIcon = Create("TextLabel", {
        Name = "Icon",
        Parent = SearchFrame,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(8, 0),
        Size = UDim2.fromOffset(24, 36),
        Font = Enum.Font.Gotham,
        Text = "⌕",
        TextColor3 = Theme.SubText,
        TextSize = 18,
        ZIndex = 1003
    })

    -- Lucide search icon
    if OTC._Lucide then
        local LucideIcon = OTC._Lucide:GetIcon("search")

        if LucideIcon then
            SearchIcon.Text = ""

            local Image = Create("ImageLabel", {
                Name = "LucideIcon",
                Parent = SearchFrame,
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(9, 9),
                Size = UDim2.fromOffset(18, 18),
                Image = LucideIcon.Url,
                ImageColor3 = Theme.SubText,
                ImageRectSize = LucideIcon.ImageRectSize,
                ImageRectOffset = LucideIcon.ImageRectOffset,
                ZIndex = 1003
            })
        end
    end

    local SearchBox = Create("TextBox", {
        Name = "SearchBox",
        Parent = SearchFrame,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(34, 0),
        Size = UDim2.new(1, -42, 1, 0),
        Font = Enum.Font.Gotham,
        PlaceholderText = "Search...",
        PlaceholderColor3 = Theme.SubText,
        Text = "",
        TextColor3 = Theme.Text,
        TextSize = 13,
        ClearTextOnFocus = false,
        TextXAlignment = Enum.TextXAlignment.Left,
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
        Position = UDim2.fromOffset(7, 50),
        Size = UDim2.new(1, -14, 1, -57),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Theme.SubText,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ZIndex = 1002
    })

    local OptionsLayout = Create("UIListLayout", {
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
    -- VALUE TEXT
    ----------------------------------------------------------------

    local function UpdateValueText()
        if MultiSelect then
            local Values = {}

            for _, Option in ipairs(Options) do
                if Selected[Option] then
                    table.insert(Values, Option)
                end
            end

            if #Values == 0 then
                ValueLabel.Text = "None"
            else
                ValueLabel.Text = table.concat(Values, ", ")
            end
        else
            local Current = nil

            for _, Option in ipairs(Options) do
                if Selected[Option] then
                    Current = Option
                    break
                end
            end

            ValueLabel.Text = Current or "None"
        end
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
            local Current = nil

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
    -- UPDATE POSITION
    ----------------------------------------------------------------

    local function UpdatePosition()
        if not DropdownFrame.Visible then
            return
        end

        local ButtonPosition = Button.AbsolutePosition
        local ButtonSize = Button.AbsoluteSize

        local Camera = workspace.CurrentCamera

        if not Camera then
            return
        end

        local Viewport = Camera.ViewportSize

        local DropdownSize = DropdownFrame.AbsoluteSize

        local X = ButtonPosition.X
        local Y = ButtonPosition.Y + ButtonSize.Y + 5

        -- Nu lăsa dropdown-ul să iasă în dreapta ecranului
        if X + DropdownSize.X > Viewport.X - 8 then
            X = Viewport.X - DropdownSize.X - 8
        end

        if X < 8 then
            X = 8
        end

        -- Dacă nu încape jos, îl deschidem în sus
        if Y + DropdownSize.Y > Viewport.Y - 8 then
            Y = ButtonPosition.Y - DropdownSize.Y - 5
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
    -- UPDATE HEIGHT
    ----------------------------------------------------------------

    local function UpdateSize()
        local Count = 0

        for _, OptionObject in pairs(OptionObjects) do
            if OptionObject.Visible then
                Count += 1
            end
        end

        local Height = 50 + math.min(
            math.max(Count, 1) * 34 + 4,
            210
        )

        DropdownFrame.Size = UDim2.fromOffset(
            260,
            Height
        )

        task.defer(UpdatePosition)
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

            task.delay(0.12, function()
                if not Open then
                    DropdownFrame.Visible = false
                    DropdownFrame.BackgroundTransparency = 0
                end
            end)
        else
            DropdownFrame.Visible = false
        end

        if OTC.Tween then
            OTC:Tween(
                Arrow,
                0.12,
                {
                    Rotation = 0
                }
            )
        else
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

        -- Închide orice alt dropdown OTC
        if OTC._OpenDropdown and OTC._OpenDropdown ~= Object then
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
                0.16,
                {
                    BackgroundTransparency = 0
                }
            )

            OTC:Tween(
                Arrow,
                0.16,
                {
                    Rotation = 180
                }
            )
        else
            DropdownFrame.BackgroundTransparency = 0
            Arrow.Rotation = 180
        end

        ----------------------------------------------------------------
        -- Keep dropdown attached to button while scrolling
        ----------------------------------------------------------------

        local RunService = game:GetService("RunService")

        RenderConnection = RunService.RenderStepped:Connect(function()
            if not Open then
                return
            end

            if not Button.Parent or not Frame.Parent then
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
            Name = "Option",
            Parent = OptionsList,
            BackgroundColor3 = Theme.Element,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -2, 0, 30),
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
            Size = UDim2.new(1, -40, 1, 0),
            Font = Enum.Font.Gotham,
            Text = Option,
            TextColor3 = Theme.Text,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 1004
        })

        local Check = Create("TextLabel", {
            Name = "Check",
            Parent = OptionButton,
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -9, 0.5, 0),
            Size = UDim2.fromOffset(20, 20),
            Font = Enum.Font.GothamBold,
            Text = "",
            TextColor3 = Theme.Text,
            TextSize = 15,
            ZIndex = 1004
        })

        local OptionObject = {
            Button = OptionButton,
            Label = OptionLabel,
            Check = Check,
            Name = Option
        }

        OptionObjects[Option] = OptionObject

        local function Refresh()
            local IsSelected = Selected[Option] == true

            if IsSelected then
                Check.Text = "✓"
            else
                Check.Text = ""
            end

            if IsSelected then
                OptionButton.BackgroundColor3 = Theme.Hover
            else
                OptionButton.BackgroundColor3 = Theme.Element
            end
        end

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
                OptionButton.BackgroundColor3 = Theme.Hover
            end
        end)

        OptionButton.MouseLeave:Connect(function()
            if Selected[Option] then
                OptionButton.BackgroundColor3 = Theme.Hover
            else
                OptionButton.BackgroundColor3 = Theme.Element
            end
        end)

        OptionButton.MouseButton1Click:Connect(function()
            if MultiSelect then
                Selected[Option] = not Selected[Option]

                Refresh()
                UpdateValueText()
                FireCallback()
            else
                for _, Existing in ipairs(Options) do
                    Selected[Existing] = false
                end

                Selected[Option] = true

                for _, ExistingObject in pairs(OptionObjects) do
                    local IsSelected = Selected[ExistingObject.Name] == true

                    ExistingObject.Check.Text = IsSelected and "✓" or ""

                    if IsSelected then
                        ExistingObject.Button.BackgroundColor3 = Theme.Hover
                    else
                        ExistingObject.Button.BackgroundColor3 = Theme.Element
                    end
                end

                UpdateValueText()
                FireCallback()

                Object:Close()
            end
        end)

        Refresh()

        return OptionObject
    end

    ----------------------------------------------------------------
    -- BUILD OPTIONS
    ----------------------------------------------------------------

    local function RebuildOptions()
        for _, Child in ipairs(OptionsList:GetChildren()) do
            if Child:IsA("TextButton") then
                Child:Destroy()
            end
        end

        OptionObjects = {}

        local SearchText = string.lower(SearchBox.Text or "")

        for _, Option in ipairs(Options) do
            if SearchText == ""
                or string.find(
                    string.lower(Option),
                    SearchText,
                    1,
                    true
                )
            then
                CreateOption(Option)
            end
        end

        UpdateValueText()
        UpdateSize()
    end

    ----------------------------------------------------------------
    -- SEARCH
    ----------------------------------------------------------------

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        RebuildOptions()
    end)

    ----------------------------------------------------------------
    -- MAIN BUTTON
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
            Frame.BackgroundColor3 = Theme.Hover
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
            Frame.BackgroundColor3 = Theme.Element
        end
    end)

    Button.MouseButton1Click:Connect(function()
        if Open then
            Object:Close()
        else
            Object:Open()
        end
    end)

    ----------------------------------------------------------------
    -- PUBLIC METHODS
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

    function Object:SetOptions(NewOptions)
        Options = NormalizeOptions(NewOptions)

        local NewSelected = {}

        for _, Option in ipairs(Options) do
            if Selected[Option] then
                NewSelected[Option] = true
            end
        end

        Selected = NewSelected

        if not MultiSelect and not next(Selected) and #Options > 0 then
            Selected[Options[1]] = true
        end

        RebuildOptions()
    end

    function Object:AddOption(Option)
        Option = tostring(Option)

        if table.find(Options, Option) then
            return
        end

        table.insert(Options, Option)

        RebuildOptions()
    end

    function Object:RemoveOption(Option)
        Option = tostring(Option)

        local Index = table.find(Options, Option)

        if Index then
            table.remove(Options, Index)
        end

        Selected[Option] = nil

        RebuildOptions()
    end

    function Object:SetName(NewName)
        Name = tostring(NewName)
        NameLabel.Text = Name
    end

    function Object:SetCallback(NewCallback)
        if type(NewCallback) == "function" then
            Callback = NewCallback
        end
    end

    function Object:ClearSearch()
        SearchBox.Text = ""
    end

    function Object:Destroy()
        Object:Close()

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