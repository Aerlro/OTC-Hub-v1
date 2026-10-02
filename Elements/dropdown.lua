--[[
    OTC Hub v1
    Dropdown Element
    by Aerlro
]]

return function(Parent, Settings, OTC)

    Settings = Settings or {}

    local Theme = OTC:GetTheme()

    local Options = Settings.Options or {}
    local MultiSelect = Settings.MultiSelect == true

    local CurrentOption = Settings.CurrentOption

    if MultiSelect then
        if type(CurrentOption) ~= "table" then
            CurrentOption = {}
        end
    else
        if type(CurrentOption) == "table" then
            CurrentOption = CurrentOption[1]
        end

        CurrentOption = CurrentOption or Options[1]
    end

    local Object = {}

    local Opened = false

    --------------------------------------------------
    -- CREATE
    --------------------------------------------------

    local function create(ClassName, Properties)

        local InstanceObject = Instance.new(ClassName)

        for Property, Value in pairs(Properties or {}) do
            InstanceObject[Property] = Value
        end

        return InstanceObject
    end

    --------------------------------------------------
    -- MAIN FRAME
    --------------------------------------------------

    local Frame = create("Frame", {
        Name = "Dropdown",
        Parent = Parent,

        BackgroundTransparency = 1,
        BorderSizePixel = 0,

        Size = UDim2.new(1, 0, 0, 48),

        ClipsDescendants = false,

        ZIndex = 10
    })

    --------------------------------------------------
    -- BUTTON
    --------------------------------------------------

    local Button = create("TextButton", {
        Name = "Button",
        Parent = Frame,

        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,

        Size = UDim2.new(1, 0, 0, 48),

        Text = "",

        AutoButtonColor = false,

        ZIndex = 11
    })

    create("UICorner", {
        Parent = Button,
        CornerRadius = UDim.new(0, 8)
    })

    --------------------------------------------------
    -- NAME
    --------------------------------------------------

    local NameLabel = create("TextLabel", {
        Name = "Name",
        Parent = Button,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(14, 5),
        Size = UDim2.new(1, -50, 0, 18),

        Font = Enum.Font.GothamMedium,

        Text = Settings.Name or "Dropdown",

        TextColor3 = Theme.Text,
        TextSize = 13,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 12
    })

    --------------------------------------------------
    -- VALUE
    --------------------------------------------------

    local ValueLabel = create("TextLabel", {
        Name = "Value",
        Parent = Button,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(14, 24),
        Size = UDim2.new(1, -50, 0, 16),

        Font = Enum.Font.Gotham,

        TextColor3 = Theme.SubText,
        TextSize = 11,

        TextXAlignment = Enum.TextXAlignment.Left,

        TextTruncate = Enum.TextTruncate.AtEnd,

        ZIndex = 12
    })

    --------------------------------------------------
    -- ARROW
    --------------------------------------------------

    local Arrow = create("TextLabel", {
        Name = "Arrow",
        Parent = Button,

        BackgroundTransparency = 1,

        AnchorPoint = Vector2.new(1, 0.5),

        Position = UDim2.new(1, -14, 0.5, 0),

        Size = UDim2.fromOffset(20, 20),

        Font = Enum.Font.GothamBold,

        Text = "⌄",

        TextColor3 = Theme.SubText,
        TextSize = 16,

        ZIndex = 12
    })

    --------------------------------------------------
    -- DROPDOWN FRAME
    --------------------------------------------------

    local DropdownFrame = create("Frame", {
        Name = "DropdownFrame",

        Parent = Frame,

        BackgroundColor3 = Theme.Secondary,

        BorderSizePixel = 0,

        Position = UDim2.new(0, 0, 0, 53),

        Size = UDim2.new(1, 0, 0, 0),

        Visible = false,

        ClipsDescendants = true,

        ZIndex = 100
    })

    create("UICorner", {
        Parent = DropdownFrame,
        CornerRadius = UDim.new(0, 8)
    })

    create("UIStroke", {
        Parent = DropdownFrame,

        Color = Theme.Border,
        Thickness = 1
    })

    --------------------------------------------------
    -- SEARCH FRAME
    --------------------------------------------------

    local SearchFrame = create("Frame", {
        Name = "Search",

        Parent = DropdownFrame,

        BackgroundColor3 = Theme.Element,

        BorderSizePixel = 0,

        Position = UDim2.fromOffset(7, 7),

        Size = UDim2.new(1, -14, 0, 36),

        ZIndex = 101
    })

    create("UICorner", {
        Parent = SearchFrame,

        CornerRadius = UDim.new(0, 7)
    })

    --------------------------------------------------
    -- SEARCH ICON
    --------------------------------------------------

    local SearchIcon

    if OTC._Lucide
        and OTC._Lucide.Available then

        local IconData =
            OTC._Lucide:GetIcon("search")

        if IconData then

            SearchIcon = create("ImageLabel", {
                Name = "Icon",

                Parent = SearchFrame,

                BackgroundTransparency = 1,

                Position = UDim2.fromOffset(10, 8),

                Size = UDim2.fromOffset(20, 20),

                Image = IconData.Url,

                ImageRectSize =
                    IconData.ImageRectSize,

                ImageRectOffset =
                    IconData.ImageRectOffset,

                ImageColor3 = Theme.SubText,

                ScaleType = Enum.ScaleType.Fit,

                ZIndex = 103
            })

        end
    end

    --------------------------------------------------
    -- FALLBACK ICON
    --------------------------------------------------

    if not SearchIcon then

        SearchIcon = create("TextLabel", {
            Name = "Icon",

            Parent = SearchFrame,

            BackgroundTransparency = 1,

            Position = UDim2.fromOffset(10, 8),

            Size = UDim2.fromOffset(20, 20),

            Font = Enum.Font.GothamBold,

            Text = "⌕",

            TextColor3 = Theme.SubText,

            TextSize = 18,

            ZIndex = 103
        })

    end

    --------------------------------------------------
    -- SEARCH BOX
    --------------------------------------------------

    local SearchBox = create("TextBox", {
        Name = "SearchBox",

        Parent = SearchFrame,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(36, 0),

        Size = UDim2.new(1, -42, 1, 0),

        Font = Enum.Font.Gotham,

        Text = "",

        PlaceholderText = "Search...",

        TextColor3 = Theme.Text,

        PlaceholderColor3 = Theme.SubText,

        TextSize = 12,

        TextXAlignment = Enum.TextXAlignment.Left,

        ClearTextOnFocus = false,

        ZIndex = 103
    })

    --------------------------------------------------
    -- OPTIONS
    --------------------------------------------------

    local OptionsList = create("ScrollingFrame", {
        Name = "Options",

        Parent = DropdownFrame,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Position = UDim2.fromOffset(7, 50),

        Size = UDim2.new(1, -14, 1, -57),

        CanvasSize = UDim2.fromOffset(0, 0),

        AutomaticCanvasSize = Enum.AutomaticSize.Y,

        ScrollBarThickness = 3,

        ScrollBarImageColor3 = Theme.Border,

        ZIndex = 101
    })

    create("UIListLayout", {
        Parent = OptionsList,

        SortOrder = Enum.SortOrder.LayoutOrder,

        Padding = UDim.new(0, 4)
    })

    --------------------------------------------------
    -- UPDATE VALUE
    --------------------------------------------------

    local function updateValue()

        if MultiSelect then

            if #CurrentOption == 0 then
                ValueLabel.Text = "None"
                return
            end

            local Values = {}

            for _, Value in ipairs(CurrentOption) do
                table.insert(
                    Values,
                    tostring(Value)
                )
            end

            ValueLabel.Text =
                table.concat(Values, ", ")

        else

            ValueLabel.Text =
                CurrentOption
                and tostring(CurrentOption)
                or "None"

        end
    end

    updateValue()

    --------------------------------------------------
    -- SELECTED CHECK
    --------------------------------------------------

    local function isSelected(Value)

        if not MultiSelect then
            return CurrentOption == Value
        end

        for _, Selected in ipairs(CurrentOption) do

            if Selected == Value then
                return true
            end

        end

        return false
    end

    --------------------------------------------------
    -- REMOVE VALUE
    --------------------------------------------------

    local function removeValue(Value)

        for Index, Selected in ipairs(CurrentOption) do

            if Selected == Value then

                table.remove(
                    CurrentOption,
                    Index
                )

                return
            end

        end
    end

    --------------------------------------------------
    -- CALLBACK
    --------------------------------------------------

    local function fireCallback(Value)

        if type(Settings.Callback) == "function" then

            task.spawn(function()

                pcall(
                    Settings.Callback,
                    Value
                )

            end)

        end
    end

    --------------------------------------------------
    -- OPTION OBJECTS
    --------------------------------------------------

    local OptionObjects = {}

    --------------------------------------------------
    -- CREATE OPTION
    --------------------------------------------------

    local function createOption(Value, Order)

        local OptionButton = create("TextButton", {

            Name = "Option",

            Parent = OptionsList,

            BackgroundColor3 = Theme.Element,

            BorderSizePixel = 0,

            Size = UDim2.new(1, 0, 0, 34),

            Text = "",

            AutoButtonColor = false,

            LayoutOrder = Order,

            ZIndex = 103
        })

        create("UICorner", {
            Parent = OptionButton,

            CornerRadius = UDim.new(0, 6)
        })

        local Label = create("TextLabel", {

            Name = "Text",

            Parent = OptionButton,

            BackgroundTransparency = 1,

            Position = UDim2.fromOffset(10, 0),

            Size = UDim2.new(1, -40, 1, 0),

            Font = Enum.Font.Gotham,

            Text = tostring(Value),

            TextColor3 = Theme.Text,

            TextSize = 12,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            ZIndex = 104
        })

        local Check = create("TextLabel", {

            Name = "Check",

            Parent = OptionButton,

            BackgroundTransparency = 1,

            AnchorPoint =
                Vector2.new(1, 0.5),

            Position =
                UDim2.new(1, -10, 0.5, 0),

            Size =
                UDim2.fromOffset(20, 20),

            Font = Enum.Font.GothamBold,

            Text = "",

            TextColor3 = Theme.Accent,

            TextSize = 14,

            ZIndex = 104
        })

        local function updateCheck()

            if isSelected(Value) then
                Check.Text = "✓"
            else
                Check.Text = ""
            end

        end

        updateCheck()

        OptionButton.MouseEnter:Connect(function()

            OTC:Tween(
                OptionButton,
                {
                    BackgroundColor3 =
                        Theme.Hover
                },
                0.1
            )

        end)

        OptionButton.MouseLeave:Connect(function()

            OTC:Tween(
                OptionButton,
                {
                    BackgroundColor3 =
                        Theme.Element
                },
                0.1
            )

        end)

        OptionButton.MouseButton1Click:Connect(function()

            if MultiSelect then

                if isSelected(Value) then

                    removeValue(Value)

                else

                    table.insert(
                        CurrentOption,
                        Value
                    )

                end

                updateCheck()
                updateValue()

                fireCallback(
                    CurrentOption
                )

            else

                CurrentOption = Value

                updateValue()

                fireCallback(Value)

                Object:Close()

            end

        end)

        return OptionButton
    end

    --------------------------------------------------
    -- REBUILD OPTIONS
    --------------------------------------------------

    local function rebuildOptions(SearchText)

        for _, Option in ipairs(OptionObjects) do

            if Option
                and Option.Parent then

                Option:Destroy()

            end

        end

        table.clear(OptionObjects)

        SearchText =
            tostring(SearchText or ""):lower()

        for Index, Value in ipairs(Options) do

            local Text =
                tostring(Value)

            if SearchText == ""
                or Text:lower():find(
                    SearchText,
                    1,
                    true
                ) then

                table.insert(
                    OptionObjects,

                    createOption(
                        Value,
                        Index
                    )
                )

            end

        end

    end

    rebuildOptions("")

    --------------------------------------------------
    -- HEIGHT
    --------------------------------------------------

    local function getHeight()

        local Count =
            #OptionObjects

        local SearchHeight = 50

        local OptionHeight = 38

        local ListHeight =
            math.min(
                math.max(
                    Count * OptionHeight,
                    38
                ),
                220
            )

        return SearchHeight
            + ListHeight
            + 7
    end

    --------------------------------------------------
    -- OPEN
    --------------------------------------------------

    function Object:Open()

        if Opened then
            return
        end

        Opened = true

        DropdownFrame.Visible = true

        DropdownFrame.Size =
            UDim2.new(
                1,
                0,
                0,
                0
            )

        OTC:Tween(
            DropdownFrame,
            {
                Size =
                    UDim2.new(
                        1,
                        0,
                        0,
                        getHeight()
                    )
            },
            0.16
        )

        OTC:Tween(
            Arrow,
            {
                Rotation = 180
            },
            0.16
        )

    end

    --------------------------------------------------
    -- CLOSE
    --------------------------------------------------

    function Object:Close()

        if not Opened then
            return
        end

        Opened = false

        OTC:Tween(
            DropdownFrame,
            {
                Size =
                    UDim2.new(
                        1,
                        0,
                        0,
                        0
                    )
            },
            0.14
        )

        OTC:Tween(
            Arrow,
            {
                Rotation = 0
            },
            0.14
        )

        task.delay(0.15, function()

            if not Opened then
                DropdownFrame.Visible = false
            end

        end)

    end

    --------------------------------------------------
    -- BUTTON
    --------------------------------------------------

    Button.MouseButton1Click:Connect(function()

        if Opened then
            Object:Close()
        else
            Object:Open()
        end

    end)

    --------------------------------------------------
    -- SEARCH
    --------------------------------------------------

    SearchBox:GetPropertyChangedSignal(
        "Text"
    ):Connect(function()

        rebuildOptions(
            SearchBox.Text
        )

        if Opened then

            OTC:Tween(
                DropdownFrame,
                {
                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            getHeight()
                        )
                },
                0.1
            )

        end

    end)

    --------------------------------------------------
    -- SET VALUE
    --------------------------------------------------

    function Object:SetValue(Value)

        if MultiSelect then

            if type(Value) == "table" then
                CurrentOption = Value
            else
                CurrentOption = {Value}
            end

        else

            CurrentOption = Value

        end

        updateValue()

        rebuildOptions(
            SearchBox.Text
        )

    end

    --------------------------------------------------
    -- GET VALUE
    --------------------------------------------------

    function Object:GetValue()

        return CurrentOption

    end

    --------------------------------------------------
    -- SET OPTIONS
    --------------------------------------------------

    function Object:SetOptions(NewOptions)

        Options = NewOptions or {}

        rebuildOptions(
            SearchBox.Text
        )

    end

    --------------------------------------------------
    -- ADD OPTION
    --------------------------------------------------

    function Object:AddOption(Value)

        table.insert(
            Options,
            Value
        )

        rebuildOptions(
            SearchBox.Text
        )

    end

    --------------------------------------------------
    -- REMOVE OPTION
    --------------------------------------------------

    function Object:RemoveOption(Value)

        for Index, Option in ipairs(Options) do

            if Option == Value then

                table.remove(
                    Options,
                    Index
                )

                break
            end

        end

        rebuildOptions(
            SearchBox.Text
        )

    end

    --------------------------------------------------
    -- SET NAME
    --------------------------------------------------

    function Object:SetName(Name)

        NameLabel.Text =
            tostring(Name)

    end

    --------------------------------------------------
    -- SET CALLBACK
    --------------------------------------------------

    function Object:SetCallback(Callback)

        Settings.Callback =
            Callback

    end

    --------------------------------------------------
    -- CLEAR SEARCH
    --------------------------------------------------

    function Object:ClearSearch()

        SearchBox.Text = ""

    end

    --------------------------------------------------
    -- DESTROY
    --------------------------------------------------

    function Object:Destroy()

        if Frame then
            Frame:Destroy()
        end

    end

    --------------------------------------------------
    -- REFERENCES
    --------------------------------------------------

    Object.Frame = Frame
    Object.Button = Button
    Object.DropdownFrame = DropdownFrame
    Object.SearchBox = SearchBox
    Object.OptionsList = OptionsList

    return Object
end