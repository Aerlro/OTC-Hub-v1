local Theme = {}

local Players = game:GetService("Players")

local PRIVATE_THEME_USERS = {
    ["romansmkboss"] = true,
    ["aerlro"] = true
}

local function RGB(R, G, B)
    return Color3.fromRGB(R, G, B)
end

local function Gradient(...)
    local Colors = {...}

    return {
        Colors = Colors,
        Rotation = 0
    }
end

local function IsRomanReignsUser(Player)
    if not Player then
        return false
    end

    local Name = string.lower(Player.Name)

    return PRIVATE_THEME_USERS[Name] == true
end

Theme.BuiltIn = {

    ["Default"] = {

        Background = RGB(35, 35, 35),
        Secondary = RGB(55, 55, 55),
        Element = RGB(75, 75, 75),
        Hover = RGB(100, 100, 100),
        Pressed = RGB(120, 120, 120),

        Border = RGB(140, 140, 140),
        BorderHover = RGB(180, 180, 180),

        Text = RGB(255, 255, 255),
        SubText = RGB(220, 220, 220),
        MutedText = RGB(160, 160, 160),

        Accent = RGB(255, 255, 255),
        AccentDark = RGB(200, 200, 200),
        AccentHover = RGB(255, 255, 255),
        AccentText = RGB(25, 25, 25),

        Success = RGB(80, 200, 120),
        Warning = RGB(240, 180, 70),
        Error = RGB(220, 70, 70),
        Info = RGB(80, 160, 220),

        Tab = RGB(45, 45, 45),
        TabHover = RGB(75, 75, 75),
        TabSelected = RGB(100, 100, 100),

        Button = RGB(75, 75, 75),
        ButtonHover = RGB(100, 100, 100),
        ButtonPressed = RGB(120, 120, 120),

        ToggleOff = RGB(60, 60, 60),
        ToggleOn = RGB(255, 255, 255),
        ToggleCircle = RGB(35, 35, 35),

        Input = RGB(45, 45, 45),
        InputHover = RGB(65, 65, 65),
        InputFocus = RGB(255, 255, 255),

        Dropdown = RGB(45, 45, 45),
        DropdownHover = RGB(70, 70, 70),
        DropdownSelected = RGB(255, 255, 255),

        SliderBackground = RGB(55, 55, 55),
        SliderFill = RGB(255, 255, 255),
        SliderKnob = RGB(255, 255, 255),

        PopupBackground = RGB(40, 40, 40),
        PopupBorder = RGB(120, 120, 120),

        NotificationBackground = RGB(45, 45, 45),
        NotificationBorder = RGB(255, 255, 255),

        Scrollbar = RGB(180, 180, 180),

        Transparency = {
            Main = 0,
            TopBar = 0,
            Sidebar = 0,
            Element = 0,
            Button = 0,
            Input = 0,
            Dropdown = 0,
            Popup = 0,
            Notification = 0
        },

        Stroke = {
            Enabled = true,
            Thickness = 1.5,
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
            Glow = true,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = true
        },

        Gradients = {
            Main = Gradient(
                RGB(35, 35, 35),
                RGB(55, 55, 55),
                RGB(35, 35, 35)
            ),

            TopBar = Gradient(
                RGB(45, 45, 45),
                RGB(80, 80, 80),
                RGB(45, 45, 45)
            ),

            Sidebar = Gradient(
                RGB(30, 30, 30),
                RGB(50, 50, 50)
            ),

            Element = Gradient(
                RGB(65, 65, 65),
                RGB(90, 90, 90)
            ),

            Accent = Gradient(
                RGB(255, 255, 255),
                RGB(200, 200, 200),
                RGB(255, 255, 255)
            )
        }
    },

    ["Red"] = {
        Background = RGB(75, 10, 15),
        Secondary = RGB(115, 15, 22),
        Element = RGB(150, 22, 30),
        Hover = RGB(190, 30, 40),
        Pressed = RGB(210, 40, 50),

        Border = RGB(230, 55, 65),
        BorderHover = RGB(255, 80, 90),

        Text = RGB(255, 255, 255),
        SubText = RGB(240, 210, 210),
        MutedText = RGB(190, 140, 140),

        Accent = RGB(255, 65, 75),
        AccentDark = RGB(200, 30, 40),
        AccentHover = RGB(255, 90, 100),
        AccentText = RGB(40, 5, 5),

        Success = RGB(80, 200, 120),
        Warning = RGB(240, 180, 70),
        Error = RGB(255, 70, 70),
        Info = RGB(80, 160, 220),

        Tab = RGB(85, 12, 18),
        TabHover = RGB(145, 22, 30),
        TabSelected = RGB(190, 30, 40),

        Button = RGB(150, 22, 30),
        ButtonHover = RGB(190, 30, 40),
        ButtonPressed = RGB(215, 40, 50),

        ToggleOff = RGB(80, 15, 20),
        ToggleOn = RGB(255, 65, 75),
        ToggleCircle = RGB(255, 235, 235),

        Input = RGB(55, 8, 12),
        InputHover = RGB(105, 15, 20),
        InputFocus = RGB(255, 65, 75),

        Dropdown = RGB(55, 8, 12),
        DropdownHover = RGB(115, 18, 25),
        DropdownSelected = RGB(255, 65, 75),

        SliderBackground = RGB(90, 15, 20),
        SliderFill = RGB(255, 65, 75),
        SliderKnob = RGB(255, 100, 110),

        PopupBackground = RGB(65, 8, 13),
        PopupBorder = RGB(230, 55, 65),

        NotificationBackground = RGB(70, 10, 15),
        NotificationBorder = RGB(255, 65, 75),

        Scrollbar = RGB(255, 65, 75),

        Transparency = {
            Main = 0,
            TopBar = 0,
            Sidebar = 0,
            Element = 0,
            Button = 0,
            Input = 0,
            Dropdown = 0,
            Popup = 0,
            Notification = 0
        },

        Stroke = {
            Enabled = true,
            Thickness = 1.5,
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
            Glow = true,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = true
        },

        Gradients = {
            Main = Gradient(
                RGB(75, 10, 15),
                RGB(120, 15, 25),
                RGB(75, 10, 15)
            ),

            TopBar = Gradient(
                RGB(100, 10, 18),
                RGB(220, 35, 45),
                RGB(100, 10, 18)
            ),

            Sidebar = Gradient(
                RGB(55, 5, 10),
                RGB(100, 12, 18)
            ),

            Element = Gradient(
                RGB(130, 15, 25),
                RGB(210, 35, 45)
            ),

            Accent = Gradient(
                RGB(255, 65, 75),
                RGB(255, 110, 120),
                RGB(200, 30, 40)
            )
        }
    },

    ["Green"] = {
        Background = RGB(8, 70, 30),
        Secondary = RGB(10, 110, 45),
        Element = RGB(15, 145, 58),
        Hover = RGB(25, 185, 75),
        Pressed = RGB(35, 205, 85),

        Border = RGB(55, 225, 105),
        BorderHover = RGB(85, 255, 130),

        Text = RGB(255, 255, 255),
        SubText = RGB(205, 235, 215),
        MutedText = RGB(145, 185, 155),

        Accent = RGB(70, 255, 120),
        AccentDark = RGB(30, 195, 75),
        AccentHover = RGB(100, 255, 145),
        AccentText = RGB(5, 35, 15),

        Success = RGB(70, 255, 120),
        Warning = RGB(240, 180, 70),
        Error = RGB(220, 70, 70),
        Info = RGB(80, 180, 220),

        Tab = RGB(10, 80, 35),
        TabHover = RGB(20, 150, 60),
        TabSelected = RGB(25, 190, 75),

        Button = RGB(15, 145, 58),
        ButtonHover = RGB(25, 185, 75),
        ButtonPressed = RGB(35, 210, 85),

        ToggleOff = RGB(10, 70, 30),
        ToggleOn = RGB(70, 255, 120),
        ToggleCircle = RGB(225, 255, 235),

        Input = RGB(5, 45, 20),
        InputHover = RGB(10, 90, 35),
        InputFocus = RGB(70, 255, 120),

        Dropdown = RGB(5, 45, 20),
        DropdownHover = RGB(15, 110, 45),
        DropdownSelected = RGB(70, 255, 120),

        SliderBackground = RGB(15, 90, 40),
        SliderFill = RGB(70, 255, 120),
        SliderKnob = RGB(110, 255, 155),

        PopupBackground = RGB(7, 55, 25),
        PopupBorder = RGB(55, 225, 105),

        NotificationBackground = RGB(8, 65, 30),
        NotificationBorder = RGB(70, 255, 120),

        Scrollbar = RGB(70, 255, 120),

        Transparency = {
            Main = 0,
            TopBar = 0,
            Sidebar = 0,
            Element = 0,
            Button = 0,
            Input = 0,
            Dropdown = 0,
            Popup = 0,
            Notification = 0
        },

        Stroke = {
            Enabled = true,
            Thickness = 1.5,
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
            Glow = true,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = true
        },

        Gradients = {
            Main = Gradient(
                RGB(8, 70, 30),
                RGB(15, 120, 50),
                RGB(8, 70, 30)
            ),

            TopBar = Gradient(
                RGB(10, 100, 40),
                RGB(50, 220, 100),
                RGB(10, 100, 40)
            ),

            Sidebar = Gradient(
                RGB(5, 50, 20),
                RGB(10, 100, 40)
            ),

            Element = Gradient(
                RGB(15, 135, 55),
                RGB(30, 200, 80)
            ),

            Accent = Gradient(
                RGB(70, 255, 120),
                RGB(130, 255, 165),
                RGB(30, 195, 75)
            )
        }
    },

    ["Blue"] = {
        Background = RGB(8, 45, 100),
        Secondary = RGB(10, 70, 145),
        Element = RGB(15, 95, 185),
        Hover = RGB(30, 125, 220),
        Pressed = RGB(40, 145, 235),

        Border = RGB(70, 165, 255),
        BorderHover = RGB(105, 195, 255),

        Text = RGB(255, 255, 255),
        SubText = RGB(205, 225, 245),
        MutedText = RGB(145, 175, 210),

        Accent = RGB(75, 155, 255),
        AccentDark = RGB(35, 105, 205),
        AccentHover = RGB(105, 180, 255),
        AccentText = RGB(5, 20, 45),

        Success = RGB(80, 200, 120),
        Warning = RGB(240, 180, 70),
        Error = RGB(220, 70, 70),
        Info = RGB(75, 155, 255),

        Tab = RGB(10, 55, 115),
        TabHover = RGB(20, 100, 185),
        TabSelected = RGB(30, 130, 220),

        Button = RGB(15, 95, 185),
        ButtonHover = RGB(30, 125, 220),
        ButtonPressed = RGB(40, 145, 235),

        ToggleOff = RGB(10, 55, 110),
        ToggleOn = RGB(75, 155, 255),
        ToggleCircle = RGB(225, 240, 255),

        Input = RGB(5, 30, 75),
        InputHover = RGB(10, 70, 135),
        InputFocus = RGB(75, 155, 255),

        Dropdown = RGB(5, 30, 75),
        DropdownHover = RGB(15, 80, 150),
        DropdownSelected = RGB(75, 155, 255),

        SliderBackground = RGB(15, 70, 135),
        SliderFill = RGB(75, 155, 255),
        SliderKnob = RGB(110, 190, 255),

        PopupBackground = RGB(6, 35, 80),
        PopupBorder = RGB(70, 165, 255),

        NotificationBackground = RGB(7, 45, 95),
        NotificationBorder = RGB(75, 155, 255),

        Scrollbar = RGB(75, 155, 255),

        Transparency = {
            Main = 0,
            TopBar = 0,
            Sidebar = 0,
            Element = 0,
            Button = 0,
            Input = 0,
            Dropdown = 0,
            Popup = 0,
            Notification = 0
        },

        Stroke = {
            Enabled = true,
            Thickness = 1.5,
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
            Glow = true,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = true
        },

        Gradients = {
            Main = Gradient(
                RGB(8, 45, 100),
                RGB(15, 85, 170),
                RGB(8, 45, 100)
            ),

            TopBar = Gradient(
                RGB(10, 65, 135),
                RGB(50, 145, 240),
                RGB(10, 65, 135)
            ),

            Sidebar = Gradient(
                RGB(5, 30, 70),
                RGB(10, 70, 140)
            ),

            Element = Gradient(
                RGB(15, 90, 180),
                RGB(35, 140, 230)
            ),

            Accent = Gradient(
                RGB(75, 155, 255),
                RGB(125, 195, 255),
                RGB(35, 105, 205)
            )
        }
    },

    ["Purple"] = {
        Background = RGB(55, 10, 95),
        Secondary = RGB(80, 15, 135),
        Element = RGB(110, 25, 175),
        Hover = RGB(145, 40, 220),
        Pressed = RGB(165, 50, 235),

        Border = RGB(190, 75, 255),
        BorderHover = RGB(220, 120, 255),

        Text = RGB(255, 255, 255),
        SubText = RGB(225, 205, 240),
        MutedText = RGB(175, 140, 195),

        Accent = RGB(190, 90, 255),
        AccentDark = RGB(130, 45, 200),
        AccentHover = RGB(215, 125, 255),
        AccentText = RGB(25, 5, 40),

        Success = RGB(80, 200, 120),
        Warning = RGB(240, 180, 70),
        Error = RGB(220, 70, 70),
        Info = RGB(120, 150, 240),

        Tab = RGB(65, 12, 110),
        TabHover = RGB(115, 25, 175),
        TabSelected = RGB(150, 40, 220),

        Button = RGB(110, 25, 175),
        ButtonHover = RGB(145, 40, 220),
        ButtonPressed = RGB(170, 50, 235),

        ToggleOff = RGB(65, 12, 110),
        ToggleOn = RGB(190, 90, 255),
        ToggleCircle = RGB(245, 225, 255),

        Input = RGB(35, 6, 65),
        InputHover = RGB(80, 15, 125),
        InputFocus = RGB(190, 90, 255),

        Dropdown = RGB(35, 6, 65),
        DropdownHover = RGB(95, 20, 150),
        DropdownSelected = RGB(190, 90, 255),

        SliderBackground = RGB(80, 20, 135),
        SliderFill = RGB(190, 90, 255),
        SliderKnob = RGB(220, 140, 255),

        PopupBackground = RGB(45, 8, 80),
        PopupBorder = RGB(190, 75, 255),

        NotificationBackground = RGB(55, 10, 95),
        NotificationBorder = RGB(190, 90, 255),

        Scrollbar = RGB(190, 90, 255),

        Transparency = {
            Main = 0,
            TopBar = 0,
            Sidebar = 0,
            Element = 0,
            Button = 0,
            Input = 0,
            Dropdown = 0,
            Popup = 0,
            Notification = 0
        },

        Stroke = {
            Enabled = true,
            Thickness = 1.5,
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
            Glow = true,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = true
        },

        Gradients = {
            Main = Gradient(
                RGB(55, 10, 95),
                RGB(100, 20, 155),
                RGB(55, 10, 95)
            ),

            TopBar = Gradient(
                RGB(75, 12, 125),
                RGB(175, 55, 235),
                RGB(75, 12, 125)
            ),

            Sidebar = Gradient(
                RGB(35, 5, 65),
                RGB(75, 15, 120)
            ),

            Element = Gradient(
                RGB(100, 20, 165),
                RGB(160, 45, 225)
            ),

            Accent = Gradient(
                RGB(190, 90, 255),
                RGB(230, 155, 255),
                RGB(130, 45, 200)
            )
        }
    },

    ["Orange"] = {
        Background = RGB(100, 40, 5),
        Secondary = RGB(145, 60, 8),
        Element = RGB(185, 80, 10),
        Hover = RGB(220, 105, 15),
        Pressed = RGB(235, 120, 20),

        Border = RGB(255, 145, 35),
        BorderHover = RGB(255, 175, 70),

        Text = RGB(255, 255, 255),
        SubText = RGB(245, 220, 195),
        MutedText = RGB(195, 150, 115),

        Accent = RGB(255, 155, 50),
        AccentDark = RGB(205, 100, 25),
        AccentHover = RGB(255, 180, 85),
        AccentText = RGB(45, 18, 3),

        Success = RGB(80, 200, 120),
        Warning = RGB(255, 180, 50),
        Error = RGB(220, 70, 70),
        Info = RGB(80, 160, 220),

        Tab = RGB(110, 42, 5),
        TabHover = RGB(175, 75, 10),
        TabSelected = RGB(220, 105, 15),

        Button = RGB(185, 80, 10),
        ButtonHover = RGB(220, 105, 15),
        ButtonPressed = RGB(235, 120, 20),

        ToggleOff = RGB(90, 30, 5),
        ToggleOn = RGB(255, 155, 50),
        ToggleCircle = RGB(255, 240, 215),

        Input = RGB(55, 20, 3),
        InputHover = RGB(115, 45, 7),
        InputFocus = RGB(255, 155, 50),

        Dropdown = RGB(55, 20, 3),
        DropdownHover = RGB(135, 55, 8),
        DropdownSelected = RGB(255, 155, 50),

        SliderBackground = RGB(120, 50, 8),
        SliderFill = RGB(255, 155, 50),
        SliderKnob = RGB(255, 195, 100),

        PopupBackground = RGB(75, 28, 4),
        PopupBorder = RGB(255, 145, 35),

        NotificationBackground = RGB(90, 35, 5),
        NotificationBorder = RGB(255, 155, 50),

        Scrollbar = RGB(255, 155, 50),

        Transparency = {
            Main = 0,
            TopBar = 0,
            Sidebar = 0,
            Element = 0,
            Button = 0,
            Input = 0,
            Dropdown = 0,
            Popup = 0,
            Notification = 0
        },

        Stroke = {
            Enabled = true,
            Thickness = 1.5,
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
            Glow = true,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = true
        },

        Gradients = {
            Main = Gradient(
                RGB(100, 40, 5),
                RGB(175, 70, 10),
                RGB(100, 40, 5)
            ),

            TopBar = Gradient(
                RGB(120, 45, 5),
                RGB(240, 115, 20),
                RGB(120, 45, 5)
            ),

            Sidebar = Gradient(
                RGB(60, 20, 3),
                RGB(120, 45, 5)
            ),

            Element = Gradient(
                RGB(175, 70, 8),
                RGB(225, 115, 20)
            ),

            Accent = Gradient(
                RGB(255, 155, 50),
                RGB(255, 205, 120),
                RGB(205, 100, 25)
            )
        }
    },

    ["Halloween"] = {
        Background = RGB(20, 7, 25),
        Secondary = RGB(40, 10, 48),
        Element = RGB(68, 17, 72),
        Hover = RGB(105, 25, 95),
        Pressed = RGB(135, 35, 115),

        Border = RGB(145, 45, 155),
        BorderHover = RGB(200, 70, 200),

        Text = RGB(255, 245, 225),
        SubText = RGB(225, 195, 215),
        MutedText = RGB(170, 135, 165),

        Accent = RGB(255, 115, 0),
        AccentDark = RGB(195, 55, 0),
        AccentHover = RGB(255, 155, 20),
        AccentText = RGB(35, 10, 5),

        Success = RGB(100, 220, 110),
        Warning = RGB(255, 150, 0),
        Error = RGB(230, 60, 70),
        Info = RGB(150, 80, 220),

        Tab = RGB(38, 10, 45),
        TabHover = RGB(80, 20, 80),
        TabSelected = RGB(120, 30, 105),

        Button = RGB(68, 17, 72),
        ButtonHover = RGB(105, 25, 95),
        ButtonPressed = RGB(140, 35, 115),

        ToggleOff = RGB(45, 10, 48),
        ToggleOn = RGB(255, 115, 0),
        ToggleCircle = RGB(255, 240, 210),

        Input = RGB(28, 8, 34),
        InputHover = RGB(55, 13, 60),
        InputFocus = RGB(255, 115, 0),

        Dropdown = RGB(28, 8, 34),
        DropdownHover = RGB(70, 18, 72),
        DropdownSelected = RGB(255, 115, 0),

        SliderBackground = RGB(48, 12, 52),
        SliderFill = RGB(255, 115, 0),
        SliderKnob = RGB(255, 165, 30),

        PopupBackground = RGB(25, 7, 30),
        PopupBorder = RGB(180, 55, 150),

        NotificationBackground = RGB(30, 8, 36),
        NotificationBorder = RGB(255, 115, 0),

        Scrollbar = RGB(255, 115, 0),

        Transparency = {
            Main = 0,
            TopBar = 0,
            Sidebar = 0,
            Element = 0,
            Button = 0,
            Input = 0,
            Dropdown = 0,
            Popup = 0,
            Notification = 0
        },

        Stroke = {
            Enabled = true,
            Thickness = 1.5,
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
            Glow = true,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = true
        },

        Gradients = {
            Main = Gradient(
                RGB(20, 7, 25),
                RGB(55, 12, 60),
                RGB(20, 7, 25)
            ),

            TopBar = Gradient(
                RGB(40, 8, 48),
                RGB(130, 25, 100),
                RGB(255, 115, 0)
            ),

            Sidebar = Gradient(
                RGB(20, 5, 28),
                RGB(65, 12, 70)
            ),

            Element = Gradient(
                RGB(68, 17, 72),
                RGB(130, 30, 105),
                RGB(210, 65, 20)
            ),

            Accent = Gradient(
                RGB(255, 115, 0),
                RGB(255, 180, 25),
                RGB(150, 30, 150)
            )
        }
    },

    ["Roman Reigns"] = {
        Background = RGB(5, 9, 10),
        Secondary = RGB(8, 25, 24),
        Element = RGB(12, 47, 43),
        Hover = RGB(20, 70, 64),
        Pressed = RGB(27, 88, 79),

        Border = RGB(52, 110, 98),
        BorderHover = RGB(82, 145, 125),

        Text = RGB(245, 245, 240),
        SubText = RGB(190, 202, 197),
        MutedText = RGB(125, 145, 140),

        Accent = RGB(215, 178, 75),
        AccentDark = RGB(150, 115, 38),
        AccentHover = RGB(240, 205, 105),
        AccentText = RGB(20, 18, 10),

        Success = RGB(80, 190, 125),
        Warning = RGB(230, 175, 60),
        Error = RGB(190, 55, 50),
        Info = RGB(70, 145, 160),

        Tab = RGB(7, 27, 26),
        TabHover = RGB(16, 58, 53),
        TabSelected = RGB(28, 82, 73),

        Button = RGB(12, 47, 43),
        ButtonHover = RGB(20, 70, 64),
        ButtonPressed = RGB(27, 88, 79),

        ToggleOff = RGB(8, 35, 33),
        ToggleOn = RGB(215, 178, 75),
        ToggleCircle = RGB(245, 235, 200),

        Input = RGB(4, 17, 18),
        InputHover = RGB(10, 40, 38),
        InputFocus = RGB(215, 178, 75),

        Dropdown = RGB(4, 17, 18),
        DropdownHover = RGB(12, 48, 45),
        DropdownSelected = RGB(215, 178, 75),

        SliderBackground = RGB(10, 38, 36),
        SliderFill = RGB(215, 178, 75),
        SliderKnob = RGB(240, 205, 105),

        PopupBackground = RGB(5, 14, 15),
        PopupBorder = RGB(52, 110, 98),

        NotificationBackground = RGB(7, 22, 22),
        NotificationBorder = RGB(215, 178, 75),

        Scrollbar = RGB(215, 178, 75),

        Transparency = {
            Main = 0,
            TopBar = 0,
            Sidebar = 0,
            Element = 0,
            Button = 0,
            Input = 0,
            Dropdown = 0,
            Popup = 0,
            Notification = 0
        },

        Stroke = {
            Enabled = true,
            Thickness = 1.5,
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
            Glow = true,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = true
        },

        Gradients = {
            Main = Gradient(
                RGB(5, 9, 10),
                RGB(8, 35, 32),
                RGB(5, 9, 10)
            ),

            TopBar = Gradient(
                RGB(7, 27, 26),
                RGB(28, 82, 73),
                RGB(215, 178, 75)
            ),

            Sidebar = Gradient(
                RGB(4, 17, 18),
                RGB(10, 45, 40)
            ),

            Element = Gradient(
                RGB(12, 47, 43),
                RGB(28, 82, 73),
                RGB(150, 115, 38)
            ),

            Accent = Gradient(
                RGB(215, 178, 75),
                RGB(240, 205, 105),
                RGB(150, 115, 38)
            )
        },

        Artwork = {
            Enabled = true,
            Image = "https://raw.githubusercontent.com/Aerlro/OTC-Hub-v1/main/Owner/db009abe18bb20e9192664f442bcb41a.jpg",
            ImageTransparency = 0.72,
            Size = UDim2.new(0, 300, 0, 300),
            Position = UDim2.new(1, -315, 1, -315),
            ZIndex = 1
        }
    }
}

