# OTC Hub v1 (i know it's AI idc i'm using only for me 😁)

<p align="center">
  <img src="https://raw.githubusercontent.com/Aerlro/OTC-Hub-v1/main/OTC.png" alt="OTC Hub" width="160">
</p>

<h1 align="center">OTC Hub v1</h1>

<p align="center">
  Modern • Modular • Customizable • Advanced Roblox UI Library
</p>

<p align="center">
  Built by <b>Aerlro</b>
</p>

<p align="center">
  <a href="https://github.com/Aerlro/OTC-Hub-v1">GitHub</a>
</p>

---

## 📖 About

**OTC Hub v1** is a modular Roblox Luau UI Library designed for scripts that need a modern, customizable and responsive interface.

The library is built around a modular architecture where the Window System, Theme System, Notifications, Animations, Icons and UI Elements are separated into individual modules.

OTC Hub focuses on:

- Modern UI
- Easy API
- Modular architecture
- Advanced themes
- Runtime theme switching
- Gradients
- Animated gradients
- Transparency
- Strokes
- Rounded corners
- Notifications
- Icons
- Responsive elements
- Runtime customization

---

# ✨ Features

### Core

- [x] Window System
- [x] Tab System
- [x] Theme System
- [x] Advanced Theme System
- [x] Gradient System
- [x] Animated Gradients
- [x] Transparency System
- [x] Stroke System
- [x] Corner System
- [x] Animation System
- [x] Notification System
- [x] Lucide Icon System
- [x] Flag System
- [x] Runtime Theme Switching
- [x] Minimize / Restore
- [x] Window Unload
- [x] Window Dragging

### Elements

- [x] Button
- [x] Toggle
- [x] Slider
- [x] Dropdown
- [x] Multi-Select Dropdown
- [x] Input
- [x] Searchable Dropdown
- [x] Element Theme Refresh

---

# 🚀 Installation

Load OTC Hub directly from GitHub:

    local OTC = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Aerlro/OTC-Hub-v1/main/otc.lua"
    ))()

After loading the library, you can create a window:

    local Window = OTC:CreateWindow({
        Name = "OTC Hub",
        Subtitle = "by Aerlro",
        Theme = "Default"
    })

---

# 🪟 Window

Create a window:

    local Window = OTC:CreateWindow({
        Name = "My Script",
        Subtitle = "by Aerlro",
        Theme = "Purple"
    })

You can also configure the toggle key:

    local Window = OTC:CreateWindow({
        Name = "My Script",
        Subtitle = "by Aerlro",
        Theme = "Purple",

        ToggleKey = Enum.KeyCode.RightControl
    })

## Window Settings

| Setting | Type | Description |
|---|---|---|
| `Name` | string | Window title |
| `Subtitle` | string | Window subtitle |
| `Theme` | string | Initial theme |
| `ToggleKey` | KeyCode | Key used to minimize/restore |

---

# 🧩 Window Methods

### Toggle

    Window:Toggle()

Toggles between the minimized and restored state.

### Minimize

    Window:Minimize()

Minimizes the window and displays the OTC logo button.

### Restore

    Window:Restore()

Restores the window.

### SetTheme

    Window:SetTheme("Red")

Changes the current window theme.

### GetTheme

    local Theme = Window:GetTheme()

Returns the current theme.

### RefreshTheme

    Window:RefreshTheme()

Refreshes the entire window and its elements.

### Unload

    Window:Unload()

Completely removes the OTC UI.

---

# 📑 Tabs

Create a tab:

    local MainTab = Window:CreateTab({
        Name = "Main",
        Icon = "home"
    })

Another tab:

    local PlayerTab = Window:CreateTab({
        Name = "Player",
        Icon = "user"
    })

Another example:

    local SettingsTab = Window:CreateTab({
        Name = "Settings",
        Icon = "settings"
    })

Tabs automatically support the active theme.

---

# 🏷️ Sections

Create a section:

    MainTab:CreateSection("Player")

