local Dialog = {}

local TweenService = game:GetService("TweenService")

local function Tween(Object, Time, Properties)
    local Animation = TweenService:Create(
        Object,
        TweenInfo.new(
            Time or 0.2,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        Properties
    )

    Animation:Play()

    return Animation
end

local function Corner(Object, Radius)
    local UI = Instance.new("UICorner")
    UI.CornerRadius = UDim.new(0, Radius)
    UI.Parent = Object
    return UI
end

local function Stroke(Object, Color, Transparency)
    local UI = Instance.new("UIStroke")
    UI.Color = Color
    UI.Thickness = 1
    UI.Transparency = Transparency or 0
    UI.Parent = Object
    return UI
end

function Dialog.Create(ScreenGui, Theme, Data)
    Data = Data or {}
    Theme = Theme or {}

    local Object = {}
    Object.Closed = false

    local Overlay = Instance.new("Frame")
    Overlay.Name = "OTC_DialogOverlay"
    Overlay.Size = UDim2.fromScale(1, 1)
    Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    Overlay.BackgroundTransparency = 1
    Overlay.BorderSizePixel = 0
    Overlay.ZIndex = 500
    Overlay.Parent = ScreenGui

    local Popup = Instance.new("Frame")
    Popup.Name = "Dialog"
    Popup.Size = UDim2.fromOffset(390, 0)
    Popup.AutomaticSize = Enum.AutomaticSize.Y
    Popup.Position = UDim2.new(0.5, -195, 0.5, 0)
    Popup.AnchorPoint = Vector2.new(0, 0.5)
    Popup.BackgroundColor3 = Theme.PopupBackground or Theme.Background or Color3.fromRGB(30, 30, 30)
    Popup.BorderSizePixel = 0
    Popup.ZIndex = 501
    Popup.Parent = Overlay

    Corner(Popup, Theme.Corners and Theme.Corners.Popup or 12)
    Stroke(Popup, Theme.PopupBorder or Theme.Border or Color3.fromRGB(100, 100, 100), 0.15)

    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, 22)
    Padding.PaddingBottom = UDim.new(0, 18)
    Padding.PaddingLeft = UDim.new(0, 22)
    Padding.PaddingRight = UDim.new(0, 22)
    Padding.Parent = Popup

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Popup

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 26)
    Title.AutomaticSize = Enum.AutomaticSize.Y
    Title.BackgroundTransparency = 1
    Title.Text = Data.Title or "OTC Hub"
    Title.TextColor3 = Theme.Text or Color3.new(1, 1, 1)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextWrapped = true
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.LayoutOrder = 1
    Title.ZIndex = 502
    Title.Parent = Popup

    local Content = Instance.new("TextLabel")
    Content.Size = UDim2.new(1, 0, 0, 20)
    Content.AutomaticSize = Enum.AutomaticSize.Y
    Content.BackgroundTransparency = 1
    Content.Text = Data.Content or Data.Description or ""
    Content.TextColor3 = Theme.SubText or Color3.fromRGB(200, 200, 200)
    Content.TextSize = 12
    Content.Font = Enum.Font.Gotham
    Content.TextWrapped = true
    Content.TextXAlignment = Enum.TextXAlignment.Left
    Content.LayoutOrder = 2
    Content.ZIndex = 502
    Content.Parent = Popup

    local Buttons = Instance.new("Frame")
    Buttons.Size = UDim2.new(1, 0, 0, 36)
    Buttons.BackgroundTransparency = 1
    Buttons.LayoutOrder = 3
    Buttons.ZIndex = 502
    Buttons.Parent = Popup

    local ButtonLayout = Instance.new("UIListLayout")
    ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
    ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ButtonLayout.Padding = UDim.new(0, 8)
    ButtonLayout.Parent = Buttons

    local function AddButton(ButtonData, Index)
        ButtonData = ButtonData or {}

        local Button = Instance.new("TextButton")
        Button.Size = UDim2.fromOffset(90, 34)
        Button.BackgroundColor3 = ButtonData.Primary
            and (Theme.Accent or Color3.new(1, 1, 1))
            or (Theme.Element or Color3.fromRGB(60, 60, 60))
        Button.TextColor3 = ButtonData.Primary
            and (Theme.AccentText or Color3.fromRGB(20, 20, 20))
            or (Theme.Text or Color3.new(1, 1, 1))
        Button.Text = ButtonData.Name or ButtonData.Text or (Index == 1 and "Close" or "OK")
        Button.TextSize = 11
        Button.Font = Enum.Font.GothamMedium
        Button.AutoButtonColor = false
        Button.LayoutOrder = Index
        Button.ZIndex = 503
        Button.Parent = Buttons

        Corner(Button, Theme.Corners and Theme.Corners.Button or 8)
        Stroke(Button, Theme.Border or Color3.fromRGB(100, 100, 100), 0.35)

        Button.MouseEnter:Connect(function()
            Tween(Button, 0.12, {
                BackgroundColor3 = Theme.Hover or Button.BackgroundColor3
            })
        end)

        Button.MouseLeave:Connect(function()
            Tween(Button, 0.12, {
                BackgroundColor3 = ButtonData.Primary
                    and (Theme.Accent or Color3.new(1, 1, 1))
                    or (Theme.Element or Color3.fromRGB(60, 60, 60))
            })
        end)

        Button.MouseButton1Click:Connect(function()
            if type(ButtonData.Callback) == "function" then
                task.spawn(ButtonData.Callback)
            end

            if ButtonData.Close ~= false then
                Object:Close()
            end
        end)

        return Button
    end

    if type(Data.Buttons) == "table" and #Data.Buttons > 0 then
        for Index, ButtonData in ipairs(Data.Buttons) do
            AddButton(ButtonData, Index)
        end
    else
        AddButton({
            Name = Data.ConfirmText or "OK",
            Primary = true,
            Callback = Data.Callback
        }, 1)
    end

    Object.Overlay = Overlay
    Object.Popup = Popup
    Object.Title = Title
    Object.Content = Content

    function Object:SetTitle(Value)
        if self.Title then
            self.Title.Text = tostring(Value or "")
        end
    end

    function Object:SetContent(Value)
        if self.Content then
            self.Content.Text = tostring(Value or "")
        end
    end

    function Object:Close()
        if self.Closed then
            return
        end

        self.Closed = true

        Tween(Overlay, 0.2, {
            BackgroundTransparency = 1
        })

        Tween(Popup, 0.2, {
            Position = UDim2.new(0.5, -195, 0.5, 12)
        })

        task.delay(0.22, function()
            if Overlay and Overlay.Parent then
                Overlay:Destroy()
            end
        end)
    end

    Tween(Overlay, 0.2, {
        BackgroundTransparency = 0.35
    })

    Tween(Popup, 0.35, {
        Position = UDim2.new(0.5, -195, 0.5, 0)
    })

    return Object
end

return Dialog
