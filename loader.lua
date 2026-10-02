--[[
    OTC Hub v1
    Module Loader
    by Aerlro
]]

local Loader = {}

local Root = script.Parent

Loader.Core = {
    Window = require(Root.Core.Window),
    Tab = require(Root.Core.Tab),
    Theme = require(Root.Core.Theme),
    Animation = require(Root.Core.Animation),
    Notification = require(Root.Core.Notification)
}

Loader.Elements = {
    Button = require(Root.Elements.Button),
    Toggle = require(Root.Elements.Toggle),
    Slider = require(Root.Elements.Slider),
    Dropdown = require(Root.Elements.Dropdown),
    Input = require(Root.Elements.Input)
}

function Loader:GetCore(Name)
    return self.Core[Name]
end

function Loader:GetElement(Name)
    return self.Elements[Name]
end

return Loader