Example:

    MainTab:CreateSection("Player")

    MainTab:CreateText(
        "Player related features."
    )

---

# 📝 Text

Create a text element:

    MainTab:CreateText(
        "This is an example text."
    )

Another example:

    MainTab:CreateText(
        "Selectează o opțiune pentru a continua."
    )

---

# 🔘 Button

Create a basic button:

    MainTab:CreateButton({
        Name = "Execute",
        Description = "Execute the selected action",

        Callback = function()
            print("Button pressed")
        end
    })

A more advanced example:

    MainTab:CreateButton({
        Name = "Notify",
        Description = "Show a notification",

        Callback = function()

            OTC:Notify({
                Title = "OTC Hub",
                Content = "Button pressed!",
                Duration = 3
            })

        end
    })

## Button Features

- Hover animation
- Press animation
- Dedicated button colors
- Gradient support
- Stroke support
- Rounded corners
- Theme refresh
- Callback support

---

# 🔄 Toggle

Create a toggle:

    local Toggle = MainTab:CreateToggle({
        Name = "Auto Farm",

        Description = "Automatically farms resources",

        CurrentValue = false,

        Flag = "AutoFarm",

        Callback = function(Value)

            print(
                "Auto Farm:",
                Value
            )

        end
    })

Set the value:

    Toggle:SetValue(true)

Get the value:

    local Value = Toggle:GetValue()

    print(Value)

Change the name:

    Toggle:SetName("Auto Collect")

Change the description:

    Toggle:SetDescription(
        "Automatically collects items."
    )

Change the callback:

    Toggle:SetCallback(function(Value)

        print(
            "New callback:",
            Value
        )

    end)

## Toggle Features

- On / Off states
- Custom colors
- Animated transitions
- Gradient support
- Stroke support
- Theme refresh
- Flags
- Callback support

---

# 🎚️ Slider

Create a slider:

    local Slider = MainTab:CreateSlider({
        Name = "WalkSpeed",

        Description = "Player movement speed",

        Min = 16,
        Max = 200,

        Default = 16,

        Increment = 1,

        Flag = "WalkSpeed",

        Callback = function(Value)

            print(
                "WalkSpeed:",
                Value
            )

        end
    })

Set the value:

    Slider:SetValue(100)

Change the minimum:

    Slider:SetMin(10)

Change the maximum:

    Slider:SetMax(500)

## Slider Features

- Minimum value
- Maximum value
- Default value
- Increment
- Dragging
- Touch support
- Flags
- Callbacks
- Custom colors
- Gradient support
- Custom knob
- Theme refresh

---

# 📋 Dropdown

Create a normal dropdown:

    MainTab:CreateDropdown({
        Name = "Mode",

        Description = "Select a mode",

        Options = {
            "Normal",
            "Fast",
            "Extreme"
        },

        CurrentOption = "Normal",

        MultiSelect = false,

        Callback = function(Value)

            print(
                "Selected:",
                Value
            )

        end
    })

---

# ☑️ Multi-Select Dropdown

Create a multi-select dropdown:

    MainTab:CreateDropdown({
        Name = "Items",

        Description = "Select multiple items",

        Options = {
            "Sword",
            "Bow",
            "Shield",
            "Potion"
        },

        CurrentOption = {},

        MultiSelect = true,

        Callback = function(Value)

            print(Value)

        end
    })

The callback receives the selected options.

---

# 🔎 Searchable Dropdown

Dropdowns support searching through their options.

Example:

    MainTab:CreateDropdown({
        Name = "Fruit",

        Description = "Search for a fruit",

        Options = {
            "Apple",
            "Banana",
            "Orange",
            "Grape",
            "Watermelon",
            "Strawberry"
        },

        CurrentOption = "Apple",

        MultiSelect = false,

        Callback = function(Value)

            print(
                "Fruit:",
                Value
            )

        end
    })

---

# ⌨️ Input