function Theme.IsPrivate(Name)
    return Name == "Roman Reigns"
end

function Theme.IsAllowed(Name, Player)
    if not Theme.IsPrivate(Name) then
        return true
    end

    return IsRomanReignsUser(Player)
end

function Theme.GetAccessMessage(Name)
    if Name == "Roman Reigns" then
        return "The Roman Reigns theme is private."
    end

    return nil
end

function Theme.Get(Name, Player)
    local SelectedTheme = Theme.BuiltIn[Name]

    if not SelectedTheme then
        return nil
    end

    if not Theme.IsAllowed(Name, Player or Players.LocalPlayer) then
        return nil
    end

    return SelectedTheme
end

function Theme.Exists(Name)
    return Theme.BuiltIn[Name] ~= nil
end

function Theme.Register(Name, Data)
    if type(Name) ~= "string" then
        return false
    end

    if type(Data) ~= "table" then
        return false
    end

    if Theme.IsPrivate(Name) then
        return false
    end

    Theme.BuiltIn[Name] = Data

    return true
end

function Theme.Remove(Name)
    if Name == "Default" then
        return false
    end

    if Theme.IsPrivate(Name) then
        return false
    end

    if not Theme.BuiltIn[Name] then
        return false
    end

    Theme.BuiltIn[Name] = nil

    return true
