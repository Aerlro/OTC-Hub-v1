--[[
    OTC Hub v1
    Theme System
    by Aerlro
]]

local Theme = {}

Theme.BuiltIn = {

    --// DEFAULT
    Default = {
        Background = Color3.fromRGB(35, 35, 35),
        Secondary = Color3.fromRGB(55, 55, 55),
        Element = Color3.fromRGB(75, 75, 75),

        Hover = Color3.fromRGB(100, 100, 100),
        Border = Color3.fromRGB(140, 140, 140),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(220, 220, 220),

        Accent = Color3.fromRGB(255, 255, 255),
        AccentDark = Color3.fromRGB(190, 190, 190)
    },

    --// RED
    Red = {
        Background = Color3.fromRGB(75, 10, 15),
        Secondary = Color3.fromRGB(115, 15, 22),
        Element = Color3.fromRGB(150, 22, 30),

        Hover = Color3.fromRGB(190, 30, 40),
        Border = Color3.fromRGB(230, 55, 65),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(255, 205, 205),

        Accent = Color3.fromRGB(255, 65, 75),
        AccentDark = Color3.fromRGB(200, 30, 40)
    },

    --// GREEN
    Green = {
        Background = Color3.fromRGB(8, 70, 30),
        Secondary = Color3.fromRGB(10, 110, 45),
        Element = Color3.fromRGB(15, 145, 58),

        Hover = Color3.fromRGB(25, 185, 75),
        Border = Color3.fromRGB(55, 225, 105),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(200, 255, 215),

        Accent = Color3.fromRGB(70, 255, 120),
        AccentDark = Color3.fromRGB(30, 195, 75)
    },

    --// BLUE
    Blue = {
        Background = Color3.fromRGB(8, 45, 100),
        Secondary = Color3.fromRGB(10, 70, 145),
        Element = Color3.fromRGB(15, 95, 185),

        Hover = Color3.fromRGB(30, 125, 220),
        Border = Color3.fromRGB(70, 165, 255),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(200, 225, 255),

        Accent = Color3.fromRGB(75, 155, 255),
        AccentDark = Color3.fromRGB(35, 105, 205)
    },

    --// PURPLE
    Purple = {
        Background = Color3.fromRGB(55, 10, 95),
        Secondary = Color3.fromRGB(80, 15, 135),
        Element = Color3.fromRGB(110, 25, 175),

        Hover = Color3.fromRGB(145, 40, 220),
        Border = Color3.fromRGB(190, 75, 255),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(230, 205, 255),

        Accent = Color3.fromRGB(190, 90, 255),
        AccentDark = Color3.fromRGB(130, 45, 200)
    },

    --// ORANGE
    Orange = {
        Background = Color3.fromRGB(100, 40, 5),
        Secondary = Color3.fromRGB(145, 60, 8),
        Element = Color3.fromRGB(185, 80, 10),

        Hover = Color3.fromRGB(220, 105, 15),
        Border = Color3.fromRGB(255, 145, 35),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(255, 225, 190),

        Accent = Color3.fromRGB(255, 155, 50),
        AccentDark = Color3.fromRGB(205, 100, 25)
    }

}

function Theme:Get(Name)
    return self.BuiltIn[Name or "Default"]
end

function Theme:Exists(Name)
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

    self.BuiltIn[Name] = Data

    return Data
end

function Theme:Remove(Name)
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

function Theme:List()
    local Themes = {}

    for Name in pairs(self.BuiltIn) do
        table.insert(Themes, Name)
    end

    table.sort(Themes)

    return Themes
end

return Theme