Create an input:

    local Input = MainTab:CreateInput({
        Name = "Username",

        Description = "Enter a username",

        Placeholder = "Type username...",

        CurrentValue = "",

        ClearTextOnFocus = false,

        Callback = function(Value)

            print(
                "Username:",
                Value
            )

        end
    })

Set the value:

    Input:SetValue("Aerlro")

Get the value:

    local Value = Input:GetValue()

    print(Value)

Change the placeholder:

    Input:SetPlaceholder(
        "Enter another value..."
    )

Focus the input:

    Input:Focus()

Clear the input:

    Input:Clear()

Change the name:

    Input:SetName("Player Name")

Change the callback:

    Input:SetCallback(function(Value)

        print(
            "New value:",
            Value
        )

    end)

---

# 🔢 Numeric Input

Numeric input can be enabled:

    MainTab:CreateInput({
        Name = "Amount",

        Description = "Enter a number",

        Placeholder = "100",

        Numeric = true,

        Callback = function(Value)

            print(
                "Amount:",
                Value
            )

        end
    })

---

# 🔢 Maximum Input Length

You can limit the number of characters:

    MainTab:CreateInput({
        Name = "Code",

        Description = "Enter your code",

        Placeholder = "XXXX",

        MaxLength = 4,

        Callback = function(Value)

            print(Value)

        end
    })

---

# 🚩 Flags

Flags allow values to be stored inside OTC.

Example:

    MainTab:CreateToggle({
        Name = "Enabled",

        CurrentValue = false,

        Flag = "Enabled",

        Callback = function(Value)

            print(Value)

        end
    })

Read the flag:

    local Enabled =
        OTC:GetFlag("Enabled")

Set the flag:

    OTC:SetFlag(
        "Enabled",
        true
    )

Another example:

    MainTab:CreateSlider({
        Name = "Speed",

        Min = 1,
        Max = 100,

        Default = 20,

        Flag = "Speed",

        Callback = function(Value)

            print(Value)

        end
    })

Read it:

    local Speed =
        OTC:GetFlag("Speed")

---

# 🎨 Theme System

OTC Hub contains an advanced theme system.

Themes control the appearance of the entire UI.

Each theme can control:

- Background
- Secondary
- Element
- Hover
- Pressed
- Border
- BorderHover
- Text
- SubText
- MutedText
- Accent
- AccentDark
- AccentHover
- AccentText
- Success
- Warning
- Error
- Info
- Tabs
- Buttons
- Toggles
- Inputs
- Dropdowns
- Sliders
- Popups
- Notifications
- Scrollbars

---

# 🎨 Built-In Themes

OTC Hub includes:

    Default
    Red
    Green
    Blue
    Purple
    Orange
    Halloween

---

# 🔄 Runtime Theme Switching

Change the theme while the UI is running:

    OTC:SetTheme("Red")

Another example:

    OTC:SetTheme("Blue")

Another:

    OTC:SetTheme("Purple")

Halloween:

    OTC:SetTheme("Halloween")

The window and supported elements refresh automatically.

---

# 📚 Get Themes

Get all available themes:

    local Themes =
        OTC:GetThemes()

    for _, ThemeName in ipairs(Themes) do

        print(
            ThemeName
        )

    end

---

# 🎨 Get Current Theme

    local Theme =
        OTC:GetTheme()

    print(
        Theme.Background
    )

---

# 🛠️ Custom Themes

You can register your own theme.

