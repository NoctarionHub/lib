if true then
    local mobileToggle = Instance.new("ImageButton")
    mobileToggle.Name = "MobileToggleButton"
    mobileToggle.BackgroundColor3 = Color3.fromRGB(1, 1, 1)
    mobileToggle.BackgroundTransparency = 0
    mobileToggle.BorderSizePixel = 0
    local topInset  = GuiService:GetGuiInset().Y
    local toggleSize = 50
    local bandY = -(topInset / GetUIScale()) + ((topInset / GetUIScale()) - toggleSize) / 2

    mobileToggle.AnchorPoint = Vector2.new(0, 0)
    mobileToggle.Position = opts.TogglePosition or UDim2.new(0.13287, 0, 0.0341, 0)
    mobileToggle.Size = UDim2.fromOffset(toggleSize, toggleSize)
    mobileToggle.Image = "rbxassetid://81687776861363"
    mobileToggle.ZIndex = Z.Toast
    mobileToggle.Parent = root

    local mobileToggleCorner = Instance.new("UICorner")
    mobileToggleCorner.CornerRadius = UDim.new(1, 0)
    mobileToggleCorner.Parent = mobileToggle

    local DRAG_SLOP = 8
    local dragInput, dragStart, startPos, dragged

    jan:Add(mobileToggle.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.Touch
            and input.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end
        if dragInput then return end
        dragInput = input
        dragStart = input.Position
        startPos  = mobileToggle.Position
        dragged   = false
    end))

    jan:Add(UserInputService.InputChanged:Connect(function(input)
        if input ~= dragInput or not dragStart then return end
        local delta = input.Position - dragStart
        if not dragged and delta.Magnitude > DRAG_SLOP then dragged = true end
        if not dragged then return end
        local s = GetUIScale()
        mobileToggle.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X / s,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y / s
        )
    end))

    jan:Add(UserInputService.InputEnded:Connect(function(input)
        if input ~= dragInput then return end
        dragInput, dragStart = nil, nil
        if not dragged then
            self:Toggle()
        end
    end))

    jan:Add(mobileToggle)
