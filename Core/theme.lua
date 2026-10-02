--[[
    OTC Hub v1
    Theme System
    by Aerlro
]]

local Theme = {}

Theme.BuiltIn = {

    --// DEFAULT
    Default = {
        Background = Color3.fromRGB(18, 18, 18),
        Secondary = Color3.fromRGB(28, 28, 28),
        Element = Color3.fromRGB(38, 38, 38),

        Hover = Color3.fromRGB(52, 52, 52),
        Border = Color3.fromRGB(75, 75, 75),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(190, 190, 190),

        Accent = Color3.fromRGB(255, 255, 255),
        AccentDark = Color3.fromRGB(200, 200, 200)
    },

    --// RED
    Red = {
        Background = Color3.fromRGB(32, 10, 10),
        Secondary = Color3.fromRGB(50, 15, 15),
        Element = Color3.fromRGB(68, 20, 20),

        Hover = Color3.fromRGB(90, 27, 27),
        Border = Color3.fromRGB(125, 40, 40),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(215, 175, 175),

        Accent = Color3.fromRGB(255, 70, 70),
        AccentDark = Color3.fromRGB(205, 35, 35)
    },

    --// GREEN
    Green = {
        Background = Color3.fromRGB(8, 30, 16),
        Secondary = Color3.fromRGB(12, 48, 24),
        Element = Color3.fromRGB(18, 68, 34),

        Hover = Color3.fromRGB(25, 90, 45),
        Border = Color3.fromRGB(40, 125, 62),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(175, 215, 185),

        Accent = Color3.fromRGB(70, 255, 120),
        AccentDark = Color3.fromRGB(35, 200, 80)
    },

    --// BLUE
    Blue = {
        Background = Color3.fromRGB(8, 20, 40),
        Secondary = Color3.fromRGB(12, 32, 62),
        Element = Color3.fromRGB(18, 45, 85),

        Hover = Color3.fromRGB(25, 62, 115),
        Border = Color3.fromRGB(40, 85, 150),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(175, 195, 225),

        Accent = Color3.fromRGB(80, 150, 255),
        AccentDark = Color3.fromRGB(40, 100, 210)
    },

    --// PURPLE
    Purple = {
        Background = Color3.fromRGB(25, 10, 38),
        Secondary = Color3.fromRGB(40, 15, 60),
        Element = Color3.fromRGB(58, 22, 85),

        Hover = Color3.fromRGB(78, 30, 115),
        Border = Color3.fromRGB(110, 45, 155),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(205, 180, 220),

        Accent = Color3.fromRGB(185, 95, 255),
        AccentDark = Color3.fromRGB(130, 55, 200)
    },

    --// ORANGE
    Orange = {
        Background = Color3.fromRGB(38, 20, 7),
        Secondary = Color3.fromRGB(58, 30, 10),
        Element = Color3.fromRGB(82, 43, 14),

        Hover = Color3.fromRGB(108, 57, 18),
        Border = Color3.fromRGB(150, 78, 25),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(225, 200, 170),

        Accent = Color3.fromRGB(255, 155, 50),
        AccentDark = Color3.fromRGB(205, 105, 25)
    }

}

function Theme:Get(Name)
    return self.BuiltIn[Name or "Default"]
end

function Theme:Exists(Name)
    return self.BuiltIn[Name] ~= nil
end

function Theme:Register(Name, Data)
    assert(type(Name) == "string", "Theme name must be a string")
    assert(type(Data) == "table", "Theme data must be a table")

    self.BuiltIn[Name] = Data

    return Data
end

function Theme:Remove(Name)
    if self.BuiltIn[Name] == nil then
        return false
    end

    if Name == "Default" then
        warn("[OTC Hub] The Default theme cannot be removed.")
        return false
    end

    self.BuiltIn[Name] = nil

    return true
end

function Theme:List()
    local Themes = {}

    for Name in pairs(self.BuiltIn) do
        table.insert(Themes, Name)
    end

    table.sort(Themes)

    return Themes
end

return Theme