Example:

    OTC:RegisterTheme("MyTheme", {

        Background =
            Color3.fromRGB(
                20,
                20,
                25
            ),

        Secondary =
            Color3.fromRGB(
                30,
                30,
                40
            ),

        Element =
            Color3.fromRGB(
                45,
                45,
                60
            ),

        Hover =
            Color3.fromRGB(
                60,
                60,
                80
            ),

        Pressed =
            Color3.fromRGB(
                70,
                70,
                95
            ),

        Border =
            Color3.fromRGB(
                100,
                100,
                130
            ),

        BorderHover =
            Color3.fromRGB(
                140,
                120,
                200
            ),

        Text =
            Color3.fromRGB(
                255,
                255,
                255
            ),

        SubText =
            Color3.fromRGB(
                190,
                190,
                200
            ),

        MutedText =
            Color3.fromRGB(
                120,
                120,
                130
            ),

        Accent =
            Color3.fromRGB(
                130,
                90,
                255
            ),

        AccentDark =
            Color3.fromRGB(
                90,
                55,
                190
            ),

        AccentHover =
            Color3.fromRGB(
                160,
                120,
                255
            ),

        AccentText =
            Color3.fromRGB(
                255,
                255,
                255
            ),

        Success =
            Color3.fromRGB(
                80,
                220,
                120
            ),

        Warning =
            Color3.fromRGB(
                255,
                190,
                70
            ),

        Error =
            Color3.fromRGB(
                255,
                80,
                80
            ),

        Info =
            Color3.fromRGB(
                80,
                160,
                255
            ),

        Tab =
            Color3.fromRGB(
                35,
                35,
                45
            ),

        TabHover =
            Color3.fromRGB(
                60,
                60,
                80
            ),

        TabSelected =
            Color3.fromRGB(
                90,
                70,
                140
            ),

        Button =
            Color3.fromRGB(
                45,
                45,
                60
            ),

        ButtonHover =
            Color3.fromRGB(
                65,
                65,
                90
            ),

        ButtonPressed =
            Color3.fromRGB(
                80,
                80,
                110
            ),

        ToggleOff =
            Color3.fromRGB(
                50,
                50,
                55
            ),

        ToggleOn =
            Color3.fromRGB(
                130,
                90,
                255
            ),

        ToggleCircle =
            Color3.fromRGB(
                255,
                255,
                255
            ),

        Input =
            Color3.fromRGB(
                25,
                25,
                30
            ),

        InputHover =
            Color3.fromRGB(
                45,
                45,
                55
            ),

        InputFocus =
            Color3.fromRGB(
                130,
                90,
                255
            ),

        Dropdown =
            Color3.fromRGB(
                25,
                25,
                30
            ),

        DropdownHover =
            Color3.fromRGB(
                50,
                50,
                65
            ),

        DropdownSelected =
            Color3.fromRGB(
                130,
                90,
                255
            ),

        SliderBackground =
            Color3.fromRGB(
                50,
                50,
                60
            ),

        SliderFill =
            Color3.fromRGB(
                130,
                90,
                255
            ),

        SliderKnob =
            Color3.fromRGB(
                170,
                140,
                255
            ),

        PopupBackground =
            Color3.fromRGB(
                25,
                25,
                30
            ),

        PopupBorder =
            Color3.fromRGB(
                100,
                100,
                130
            ),

        NotificationBackground =
            Color3.fromRGB(
                25,
                25,
                30
            ),

        NotificationBorder =
            Color3.fromRGB(
                130,
                90,
                255
            ),

        Scrollbar =
            Color3.fromRGB(
                130,
                90,
                255
            ),

        Transparency = {

            Main = 0,
            Secondary = 0,
            Element = 0,
            Popup = 0,
            Notification = 0

        },

        Stroke = {

            Enabled = true,
            Thickness = 1,
            Transparency = 0

        },

        Corners = {

            Main = 12,
            Element = 8,
            Button = 8,
            Input = 8,
            Dropdown = 8,
            Popup = 12,
            Notification = 9

        },

        Effects = {

            Glow = false,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = true

        }

    })

    OTC:SetTheme("MyTheme")

---

# 🌈 Gradient System

OTC Hub supports gradients for different UI areas.

Available gradient types include:

    Main
    TopBar
    Sidebar
    Element
    Accent

