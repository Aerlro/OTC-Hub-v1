--[[
    OTC Hub v1
    Lucide Icon System
    by Aerlro
]]

local Lucide = {}

--// Remote Lucide implementation
local LUCIDE_URL =
    "https://raw.githubusercontent.com/deividcomsono/lucide-roblox-direct/refs/heads/main/source.lua"

local Loaded = false
local Library = nil

--// Cache
local Cache = {}

--// Normalize icon name
local function normalize(Name)
    if type(Name) ~= "string" then
        return nil
    end

    return Name
        :gsub("_", "-")
        :gsub("%s+", "-")
        :lower()
end

--// Load Lucide
function Lucide.Load()

    if Loaded then
        return Library
    end

    local Success, Result = pcall(function()

        local Source = game:HttpGet(
            LUCIDE_URL
        )

        local Loader = loadstring(Source)

        if not Loader then
            error(
                "[OTC Lucide] Failed to compile Lucide"
            )
        end

        return Loader()
    end)

    if not Success then

        warn(
            "[OTC Lucide] Failed to load:",
            Result
        )

        return nil
    end

    Library = Result
    Loaded = true

    return Library
end

--// Get Lucide asset
function Lucide.GetAsset(Name, Size)

    local Normalized =
        normalize(Name)

    if not Normalized then
        return nil
    end

    local CacheKey =
        Normalized
        .. ":"
        .. tostring(Size or 24)

    if Cache[CacheKey] then
        return Cache[CacheKey]
    end

    local Lib =
        Lucide.Load()

    if not Lib then
        return nil
    end

    local Success, Asset =
        pcall(function()

            return Lib.GetAsset(
                Normalized,
                Size or 24
            )
        end)

    if not Success or not Asset then

        warn(
            "[OTC Lucide] Unknown icon:",
            Name
        )

        return nil
    end

    Cache[CacheKey] = Asset

    return Asset
end

--// Create ImageLabel
function Lucide.Create(
    Parent,
    Name,
    Size,
    Properties
)

    Properties = Properties or {}

    local Asset =
        Lucide.GetAsset(
            Name,
            Size
        )

    if not Asset then
        return nil
    end

    local Icon = Instance.new(
        "ImageLabel"
    )

    Icon.Name =
        Properties.Name
        or "LucideIcon"

    Icon.Parent =
        Parent

    Icon.BackgroundTransparency =
        Properties.BackgroundTransparency
        or 1

    Icon.BorderSizePixel = 0

    Icon.Size =
        Properties.Size
        or UDim2.fromOffset(
            Size or 20,
            Size or 20
        )

    Icon.Position =
        Properties.Position
        or UDim2.new()

    Icon.AnchorPoint =
        Properties.AnchorPoint
        or Vector2.new()

    Icon.Image =
        Asset.Url

    Icon.ImageRectOffset =
        Asset.ImageRectOffset
        or Vector2.new()

    Icon.ImageRectSize =
        Asset.ImageRectSize
        or Vector2.new()

    Icon.ImageColor3 =
        Properties.ImageColor3
        or Color3.fromRGB(
            255,
            255,
            255
        )

    Icon.ImageTransparency =
        Properties.ImageTransparency
        or 0

    Icon.ScaleType =
        Properties.ScaleType
        or Enum.ScaleType.Fit

    return Icon
end

return Lucide