local Players = game:GetService("Players")

local Theme = {}

local PRIVATE_THEME_USERS = {
    ["aerlro"] = true,
    ["romansmkboss"] = true
}

local function GetCurrentPlayer()
    local Player = Players.LocalPlayer

    if Player then
        return Player
    end

    return nil
end

local function IsRomanReignsUser(Player)
    Player = Player or GetCurrentPlayer()

    if not Player then
        return false
    end

    local Name = Player.Name

    if type(Name) ~= "string" then
        return false
    end

    return PRIVATE_THEME_USERS[string.lower(Name)] == true
end

Theme.BuiltIn = {
    Default = {
        Name = "Default",

        Background = Color3.fromRGB(35, 35, 35),
        Secondary = Color3.fromRGB(55, 55, 55),
        Element = Color3.fromRGB(75, 75, 75),
        Hover = Color3.fromRGB(100, 100, 100),
        Pressed = Color3.fromRGB(120, 120, 120),

        Border = Color3.fromRGB(140, 140, 140),
        BorderHover = Color3.fromRGB(180, 180, 180),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(210, 210, 210),
        MutedText = Color3.fromRGB(160, 160, 160),

        Accent = Color3.fromRGB(255, 255, 255),
        AccentDark = Color3.fromRGB(200, 200, 200),
        AccentHover = Color3.fromRGB(255, 255, 255),
        AccentText = Color3.fromRGB(25, 25, 25),

        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(240, 180, 60),
        Error = Color3.fromRGB(220, 70, 70),
        Info = Color3.fromRGB(80, 160, 220),

        Tab = Color3.fromRGB(45, 45, 45),
        TabHover = Color3.fromRGB(80, 80, 80),
        TabSelected = Color3.fromRGB(110, 110, 110),

        Button = Color3.fromRGB(75, 75, 75),
        ButtonHover = Color3.fromRGB(100, 100, 100),
        ButtonPressed = Color3.fromRGB(120, 120, 120),

        ToggleOff = Color3.fromRGB(55, 55, 55),
        ToggleOn = Color3.fromRGB(255, 255, 255),
        ToggleCircle = Color3.fromRGB(235, 235, 235),

        Input = Color3.fromRGB(40, 40, 40),
        InputHover = Color3.fromRGB(65, 65, 65),
        InputFocus = Color3.fromRGB(255, 255, 255),

        Dropdown = Color3.fromRGB(40, 40, 40),
        DropdownHover = Color3.fromRGB(65, 65, 65),
        DropdownSelected = Color3.fromRGB(255, 255, 255),

        SliderBackground = Color3.fromRGB(55, 55, 55),
        SliderFill = Color3.fromRGB(255, 255, 255),
        SliderKnob = Color3.fromRGB(235, 235, 235),

        PopupBackground = Color3.fromRGB(30, 30, 30),
        PopupBorder = Color3.fromRGB(140, 140, 140),

        NotificationBackground = Color3.fromRGB(35, 35, 35),
        NotificationBorder = Color3.fromRGB(255, 255, 255),

        Scrollbar = Color3.fromRGB(255, 255, 255),

        Transparency = {
            Main = 0,
            Secondary = 0,
            Element = 0,
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
            Main = {
                Color3.fromRGB(45, 45, 45),
                Color3.fromRGB(80, 80, 80),
                Color3.fromRGB(120, 120, 120)
            },

            TopBar = {
                Color3.fromRGB(35, 35, 35),
                Color3.fromRGB(75, 75, 75),
                Color3.fromRGB(120, 120, 120)
            },

            Sidebar = {
                Color3.fromRGB(25, 25, 25),
                Color3.fromRGB(50, 50, 50)
            },

            Element = {
                Color3.fromRGB(65, 65, 65),
                Color3.fromRGB(100, 100, 100)
            },

            Accent = {
                Color3.fromRGB(255, 255, 255),
                Color3.fromRGB(200, 200, 200),
                Color3.fromRGB(255, 255, 255)
            }
        }
    },

    Red = {
        Name = "Red",

        Background = Color3.fromRGB(75, 10, 15),
        Secondary = Color3.fromRGB(115, 15, 22),
        Element = Color3.fromRGB(150, 22, 30),
        Hover = Color3.fromRGB(190, 30, 40),
        Pressed = Color3.fromRGB(210, 40, 50),

        Border = Color3.fromRGB(230, 55, 65),
        BorderHover = Color3.fromRGB(255, 80, 90),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(235, 205, 205),
        MutedText = Color3.fromRGB(190, 140, 140),

        Accent = Color3.fromRGB(255, 65, 75),
        AccentDark = Color3.fromRGB(200, 30, 40),
        AccentHover = Color3.fromRGB(255, 100, 110),
        AccentText = Color3.fromRGB(45, 5, 8),

        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(240, 180, 60),
        Error = Color3.fromRGB(255, 80, 80),
        Info = Color3.fromRGB(80, 160, 220),

        Tab = Color3.fromRGB(90, 12, 18),
        TabHover = Color3.fromRGB(145, 25, 32),
        TabSelected = Color3.fromRGB(190, 35, 45),

        Button = Color3.fromRGB(150, 22, 30),
        ButtonHover = Color3.fromRGB(190, 30, 40),
        ButtonPressed = Color3.fromRGB(215, 40, 50),

        ToggleOff = Color3.fromRGB(90, 15, 20),
        ToggleOn = Color3.fromRGB(255, 65, 75),
        ToggleCircle = Color3.fromRGB(255, 220, 220),

        Input = Color3.fromRGB(55, 8, 12),
        InputHover = Color3.fromRGB(105, 15, 20),
        InputFocus = Color3.fromRGB(255, 65, 75),

        Dropdown = Color3.fromRGB(55, 8, 12),
        DropdownHover = Color3.fromRGB(110, 18, 25),
        DropdownSelected = Color3.fromRGB(255, 65, 75),

        SliderBackground = Color3.fromRGB(95, 15, 20),
        SliderFill = Color3.fromRGB(255, 65, 75),
        SliderKnob = Color3.fromRGB(255, 120, 125),

        PopupBackground = Color3.fromRGB(50, 7, 12),
        PopupBorder = Color3.fromRGB(230, 55, 65),

        NotificationBackground = Color3.fromRGB(60, 8, 14),
        NotificationBorder = Color3.fromRGB(255, 65, 75),

        Scrollbar = Color3.fromRGB(255, 65, 75),

        Transparency = {
            Main = 0,
            Secondary = 0,
            Element = 0,
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
            Main = {
                Color3.fromRGB(75, 10, 15),
                Color3.fromRGB(150, 22, 30),
                Color3.fromRGB(230, 55, 65)
            },

            TopBar = {
                Color3.fromRGB(75, 10, 15),
                Color3.fromRGB(150, 22, 30),
                Color3.fromRGB(255, 65, 75)
            },

            Sidebar = {
                Color3.fromRGB(50, 5, 10),
                Color3.fromRGB(100, 12, 18)
            },

            Element = {
                Color3.fromRGB(115, 15, 22),
                Color3.fromRGB(190, 30, 40)
            },

            Accent = {
                Color3.fromRGB(255, 65, 75),
                Color3.fromRGB(255, 110, 115),
                Color3.fromRGB(200, 30, 40)
            }
        }
    },

    Green = {
        Name = "Green",

        Background = Color3.fromRGB(8, 70, 30),
        Secondary = Color3.fromRGB(10, 110, 45),
        Element = Color3.fromRGB(15, 145, 58),
        Hover = Color3.fromRGB(25, 185, 75),
        Pressed = Color3.fromRGB(35, 205, 90),

        Border = Color3.fromRGB(55, 225, 105),
        BorderHover = Color3.fromRGB(90, 255, 135),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(205, 235, 215),
        MutedText = Color3.fromRGB(145, 190, 155),

        Accent = Color3.fromRGB(70, 255, 120),
        AccentDark = Color3.fromRGB(30, 195, 75),
        AccentHover = Color3.fromRGB(110, 255, 150),
        AccentText = Color3.fromRGB(5, 35, 15),

        Success = Color3.fromRGB(80, 255, 130),
        Warning = Color3.fromRGB(240, 180, 60),
        Error = Color3.fromRGB(220, 70, 70),
        Info = Color3.fromRGB(80, 160, 220),

        Tab = Color3.fromRGB(8, 85, 35),
        TabHover = Color3.fromRGB(20, 150, 60),
        TabSelected = Color3.fromRGB(30, 190, 75),

        Button = Color3.fromRGB(15, 145, 58),
        ButtonHover = Color3.fromRGB(25, 185, 75),
        ButtonPressed = Color3.fromRGB(35, 205, 90),

        ToggleOff = Color3.fromRGB(10, 90, 38),
        ToggleOn = Color3.fromRGB(70, 255, 120),
        ToggleCircle = Color3.fromRGB(220, 255, 230),

        Input = Color3.fromRGB(5, 40, 18),
        InputHover = Color3.fromRGB(12, 100, 40),
        InputFocus = Color3.fromRGB(70, 255, 120),

        Dropdown = Color3.fromRGB(5, 40, 18),
        DropdownHover = Color3.fromRGB(15, 110, 45),
        DropdownSelected = Color3.fromRGB(70, 255, 120),

        SliderBackground = Color3.fromRGB(12, 95, 40),
        SliderFill = Color3.fromRGB(70, 255, 120),
        SliderKnob = Color3.fromRGB(130, 255, 160),

        PopupBackground = Color3.fromRGB(5, 35, 15),
        PopupBorder = Color3.fromRGB(55, 225, 105),

        NotificationBackground = Color3.fromRGB(7, 50, 20),
        NotificationBorder = Color3.fromRGB(70, 255, 120),

        Scrollbar = Color3.fromRGB(70, 255, 120),

        Transparency = {
            Main = 0,
            Secondary = 0,
            Element = 0,
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
            Main = {
                Color3.fromRGB(8, 70, 30),
                Color3.fromRGB(15, 145, 58),
                Color3.fromRGB(70, 255, 120)
            },

            TopBar = {
                Color3.fromRGB(8, 70, 30),
                Color3.fromRGB(25, 185, 75),
                Color3.fromRGB(70, 255, 120)
            },

            Sidebar = {
                Color3.fromRGB(5, 45, 20),
                Color3.fromRGB(10, 90, 38)
            },

            Element = {
                Color3.fromRGB(10, 110, 45),
                Color3.fromRGB(25, 185, 75)
            },

            Accent = {
                Color3.fromRGB(70, 255, 120),
                Color3.fromRGB(130, 255, 160),
                Color3.fromRGB(30, 195, 75)
            }
        }
    },

    Blue = {
        Name = "Blue",

        Background = Color3.fromRGB(8, 45, 100),
        Secondary = Color3.fromRGB(10, 70, 145),
        Element = Color3.fromRGB(15, 95, 185),
        Hover = Color3.fromRGB(30, 125, 220),
        Pressed = Color3.fromRGB(45, 145, 240),

        Border = Color3.fromRGB(70, 165, 255),
        BorderHover = Color3.fromRGB(110, 195, 255),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(205, 225, 245),
        MutedText = Color3.fromRGB(140, 175, 215),

        Accent = Color3.fromRGB(75, 155, 255),
        AccentDark = Color3.fromRGB(35, 105, 205),
        AccentHover = Color3.fromRGB(115, 180, 255),
        AccentText = Color3.fromRGB(5, 20, 45),

        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(240, 180, 60),
        Error = Color3.fromRGB(220, 70, 70),
        Info = Color3.fromRGB(80, 180, 255),

        Tab = Color3.fromRGB(8, 55, 115),
        TabHover = Color3.fromRGB(20, 105, 190),
        TabSelected = Color3.fromRGB(35, 135, 225),

        Button = Color3.fromRGB(15, 95, 185),
        ButtonHover = Color3.fromRGB(30, 125, 220),
        ButtonPressed = Color3.fromRGB(45, 145, 240),

        ToggleOff = Color3.fromRGB(10, 65, 125),
        ToggleOn = Color3.fromRGB(75, 155, 255),
        ToggleCircle = Color3.fromRGB(220, 240, 255),

        Input = Color3.fromRGB(5, 30, 70),
        InputHover = Color3.fromRGB(10, 75, 145),
        InputFocus = Color3.fromRGB(75, 155, 255),

        Dropdown = Color3.fromRGB(5, 30, 70),
        DropdownHover = Color3.fromRGB(12, 85, 160),
        DropdownSelected = Color3.fromRGB(75, 155, 255),

        SliderBackground = Color3.fromRGB(10, 70, 140),
        SliderFill = Color3.fromRGB(75, 155, 255),
        SliderKnob = Color3.fromRGB(120, 190, 255),

        PopupBackground = Color3.fromRGB(5, 25, 60),
        PopupBorder = Color3.fromRGB(70, 165, 255),

        NotificationBackground = Color3.fromRGB(7, 35, 80),
        NotificationBorder = Color3.fromRGB(75, 155, 255),

        Scrollbar = Color3.fromRGB(75, 155, 255),

        Transparency = {
            Main = 0,
            Secondary = 0,
            Element = 0,
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
            Main = {
                Color3.fromRGB(8, 45, 100),
                Color3.fromRGB(15, 95, 185),
                Color3.fromRGB(75, 155, 255)
            },

            TopBar = {
                Color3.fromRGB(8, 45, 100),
                Color3.fromRGB(30, 125, 220),
                Color3.fromRGB(75, 155, 255)
            },

            Sidebar = {
                Color3.fromRGB(5, 30, 70),
                Color3.fromRGB(10, 70, 140)
            },

            Element = {
                Color3.fromRGB(10, 70, 145),
                Color3.fromRGB(30, 125, 220)
            },

            Accent = {
                Color3.fromRGB(75, 155, 255),
                Color3.fromRGB(120, 190, 255),
                Color3.fromRGB(35, 105, 205)
            }
        }
    },

    Purple = {
        Name = "Purple",

        Background = Color3.fromRGB(55, 10, 95),
        Secondary = Color3.fromRGB(80, 15, 135),
        Element = Color3.fromRGB(110, 25, 175),
        Hover = Color3.fromRGB(145, 40, 220),
        Pressed = Color3.fromRGB(165, 50, 235),

        Border = Color3.fromRGB(190, 75, 255),
        BorderHover = Color3.fromRGB(220, 110, 255),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(225, 205, 240),
        MutedText = Color3.fromRGB(170, 135, 195),

        Accent = Color3.fromRGB(190, 90, 255),
        AccentDark = Color3.fromRGB(130, 45, 200),
        AccentHover = Color3.fromRGB(215, 125, 255),
        AccentText = Color3.fromRGB(30, 8, 45),

        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(240, 180, 60),
        Error = Color3.fromRGB(220, 70, 70),
        Info = Color3.fromRGB(120, 160, 255),

        Tab = Color3.fromRGB(65, 10, 110),
        TabHover = Color3.fromRGB(120, 25, 175),
        TabSelected = Color3.fromRGB(155, 40, 220),

        Button = Color3.fromRGB(110, 25, 175),
        ButtonHover = Color3.fromRGB(145, 40, 220),
        ButtonPressed = Color3.fromRGB(165, 50, 235),

        ToggleOff = Color3.fromRGB(75, 12, 120),
        ToggleOn = Color3.fromRGB(190, 90, 255),
        ToggleCircle = Color3.fromRGB(240, 225, 255),

        Input = Color3.fromRGB(35, 5, 65),
        InputHover = Color3.fromRGB(90, 18, 145),
        InputFocus = Color3.fromRGB(190, 90, 255),

        Dropdown = Color3.fromRGB(35, 5, 65),
        DropdownHover = Color3.fromRGB(95, 20, 155),
        DropdownSelected = Color3.fromRGB(190, 90, 255),

        SliderBackground = Color3.fromRGB(75, 15, 125),
        SliderFill = Color3.fromRGB(190, 90, 255),
        SliderKnob = Color3.fromRGB(220, 140, 255),

        PopupBackground = Color3.fromRGB(30, 5, 55),
        PopupBorder = Color3.fromRGB(190, 75, 255),

        NotificationBackground = Color3.fromRGB(40, 7, 70),
        NotificationBorder = Color3.fromRGB(190, 90, 255),

        Scrollbar = Color3.fromRGB(190, 90, 255),

        Transparency = {
            Main = 0,
            Secondary = 0,
            Element = 0,
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
            Main = {
                Color3.fromRGB(55, 10, 95),
                Color3.fromRGB(110, 25, 175),
                Color3.fromRGB(190, 90, 255)
            },

            TopBar = {
                Color3.fromRGB(55, 10, 95),
                Color3.fromRGB(145, 40, 220),
                Color3.fromRGB(190, 90, 255)
            },

            Sidebar = {
                Color3.fromRGB(30, 5, 55),
                Color3.fromRGB(80, 15, 135)
            },

            Element = {
                Color3.fromRGB(80, 15, 135),
                Color3.fromRGB(145, 40, 220)
            },

            Accent = {
                Color3.fromRGB(190, 90, 255),
                Color3.fromRGB(220, 140, 255),
                Color3.fromRGB(130, 45, 200)
            }
        }
    },

    Orange = {
        Name = "Orange",

        Background = Color3.fromRGB(100, 40, 5),
        Secondary = Color3.fromRGB(145, 60, 8),
        Element = Color3.fromRGB(185, 80, 10),
        Hover = Color3.fromRGB(220, 105, 15),
        Pressed = Color3.fromRGB(235, 120, 20),

        Border = Color3.fromRGB(255, 145, 35),
        BorderHover = Color3.fromRGB(255, 180, 75),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(245, 220, 195),
        MutedText = Color3.fromRGB(205, 160, 115),

        Accent = Color3.fromRGB(255, 155, 50),
        AccentDark = Color3.fromRGB(205, 100, 25),
        AccentHover = Color3.fromRGB(255, 185, 90),
        AccentText = Color3.fromRGB(50, 20, 5),

        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 190, 60),
        Error = Color3.fromRGB(220, 70, 70),
        Info = Color3.fromRGB(80, 160, 220),

        Tab = Color3.fromRGB(115, 45, 5),
        TabHover = Color3.fromRGB(180, 75, 10),
        TabSelected = Color3.fromRGB(220, 105, 15),

        Button = Color3.fromRGB(185, 80, 10),
        ButtonHover = Color3.fromRGB(220, 105, 15),
        ButtonPressed = Color3.fromRGB(235, 120, 20),

        ToggleOff = Color3.fromRGB(115, 45, 5),
        ToggleOn = Color3.fromRGB(255, 155, 50),
        ToggleCircle = Color3.fromRGB(255, 235, 205),

        Input = Color3.fromRGB(55, 20, 5),
        InputHover = Color3.fromRGB(125, 50, 8),
        InputFocus = Color3.fromRGB(255, 155, 50),

        Dropdown = Color3.fromRGB(55, 20, 5),
        DropdownHover = Color3.fromRGB(135, 55, 8),
        DropdownSelected = Color3.fromRGB(255, 155, 50),

        SliderBackground = Color3.fromRGB(120, 50, 8),
        SliderFill = Color3.fromRGB(255, 155, 50),
        SliderKnob = Color3.fromRGB(255, 190, 90),

        PopupBackground = Color3.fromRGB(45, 15, 3),
        PopupBorder = Color3.fromRGB(255, 145, 35),

        NotificationBackground = Color3.fromRGB(65, 25, 4),
        NotificationBorder = Color3.fromRGB(255, 155, 50),

        Scrollbar = Color3.fromRGB(255, 155, 50),

        Transparency = {
            Main = 0,
            Secondary = 0,
            Element = 0,
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
            Main = {
                Color3.fromRGB(100, 40, 5),
                Color3.fromRGB(185, 80, 10),
                Color3.fromRGB(255, 155, 50)
            },

            TopBar = {
                Color3.fromRGB(100, 40, 5),
                Color3.fromRGB(220, 105, 15),
                Color3.fromRGB(255, 155, 50)
            },

            Sidebar = {
                Color3.fromRGB(55, 20, 5),
                Color3.fromRGB(120, 50, 8)
            },

            Element = {
                Color3.fromRGB(145, 60, 8),
                Color3.fromRGB(220, 105, 15)
            },

            Accent = {
                Color3.fromRGB(255, 155, 50),
                Color3.fromRGB(255, 200, 100),
                Color3.fromRGB(205, 100, 25)
            }
        }
    },

    Halloween = {
        Name = "Halloween",

        Background = Color3.fromRGB(20, 7, 25),
        Secondary = Color3.fromRGB(40, 10, 48),
        Element = Color3.fromRGB(68, 17, 72),
        Hover = Color3.fromRGB(105, 25, 95),
        Pressed = Color3.fromRGB(135, 35, 115),

        Border = Color3.fromRGB(145, 45, 155),
        BorderHover = Color3.fromRGB(200, 70, 200),

        Text = Color3.fromRGB(255, 245, 225),
        SubText = Color3.fromRGB(225, 195, 215),
        MutedText = Color3.fromRGB(170, 135, 165),

        Accent = Color3.fromRGB(255, 115, 0),
        AccentDark = Color3.fromRGB(195, 55, 0),
        AccentHover = Color3.fromRGB(255, 155, 20),
        AccentText = Color3.fromRGB(35, 10, 5),

        Success = Color3.fromRGB(100, 210, 120),
        Warning = Color3.fromRGB(255, 175, 50),
        Error = Color3.fromRGB(220, 65, 60),
        Info = Color3.fromRGB(120, 100, 220),

        Tab = Color3.fromRGB(38, 10, 45),
        TabHover = Color3.fromRGB(80, 20, 80),
        TabSelected = Color3.fromRGB(120, 30, 105),

        Button = Color3.fromRGB(68, 17, 72),
        ButtonHover = Color3.fromRGB(105, 25, 95),
        ButtonPressed = Color3.fromRGB(140, 35, 115),

        ToggleOff = Color3.fromRGB(45, 10, 48),
        ToggleOn = Color3.fromRGB(255, 115, 0),
        ToggleCircle = Color3.fromRGB(255, 240, 210),

        Input = Color3.fromRGB(28, 8, 34),
        InputHover = Color3.fromRGB(55, 13, 60),
        InputFocus = Color3.fromRGB(255, 115, 0),

        Dropdown = Color3.fromRGB(28, 8, 34),
        DropdownHover = Color3.fromRGB(70, 18, 72),
        DropdownSelected = Color3.fromRGB(255, 115, 0),

        SliderBackground = Color3.fromRGB(48, 12, 52),
        SliderFill = Color3.fromRGB(255, 115, 0),
        SliderKnob = Color3.fromRGB(255, 165, 30),

        PopupBackground = Color3.fromRGB(25, 7, 30),
        PopupBorder = Color3.fromRGB(180, 55, 150),

        NotificationBackground = Color3.fromRGB(30, 8, 36),
        NotificationBorder = Color3.fromRGB(255, 115, 0),

        Scrollbar = Color3.fromRGB(255, 115, 0),

        Transparency = {
            Main = 0,
            Secondary = 0,
            Element = 0,
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
            Main = {
                Color3.fromRGB(38, 10, 45),
                Color3.fromRGB(120, 30, 105),
                Color3.fromRGB(255, 115, 0)
            },

            TopBar = {
                Color3.fromRGB(45, 10, 55),
                Color3.fromRGB(150, 35, 120),
                Color3.fromRGB(255, 115, 0)
            },

            Sidebar = {
                Color3.fromRGB(20, 7, 25),
                Color3.fromRGB(68, 17, 72)
            },

            Element = {
                Color3.fromRGB(68, 17, 72),
                Color3.fromRGB(140, 35, 115),
                Color3.fromRGB(255, 115, 0)
            },

            Accent = {
                Color3.fromRGB(255, 165, 30),
                Color3.fromRGB(255, 115, 0),
                Color3.fromRGB(170, 35, 140)
            }
        }
    },

    ["Roman Reigns"] = {
        Name = "Roman Reigns",

        Background = Color3.fromRGB(5, 9, 10),
        Secondary = Color3.fromRGB(8, 25, 24),
        Element = Color3.fromRGB(12, 47, 43),
        Hover = Color3.fromRGB(20, 70, 64),
        Pressed = Color3.fromRGB(27, 88, 79),

        Border = Color3.fromRGB(52, 110, 98),
        BorderHover = Color3.fromRGB(82, 145, 125),

        Text = Color3.fromRGB(245, 245, 240),
        SubText = Color3.fromRGB(190, 202, 197),
        MutedText = Color3.fromRGB(125, 145, 140),

        Accent = Color3.fromRGB(215, 178, 75),
        AccentDark = Color3.fromRGB(150, 115, 38),
        AccentHover = Color3.fromRGB(240, 205, 105),
        AccentText = Color3.fromRGB(20, 18, 10),

        Success = Color3.fromRGB(80, 190, 125),
        Warning = Color3.fromRGB(230, 175, 60),
        Error = Color3.fromRGB(190, 55, 50),
        Info = Color3.fromRGB(70, 145, 160),

        Tab = Color3.fromRGB(7, 27, 26),
        TabHover = Color3.fromRGB(16, 58, 53),
        TabSelected = Color3.fromRGB(28, 82, 73),

        Button = Color3.fromRGB(12, 47, 43),
        ButtonHover = Color3.fromRGB(20, 70, 64),
        ButtonPressed = Color3.fromRGB(27, 88, 79),

        ToggleOff = Color3.fromRGB(8, 35, 33),
        ToggleOn = Color3.fromRGB(215, 178, 75),
        ToggleCircle = Color3.fromRGB(245, 235, 200),

        Input = Color3.fromRGB(4, 17, 18),
        InputHover = Color3.fromRGB(10, 40, 38),
        InputFocus = Color3.fromRGB(215, 178, 75),

        Dropdown = Color3.fromRGB(4, 17, 18),
        DropdownHover = Color3.fromRGB(12, 48, 45),
        DropdownSelected = Color3.fromRGB(215, 178, 75),

        SliderBackground = Color3.fromRGB(10, 38, 36),
        SliderFill = Color3.fromRGB(215, 178, 75),
        SliderKnob = Color3.fromRGB(240, 205, 105),

        PopupBackground = Color3.fromRGB(5, 14, 15),
        PopupBorder = Color3.fromRGB(52, 110, 98),

        NotificationBackground = Color3.fromRGB(7, 22, 22),
        NotificationBorder = Color3.fromRGB(215, 178, 75),

        Scrollbar = Color3.fromRGB(215, 178, 75),

        Transparency = {
            Main = 0,
            Secondary = 0,
            Element = 0,
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
            Main = {
                Color3.fromRGB(5, 9, 10),
                Color3.fromRGB(12, 47, 43),
                Color3.fromRGB(215, 178, 75)
            },

            TopBar = {
                Color3.fromRGB(5, 20, 20),
                Color3.fromRGB(20, 70, 64),
                Color3.fromRGB(215, 178, 75)
            },

            Sidebar = {
                Color3.fromRGB(5, 14, 15),
                Color3.fromRGB(8, 35, 33)
            },

            Element = {
                Color3.fromRGB(12, 47, 43),
                Color3.fromRGB(20, 70, 64),
                Color3.fromRGB(215, 178, 75)
            },

            Accent = {
                Color3.fromRGB(240, 205, 105),
                Color3.fromRGB(215, 178, 75),
                Color3.fromRGB(150, 115, 38)
            }
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

    Player = Player or GetCurrentPlayer()

    return IsRomanReignsUser(Player)
end

function Theme.Get(Name, Player)
    if not Theme.IsAllowed(Name, Player) then
        return Theme.BuiltIn.Default
    end

    return Theme.BuiltIn[Name]
end

function Theme.List(Player)
    Player = Player or GetCurrentPlayer()

    print("[OTC DEBUG] LocalPlayer:", Players.LocalPlayer)
    print("[OTC DEBUG] LocalPlayer.Name:", Players.LocalPlayer and Players.LocalPlayer.Name)
    print("[OTC DEBUG] Player argument:", Player)
    print("[OTC DEBUG] Player.Name:", Player and Player.Name)
    print("[OTC DEBUG] Roman allowed:", Theme.IsAllowed("Roman Reigns", Player))

    local List = {}

    for Name in pairs(Theme.BuiltIn) do
        print("[OTC DEBUG] Theme:", Name, "Allowed:", Theme.IsAllowed(Name, Player))

        if Theme.IsAllowed(Name, Player) then
            table.insert(List, Name)
        end
    end

    table.sort(List, function(A, B)
        if A == "Default" then
            return true
        end

        if B == "Default" then
            return false
        end

        return A < B
    end)

    print("[OTC DEBUG] Final themes:", table.concat(List, ", "))

    return List
end

function Theme.Exists(Name, Player)
    return Theme.BuiltIn[Name] ~= nil
        and Theme.IsAllowed(Name, Player)
end

function Theme.GetNames(Player)
    return Theme.List(Player)
end

return Theme