Example:

    Gradients = {

        Main = {

            Enabled = true,

            Colors = ColorSequence.new({

                ColorSequenceKeypoint.new(
                    0,
                    Color3.fromRGB(
                        30,
                        0,
                        60
                    )
                ),

                ColorSequenceKeypoint.new(
                    1,
                    Color3.fromRGB(
                        100,
                        20,
                        150
                    )
                )

            }),

            Rotation = 0

        }

    }

---

# ✨ Animated Gradients

Enable animated gradients:

    Effects = {

        Gradient = true,

        AnimatedGradient = true

    }

The gradient can automatically animate while the UI is running.

---

# 🪟 Transparency

Themes can control transparency:

    Transparency = {

        Main = 0,
        Secondary = 0,
        Element = 0,
        Popup = 0,
        Notification = 0

    }

For example:

    Transparency = {

        Main = 0.1,
        Secondary = 0.15,
        Element = 0.05,
        Popup = 0.1,
        Notification = 0.05

    }

---

# 🖌️ Stroke System

Themes support UI strokes:

    Stroke = {

        Enabled = true,

        Thickness = 1,

        Transparency = 0

    }

You can use thicker strokes:

    Stroke = {

        Enabled = true,

        Thickness = 2,

        Transparency = 0

    }

---

# ⭕ Corner System

Corners can be customized individually:

    Corners = {

        Main = 12,

        Element = 8,

        Button = 8,

        Input = 8,

        Dropdown = 8,

        Popup = 12,

        Notification = 9

    }

---

# 🔔 Notifications

Create a notification:

    OTC:Notify({
        Title = "Information",

        Content =
            "Aceasta este o notificare Info.",

        Duration = 3
    })

The notification system supports:

- Title
- Content
- Duration
- Accent color
- Progress bar
- Animated entrance
- Animated exit
- Theme colors
- Custom icon
- OTC logo

---

# 🖼️ Notification Logo

By default, notifications can use the OTC logo.

Custom icon:

    OTC:Notify({
        Title = "Success",

        Content =
            "Action completed successfully.",

        Duration = 3,

        Icon =
            "rbxassetid://123456789"
    })

Text icon:

    OTC:Notify({
        Title = "Warning",

        Content =
            "Something happened.",

        Duration = 3,

        Icon = "!"
    })

Another text icon:

    OTC:Notify({
        Title = "Info",

        Content =
            "Information message.",

        Duration = 3,

        Icon = "i"
    })

If no icon is supplied, the default OTC notification icon is used.

---

# 🎞️ Notification Object

You can store the notification:

    local Notification = OTC:Notify({

        Title = "OTC Hub",

        Content =
            "This notification can be controlled.",

        Duration = 10

    })

Close it manually:

    Notification:Close()

Change the title:

    Notification:SetTitle(
        "New Title"
    )

Change the content:

    Notification:SetContent(
        "New content."
    )

Change the icon:

    Notification:SetIcon(
        "!"
    )

---

# 🎞️ Tween System

OTC contains a Tween helper.

Basic example:

    OTC:Tween(
        Window.Main,
        0.35,
        {
            Size =
                UDim2.new(
                    0,
                    580,
                    0,
                    400
                )
        }
    )

