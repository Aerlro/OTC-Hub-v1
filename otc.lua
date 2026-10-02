--[[
    OTC Hub v1
    Main Library
    by Aerlro
]]

local OTC = {}

OTC.Version = "1.0.0"
OTC.Name = "OTC Hub"

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Internal data
OTC._Windows = {}
OTC._Themes = {}
OTC._Flags = {}
OTC._Connections = {}

-- Default theme
OTC._Themes.Default = {
    Background = Color3.fromRGB(10, 10, 10),
    Secondary = Color3.fromRGB(15, 15, 15),
    Element = Color3.fromRGB(20, 20, 20),

    Hover = Color3.fromRGB(30, 30, 30),
    Border = Color3.fromRGB(40, 40, 40),

    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(160, 160, 160),

    Accent = Color3.fromRGB(255, 255, 255),
    AccentDark = Color3.fromRGB(180, 180, 180)
}

OTC.CurrentTheme = "Default"

-- Utility
function OTC:GetTheme()
    return self._Themes[self.CurrentTheme]
end

function OTC:RegisterTheme(Name, Theme)
    assert(type(Name) == "string", "Theme name must be a string")
    assert(type(Theme) == "table", "Theme must be a table")

    self._Themes[Name] = Theme
end

function OTC:SetTheme(Name)
    if not self._Themes[Name] then
        warn("[OTC Hub] Theme does not exist:", Name)
        return
    end

    self.CurrentTheme = Name

    for _, Window in pairs(self._Windows) do
        if Window.RefreshTheme then
            Window:RefreshTheme()
        end
    end
end

-- Tween utility
function OTC:Tween(Object, Time, Properties, Style, Direction)
    if not Object then
        return
    end

    local Info = TweenInfo.new(
        Time or 0.25,
        Style or Enum.EasingStyle.Quint,
        Direction or Enum.EasingDirection.Out
    )

    local Tween = TweenService:Create(
        Object,
        Info,
        Properties
    )

    Tween:Play()

    return Tween
end

-- Notification
function OTC:Notify(Data)
    Data = Data or {}

    local Title = Data.Title or "OTC Hub"
    local Content = Data.Content or ""
    local Duration = Data.Duration or 3

    print(string.format(
        "[OTC Hub] %s: %s",
        Title,
        Content
    ))

    -- Notification UI will be implemented
    -- in Core/Notification.lua
end

-- Flags
function OTC:SetFlag(Name, Value)
    self._Flags[Name] = Value
end

function OTC:GetFlag(Name)
    return self._Flags[Name]
end

-- Connection management
function OTC:Connect(Connection)
    table.insert(self._Connections, Connection)

    return Connection
end

function OTC:DisconnectAll()
    for _, Connection in ipairs(self._Connections) do
        if Connection and Connection.Disconnect then
            Connection:Disconnect()
        end
    end

    table.clear(self._Connections)
end

-- Create Window
function OTC:CreateWindow(Settings)
    Settings = Settings or {}

    local Window = {
        Name = Settings.Name or "OTC Hub",
        Subtitle = Settings.Subtitle or "by Aerlro",

        LoadingTitle = Settings.LoadingTitle or "OTC Hub",
        LoadingSubtitle = Settings.LoadingSubtitle or "Initializing...",

        ToggleKey = Settings.ToggleKey or Enum.KeyCode.RightShift,

        Theme = Settings.Theme or self.CurrentTheme,

        Tabs = {},
        Visible = true
    }

    function Window:CreateTab(TabSettings)
        TabSettings = TabSettings or {}

        local Tab = {
            Name = TabSettings.Name or "Tab",
            Icon = TabSettings.Icon,
            Elements = {},
            Window = self
        }

        table.insert(self.Tabs, Tab)

        return Tab
    end

    function Window:SetVisibility(State)
        self.Visible = State

        -- UI visibility will be handled
        -- by Core/Window.lua
    end

    function Window:Toggle()
        self:SetVisibility(not self.Visible)
    end

    function Window:RefreshTheme()
        -- Theme refresh will be implemented
        -- by Core/Theme.lua
    end

    table.insert(self._Windows or {}, Window)

    return Window
end

-- Global toggle handling
function OTC:InitializeInput()
    if self._InputInitialized then
        return
    end

    self._InputInitialized = true

    self:Connect(
        UserInputService.InputBegan:Connect(function(Input, GameProcessed)
            if GameProcessed then
                return
            end

            for _, Window in pairs(self._Windows) do
                if Input.KeyCode == Window.ToggleKey then
                    Window:Toggle()
                end
            end
        end)
    )
end

OTC:InitializeInput()

return OTC
