--[[
    OTC Hub v1
    Theme System
    by Aerlro
]]

local Theme = {}

Theme.BuiltIn = {

    Default = {
        Background = Color3.fromRGB(10, 10, 10),
        Secondary = Color3.fromRGB(15, 15, 15),
        Element = Color3.fromRGB(20, 20, 20),

        Hover = Color3.fromRGB(30, 30, 30),
        Border = Color3.fromRGB(42, 42, 42),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(155, 155, 155),

        Accent = Color3.fromRGB(255, 255, 255),
        AccentDark = Color3.fromRGB(190, 190, 190)
    },

    Red = {
        Background = Color3.fromRGB(10, 8, 8),
        Secondary = Color3.fromRGB(17, 12, 12),
        Element = Color3.fromRGB(25, 17, 17),

        Hover = Color3.fromRGB(40, 22, 22),
        Border = Color3.fromRGB(55, 30, 30),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(165, 145, 145),

        Accent = Color3.fromRGB(255, 65, 65),
        AccentDark = Color3.fromRGB(190, 35, 35)
    },

    Green = {
        Background = Color3.fromRGB(8, 11, 9),
        Secondary = Color3.fromRGB(12, 19, 14),
        Element = Color3.fromRGB(18, 28, 21),

        Hover = Color3.fromRGB(25, 42, 30),
        Border = Color3.fromRGB(35, 60, 43),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(145, 165, 150),

        Accent = Color3.fromRGB(70, 255, 120),
        AccentDark = Color3.fromRGB(35, 190, 80)
    },

    Blue = {
        Background = Color3.fromRGB(8, 10, 14),
        Secondary = Color3.fromRGB(12, 16, 23),
        Element = Color3.fromRGB(18, 23, 32),

        Hover = Color3.fromRGB(25, 34, 48),
        Border = Color3.fromRGB(35, 48, 68),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(145, 155, 175),

        Accent = Color3.fromRGB(80, 150, 255),
        AccentDark = Color3.fromRGB(40, 100, 200)
    },

    Purple = {
        Background = Color3.fromRGB(10, 8, 13),
        Secondary = Color3.fromRGB(17, 12, 22),
        Element = Color3.fromRGB(24, 17, 31),

        Hover = Color3.fromRGB(37, 25, 48),
        Border = Color3.fromRGB(55, 38, 70),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(160, 145, 175),

        Accent = Color3.fromRGB(180, 90, 255),
        AccentDark = Color3.fromRGB(125, 50, 190)
    },

    Orange = {
        Background = Color3.fromRGB(13, 10, 7),
        Secondary = Color3.fromRGB(21, 16, 10),
        Element = Color3.fromRGB(30, 22, 14),

        Hover = Color3.fromRGB(45, 31, 17),
        Border = Color3.fromRGB(65, 45, 24),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(175, 160, 140),

        Accent = Color3.fromRGB(255, 150, 50),
        AccentDark = Color3.fromRGB(200, 100, 25)
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