Custom easing:

    OTC:Tween(
        Object,
        0.25,
        {
            BackgroundTransparency = 0
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

---

# 🎯 Component Colors

OTC does not depend on a single global accent.

Each component can have its own colors.

## Button

    Button
    ButtonHover
    ButtonPressed

## Toggle

    ToggleOff
    ToggleOn
    ToggleCircle

## Input

    Input
    InputHover
    InputFocus

## Dropdown

    Dropdown
    DropdownHover
    DropdownSelected

## Slider

    SliderBackground
    SliderFill
    SliderKnob

## Popup

    PopupBackground
    PopupBorder

## Notification

    NotificationBackground
    NotificationBorder

This allows themes to have completely different visual identities.

---

# 🎨 Theme Example

A simple red theme:

    OTC:SetTheme("Red")

A green theme:

    OTC:SetTheme("Green")

A blue theme:

    OTC:SetTheme("Blue")

A purple theme:

    OTC:SetTheme("Purple")

An orange theme:

    OTC:SetTheme("Orange")

Halloween:

    OTC:SetTheme("Halloween")

---

# 🧪 Complete Example

The following example demonstrates multiple OTC Hub features together:

    local OTC = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Aerlro/OTC-Hub-v1/main/otc.lua"
    ))()

    local Window = OTC:CreateWindow({
        Name = "OTC Hub",
        Subtitle = "by Aerlro",
        Theme = "Purple",
        ToggleKey = Enum.KeyCode.RightControl
    })

    local MainTab = Window:CreateTab({
        Name = "Main",
        Icon = "home"
    })

    local PlayerTab = Window:CreateTab({
        Name = "Player",
        Icon = "user"
    })

    local SettingsTab = Window:CreateTab({
        Name = "Settings",
        Icon = "settings"
    })

    MainTab:CreateSection(
        "Main Features"
    )

    MainTab:CreateText(
        "Welcome to OTC Hub v1."
    )

    MainTab:CreateButton({

        Name = "Test Button",

        Description =
            "Test the OTC button system.",

        Callback = function()

            OTC:Notify({

                Title = "Button",

                Content =
                    "Button pressed!",

                Duration = 3

            })

        end

    })

    MainTab:CreateToggle({

        Name = "Enabled",

        Description =
            "Enable the feature.",

        CurrentValue = false,

        Flag = "Enabled",

        Callback = function(Value)

            print(
                "Enabled:",
                Value
            )

        end

    })

    PlayerTab:CreateSection(
        "Player"
    )

    PlayerTab:CreateSlider({

        Name = "WalkSpeed",

        Description =
            "Change player speed.",

        Min = 16,

        Max = 200,

        Default = 16,

        Increment = 1,

        Flag = "WalkSpeed",

        Callback = function(Value)

            print(
                "WalkSpeed:",
                Value
            )

        end

    })

    PlayerTab:CreateDropdown({

        Name = "Mode",

        Description =
            "Select a mode.",

        Options = {

            "Normal",
            "Fast",
            "Extreme"

        },

        CurrentOption =
            "Normal",

        MultiSelect = false,

        Callback = function(Value)

            print(
                "Mode:",
                Value
            )

        end

    })

    SettingsTab:CreateSection(
        "Settings"
    )

    SettingsTab:CreateInput({

        Name = "Username",

        Description =
            "Enter a username.",

        Placeholder =
            "Type username...",

        ClearTextOnFocus = false,

        Callback = function(Value)

            print(
                "Username:",
                Value
            )

        end

    })

    SettingsTab:CreateDropdown({

        Name = "Theme",

        Description =
            "Select an OTC theme.",

        Options =
            OTC:GetThemes(),

        CurrentOption =
            OTC.CurrentTheme,

        MultiSelect = false,

        Callback = function(Value)

            local ThemeName = Value

            if type(Value) == "table" then

                ThemeName =
                    Value[1]

            end

            if ThemeName then

                OTC:SetTheme(
                    ThemeName
                )

            end

        end

    })

---

# 🧪 Theme Test

