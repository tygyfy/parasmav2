-- ============================================
-- GUI БИБЛИОТЕКА
-- ============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Основной класс GUI
local GUI = {}
GUI.__index = GUI

-- Создание основного окна
function GUI:CreateWindow(config)
    local window = {}
    window.__index = window
    
    config = config or {}
    local title = config.Title or "GUI"
    local size = config.Size or UDim2.new(0, 400, 0, 500)
    local position = config.Position or UDim2.new(0, 10, 0.5, -250)
    
    -- Создание ScreenGui
    window.ScreenGui = Instance.new("ScreenGui")
    window.ScreenGui.Name = title .. "Gui"
    window.ScreenGui.ResetOnSpawn = false
    window.ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Основная панель
    window.MainPanel = Instance.new("Frame")
    window.MainPanel.Size = size
    window.MainPanel.Position = position
    window.MainPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    window.MainPanel.BackgroundTransparency = 0.1
    window.MainPanel.BorderSizePixel = 1
    window.MainPanel.BorderColor3 = Color3.fromRGB(100, 150, 200)
    window.MainPanel.Visible = true
    window.MainPanel.Parent = window.ScreenGui
    
    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, 10)
    panelCorner.Parent = window.MainPanel
    
    -- Заголовок
    window.TitleBar = Instance.new("TextLabel")
    window.TitleBar.Size = UDim2.new(1, 0, 0, 40)
    window.TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    window.TitleBar.BackgroundTransparency = 0.3
    window.TitleBar.Text = title
    window.TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    window.TitleBar.TextSize = 16
    window.TitleBar.Font = Enum.Font.GothamBold
    window.TitleBar.Parent = window.MainPanel
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 10)
    titleCorner.Parent = window.TitleBar
    
    -- Кнопка закрытия
    window.CloseButton = Instance.new("TextButton")
    window.CloseButton.Size = UDim2.new(0, 30, 0, 30)
    window.CloseButton.Position = UDim2.new(1, -35, 0, 5)
    window.CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    window.CloseButton.Text = "✕"
    window.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    window.CloseButton.TextSize = 18
    window.CloseButton.Font = Enum.Font.GothamBold
    window.CloseButton.Parent = window.TitleBar
    window.CloseButton.MouseButton1Click:Connect(function()
        window.MainPanel.Visible = false
        if window.ToggleButton then
            window.ToggleButton.Visible = true
        end
    end)
    
    -- Кнопка открытия
    window.ToggleButton = Instance.new("TextButton")
    window.ToggleButton.Size = UDim2.new(0, 40, 0, 40)
    window.ToggleButton.Position = UDim2.new(1, -50, 0, 10)
    window.ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    window.ToggleButton.BackgroundTransparency = 0.2
    window.ToggleButton.Text = "⚙️"
    window.ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    window.ToggleButton.TextSize = 20
    window.ToggleButton.Font = Enum.Font.GothamBold
    window.ToggleButton.Visible = false
    window.ToggleButton.Parent = window.ScreenGui
    window.ToggleButton.MouseButton1Click:Connect(function()
        window.MainPanel.Visible = true
        window.ToggleButton.Visible = false
    end)
    
    -- ScrollingFrame
    window.ScrollFrame = Instance.new("ScrollingFrame")
    window.ScrollFrame.Size = UDim2.new(1, 0, 1, -40)
    window.ScrollFrame.Position = UDim2.new(0, 0, 0, 40)
    window.ScrollFrame.BackgroundTransparency = 1
    window.ScrollFrame.BorderSizePixel = 0
    window.ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    window.ScrollFrame.ScrollBarThickness = 6
    window.ScrollFrame.Parent = window.MainPanel
    
    window.ScrollLayout = Instance.new("UIListLayout")
    window.ScrollLayout.Padding = UDim.new(0, 8)
    window.ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
    window.ScrollLayout.Parent = window.ScrollFrame
    
    window.Sections = {}
    
    local function updateCanvas()
        window.ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, window.ScrollLayout.AbsoluteContentSize.Y)
    end
    
    updateCanvas()
    window.ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
    
    -- Функция для сворачивания/разворачивания окна
    function window:Toggle()
        self.MainPanel.Visible = not self.MainPanel.Visible
        if self.ToggleButton then
            self.ToggleButton.Visible = not self.MainPanel.Visible
        end
    end
    
    -- Функция для добавления секции
    function window:AddSection(config)
        local section = {}
        
        section.Frame = Instance.new("Frame")
        section.Frame.Size = UDim2.new(1, -10, 0, 0)
        section.Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        section.Frame.BackgroundTransparency = 0.2
        section.Frame.BorderSizePixel = 0
        section.Frame.LayoutOrder = #self.Sections + 1
        section.Frame.Parent = self.ScrollFrame
        
        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 6)
        sectionCorner.Parent = section.Frame
        
        section.TitleLabel = Instance.new("TextLabel")
        section.TitleLabel.Size = UDim2.new(1, 0, 0, 25)
        section.TitleLabel.Position = UDim2.new(0, 5, 0, 0)
        section.TitleLabel.BackgroundTransparency = 1
        section.TitleLabel.Text = config.Name or "Section"
        section.TitleLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
        section.TitleLabel.TextSize = 12
        section.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        section.TitleLabel.Font = Enum.Font.GothamBold
        section.TitleLabel.Parent = section.Frame
        
        section.CurrentY = 25
        
        -- AddButton
        function section:AddButton(config)
            local btnFrame = Instance.new("Frame")
            btnFrame.Size = UDim2.new(1, -10, 0, 30)
            btnFrame.Position = UDim2.new(0, 5, 0, self.CurrentY)
            btnFrame.BackgroundTransparency = 1
            btnFrame.Parent = self.Frame
            
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, 0, 1, 0)
            button.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
            button.Text = config.Name or "Button"
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.TextSize = 11
            button.Font = Enum.Font.GothamBold
            button.Parent = btnFrame
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 4)
            btnCorner.Parent = button
            
            if config.Callback then
                button.MouseButton1Click:Connect(config.Callback)
            end
            
            self.CurrentY = self.CurrentY + 35
            self.Frame.Size = UDim2.new(1, -10, 0, self.CurrentY + 10)
            
            return button
        end
        
        -- AddToggle
        function section:AddToggle(config)
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Size = UDim2.new(1, -10, 0, 30)
            toggleFrame.Position = UDim2.new(0, 5, 0, self.CurrentY)
            toggleFrame.BackgroundTransparency = 1
            toggleFrame.Parent = self.Frame
            
            local labelText = Instance.new("TextLabel")
            labelText.Size = UDim2.new(0.7, 0, 1, 0)
            labelText.BackgroundTransparency = 1
            labelText.Text = config.Name or "Toggle"
            labelText.TextColor3 = Color3.fromRGB(220, 220, 220)
            labelText.TextSize = 11
            labelText.TextXAlignment = Enum.TextXAlignment.Left
            labelText.Font = Enum.Font.Gotham
            labelText.Parent = toggleFrame
            
            local toggleBtn = Instance.new("TextButton")
            toggleBtn.Size = UDim2.new(0, 60, 0, 25)
            toggleBtn.Position = UDim2.new(1, -65, 0, 2.5)
            local defaultValue = config.Default or false
            toggleBtn.BackgroundColor3 = defaultValue and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(200, 80, 80)
            toggleBtn.Text = defaultValue and "ON" or "OFF"
            toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleBtn.TextSize = 11
            toggleBtn.Font = Enum.Font.GothamBold
            toggleBtn.Parent = toggleFrame
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 4)
            btnCorner.Parent = toggleBtn
            
            local state = defaultValue
            
            local function setState(newState)
                state = newState
                toggleBtn.BackgroundColor3 = state and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(200, 80, 80)
                toggleBtn.Text = state and "ON" or "OFF"
                if config.Callback then
                    config.Callback(state)
                end
                if config.Flag then
                    _G[config.Flag] = state
                end
            end
            
            toggleBtn.MouseButton1Click:Connect(function()
                setState(not state)
            end)
            
            self.CurrentY = self.CurrentY + 35
            self.Frame.Size = UDim2.new(1, -10, 0, self.CurrentY + 10)
            
            return {SetState = setState, GetState = function() return state end}
        end
        
        -- AddLabel
        function section:AddLabel(config)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -10, 0, 20)
            label.Position = UDim2.new(0, 5, 0, self.CurrentY)
            label.BackgroundTransparency = 1
            label.Text = config.Name or "Label"
            label.TextColor3 = Color3.fromRGB(200, 200, 200)
            label.TextSize = 10
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Font = Enum.Font.Gotham
            label.Parent = self.Frame
            
            self.CurrentY = self.CurrentY + 25
            self.Frame.Size = UDim2.new(1, -10, 0, self.CurrentY + 10)
            
            return label
        end

        -- AddTextbox (поле для ввода данных)
        function section:AddTextbox(config)
            local textboxFrame = Instance.new("Frame")
            textboxFrame.Size = UDim2.new(1, -10, 0, 30)
            textboxFrame.Position = UDim2.new(0, 5, 0, self.CurrentY)
            textboxFrame.BackgroundTransparency = 1
            textboxFrame.Parent = self.Frame
            
            local labelText = Instance.new("TextLabel")
            labelText.Size = UDim2.new(0.35, 0, 1, 0)
            labelText.BackgroundTransparency = 1
            labelText.Text = config.Name or "Input"
            labelText.TextColor3 = Color3.fromRGB(220, 220, 220)
            labelText.TextSize = 11
            labelText.TextXAlignment = Enum.TextXAlignment.Left
            labelText.Font = Enum.Font.Gotham
            labelText.Parent = textboxFrame
            
            local inputBox = Instance.new("TextBox")
            inputBox.Size = UDim2.new(0.6, 0, 1, 0)
            inputBox.Position = UDim2.new(0.35, 0, 0, 0)
            inputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            inputBox.Text = config.Default or ""
            inputBox.PlaceholderText = config.Placeholder or "Введите значение..."
            inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            inputBox.TextSize = 11
            inputBox.Font = Enum.Font.Gotham
            inputBox.Parent = textboxFrame
            
            local inputCorner = Instance.new("UICorner")
            inputCorner.CornerRadius = UDim.new(0, 4)
            inputCorner.Parent = inputBox
            
            local currentValue = inputBox.Text
            
            -- Обработка ввода (по Enter или по потере фокуса)
            inputBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    currentValue = inputBox.Text
                    if config.Callback then
                        config.Callback(currentValue)
                    end
                    if config.Flag then
                        _G[config.Flag] = currentValue
                    end
                end
            end)
            
            self.CurrentY = self.CurrentY + 35
            self.Frame.Size = UDim2.new(1, -10, 0, self.CurrentY + 10)
            
            return {
                GetValue = function() return currentValue end,
                SetValue = function(v)
                    currentValue = v
                    inputBox.Text = v
                    if config.Callback then
                        config.Callback(v)
                    end
                    if config.Flag then
                        _G[config.Flag] = v
                    end
                end
            }
        end
        
        -- AddDropdown (исправленная версия с фиксацией значения)
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
            dropdownList.Size = UDim2.new(0.6, 0, 0, 0)
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
            
            dropdownBtn.Text = selectedValue
            
            -- Создание кнопок опций
            for i = 1, #options do
                local optValue = options[i]  -- Локальная переменная для каждой итерации
                
                local optBtn = Instance.new("TextButton")
                optBtn.Size = UDim2.new(1, 0, 0, 25)
                optBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                optBtn.Text = optValue
                optBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
                optBtn.TextSize = 10
                optBtn.Font = Enum.Font.Gotham
                optBtn.Parent = listScroll
                
                local optCorner = Instance.new("UICorner")
                optCorner.CornerRadius = UDim.new(0, 3)
                optCorner.Parent = optBtn
                
                optBtn.MouseButton1Click:Connect(function()
                    selectedValue = optValue
                    dropdownBtn.Text = optValue
                    dropdownList.Visible = false
                    if config.Callback then
                        config.Callback(optValue)
                    end
                    if config.Flag then
                        _G[config.Flag] = optValue
                    end
                end)
            end
            
            local count = #options
            local height = math.min(count * 27, 120)
            dropdownList.Size = UDim2.new(0.6, 0, 0, height)
            listScroll.CanvasSize = UDim2.new(0, 0, 0, count * 27)
            
            -- Открытие/закрытие списка
            dropdownBtn.MouseButton1Click:Connect(function()
                dropdownList.Visible = not dropdownList.Visible
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
                
        table.insert(self.Sections, section)
        
        return section
    end
    
    return window
end

return GUI
