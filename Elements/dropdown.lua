--[[
    OTC Hub v1
    Dropdown Element
    by Aerlro
]]

local Dropdown = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function create(Class, Properties)
    local Object = Instance.new(Class)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    return Object
end

local function tween(Object, Time, Properties)
    local Animation = TweenService:Create(
        Object,
        TweenInfo.new(
            Time or 0.2,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        Properties
    )

    Animation:Play()

    return Animation
end

function Dropdown.Create(Tab, OTC, Settings)

    Settings = Settings or {}

    local Theme = OTC:GetTheme()

    local Name = Settings.Name or "Dropdown"
    local Description = Settings.Description
    local Options = Settings.Options or {}
    local CurrentOption = Settings.CurrentOption
    local MultiSelect = Settings.MultiSelect == true
    local Flag = Settings.Flag

    local Callback = Settings.Callback or function() end

    local Selected = {}

    if MultiSelect then

        if type(CurrentOption) == "table" then
            for _, Option in ipairs(CurrentOption) do
                Selected[Option] = true
            end
        end

    elseif CurrentOption ~= nil then

        Selected[CurrentOption] = true

    end

    local Open = false

    local FrameHeight = Description and 62 or 48

    local Frame = create("Frame", {
        Name = "Dropdown",

        Parent = Tab.Page,

        BackgroundColor3 = Theme.Element,

        BorderSizePixel = 0,

        Size = UDim2.new(
            1,
            0,
            0,
            FrameHeight
        ),

        ClipsDescendants = false
    })

    create("UICorner", {
        Parent = Frame,

        CornerRadius = UDim.new(0, 8)
    })

    local Stroke = create("UIStroke", {
        Parent = Frame,

        Color = Theme.Border,

        Thickness = 1
    })

    local Button = create("TextButton", {
        Name = "Button",

        Parent = Frame,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Size = UDim2.new(1, 0, 1, 0),

        AutoButtonColor = false,

        Text = ""
    })

    local Title = create("TextLabel", {
        Name = "Title",

        Parent = Button,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(
            15,
            Description and 8 or 0
        ),

        Size = UDim2.new(
            1,
            -180,
            0,
            22
        ),

        Font = Enum.Font.GothamMedium,

        Text = Name,

        TextColor3 = Theme.Text,

        TextSize = 13,

        TextXAlignment = Enum.TextXAlignment.Left
    })

    local DescriptionLabel

    if Description then

        DescriptionLabel = create("TextLabel", {
            Name = "Description",

            Parent = Button,

            BackgroundTransparency = 1,

            Position = UDim2.fromOffset(
                15,
                30
            ),

            Size = UDim2.new(
                1,
                -180,
                0,
                20
            ),

            Font = Enum.Font.Gotham,

            Text = Description,

            TextColor3 = Theme.SubText,

            TextSize = 10,

            TextWrapped = true,

            TextXAlignment = Enum.TextXAlignment.Left
        })

    end

    local SelectedText = create("TextLabel", {
        Name = "Selected",

        Parent = Button,

        BackgroundTransparency = 1,

        AnchorPoint = Vector2.new(1, 0.5),

        Position = UDim2.new(
            1,
            -40,
            0.5,
            0
        ),

        Size = UDim2.fromOffset(
            130,
            24
        ),

        Font = Enum.Font.Gotham,

        Text = "None",

        TextColor3 = Theme.SubText,

        TextSize = 11,

        TextTruncate = Enum.TextTruncate.AtEnd,

        TextXAlignment = Enum.TextXAlignment.Right,

        TextYAlignment = Enum.TextYAlignment.Center
    })

    local Arrow = create("TextLabel", {
        Name = "Arrow",

        Parent = Button,

        BackgroundTransparency = 1,

        AnchorPoint = Vector2.new(1, 0.5),

        Position = UDim2.new(
            1,
            -15,
            0.5,
            0
        ),

        Size = UDim2.fromOffset(
            18,
            20
        ),

        Font = Enum.Font.GothamBold,

        Text = "⌄",

        TextColor3 = Theme.SubText,

        TextSize = 14,

        TextXAlignment = Enum.TextXAlignment.Center,

        TextYAlignment = Enum.TextYAlignment.Center
    })

    -- Dropdown container
    local DropdownFrame = create("Frame", {
        Name = "Options",

        Parent = Frame,

        BackgroundColor3 = Theme.Secondary,

        BorderSizePixel = 0,

        Position = UDim2.new(
            0,
            0,
            1,
            7
        ),

        Size = UDim2.new(
            1,
            0,
            0,
            0
        ),

        ClipsDescendants = true,

        Visible = false,

        ZIndex = 20
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

    local OptionsList = create("ScrollingFrame", {
        Name = "List",

        Parent = DropdownFrame,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Position = UDim2.fromOffset(
            5,
            5
        ),

        Size = UDim2.new(
            1,
            -10,
            1,
            -10
        ),

        CanvasSize = UDim2.new(),

        AutomaticCanvasSize = Enum.AutomaticSize.Y,

        ScrollBarThickness = 2,

        ScrollBarImageColor3 = Theme.Accent,

        ZIndex = 21
    })

    create("UIListLayout", {
        Parent = OptionsList,

        Padding = UDim.new(0, 3),

        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local SearchBox

    if Settings.Search == true then

        SearchBox = create("TextBox", {
            Name = "Search",

            Parent = DropdownFrame,

            BackgroundColor3 = Theme.Element,

            BorderSizePixel = 0,

            Position = UDim2.fromOffset(
                8,
                8
            ),

            Size = UDim2.new(
                1,
                -16,
                0,
                30
            ),

            Font = Enum.Font.Gotham,

            PlaceholderText = "Search...",

            PlaceholderColor3 = Theme.SubText,

            Text = "",

            TextColor3 = Theme.Text,

            TextSize = 11,

            ClearTextOnFocus = false,

            ZIndex = 22
        })

        create("UICorner", {
            Parent = SearchBox,

            CornerRadius = UDim.new(0, 6)
        })

        OptionsList.Position = UDim2.fromOffset(8, 45)
        OptionsList.Size = UDim2.new(1, -16, 1, -53)

    end

    local OptionButtons = {}

    local function getSelectedText()

        local Values = {}

        for Option in pairs(Selected) do
            if Selected[Option] then
                table.insert(
                    Values,
                    tostring(Option)
                )
            end
        end

        table.sort(Values)

        if #Values == 0 then
            return "None"
        end

        if #Values > 3 then
            return tostring(#Values) .. " selected"
        end

        return table.concat(
            Values,
            ", "
        )

    end

    local function updateSelectedText()

        SelectedText.Text =
            getSelectedText()

    end

    local function callback()

        local Value

        if MultiSelect then

            Value = {}

            for Option in pairs(Selected) do

                if Selected[Option] then
                    table.insert(
                        Value,
                        Option
                    )
                end

            end

        else

            for Option in pairs(Selected) do

                if Selected[Option] then
                    Value = Option
                    break
                end

            end

        end

        if Flag then
            OTC:SetFlag(
                Flag,
                Value
            )
        end

        local Success, Error =
            pcall(
                Callback,
                Value
            )

        if not Success then
            warn(
                "[OTC Hub] Dropdown callback error:",
                Error
            )
        end

    end

    local function selectOption(Option)

        if MultiSelect then

            Selected[Option] =
                not Selected[Option]

        else

            table.clear(Selected)

            Selected[Option] = true

            Open = false

        end

        updateSelectedText()

        callback()

        for Value, OptionButton in pairs(
            OptionButtons
        ) do

            local IsSelected =
                Selected[Value] == true

            OptionButton.BackgroundColor3 =
                IsSelected
                and Theme.Hover
                or Theme.Element

        end

        if not MultiSelect then

            DropdownFrame.Visible = false

            tween(
                DropdownFrame,
                0.2,
                {
                    Size = UDim2.new(
                        1,
                        0,
                        0,
                        0
                    )
                }
            )

            tween(
                Arrow,
                0.2,
                {
                    Rotation = 0
                }
            )

        end

    end

    local function createOption(Option)

        local OptionButton =
            create(
                "TextButton",
                {
                    Name = tostring(Option),

                    Parent = OptionsList,

                    BackgroundColor3 =
                        Selected[Option]
                        and Theme.Hover
                        or Theme.Element,

                    BorderSizePixel = 0,

                    Size = UDim2.new(
                        1,
                        0,
                        0,
                        32
                    ),

                    AutoButtonColor = false,

                    Font = Enum.Font.Gotham,

                    Text = tostring(Option),

                    TextColor3 = Theme.Text,

                    TextSize = 11,

                    TextXAlignment =
                        Enum.TextXAlignment.Left,

                    ZIndex = 23
                }
            )

        create("UICorner", {
            Parent = OptionButton,

            CornerRadius =
                UDim.new(0, 6)
        })

        create("UIPadding", {
            Parent = OptionButton,

            PaddingLeft =
                UDim.new(0, 10)
        })

        OptionButtons[Option] =
            OptionButton

        OptionButton.MouseEnter:Connect(
            function()

                tween(
                    OptionButton,
                    0.12,
                    {
                        BackgroundColor3 =
                            Theme.Hover
                    }
                )

            end
        )

        OptionButton.MouseLeave:Connect(
            function()

                if Selected[Option] then
                    return
                end

                tween(
                    OptionButton,
                    0.12,
                    {
                        BackgroundColor3 =
                            Theme.Element
                    }
                )

            end
        )

        OptionButton.MouseButton1Click:Connect(
            function()

                selectOption(
                    Option
                )

            end
        )

    end

    for _, Option in ipairs(Options) do
        createOption(Option)
    end

    if SearchBox then

        SearchBox:GetPropertyChangedSignal(
            "Text"
        ):Connect(
            function()

                local Search =
                    string.lower(
                        SearchBox.Text
                    )

                for Option, ButtonObject in pairs(
                    OptionButtons
                ) do

                    local Match =
                        Search == ""
                        or string.find(
                            string.lower(
                                tostring(Option)
                            ),
                            Search,
                            1,
                            true
                        )

                    ButtonObject.Visible =
                        Match == true

                end

            end
        )

    end

    local function calculateHeight()

        local Count = 0

        for _, ButtonObject in pairs(
            OptionButtons
        ) do

            if ButtonObject.Visible then
                Count += 1
            end

        end

        local Height =
            math.clamp(
                Count * 35 + 10,
                45,
                220
            )

        if SearchBox then
            Height += 38
        end

        return Height

    end

    local function setOpen(Value)

        Open = Value

        if Open then

            DropdownFrame.Visible = true

            DropdownFrame.Size =
                UDim2.new(
                    1,
                    0,
                    0,
                    0
                )

            tween(
                DropdownFrame,
                0.25,
                {
                    Size = UDim2.new(
                        1,
                        0,
                        0,
                        calculateHeight()
                    )
                }
            )

            tween(
                Arrow,
                0.2,
                {
                    Rotation = 180
                }
            )

            tween(
                Stroke,
                0.2,
                {
                    Color = Theme.Accent
                }
            )

        else

            tween(
                DropdownFrame,
                0.2,
                {
                    Size = UDim2.new(
                        1,
                        0,
                        0,
                        0
                    )
                }
            )

            tween(
                Arrow,
                0.2,
                {
                    Rotation = 0
                }
            )

            tween(
                Stroke,
                0.2,
                {
                    Color = Theme.Border
                }
            )

            task.delay(
                0.2,
                function()

                    if not Open then
                        DropdownFrame.Visible =
                            false
                    end

                end
            )

        end

    end

    Button.MouseButton1Click:Connect(
        function()

            setOpen(
                not Open
            )

        end
    )

    Button.MouseEnter:Connect(
        function()

            tween(
                Frame,
                0.15,
                {
                    BackgroundColor3 =
                        Theme.Hover
                }
            )

        end
    )

    Button.MouseLeave:Connect(
        function()

            if not Open then

                tween(
                    Frame,
                    0.15,
                    {
                        BackgroundColor3 =
                            Theme.Element
                    }
                )

            end

        end
    )

    updateSelectedText()

    local Object = {}

    function Object:SetValue(Value)

        table.clear(Selected)

        if MultiSelect then

            if type(Value) == "table" then

                for _, Option in ipairs(Value) do
                    Selected[Option] = true
                end

            end

        else

            Selected[Value] = true

        end

        updateSelectedText()

        callback()

    end

    function Object:GetValue()

        if MultiSelect then

            local Values = {}

            for Option in pairs(Selected) do

                if Selected[Option] then
                    table.insert(
                        Values,
                        Option
                    )
                end

            end

            return Values

        end

        for Option in pairs(Selected) do

            if Selected[Option] then
                return Option
            end

        end

        return nil

    end

    function Object:SetOptions(NewOptions)

        Options = NewOptions or {}

        for _, ButtonObject in pairs(
            OptionButtons
        ) do

            ButtonObject:Destroy()

        end

        table.clear(OptionButtons)

        for _, Option in ipairs(Options) do
            createOption(Option)
        end

        updateSelectedText()

    end

    function Object:AddOption(Option)

        table.insert(
            Options,
            Option
        )

        createOption(Option)

    end

    function Object:RemoveOption(Option)

        for Index, Value in ipairs(Options) do

            if Value == Option then

                table.remove(
                    Options,
                    Index
                )

                break

            end

        end

        if OptionButtons[Option] then

            OptionButtons[Option]:Destroy()
            OptionButtons[Option] = nil

        end

        Selected[Option] = nil

        updateSelectedText()

    end

    function Object:Open()

        setOpen(true)

    end

    function Object:Close()

        setOpen(false)

    end

    function Object:SetName(NewName)

        Name = NewName
        Title.Text = NewName

    end

    function Object:SetCallback(NewCallback)

        if type(NewCallback) == "function" then
            Callback = NewCallback
        end

    end

    function Object:Destroy()

        Frame:Destroy()

    end

    Object.Instance = Frame
    Object.Button = Button
    Object.Options = DropdownFrame

    Tab:AddElement(Object)

    return Object
end

return Dropdown