--[[
    OTC Hub v1
    Dropdown Element
    by Aerlro
]]

return function(OTC)

    local Dropdown = {}

    local function create(ClassName, Properties)
        local Object = Instance.new(ClassName)

        for Property, Value in pairs(Properties or {}) do
            Object[Property] = Value
        end

        return Object
    end

    local function getTheme()
        return OTC:GetTheme()
    end

    local function normalizeValue(Value)
        if type(Value) == "table" then
            return Value
        end

        if Value == nil then
            return ""
        end

        return tostring(Value)
    end

    function Dropdown.Create(Parent, Settings)

        Settings = Settings or {}

        local Theme = getTheme()

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
            BackgroundTransparency = 0,

            BorderSizePixel = 0,

            Size = UDim2.new(1, 0, 0, 48),

            Text = "",

            AutoButtonColor = false,

            ZIndex = 11
        })

        local ButtonCorner = create("UICorner", {
            Parent = Button,
            CornerRadius = UDim.new(0, 8)
        })

        local NameLabel = create("TextLabel", {
            Name = "Name",
            Parent = Button,

            BackgroundTransparency = 1,

            Position = UDim2.fromOffset(14, 6),
            Size = UDim2.new(0.55, 0, 0, 18),

            Font = Enum.Font.GothamMedium,
            Text = Settings.Name or "Dropdown",

            TextColor3 = Theme.Text,
            TextSize = 13,

            TextXAlignment = Enum.TextXAlignment.Left,

            ZIndex = 12
        })

        local ValueLabel = create("TextLabel", {
            Name = "Value",
            Parent = Button,

            BackgroundTransparency = 1,

            Position = UDim2.fromOffset(14, 25),
            Size = UDim2.new(1, -45, 0, 16),

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
        -- DROPDOWN OVERLAY
        --------------------------------------------------

        local DropdownFrame = create("Frame", {
            Name = "DropdownFrame",
            Parent = Frame,

            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 0,

            BorderSizePixel = 0,

            Position = UDim2.new(0, 0, 0, 53),

            Size = UDim2.new(1, 0, 0, 0),

            Visible = false,

            ClipsDescendants = true,

            ZIndex = 100
        })

        local DropdownCorner = create("UICorner", {
            Parent = DropdownFrame,
            CornerRadius = UDim.new(0, 8)
        })

        local DropdownStroke = create("UIStroke", {
            Parent = DropdownFrame,

            Color = Theme.Border,
            Thickness = 1,

            Transparency = 0
        })

        --------------------------------------------------
        -- SEARCH
        --------------------------------------------------

        local SearchFrame = create("Frame", {
            Name = "Search",
            Parent = DropdownFrame,

            BackgroundColor3 = Theme.Element,
            BackgroundTransparency = 0,

            BorderSizePixel = 0,

            Position = UDim2.fromOffset(7, 7),

            Size = UDim2.new(1, -14, 0, 36),

            ZIndex = 101
        })

        local SearchCorner = create("UICorner", {
            Parent = SearchFrame,
            CornerRadius = UDim.new(0, 7)
        })

        --------------------------------------------------
        -- SEARCH ICON
        --------------------------------------------------

        local SearchIcon

        if OTC._Lucide and OTC._Lucide.Available then

            local IconData = OTC._Lucide:GetIcon("search")

            if IconData then

                SearchIcon = create("ImageLabel", {
                    Name = "Icon",
                    Parent = SearchFrame,

                    BackgroundTransparency = 1,

                    Position = UDim2.fromOffset(10, 8),
                    Size = UDim2.fromOffset(20, 20),

                    Image = IconData.Url,

                    ImageRectSize = IconData.ImageRectSize,
                    ImageRectOffset = IconData.ImageRectOffset,

                    ImageColor3 = Theme.SubText,

                    ScaleType = Enum.ScaleType.Fit,

                    ZIndex = 103
                })

            end
        end

        --------------------------------------------------
        -- FALLBACK SEARCH ICON
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
        -- OPTIONS LIST
        --------------------------------------------------

        local OptionsList = create("ScrollingFrame", {
            Name = "Options",
            Parent = DropdownFrame,

            BackgroundTransparency = 1,

            BorderSizePixel = 0,

            Position = UDim2.fromOffset(7, 50),

            Size = UDim2.new(1, -14, 1, -57),

            CanvasSize = UDim2.fromOffset(0, 0),

            ScrollBarThickness = 3,

            ScrollBarImageColor3 = Theme.Border,

            AutomaticCanvasSize = Enum.AutomaticSize.Y,

            ZIndex = 101
        })

        local OptionsLayout = create("UIListLayout", {
            Parent = OptionsList,

            SortOrder = Enum.SortOrder.LayoutOrder,

            Padding = UDim.new(0, 4)
        })

        --------------------------------------------------
        -- CURRENT VALUE TEXT
        --------------------------------------------------

        local function updateValueText()

            if MultiSelect then

                if #CurrentOption == 0 then
                    ValueLabel.Text = "None"
                    return
                end

                local Text = {}

                for _, Value in ipairs(CurrentOption) do
                    table.insert(Text, tostring(Value))
                end

                ValueLabel.Text = table.concat(Text, ", ")

            else

                if CurrentOption == nil or CurrentOption == "" then
                    ValueLabel.Text = "None"
                else
                    ValueLabel.Text = tostring(CurrentOption)
                end

            end
        end

        updateValueText()

        --------------------------------------------------
        -- CHECK SELECTED
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
        -- REMOVE MULTI VALUE
        --------------------------------------------------

        local function removeValue(Value)

            for Index, Selected in ipairs(CurrentOption) do

                if Selected == Value then
                    table.remove(CurrentOption, Index)
                    break
                end

            end
        end

        --------------------------------------------------
        -- CALLBACK
        --------------------------------------------------

        local function callback(Value)

            if Settings.Callback then

                task.spawn(function()

                    pcall(
                        Settings.Callback,
                        Value
                    )

                end)

            end
        end

        --------------------------------------------------
        -- OPTION BUTTON
        --------------------------------------------------

        local function createOption(Value, LayoutOrder)

            local OptionButton = create("TextButton", {
                Name = "Option",

                Parent = OptionsList,

                BackgroundColor3 = Theme.Element,

                BackgroundTransparency = 0,

                BorderSizePixel = 0,

                Size = UDim2.new(1, 0, 0, 34),

                Text = "",

                AutoButtonColor = false,

                LayoutOrder = LayoutOrder,

                ZIndex = 103
            })

            local Corner = create("UICorner", {
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

                TextXAlignment = Enum.TextXAlignment.Left,

                ZIndex = 104
            })

            local Check = create("TextLabel", {
                Name = "Check",

                Parent = OptionButton,

                BackgroundTransparency = 1,

                AnchorPoint = Vector2.new(1, 0.5),

                Position = UDim2.new(1, -10, 0.5, 0),

                Size = UDim2.fromOffset(20, 20),

                Font = Enum.Font.GothamBold,

                Text = "",

                TextColor3 = Theme.Text,

                TextSize = 14,

                ZIndex = 104
            })

            local function updateCheck()

                if isSelected(Value) then
                    Check.Text = "✓"
                    Check.TextColor3 = Theme.Accent
                else
                    Check.Text = ""
                end

            end

            updateCheck()

            OptionButton.MouseEnter:Connect(function()

                OTC:Tween(
                    OptionButton,
                    {
                        BackgroundColor3 = Theme.Hover
                    },
                    0.12
                )

            end)

            OptionButton.MouseLeave:Connect(function()

                OTC:Tween(
                    OptionButton,
                    {
                        BackgroundColor3 = Theme.Element
                    },
                    0.12
                )

            end)

            OptionButton.MouseButton1Click:Connect(function()

                if MultiSelect then

                    if isSelected(Value) then
                        removeValue(Value)
                    else
                        table.insert(CurrentOption, Value)
                    end

                    updateCheck()
                    updateValueText()

                    callback(CurrentOption)

                else

                    CurrentOption = Value

                    updateValueText()

                    callback(Value)

                    Object:Close()

                end

            end)

            return OptionButton
        end

        --------------------------------------------------
        -- OPTIONS
        --------------------------------------------------

        local OptionObjects = {}

        local function rebuildOptions(SearchText)

            for _, Object in ipairs(OptionObjects) do

                if Object and Object.Parent then
                    Object:Destroy()
                end

            end

            table.clear(OptionObjects)

            SearchText = tostring(SearchText or ""):lower()

            for Index, Value in ipairs(Options) do

                local ValueString = tostring(Value)

                if SearchText == ""
                    or ValueString:lower():find(
                        SearchText,
                        1,
                        true
                    ) then

                    local OptionButton =
                        createOption(
                            Value,
                            Index
                        )

                    table.insert(
                        OptionObjects,
                        OptionButton
                    )

                end

            end

        end

        rebuildOptions("")

        --------------------------------------------------
        -- HEIGHT
        --------------------------------------------------

        local function calculateHeight()

            local Count = #OptionObjects

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

            return SearchHeight + ListHeight + 7
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

            local Height = calculateHeight()

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
                    Size = UDim2.new(
                        1,
                        0,
                        0,
                        Height
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
                    Size = UDim2.new(
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
        -- BUTTON CLICK
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

                local Height =
                    calculateHeight()

                OTC:Tween(
                    DropdownFrame,
                    {
                        Size = UDim2.new(
                            1,
                            0,
                            0,
                            Height
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

                    CurrentOption = {
                        Value
                    }

                end

            else

                CurrentOption = Value

            end

            updateValueText()

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

            if Opened then

                local Height =
                    calculateHeight()

                DropdownFrame.Size =
                    UDim2.new(
                        1,
                        0,
                        0,
                        Height
                    )

            end

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

            Settings.Callback = Callback

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
        -- PUBLIC REFERENCES
        --------------------------------------------------

        Object.Frame = Frame
        Object.Button = Button
        Object.DropdownFrame = DropdownFrame
        Object.SearchBox = SearchBox
        Object.OptionsList = OptionsList

        Object.MultiSelect = MultiSelect

        return Object
    end

    return Dropdown
end