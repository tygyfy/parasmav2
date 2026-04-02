-- AddDropdown (исправленная версия)
function section:AddDropdown(config)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, -10, 0, 30)
    dropdownFrame.Position = UDim2.new(0, 5, 0, self.CurrentY)
    dropdownFrame.BackgroundTransparency = 1
    dropdownFrame.Parent = self.Frame
    
    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(0.35, 0, 1, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = config.Name or "Dropdown"
    labelText.TextColor3 = Color3.fromRGB(220, 220, 220)
    labelText.TextSize = 11
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Font = Enum.Font.Gotham
    labelText.Parent = dropdownFrame
    
    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Size = UDim2.new(0.6, 0, 1, 0)
    dropdownBtn.Position = UDim2.new(0.35, 0, 0, 0)
    dropdownBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    dropdownBtn.Text = config.Default or "Select"
    dropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownBtn.TextSize = 11
    dropdownBtn.Font = Enum.Font.Gotham
    dropdownBtn.Parent = dropdownFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = dropdownBtn
    
    -- Выпадающий список
    local dropdownList = Instance.new("Frame")
    dropdownList.Size = UDim2.new(0.6, 0, 0, 100)
    dropdownList.Position = UDim2.new(0.35, 0, 0, 30)
    dropdownList.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    dropdownList.BackgroundTransparency = 0.1
    dropdownList.BorderSizePixel = 1
    dropdownList.BorderColor3 = Color3.fromRGB(100, 100, 100)
    dropdownList.Visible = false
    dropdownList.Parent = dropdownFrame
    
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 4)
    listCorner.Parent = dropdownList
    
    local listScroll = Instance.new("ScrollingFrame")
    listScroll.Size = UDim2.new(1, 0, 1, 0)
    listScroll.BackgroundTransparency = 1
    listScroll.BorderSizePixel = 0
    listScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    listScroll.ScrollBarThickness = 4
    listScroll.Parent = dropdownList
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = listScroll
    
    local options = config.Options or {}
    local selectedValue = config.Default or (options[1] or "")
    
    -- Устанавливаем начальное значение на кнопке
    dropdownBtn.Text = selectedValue
    
    -- Создание кнопок опций
    for i = 1, #options do
        local option = options[i]
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 25)
        optBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        optBtn.Text = option
        optBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
        optBtn.TextSize = 10
        optBtn.Font = Enum.Font.Gotham
        optBtn.Parent = listScroll
        
        local optCorner = Instance.new("UICorner")
        optCorner.CornerRadius = UDim.new(0, 3)
        optCorner.Parent = optBtn
        
        -- Сохраняем значение опции в замыкании
        local selectedOption = option
        optBtn.MouseButton1Click:Connect(function()
            selectedValue = selectedOption
            dropdownBtn.Text = selectedOption
            dropdownList.Visible = false
            dropdownList.Size = UDim2.new(0.6, 0, 0, 100)
            if config.Callback then
                config.Callback(selectedOption)
            end
            if config.Flag then
                _G[config.Flag] = selectedOption
            end
        end)
    end
    
    listScroll.CanvasSize = UDim2.new(0, 0, 0, #options * 27)
    
    -- Открытие/закрытие списка
    dropdownBtn.MouseButton1Click:Connect(function()
        dropdownList.Visible = not dropdownList.Visible
        if dropdownList.Visible then
            local height = math.min(#options * 27, 120)
            dropdownList.Size = UDim2.new(0.6, 0, 0, height)
        else
            dropdownList.Size = UDim2.new(0.6, 0, 0, 100)
        end
    end)
    
    -- Закрытие списка при клике вне его
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            task.wait()
            if dropdownList and dropdownList.Parent then
                local mousePos = UserInputService:GetMouseLocation()
                local absPos = dropdownList.AbsolutePosition
                local absSize = dropdownList.AbsoluteSize
                if not (mousePos.X >= absPos.X and mousePos.X <= absPos.X + absSize.X and
                       mousePos.Y >= absPos.Y and mousePos.Y <= absPos.Y + absSize.Y) then
                    dropdownList.Visible = false
                    dropdownList.Size = UDim2.new(0.6, 0, 0, 100)
                end
            end
        end
    end)
    
    self.CurrentY = self.CurrentY + 35
    self.Frame.Size = UDim2.new(1, -10, 0, self.CurrentY + 10)
    
    return {
        GetValue = function() return selectedValue end,
        SetValue = function(v)
            selectedValue = v
            dropdownBtn.Text = v
            if config.Callback then
                config.Callback(v)
            end
            if config.Flag then
                _G[config.Flag] = v
            end
        end
    }
end
