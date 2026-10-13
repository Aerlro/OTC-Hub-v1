# OTC Hub v1.0.4

**by Aerlro**

OTC Hub is a modular Roblox UI library with a compact floating interface, theme engine, searchable navigation, configurable elements and persistent settings. The v1.0.4 visual update follows the supplied UI reference: a compact slate window, cyan accents, a narrow sidebar and image-based window controls.

## Load latest

```lua
return loadstring(game:HttpGet("https://raw.githubusercontent.com/Aerlro/OTC-Hub-v1/main/latest.lua"))()
```

## Load a fixed version

```lua
return loadstring(game:HttpGet("https://raw.githubusercontent.com/Aerlro/OTC-Hub-v1/main/v1.0.4.lua"))()
```

## Basic example

```lua
local OTC = loadstring(game:HttpGet("https://raw.githubusercontent.com/Aerlro/OTC-Hub-v1/main/latest.lua"))()
local Window = OTC:CreateWindow({Name = "OTC Hub", Subtitle = "by Aerlro", Theme = "Default", Width = 500, Height = 300, ToggleKey = Enum.KeyCode.RightControl})
local Main = Window:CreateTab({Name = "Main", Icon = "house"})
Main:CreateSection("Main")
Main:CreateParagraph({Title = "Welcome", Content = "Compact UI, theme support and configurable elements."})
Main:CreateToggle({Name = "Example toggle", Flag = "example_toggle", Default = false, Callback = function(Value) print(Value) end})
Main:CreateButton({Name = "Example button", Callback = function() OTC:Notify({Title = "OTC Hub", Content = "Button clicked"}) end})
Main:CreateSlider({Name = "Example slider", Flag = "example_slider", Min = 0, Max = 100, Increment = 1, Default = 50, Callback = function(Value) print(Value) end})
```

## Configuration

```lua
OTC:Configure({AutoSave = true, AutoLoad = true, FileName = "MyConfig"})
Window:SaveConfig()
Window:LoadConfig()
Window:ExportConfig()
Window:ImportConfig("MyConfig", jsonString)
Window:GetConfigs()
Window:DeleteConfig("MyConfig")
```

## Themes

Built-in themes include Default, Red, Green, Blue, Purple, Orange, Cyber, Halloween and Roman Reigns. Roman Reigns is private and remains restricted to the authorized user ID `572117566`.

## v1.0.4 changelog

- **[ADDED]** Compact floating layout based on the supplied reference video.
- **[ADDED]** Image controls for Search, Minimize and Close.
- **[CHANGED]** Default theme updated to slate and cyan.
- **[CHANGED]** Default window size reduced to 500×300.
- **[FIXED]** Theme list sort comparator handles equal names.
- **[FIXED]** Slider increment is clamped to a positive value.
- **[FIXED]** Missing config files return a failed load instead of a false success.
- **[FIXED]** Window drag input connections are disconnected on unload.

## Notes

Configuration persistence requires executor file functions such as `readfile`, `writefile`, and `isfile`. Test the UI in Roblox before distributing a production release; this package has been statically checked, but the environment here cannot run Roblox client UI.
