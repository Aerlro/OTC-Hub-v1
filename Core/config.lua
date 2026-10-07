local Config = {}

local HttpService = game:GetService("HttpService")

Config.Folder = "OTC Hub"
Config.DefaultName = "OTCHub"

local function available()
    return type(readfile) == "function"
        and type(writefile) == "function"
        and type(isfile) == "function"
end

local function ensureFolder()
    if type(makefolder) ~= "function" then
        return true
    end

    pcall(function()
        makefolder(Config.Folder)
    end)

    return true
end

local function sanitize(Value, Depth)
    Depth = Depth or 0

    if Depth > 8 then
        return nil
    end

    local ValueType = typeof(Value)

    if ValueType == "string"
        or ValueType == "number"
        or ValueType == "boolean" then
        return Value
    end

    if ValueType == "Color3" then
        return {
            __otc_type = "Color3",
            r = Value.R,
            g = Value.G,
            b = Value.B
        }
    end

    if ValueType == "EnumItem" then
        return {
            __otc_type = "EnumItem",
            enum = tostring(Value.EnumType),
            name = Value.Name
        }
    end

    if ValueType == "table" then
        local Result = {}

        for Key, Item in pairs(Value) do
            local Clean = sanitize(Item, Depth + 1)

            if Clean ~= nil then
                Result[tostring(Key)] = Clean
            end
        end

        return Result
    end

    return nil
end

local function restore(Value)
    if type(Value) ~= "table" then
        return Value
    end

    if Value.__otc_type == "Color3" then
        return Color3.new(
            tonumber(Value.r) or 1,
            tonumber(Value.g) or 1,
            tonumber(Value.b) or 1
        )
    end

    if Value.__otc_type == "EnumItem"
        and Value.enum == "Enum.KeyCode" then
        local Success, Result = pcall(function()
            return Enum.KeyCode[Value.name]
        end)

        if Success then
            return Result
        end
    end

    local Result = {}

    for Key, Item in pairs(Value) do
        Result[Key] = restore(Item)
    end

    return Result
end

function Config:GetPath(Name)
    Name = tostring(Name or self.DefaultName)
    Name = Name:gsub("[^%w%._%-]", "_")

    return self.Folder .. "/" .. Name .. ".json"
end

function Config:Load(Name)
    if not available() then
        return {}
    end

    ensureFolder()

    local Path = self:GetPath(Name)

    if not isfile(Path) then
        return {}
    end

    local Success, Content = pcall(readfile, Path)

    if not Success or type(Content) ~= "string" then
        return {}
    end

    local DecodeSuccess, Data = pcall(function()
        return HttpService:JSONDecode(Content)
    end)

    if not DecodeSuccess or type(Data) ~= "table" then
        return {}
    end

    return restore(Data)
end

function Config:Save(Name, Data)
    if not available() then
        return false
    end

    ensureFolder()

    local Clean = sanitize(Data or {})

    if type(Clean) ~= "table" then
        return false
    end

    local Success, Content = pcall(function()
        return HttpService:JSONEncode(Clean)
    end)

    if not Success then
        return false
    end

    local WriteSuccess = pcall(function()
        writefile(
            self:GetPath(Name),
            Content
        )
    end)

    return WriteSuccess
end

function Config:Available()
    return available()
end

return Config
