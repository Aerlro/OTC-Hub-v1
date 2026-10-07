--[[
    OTC Hub v1.0.2
    Module Loader
    by Aerlro
]]

local Loader = {}

local Root = script.Parent

Loader.Core = {
    Window = require(Root.Core.window),
    Tab = require(Root.Core.tab),
    Theme = require(Root.Core.theme),
    Animation = require(Root.Core.animation),
    Notification = require(Root.Core.notification),
    Config = require(Root.Core.config),
    Dialog = require(Root.Core.dialog)
}

Loader.Elements = {
    Button = require(Root.Elements.button),
    Toggle = require(Root.Elements.toggle),
    Slider = require(Root.Elements.slider),
    Dropdown = require(Root.Elements.dropdown),
    Input = require(Root.Elements.input),
    Keybind = require(Root.Elements.keybind),
    Colorpicker = require(Root.Elements.colorpicker),
    Stat = require(Root.Elements.stat)
}

function Loader:GetCore(Name)
    return self.Core[Name]
end

function Loader:GetElement(Name)
    return self.Elements[Name]
end

return Loader