A complete theme testing setup:

    local OTC = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Aerlro/OTC-Hub-v1/main/otc.lua"
    ))()

    local Window = OTC:CreateWindow({

        Name = "OTC Hub",

        Subtitle =
            "Advanced Theme Test",

        Theme = "Default"

    })

    local MainTab =
        Window:CreateTab({

            Name = "Theme Test",

            Icon = "palette"

        })

    MainTab:CreateSection(
        "Theme System"
    )

    MainTab:CreateText(
        "Selectează un theme pentru a testa toate elementele."
    )

    MainTab:CreateDropdown({

        Name = "Theme",

        Description =
            "Selectează theme-ul OTC Hub",

        Options =
            OTC:GetThemes(),

        CurrentOption =
            OTC.CurrentTheme,

        MultiSelect = false,

        Callback = function(Value)

            local ThemeName =
                Value

            if type(Value)
                == "table" then

                ThemeName =
                    Value[1]

            end

            if not ThemeName then
                return
            end

            OTC:SetTheme(
                ThemeName
            )

        end

    })

    MainTab:CreateSection(
        "Button"
    )

    MainTab:CreateButton({

        Name =
            "Test Button",

        Description =
            "Testează culoarea și hover-ul",

        Callback = function()

            OTC:Notify({

                Title =
                    "Button",

                Content =
                    "Button test!",

                Duration = 3

            })

        end

    })

    MainTab:CreateSection(
        "Toggle"
    )

    MainTab:CreateToggle({

        Name =
            "Test Toggle",

        Description =
            "Testează culoarea toggle-ului",

        CurrentValue = false,

        Callback = function(Value)

            print(
                "Toggle:",
                Value
            )

        end

    })

    MainTab:CreateSection(
        "Slider"
    )

    MainTab:CreateSlider({

        Name =
            "Test Slider",

        Description =
            "Testează culoarea slider-ului",

        Min = 0,

        Max = 100,

        Default = 50,

        Increment = 1,

        Flag =
            "ThemeTestSlider",

        Callback = function(Value)

            print(
                "Slider:",
                Value
            )

        end

    })

    MainTab:CreateSection(
        "Dropdown"
    )

    MainTab:CreateDropdown({

        Name =
            "Test Dropdown",

        Description =
            "Testează dropdown-ul",

        Options = {

            "Option 1",
            "Option 2",
            "Option 3",
            "Option 4"

        },

        CurrentOption =
            "Option 1",

        MultiSelect = false,

        Callback = function(Value)

            print(
                "Dropdown:",
                Value
            )

        end

    })

    MainTab:CreateSection(
        "Multi Dropdown"
    )

    MainTab:CreateDropdown({

        Name =
            "Multi Dropdown",

        Description =
            "Testează multi-select dropdown",

        Options = {

            "Apple",
            "Banana",
            "Orange",
            "Grape"

        },

        CurrentOption = {},

        MultiSelect = true,

        Callback = function(Value)

            print(
                Value
            )

        end

    })

    MainTab:CreateSection(
        "Input"
    )

    MainTab:CreateInput({

        Name =
            "Test Input",

        Description =
            "Testează input-ul",

        Placeholder =
            "Type something...",

        RemoveTextAfterFocusLost =
            false,

        Callback = function(Value)

            print(
                "Input:",
                Value
            )

        end

    })

    MainTab:CreateSection(
        "Notifications"
    )

    MainTab:CreateButton({

        Name =
            "Info Notification",

        Description =
            "Test notification system.",

        Callback = function()

            OTC:Notify({

                Title =
                    "Information",

                Content =
                    "Aceasta este o notificare Info.",

                Duration = 4

            })

        end

    })

    MainTab:CreateButton({

        Name =
            "Custom Icon",

        Description =
            "Test custom notification icon.",

        Callback = function()

            OTC:Notify({

                Title =
                    "Custom Icon",

                Content =
                    "Această notificare folosește un icon custom.",

                Icon = "!",

                Duration = 4

            })

        end

    })

---

# 📁 Project Structure

    OTC-Hub-v1/
    │
    ├── otc.lua
    ├── loader.lua
    │
    ├── Core/
    │   ├── tab.lua
    │   ├── window.lua
    │   ├── theme.lua
    │   ├── animation.lua
    │   ├── notification.lua
    │   └── lucide.lua
    │
    └── Elements/
        ├── button.lua
        ├── toggle.lua
        ├── slider.lua
        ├── dropdown.lua
        └── input.lua

---

# 🧠 Architecture

OTC Hub is separated into two major parts.

## Core

The `Core` directory contains the systems responsible for the library itself.

### `window.lua`

Handles:

- Window creation
- Window dragging
- Minimize
- Restore
- Unload
- Tabs container
- User card
- Theme refresh
- Window animations

