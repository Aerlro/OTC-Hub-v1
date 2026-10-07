--[[
    OTC Hub v1
    Main Library
    by Aerlro
]]

local OTC = {}

OTC.Version = "1.0.2"
OTC.Name = "OTC Hub"

OTC.Changelog = {
    ["1.0.2"] = {
        "New modern OTC loading experience",
        "Real configuration save and load system",
        "New Keybind element",
        "New Colorpicker element",
        "New Stat element",
        "New Dialog API",
        "Responsive window scaling",
        "Improved runtime state handling",
        "Improved theme refresh support",
        "New mobile-friendly foundation"
    },
    ["1.0.1"] = {
        "New Halloween loading screen",
        "Animated Halloween decorations",
        "Improved loading screen fade-out",
        "Advanced Theme System improvements",
        "Animated gradients",
        "Version badge",
        "Improved unload confirmation",
        "Improved UI animations"
    }
}

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
    "Core/config.lua",
    "Core/dialog.lua",
    "Elements/button.lua",
    "Elements/toggle.lua",
    "Elements/slider.lua",
    "Elements/dropdown.lua",
    "Elements/input.lua",
    "Elements/keybind.lua",
    "Elements/colorpicker.lua",
    "Elements/stat.lua"
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

local ConfigModule = LoadModule(
    "Core/config.lua"
)

local DialogModule = LoadModule(
    "Core/dialog.lua"
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

    if ThemeModule.IsPrivate
        and ThemeModule.IsPrivate(Name)
        and ThemeModule.IsAllowed
        and not ThemeModule.IsAllowed(Name, LocalPlayer) then

        warn(
            "[OTC Hub] You don't have permission to use this theme:",
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
    return ThemeModule:List(LocalPlayer)
end

function OTC:Dialog(Data)
    local Window = self._Windows[1]

    if not Window or not Window.ScreenGui then
        warn("[OTC Hub] No active window for dialog")
        return nil
    end

    return DialogModule.Create(
        Window.ScreenGui,
        self:GetTheme(),
        Data
    )
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
    if Name == nil then
        return
    end

    self._Flags[tostring(Name)] =
        Value

    self._ConfigDirty = true
end

function OTC:GetFlag(Name, Default)
    if Name == nil then
        return Default
    end

    local Value = self._Flags[tostring(Name)]

    if Value == nil then
        return Default
    end

    return Value
end

function OTC:Configure(Settings)
    Settings = Settings or {}

    self._Configuration = {
        AutoSave = (Settings.AutoSave ~= nil and Settings.AutoSave or Settings.autoSave) == true,
        AutoLoad = (Settings.AutoLoad ~= nil and Settings.AutoLoad or Settings.autoLoad) == true,
        FileName = Settings.FileName
            or Settings.fileName
            or "OTCHub"
    }

    return self._Configuration
end

function OTC:LoadConfig(Name)
    if not self._ConfigModule then
        return false
    end

    local Configuration = self._Configuration or {}
    local Data = self._ConfigModule:Load(
        Name or Configuration.FileName or "OTCHub"
    )

    if type(Data) ~= "table" then
        return false
    end

    if type(Data.Flags) == "table" then
        for Key, Value in pairs(Data.Flags) do
            self._Flags[Key] = Value
        end
    end

    self._ConfigDirty = false

    return true
end

function OTC:SaveConfig(Name)
    if not self._ConfigModule then
        return false
    end

    local Configuration = self._Configuration or {}

    local Success = self._ConfigModule:Save(
        Name or Configuration.FileName or "OTCHub",
        {
            Version = self.Version,
            Flags = self._Flags
        }
    )

    if Success then
        self._ConfigDirty = false
    end

    return Success
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

OTC._ConfigModule =
    ConfigModule

OTC._DialogModule =
    DialogModule

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

local KeybindModule = LoadModule(
    "Elements/keybind.lua"
)

local ColorpickerModule = LoadModule(
    "Elements/colorpicker.lua"
)

local StatModule = LoadModule(
    "Elements/stat.lua"
)

OTC._Modules = {
    Button = ButtonModule,
    Toggle = ToggleModule,
    Slider = SliderModule,
    Dropdown = DropdownModule,
    Input = InputModule,
    Keybind = KeybindModule,
    Colorpicker = ColorpickerModule,
    Stat = StatModule,
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

    local ConfigurationSettings =
        Settings.Configuration
        or Settings.configuration

    if ConfigurationSettings then
        self:Configure(ConfigurationSettings)

        if self._Configuration.AutoLoad then
            self:LoadConfig(
                self._Configuration.FileName
            )
        end
    end

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

    function Window:Dialog(Data)
        return DialogModule.Create(
            self.ScreenGui,
            self:GetTheme(),
            Data
        )
    end

    function Window:SaveConfig(Name)
        return OTC:SaveConfig(Name)
    end

    function Window:LoadConfig(Name)
        return OTC:LoadConfig(Name)
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