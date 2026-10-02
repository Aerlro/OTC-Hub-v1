--[[
    OTC Hub v1
    Main Library
    by Aerlro
]]

local OTC = {}

OTC.Version = "1.0.0"
OTC.Name = "OTC Hub"

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

--// GitHub
local BASE_URL =
    "https://raw.githubusercontent.com/Aerlro/OTC-Hub-v1/main/"

--// Internal Data
OTC._Windows = {}
OTC._Themes = {}
OTC._Flags = {}
OTC._Connections = {}
OTC._Modules = {}

--// Load Module
local function LoadModule(Path)
    local URL = BASE_URL .. Path

    print("[OTC Hub] Loading:", Path)

    local Success, Source = pcall(function()
        return game:HttpGet(URL)
    end)

    if not Success then
        error(
            "[OTC Hub] Failed to download module: "
            .. Path
            .. "\n"
            .. tostring(Source)
        )
    end

    local CompileSuccess, Module = pcall(function()
        return loadstring(Source)
    end)

    if not CompileSuccess or not Module then
        error(
            "[OTC Hub] Failed to compile module: "
            .. Path
            .. "\n"
            .. tostring(Module)
        )
    end

    local RunSuccess, Result = pcall(Module)

    if not RunSuccess then
        error(
            "[OTC Hub] Failed to load module: "
            .. Path
            .. "\n"
            .. tostring(Result)
        )
    end

    if Result == nil then
        error(
            "[OTC Hub] Module returned nil: "
            .. Path
        )
    end

    print("[OTC Hub] Loaded:", Path)

    return Result
end

--// Default Theme
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

--// Theme Functions
function OTC:GetTheme()
    return self._Themes[self.CurrentTheme]
end

function OTC:RegisterTheme(Name, Theme)
    assert(
        type(Name) == "string",
        "Theme name must be a string"
    )

    assert(
        type(Theme) == "table",
        "Theme must be a table"
    )

    self._Themes[Name] = Theme
end

function OTC:SetTheme(Name)
    if not self._Themes[Name] then
        warn(
            "[OTC Hub] Theme does not exist:",
            Name
        )

        return
    end

    self.CurrentTheme = Name

    for _, Window in pairs(self._Windows) do
        if Window.RefreshTheme then
            Window:RefreshTheme()
        end
    end
end

--// Tween
function OTC:Tween(
    Object,
    Time,
    Properties,
    Style,
    Direction
)
    if not Object then
        return
    end

    local Info = TweenInfo.new(
        Time or 0.25,

        Style or Enum.EasingStyle.Quint,

        Direction or Enum.EasingDirection.Out
    )

    local Animation = TweenService:Create(
        Object,
        Info,
        Properties
    )

    Animation:Play()

    return Animation
end

--// Flags
function OTC:SetFlag(Name, Value)
    self._Flags[Name] = Value
end

function OTC:GetFlag(Name)
    return self._Flags[Name]
end

--// Connections
function OTC:Connect(Connection)
    table.insert(
        self._Connections,
        Connection
    )

    return Connection
end

function OTC:DisconnectAll()
    for _, Connection in ipairs(
        self._Connections
    ) do
        if Connection
            and Connection.Disconnect then

            Connection:Disconnect()
        end
    end

    table.clear(
        self._Connections
    )
end

--// Load Core Modules
local TabModule = LoadModule(
    "Core/tab.lua"
)

local WindowModule = LoadModule(
    "Core/window.lua"
)

local ThemeModule = LoadModule(
    "Core/theme.lua"
)

local AnimationModule = LoadModule(
    "Core/animation.lua"
)

local NotificationModule = LoadModule(
    "Core/notification.lua"
)

--// Load Element Modules
local ButtonModule = LoadModule(
    "Elements/button.lua"
)

local ToggleModule = LoadModule(
    "Elements/toggle.lua"
)

local SliderModule = LoadModule(
    "Elements/slider.lua"
)

local DropdownModule = LoadModule(
    "Elements/dropdown.lua"
)

local InputModule = LoadModule(
    "Elements/input.lua"
)

--// Register Modules
OTC._Modules = {
    Button = ButtonModule,
    Toggle = ToggleModule,
    Slider = SliderModule,
    Dropdown = DropdownModule,
    Input = InputModule
}

--// Notification
function OTC:Notify(Data)
    Data = Data or {}

    local Window = self._Windows[1]

    if Window
        and Window.ScreenGui then

        return NotificationModule.Create(
            Window.ScreenGui,
            self:GetTheme(),
            Data
        )
    end

    warn(
        "[OTC Hub] No active window for notification"
    )
end

--// Create Window
function OTC:CreateWindow(Settings)
    Settings = Settings or {}

    local Window = WindowModule.Create(
        Settings,
        self
    )

    if not Window then
        error(
            "[OTC Hub] Window creation failed"
        )
    end

    table.insert(
        self._Windows,
        Window
    )

    --// Create Tab
    function Window:CreateTab(TabSettings)
        TabSettings = TabSettings or {}

        return TabModule.Create(
            self,
            OTC,
            TabSettings
        )
    end

    return Window
end

--// Input
function OTC:InitializeInput()
    if self._InputInitialized then
        return
    end

    self._InputInitialized = true

    self:Connect(
        UserInputService.InputBegan:Connect(
            function(
                Input,
                GameProcessed
            )
                if GameProcessed then
                    return
                end

                for _, Window in pairs(
                    self._Windows
                ) do

                    if Input.KeyCode
                        == Window.ToggleKey then

                        if Window.Toggle then
                            Window:Toggle()
                        end
                    end
                end
            end
        )
    )
end

--// Initialize
OTC:InitializeInput()

return OTC