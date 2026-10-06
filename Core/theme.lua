--[[
    OTC Hub v1
    Advanced Theme System
    by Aerlro
]]

local Theme = {}

local Players = game:GetService("Players")

local PRIVATE_THEME_USER = "romansmkboss"

local function RGB(R, G, B)
    return Color3.fromRGB(R, G, B)
end

local function Gradient(...)
    local Colors = {...}
    local Keypoints = {}

    local Count = #Colors

    for Index, Color in ipairs(Colors) do
        local Position = (Index - 1) / math.max(Count - 1, 1)

        table.insert(
            Keypoints,
            ColorSequenceKeypoint.new(
                Position,
                Color
            )
        )
    end

    return {
        Colors = ColorSequence.new(Keypoints),
        Rotation = 0,
        Enabled = true
    }
end

local function IsRomanReignsUser(Player)
    Player = Player or Players.LocalPlayer

    if not Player then
        return false
    end

    return string.lower(Player.Name) == string.lower(PRIVATE_THEME_USER)
end

Theme.BuiltIn = {

    --// DEFAULT
    Default = {

        Background = RGB(35, 35, 35),
        Secondary = RGB(55, 55, 55),
        Element = RGB(75, 75, 75),

        Hover = RGB(100, 100, 100),
        Pressed = RGB(120, 120, 120),

        Border = RGB(140, 140, 140),
        BorderHover = RGB(180, 180, 180),

        Text = RGB(255, 255, 255),
        SubText = RGB(220, 220, 220),
        MutedText = RGB(165, 165, 165),

        Accent = RGB(255, 255, 255),
        AccentDark = RGB(190, 190, 190),
        AccentHover = RGB(255, 255, 255),
        AccentText = RGB(30, 30, 30),

        Success = RGB(80, 220, 120),
        Warning = RGB(255, 190, 70),
        Error = RGB(255, 75, 75),
        Info = RGB(80, 160, 255),

        Tab = RGB(55, 55, 55),
        TabHover = RGB(85, 85, 85),
        TabSelected = RGB(100, 100, 100),

        Button = RGB(75, 75, 75),
        ButtonHover = RGB(100, 100, 100),
        ButtonPressed = RGB(120, 120, 120),

        ToggleOff = RGB(55, 55, 55),
        ToggleOn = RGB(255, 255, 255),
        ToggleCircle = RGB(240, 240, 240),

        Input = RGB(45, 45, 45),
        InputHover = RGB(60, 60, 60),
        InputFocus = RGB(255, 255, 255),

        Dropdown = RGB(45, 45, 45),
        DropdownHover = RGB(70, 70, 70),
        DropdownSelected = RGB(255, 255, 255),

        SliderBackground = RGB(55, 55, 55),
        SliderFill = RGB(255, 255, 255),
        SliderKnob = RGB(255, 255, 255),

        PopupBackground = RGB(35, 35, 35),
        PopupBorder = RGB(140, 140, 140),

        NotificationBackground = RGB(45, 45, 45),
        NotificationBorder = RGB(140, 140, 140),

        Scrollbar = RGB(140, 140, 140),

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
            Main = 10,
            Element = 7,
            Button = 7,
            Input = 7,
            Dropdown = 7,
            Popup = 10,
            Notification = 8
        },

        Effects = {
            Glow = false,
            Shadow = true,
            Gradient = false,
            AnimatedGradient = false
        },

        Gradients = {
            Main = Gradient(
                RGB(35, 35, 35),
                RGB(55, 55, 55)
            ),

            TopBar = Gradient(
                RGB(55, 55, 55),
                RGB(75, 75, 75)
            ),

            Sidebar = Gradient(
                RGB(45, 45, 45),
                RGB(60, 60, 60)
            ),

            Element = Gradient(
                RGB(70, 70, 70),
                RGB(90, 90, 90)
            ),

            Accent = Gradient(
                RGB(255, 255, 255),
                RGB(190, 190, 190)
            )
        }
    },

    --// RED
    Red = {

        Background = RGB(75, 10, 15),
        Secondary = RGB(115, 15, 22),
        Element = RGB(150, 22, 30),

        Hover = RGB(190, 30, 40),
        Pressed = RGB(220, 45, 55),

        Border = RGB(230, 55, 65),
        BorderHover = RGB(255, 90, 100),

        Text = RGB(255, 255, 255),
        SubText = RGB(255, 205, 205),
        MutedText = RGB(220, 145, 145),

        Accent = RGB(255, 65, 75),
        AccentDark = RGB(200, 30, 40),
        AccentHover = RGB(255, 95, 105),
        AccentText = RGB(255, 255, 255),

        Success = RGB(80, 230, 120),
        Warning = RGB(255, 190, 60),
        Error = RGB(255, 70, 70),
        Info = RGB(90, 160, 255),

        Tab = RGB(100, 12, 20),
        TabHover = RGB(160, 20, 30),
        TabSelected = RGB(200, 35, 45),

        Button = RGB(150, 22, 30),
        ButtonHover = RGB(190, 30, 40),
        ButtonPressed = RGB(220, 45, 55),

        ToggleOff = RGB(80, 15, 20),
        ToggleOn = RGB(255, 65, 75),
        ToggleCircle = RGB(255, 240, 240),

        Input = RGB(55, 10, 15),
        InputHover = RGB(85, 15, 22),
        InputFocus = RGB(255, 65, 75),

        Dropdown = RGB(55, 10, 15),
        DropdownHover = RGB(105, 15, 25),
        DropdownSelected = RGB(255, 65, 75),

        SliderBackground = RGB(80, 15, 20),
        SliderFill = RGB(255, 65, 75),
        SliderKnob = RGB(255, 100, 105),

        PopupBackground = RGB(65, 8, 14),
        PopupBorder = RGB(230, 55, 65),

        NotificationBackground = RGB(75, 10, 15),
        NotificationBorder = RGB(230, 55, 65),

        Scrollbar = RGB(230, 55, 65),

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
            Main = 10,
            Element = 7,
            Button = 7,
            Input = 7,
            Dropdown = 7,
            Popup = 10,
            Notification = 8
        },

        Effects = {
            Glow = true,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = false
        },

        Gradients = {
            Main = Gradient(
                RGB(75, 10, 15),
                RGB(125, 15, 25),
                RGB(65, 5, 10)
            ),

            TopBar = Gradient(
                RGB(125, 15, 22),
                RGB(190, 30, 40)
            ),

            Sidebar = Gradient(
                RGB(80, 10, 16),
                RGB(130, 18, 25)
            ),

            Element = Gradient(
                RGB(150, 22, 30),
                RGB(200, 35, 45)
            ),

            Accent = Gradient(
                RGB(255, 100, 110),
                RGB(255, 40, 55)
            )
        }
    },

    --// GREEN
    Green = {

        Background = RGB(8, 70, 30),
        Secondary = RGB(10, 110, 45),
        Element = RGB(15, 145, 58),

        Hover = RGB(25, 185, 75),
        Pressed = RGB(35, 215, 90),

        Border = RGB(55, 225, 105),
        BorderHover = RGB(90, 255, 135),

        Text = RGB(255, 255, 255),
        SubText = RGB(200, 255, 215),
        MutedText = RGB(140, 215, 165),

        Accent = RGB(70, 255, 120),
        AccentDark = RGB(30, 195, 75),
        AccentHover = RGB(100, 255, 145),
        AccentText = RGB(5, 45, 20),

        Success = RGB(80, 255, 130),
        Warning = RGB(255, 200, 60),
        Error = RGB(255, 75, 75),
        Info = RGB(80, 170, 255),

        Tab = RGB(10, 90, 38),
        TabHover = RGB(20, 145, 60),
        TabSelected = RGB(35, 190, 80),

        Button = RGB(15, 145, 58),
        ButtonHover = RGB(25, 185, 75),
        ButtonPressed = RGB(35, 215, 90),

        ToggleOff = RGB(10, 80, 35),
        ToggleOn = RGB(70, 255, 120),
        ToggleCircle = RGB(230, 255, 235),

        Input = RGB(6, 55, 25),
        InputHover = RGB(10, 90, 38),
        InputFocus = RGB(70, 255, 120),

        Dropdown = RGB(6, 55, 25),
        DropdownHover = RGB(15, 100, 42),
        DropdownSelected = RGB(70, 255, 120),

        SliderBackground = RGB(10, 90, 38),
        SliderFill = RGB(70, 255, 120),
        SliderKnob = RGB(110, 255, 150),

        PopupBackground = RGB(7, 60, 26),
        PopupBorder = RGB(55, 225, 105),

        NotificationBackground = RGB(8, 70, 30),
        NotificationBorder = RGB(55, 225, 105),

        Scrollbar = RGB(55, 225, 105),

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
            Main = 10,
            Element = 7,
            Button = 7,
            Input = 7,
            Dropdown = 7,
            Popup = 10,
            Notification = 8
        },

        Effects = {
            Glow = true,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = false
        },

        Gradients = {
            Main = Gradient(
                RGB(8, 70, 30),
                RGB(10, 120, 45),
                RGB(5, 60, 25)
            ),

            TopBar = Gradient(
                RGB(10, 110, 45),
                RGB(25, 185, 75)
            ),

            Sidebar = Gradient(
                RGB(8, 80, 35),
                RGB(12, 135, 55)
            ),

            Element = Gradient(
                RGB(15, 145, 58),
                RGB(35, 205, 85)
            ),

            Accent = Gradient(
                RGB(110, 255, 150),
                RGB(40, 225, 95)
            )
        }
    },

    --// BLUE
    Blue = {

        Background = RGB(8, 45, 100),
        Secondary = RGB(10, 70, 145),
        Element = RGB(15, 95, 185),

        Hover = RGB(30, 125, 220),
        Pressed = RGB(45, 150, 245),

        Border = RGB(70, 165, 255),
        BorderHover = RGB(110, 195, 255),

        Text = RGB(255, 255, 255),
        SubText = RGB(200, 225, 255),
        MutedText = RGB(145, 185, 230),

        Accent = RGB(75, 155, 255),
        AccentDark = RGB(35, 105, 205),
        AccentHover = RGB(105, 180, 255),
        AccentText = RGB(255, 255, 255),

        Success = RGB(80, 230, 140),
        Warning = RGB(255, 195, 60),
        Error = RGB(255, 75, 75),
        Info = RGB(80, 175, 255),

        Tab = RGB(10, 60, 120),
        TabHover = RGB(20, 105, 190),
        TabSelected = RGB(35, 135, 225),

        Button = RGB(15, 95, 185),
        ButtonHover = RGB(30, 125, 220),
        ButtonPressed = RGB(45, 150, 245),

        ToggleOff = RGB(10, 65, 130),
        ToggleOn = RGB(75, 155, 255),
        ToggleCircle = RGB(235, 245, 255),

        Input = RGB(6, 35, 80),
        InputHover = RGB(10, 65, 130),
        InputFocus = RGB(75, 155, 255),

        Dropdown = RGB(6, 35, 80),
        DropdownHover = RGB(15, 75, 145),
        DropdownSelected = RGB(75, 155, 255),

        SliderBackground = RGB(10, 65, 130),
        SliderFill = RGB(75, 155, 255),
        SliderKnob = RGB(110, 190, 255),

        PopupBackground = RGB(7, 40, 90),
        PopupBorder = RGB(70, 165, 255),

        NotificationBackground = RGB(8, 45, 100),
        NotificationBorder = RGB(70, 165, 255),

        Scrollbar = RGB(70, 165, 255),

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
            Main = 10,
            Element = 7,
            Button = 7,
            Input = 7,
            Dropdown = 7,
            Popup = 10,
            Notification = 8
        },

        Effects = {
            Glow = true,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = false
        },

        Gradients = {
            Main = Gradient(
                RGB(8, 45, 100),
                RGB(12, 80, 165),
                RGB(5, 35, 80)
            ),

            TopBar = Gradient(
                RGB(10, 70, 145),
                RGB(30, 125, 220)
            ),

            Sidebar = Gradient(
                RGB(8, 55, 115),
                RGB(15, 95, 175)
            ),

            Element = Gradient(
                RGB(15, 95, 185),
                RGB(40, 140, 230)
            ),

            Accent = Gradient(
                RGB(110, 190, 255),
                RGB(55, 125, 255)
            )
        }
    },

    --// PURPLE
    Purple = {

        Background = RGB(55, 10, 95),
        Secondary = RGB(80, 15, 135),
        Element = RGB(110, 25, 175),

        Hover = RGB(145, 40, 220),
        Pressed = RGB(175, 55, 245),

        Border = RGB(190, 75, 255),
        BorderHover = RGB(220, 120, 255),

        Text = RGB(255, 255, 255),
        SubText = RGB(230, 205, 255),
        MutedText = RGB(175, 135, 215),

        Accent = RGB(190, 90, 255),
        AccentDark = RGB(130, 45, 200),
        AccentHover = RGB(215, 125, 255),
        AccentText = RGB(255, 255, 255),

        Success = RGB(90, 230, 140),
        Warning = RGB(255, 190, 60),
        Error = RGB(255, 75, 100),
        Info = RGB(120, 150, 255),

        Tab = RGB(70, 12, 115),
        TabHover = RGB(120, 25, 170),
        TabSelected = RGB(155, 45, 215),

        Button = RGB(110, 25, 175),
        ButtonHover = RGB(145, 40, 220),
        ButtonPressed = RGB(175, 55, 245),

        ToggleOff = RGB(70, 15, 115),
        ToggleOn = RGB(190, 90, 255),
        ToggleCircle = RGB(245, 235, 255),

        Input = RGB(40, 8, 70),
        InputHover = RGB(70, 15, 115),
        InputFocus = RGB(190, 90, 255),

        Dropdown = RGB(40, 8, 70),
        DropdownHover = RGB(85, 20, 130),
        DropdownSelected = RGB(190, 90, 255),

        SliderBackground = RGB(70, 15, 115),
        SliderFill = RGB(190, 90, 255),
        SliderKnob = RGB(220, 135, 255),

        PopupBackground = RGB(45, 8, 80),
        PopupBorder = RGB(190, 75, 255),

        NotificationBackground = RGB(55, 10, 95),
        NotificationBorder = RGB(190, 75, 255),

        Scrollbar = RGB(190, 75, 255),

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
            Main = 10,
            Element = 7,
            Button = 7,
            Input = 7,
            Dropdown = 7,
            Popup = 10,
            Notification = 8
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
                RGB(100, 15, 155),
                RGB(40, 5, 75)
            ),

            TopBar = Gradient(
                RGB(80, 15, 135),
                RGB(145, 40, 220)
            ),

            Sidebar = Gradient(
                RGB(65, 10, 110),
                RGB(110, 25, 165)
            ),

            Element = Gradient(
                RGB(110, 25, 175),
                RGB(165, 50, 230)
            ),

            Accent = Gradient(
                RGB(225, 135, 255),
                RGB(170, 65, 255)
            )
        }
    },

    --// ORANGE
    Orange = {

        Background = RGB(100, 40, 5),
        Secondary = RGB(145, 60, 8),
        Element = RGB(185, 80, 10),

        Hover = RGB(220, 105, 15),
        Pressed = RGB(245, 125, 20),

        Border = RGB(255, 145, 35),
        BorderHover = RGB(255, 180, 75),

        Text = RGB(255, 255, 255),
        SubText = RGB(255, 225, 190),
        MutedText = RGB(220, 165, 105),

        Accent = RGB(255, 155, 50),
        AccentDark = RGB(205, 100, 25),
        AccentHover = RGB(255, 185, 85),
        AccentText = RGB(55, 20, 5),

        Success = RGB(90, 230, 120),
        Warning = RGB(255, 200, 60),
        Error = RGB(255, 70, 50),
        Info = RGB(80, 165, 255),

        Tab = RGB(120, 45, 5),
        TabHover = RGB(175, 70, 10),
        TabSelected = RGB(220, 105, 15),

        Button = RGB(185, 80, 10),
        ButtonHover = RGB(220, 105, 15),
        ButtonPressed = RGB(245, 125, 20),

        ToggleOff = RGB(100, 35, 5),
        ToggleOn = RGB(255, 155, 50),
        ToggleCircle = RGB(255, 245, 225),

        Input = RGB(65, 25, 4),
        InputHover = RGB(105, 40, 5),
        InputFocus = RGB(255, 155, 50),

        Dropdown = RGB(65, 25, 4),
        DropdownHover = RGB(120, 45, 5),
        DropdownSelected = RGB(255, 155, 50),

        SliderBackground = RGB(110, 40, 5),
        SliderFill = RGB(255, 155, 50),
        SliderKnob = RGB(255, 195, 90),

        PopupBackground = RGB(85, 30, 4),
        PopupBorder = RGB(255, 145, 35),

        NotificationBackground = RGB(100, 40, 5),
        NotificationBorder = RGB(255, 145, 35),

        Scrollbar = RGB(255, 145, 35),

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
            Main = 10,
            Element = 7,
            Button = 7,
            Input = 7,
            Dropdown = 7,
            Popup = 10,
            Notification = 8
        },

        Effects = {
            Glow = true,
            Shadow = true,
            Gradient = true,
            AnimatedGradient = false
        },

        Gradients = {
            Main = Gradient(
                RGB(100, 40, 5),
                RGB(165, 65, 8),
                RGB(80, 25, 3)
            ),

            TopBar = Gradient(
                RGB(145, 60, 8),
                RGB(220, 105, 15)
            ),

            Sidebar = Gradient(
                RGB(110, 40, 5),
                RGB(175, 70, 10)
            ),

            Element = Gradient(
                RGB(185, 80, 10),
                RGB(235, 115, 20)
            ),

            Accent = Gradient(
                RGB(255, 200, 90),
                RGB(255, 120, 25)
            )
        }
    },

    --// HALLOWEEN
    Halloween = {

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

        Success = RGB(100, 255, 110),
        Warning = RGB(255, 175, 35),
        Error = RGB(255, 55, 55),
        Info = RGB(175, 90, 255),

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
                Enabled = true,
                Rotation = 45,
                Colors = ColorSequence.new({
                    ColorSequenceKeypoint.new(
                        0,
                        RGB(20, 7, 25)
                    ),

                    ColorSequenceKeypoint.new(
                        0.45,
                        RGB(65, 10, 65)
                    ),

                    ColorSequenceKeypoint.new(
                        1,
                        RGB(110, 28, 5)
                    )
                })
            },

            TopBar = {
                Enabled = true,
                Rotation = 0,
                Colors = ColorSequence.new({
                    ColorSequenceKeypoint.new(
                        0,
                        RGB(65, 12, 75)
                    ),

                    ColorSequenceKeypoint.new(
                        0.5,
                        RGB(120, 25, 100)
                    ),

                    ColorSequenceKeypoint.new(
                        1,
                        RGB(220, 70, 0)
                    )
                })
            },

            Sidebar = {
                Enabled = true,
                Rotation = 90,
                Colors = ColorSequence.new({
                    ColorSequenceKeypoint.new(
                        0,
                        RGB(30, 7, 38)
                    ),

                    ColorSequenceKeypoint.new(
                        0.5,
                        RGB(70, 12, 75)
                    ),

                    ColorSequenceKeypoint.new(
                        1,
                        RGB(100, 25, 65)
                    )
                })
            },

            Element = {
                Enabled = true,
                Rotation = 45,
                Colors = ColorSequence.new({
                    ColorSequenceKeypoint.new(
                        0,
                        RGB(65, 15, 70)
                    ),

                    ColorSequenceKeypoint.new(
                        0.5,
                        RGB(115, 25, 100)
                    ),

                    ColorSequenceKeypoint.new(
                        1,
                        RGB(180, 55, 10)
                    )
                })
            },

            Accent = {
                Enabled = true,
                Rotation = 90,
                Colors = ColorSequence.new({
                    ColorSequenceKeypoint.new(
                        0,
                        RGB(255, 185, 40)
                    ),

                    ColorSequenceKeypoint.new(
                        0.5,
                        RGB(255, 105, 0)
                    ),

                    ColorSequenceKeypoint.new(
                        1,
                        RGB(160, 30, 150)
                    )
                })
            }
        }
    },

    --// ROMAN REIGNS - PRIVATE
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
                Enabled = true,
                Rotation = 45,
                Colors = ColorSequence.new({
                    ColorSequenceKeypoint.new(
                        0,
                        RGB(5, 9, 10)
                    ),

                    ColorSequenceKeypoint.new(
                        0.45,
                        RGB(8, 35, 32)
                    ),

                    ColorSequenceKeypoint.new(
                        1,
                        RGB(18, 55, 48)
                    )
                })
            },

            TopBar = {
                Enabled = true,
                Rotation = 0,
                Colors = ColorSequence.new({
                    ColorSequenceKeypoint.new(
                        0,
                        RGB(8, 25, 24)
                    ),

                    ColorSequenceKeypoint.new(
                        0.5,
                        RGB(70, 55, 20)
                    ),

                    ColorSequenceKeypoint.new(
                        1,
                        RGB(215, 178, 75)
                    )
                })
            },

            Sidebar = {
                Enabled = true,
                Rotation = 90,
                Colors = ColorSequence.new({
                    ColorSequenceKeypoint.new(
                        0,
                        RGB(5, 18, 18)
                    ),

                    ColorSequenceKeypoint.new(
                        1,
                        RGB(10, 45, 41)
                    )
                })
            },

            Element = {
                Enabled = true,
                Rotation = 45,
                Colors = ColorSequence.new({
                    ColorSequenceKeypoint.new(
                        0,
                        RGB(12, 47, 43)
                    ),

                    ColorSequenceKeypoint.new(
                        0.5,
                        RGB(35, 85, 73)
                    ),

                    ColorSequenceKeypoint.new(
                        1,
                        RGB(150, 115, 38)
                    )
                })
            },

            Accent = {
                Enabled = true,
                Rotation = 90,
                Colors = ColorSequence.new({
                    ColorSequenceKeypoint.new(
                        0,
                        RGB(240, 205, 105)
                    ),

                    ColorSequenceKeypoint.new(
                        0.5,
                        RGB(215, 178, 75)
                    ),

                    ColorSequenceKeypoint.new(
                        1,
                        RGB(150, 115, 38)
                    )
                })
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

function Theme:IsPrivate(Name)
    return Name == "Roman Reigns"
end

function Theme:IsAllowed(Name, Player)
    if not self:IsPrivate(Name) then
        return true
    end

    return IsRomanReignsUser(Player)
end

function Theme:GetAccessMessage(Name)
    if Name == "Roman Reigns" then
        return "Roman Reigns theme is private."
    end

    return "You don't have permission to use this theme."
end

function Theme:Get(Name, Player)
    Name = Name or "Default"

    if not self:IsAllowed(Name, Player) then
        return nil
    end

    return self.BuiltIn[Name]
end

function Theme:Exists(Name, Player)
    if not self:IsAllowed(Name, Player) then
        return false
    end

    return self.BuiltIn[Name] ~= nil
end

function Theme:Register(Name, Data)
    assert(
        type(Name) == "string",
        "Theme name must be a string"
    )

    assert(
        type(Data) == "table",
        "Theme data must be a table"
    )

    if Name == "Roman Reigns" and not IsRomanReignsUser() then
        warn(
            "[OTC Hub] Roman Reigns theme is private."
        )

        return nil
    end

    self.BuiltIn[Name] = Data

    return Data
end

function Theme:Remove(Name)
    if Name == "Roman Reigns" then
        warn(
            "[OTC Hub] The Roman Reigns theme is private."
        )

        return false
    end

    if self.BuiltIn[Name] == nil then
        return false
    end

    if Name == "Default" then
        warn(
            "[OTC Hub] The Default theme cannot be removed."
        )

        return false
    end

    self.BuiltIn[Name] = nil

    return true
end

function Theme:List(Player)
    local Themes = {}

    Player = Player or Players.LocalPlayer

    for Name in pairs(self.BuiltIn) do
        if self:IsAllowed(Name, Player) then
            table.insert(
                Themes,
                Name
            )
        end
    end

    table.sort(Themes)

    return Themes
end

function Theme:GetGradient(Name, GradientName, Player)
    local ThemeData = self:Get(Name, Player)

    if not ThemeData then
        return nil
    end

    if not ThemeData.Gradients then
        return nil
    end

    return ThemeData.Gradients[GradientName]
end

function Theme:HasGradient(Name, GradientName, Player)
    local GradientData = self:GetGradient(
        Name,
        GradientName,
        Player
    )

    return GradientData ~= nil
        and GradientData.Enabled == true
end

function Theme:GetColor(Name, ColorName, Player)
    local ThemeData = self:Get(Name, Player)

    if not ThemeData then
        return nil
    end

    return ThemeData[ColorName]
end

function Theme:GetTransparency(Name, ObjectName, Player)
    local ThemeData = self:Get(Name, Player)

    if not ThemeData
        or not ThemeData.Transparency then
        return 0
    end

    return ThemeData.Transparency[ObjectName] or 0
end

function Theme:GetCorner(Name, ObjectName, Player)
    local ThemeData = self:Get(Name, Player)

    if not ThemeData
        or not ThemeData.Corners then
        return 8
    end

    return ThemeData.Corners[ObjectName] or 8
end

function Theme:GetEffect(Name, EffectName, Player)
    local ThemeData = self:Get(Name, Player)

    if not ThemeData
        or not ThemeData.Effects then
        return false
    end

    return ThemeData.Effects[EffectName] == true
end

return Theme