end

function Theme.List(Player)
    Player = Player or Players.LocalPlayer

    local List = {}

    for Name in pairs(Theme.BuiltIn) do
        if Theme.IsAllowed(Name, Player) then
            table.insert(List, Name)
        end
    end

    table.sort(List)

    return List
end

function Theme.GetGradient(Name, GradientName, Player)
    local SelectedTheme = Theme.Get(Name, Player)

    if not SelectedTheme then
        return nil
    end

    if not SelectedTheme.Gradients then
        return nil
    end

    return SelectedTheme.Gradients[GradientName]
end

function Theme.HasGradient(Name, GradientName, Player)
    return Theme.GetGradient(Name, GradientName, Player) ~= nil
end

function Theme.GetColor(Name, ColorName, Player)
    local SelectedTheme = Theme.Get(Name, Player)

    if not SelectedTheme then
        return nil
    end

    return SelectedTheme[ColorName]
end

function Theme.GetTransparency(Name, ObjectName, Player)
    local SelectedTheme = Theme.Get(Name, Player)

    if not SelectedTheme then
        return nil
    end

    if not SelectedTheme.Transparency then
        return nil
    end

    return SelectedTheme.Transparency[ObjectName]
end

function Theme.GetCorner(Name, ObjectName, Player)
    local SelectedTheme = Theme.Get(Name, Player)

    if not SelectedTheme then
        return nil
    end

    if not SelectedTheme.Corners then
        return nil
    end

    return SelectedTheme.Corners[ObjectName]
end

function Theme.GetEffect(Name, EffectName, Player)
    local SelectedTheme = Theme.Get(Name, Player)

    if not SelectedTheme then
        return nil
    end

    if not SelectedTheme.Effects then
        return nil
    end

    return SelectedTheme.Effects[EffectName]
end

return Theme