### `tab.lua`

Handles:

- Tab creation
- Tab selection
- Tab buttons
- Tab icons
- Tab pages
- Element registration
- Theme refresh

### `theme.lua`

Handles:

- Built-in themes
- Custom themes
- Theme registration
- Theme lookup
- Theme colors
- Gradients
- Transparency
- Corners
- Effects

### `animation.lua`

Handles:

- UI animations
- Entrance animations
- Tween-based transitions

### `notification.lua`

Handles:

- Notifications
- Notification animations
- Progress bars
- Icons
- Notification themes

### `lucide.lua`

Handles:

- Lucide icons
- Icon lookup
- UI icon rendering

---

# 🧩 Elements

The `Elements` folder contains the individual UI components.

### `button.lua`

Handles buttons.

### `toggle.lua`

Handles toggles.

### `slider.lua`

Handles sliders.

### `dropdown.lua`

Handles:

- Dropdowns
- Multi-select
- Search
- Options
- Popup UI

### `input.lua`

Handles:

- Text input
- Numeric input
- Placeholder
- Focus
- Maximum length
- Callbacks

---

# 🛠️ Creating a New Element

When adding a new element to OTC Hub:

1. Create a module inside `Elements`.
2. Create the UI.
3. Add theme support.
4. Add `RefreshTheme()`.
5. Add callbacks.
6. Add flags if required.
7. Register the element in `otc.lua`.
8. Expose it through `tab.lua`.
9. Add it to the test script.
10. Update the README.

---

# 🔌 API Design

OTC Hub attempts to keep the API simple and predictable.

Typical usage:

    local Element = Tab:CreateElement({
        Name = "Example",
        Description = "Example description",

        Callback = function(Value)

            print(Value)

        end
    })

Most elements expose methods for runtime control.

Examples:

    Element:SetValue(...)
    Element:SetName(...)
    Element:SetCallback(...)
    Element:RefreshTheme()
    Element:Destroy()

---

# 🐛 Bug Reports

If you find a bug, provide:

- OTC Hub version
- Roblox environment
- Theme
- Element
- Error message
- Steps to reproduce
- Screenshot or video

Example:

    OTC Hub Version:
    1.0.0

    Theme:
    Halloween

    Element:
    Dropdown

    Problem:
    Dropdown popup does not refresh after changing theme.

---

# 🤝 Contributing

Contributions are welcome.

When submitting changes:

- Keep the modular structure.
- Preserve existing APIs.
- Avoid unnecessary breaking changes.
- Add theme support.
- Add `RefreshTheme()`.
- Test multiple themes.
- Test mobile input when possible.
- Update the README.
- Keep the code organized.

---

# 🗺️ Roadmap

### UI

- [x] Window
- [x] Tabs
- [x] Button
- [x] Toggle
- [x] Slider
- [x] Dropdown
- [x] Multi Dropdown
- [x] Input
- [x] Notifications
- [x] Icons

### Theme System

- [x] Built-in themes
- [x] Custom themes
- [x] Runtime theme switching
- [x] Gradients
- [x] Animated gradients
- [x] Transparency
- [x] Strokes
- [x] Corners
- [x] Component-specific colors

### Future

- [ ] Keybind element
- [ ] Color Picker
- [ ] Configuration System
- [ ] Save / Load configuration
- [ ] More notification types
- [ ] More animation presets
- [ ] Theme Editor
- [ ] Additional built-in themes
- [ ] Improved mobile support
- [ ] Advanced component animations
- [ ] More customization APIs

---

# 📜 License

See the repository license for the current terms of use.

---

# 👑 OTC Hub

<p align="center">
  <b>OTC Hub v1</b>
</p>

<p align="center">
  Modern • Modular • Advanced
</p>

<p align="center">
  Built by <b>Aerlro</b>
</p>

<p align="center">
  https://github.com/Aerlro/OTC-Hub-v1
</p>