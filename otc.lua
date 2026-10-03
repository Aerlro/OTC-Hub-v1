--[[
    OTC Hub v1
    Main Library
    by Aerlro
]]

local OTC = {}

OTC.Version = "1.0.1"
OTC.Name = "OTC Hub"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local BASE_URL =
    "https://raw.githubusercontent.com/Aerlro/OTC-Hub-v1/main/"

OTC._Windows = {}
OTC._Themes = {}
OTC._Flags = {}
OTC._Connections = {}
OTC._Modules = {}

local function LoadRawModule(Path)
    local URL = BASE_URL .. Path

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

    return Result
end

--// Loading Screen
local LoadingModule = LoadRawModule(
    "Core/loading.lua"
)

local ModulesToLoad = {
    "Core/tab.lua",
    "Core/window.lua",
    "Core/theme.lua",
    "Core/animation.lua",
    "Core/notification.lua",
    "Core/lucide.lua",
    "Elements/button.lua",
    "Elements/toggle.lua",
    "Elements/slider.lua",
    "Elements/dropdown.lua",
    "Elements/input.lua"
}

local Loading = LoadingModule.Create(
    #ModulesToLoad
)

--// Module Loader
local function LoadModule(Path)
    local Current =
        Loading.Current

    Loading:Update(
        Current,
        "Loading OTC Hub...",
        "Downloading " .. Path
    )

    local URL = BASE_URL .. Path

    print(
        "[OTC Hub] Loading:",
        Path
    )

    local Success, Source = pcall(function()
        return game:HttpGet(URL)
    end)

    if not Success then
        Loading:Update(
            Current,
            "Failed to download module",
            Path
        )

        task.wait(0.25)

        error(
            "[OTC Hub] Failed to download module: "
            .. Path
            .. "\n"
            .. tostring(Source)
        )
    end

    Loading:Update(
        Current,
        "Compiling module...",
        Path
    )

    local CompileSuccess, Module = pcall(function()
        return loadstring(Source)
    end)

    if not CompileSuccess or not Module then
        Loading:Update(
            Current,
            "Compilation failed",
            Path
        )

        task.wait(0.25)

        error(
            "[OTC Hub] Failed to compile module: "
            .. Path
            .. "\n"
            .. tostring(Module)
        )
    end

    Loading:Update(
        Current,
        "Initializing module...",
        Path
    )

    local RunSuccess, Result = pcall(Module)

    if not RunSuccess then
        Loading:Update(
            Current,
            "Module initialization failed",
            Path
        )

        task.wait(0.25)

        error(
            "[OTC Hub] Failed to load module: "
            .. Path
            .. "\n"
            .. tostring(Result)
        )
    end

    if Result == nil then
        Loading:Update(
            Current,
            "Module returned nil",
            Path
        )

        task.wait(0.25)

        error(
            "[OTC Hub] Module returned nil: "
            .. Path
        )
    end

    Loading.Current =
        Loading.Current + 1

    Loading:Update(
        Loading.Current,
        "Module loaded",
        Path
    )

    print(
        "[OTC Hub] Loaded:",
        Path
    )

    return Result
end

--// Core Modules
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

local LucideModule = LoadModule(
    "Core/lucide.lua"
)

--// Themes
OTC._Themes =
    ThemeModule.BuiltIn

OTC.CurrentTheme =
    "Default"

function OTC:GetTheme()
    return self._Themes[self.CurrentTheme]
        or self._Themes.Default
end

function OTC:RegisterTheme(
    Name,
    ThemeData
)
    return ThemeModule:Register(
        Name,
        ThemeData
    )
end

function OTC:SetTheme(Name)
    if not self._Themes[Name] then
        warn(
            "[OTC Hub] Theme does not exist:",
            Name
        )

        return false
    end

    self.CurrentTheme =
        Name

    for _, Window in pairs(
        self._Windows
    ) do
        if Window.SetTheme then
            Window:SetTheme(Name)
        elseif Window.RefreshTheme then
            Window:RefreshTheme()
        end
    end

    return true
end

function OTC:GetThemes()
    return ThemeModule:List()
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

    local Animation =
        TweenService:Create(
            Object,
            Info,
            Properties
        )

    Animation:Play()

    return Animation
end

--// Flags
function OTC:SetFlag(
    Name,
    Value
)
    self._Flags[Name] =
        Value
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

--// Core References
OTC._TabModule =
    TabModule

OTC._WindowModule =
    WindowModule

OTC._ThemeModule =
    ThemeModule

OTC._AnimationModule =
    AnimationModule

OTC._NotificationModule =
    NotificationModule

--// Element Modules
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

OTC._Modules = {
    Button = ButtonModule,
    Toggle = ToggleModule,
    Slider = SliderModule,
    Dropdown = DropdownModule,
    Input = InputModule,
}

--// Lucide
OTC._Lucide =
    LucideModule

--// Notifications
function OTC:Notify(Data)
    Data = Data or {}

    local Window =
        self._Windows[1]

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

--// Window
function OTC:CreateWindow(
    Settings
)
    Settings =
        Settings or {}

    if Settings.Theme then
        if not self._Themes[
            Settings.Theme
        ] then

            warn(
                "[OTC Hub] Theme does not exist:",
                Settings.Theme,
                "| Using Default"
            )

            Settings.Theme =
                "Default"
        end
    else
        Settings.Theme =
            self.CurrentTheme
    end

    local Window =
        WindowModule.Create(
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

    function Window:CreateTab(
        TabSettings
    )
        TabSettings =
            TabSettings or {}

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

    self._InputInitialized =
        true

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

OTC:InitializeInput()

--// Finish Loading
Loading:Finish()

return OTC