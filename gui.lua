-- =============== УЛУЧШЕННЫЙ GUI ИНТЕРФЕЙС ===============

-- Создаем основной GUI для управления
local controlGui = Instance.new("ScreenGui")
controlGui.Name = "ControlPanelGui"
controlGui.ResetOnSpawn = false
controlGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Основная панель
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, 350, 0, 600)
mainPanel.Position = UDim2.new(0, 10, 0.5, -300)
mainPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainPanel.BackgroundTransparency = 0.1
mainPanel.BorderSizePixel = 1
mainPanel.BorderColor3 = Color3.fromRGB(100, 150, 200)
mainPanel.Visible = true
mainPanel.Parent = controlGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 10)
panelCorner.Parent = mainPanel

-- Заголовок панели
local panelTitle = Instance.new("TextLabel")
panelTitle.Size = UDim2.new(1, 0, 0, 40)
panelTitle.Position = UDim2.new(0, 0, 0, 0)
panelTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
panelTitle.BackgroundTransparency = 0.3
panelTitle.Text = "⚙️ КОНТРОЛЬНАЯ ПАНЕЛЬ"
panelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
panelTitle.TextSize = 16
panelTitle.Font = Enum.Font.GothamBold
panelTitle.Parent = mainPanel

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = panelTitle

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = panelTitle

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    mainPanel.Visible = false
end)

-- Кнопка для открытия панели
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(1, -50, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
toggleButton.BackgroundTransparency = 0.2
toggleButton.Text = "⚙️"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 20
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = controlGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

toggleButton.MouseButton1Click:Connect(function()
    mainPanel.Visible = true
end)

-- ScrollingFrame
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -40)
scrollFrame.Position = UDim2.new(0, 0, 0, 40)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.Parent = mainPanel

local scrollLayout = Instance.new("UIListLayout")
scrollLayout.Padding = UDim.new(0, 8)
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollLayout.Parent = scrollFrame

-- Функция создания секции
local function createSection(title, order)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -10, 0, 0)
    section.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    section.BackgroundTransparency = 0.2
    section.BorderSizePixel = 0
    section.LayoutOrder = order
    section.Parent = scrollFrame
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 6)
    sectionCorner.Parent = section
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 25)
    titleLabel.Position = UDim2.new(0, 5, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    titleLabel.TextSize = 12
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = section
    
    return section
end

-- Функция создания кнопки
local function createButton(section, label, yPos, onClick)
    local btnFrame = Instance.new("Frame")
    btnFrame.Size = UDim2.new(1, -10, 0, 30)
    btnFrame.Position = UDim2.new(0, 5, 0, yPos)
    btnFrame.BackgroundTransparency = 1
    btnFrame.Parent = section
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
    button.Text = label
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 11
    button.Font = Enum.Font.GothamBold
    button.Parent = btnFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = button
    
    if onClick then
        button.MouseButton1Click:Connect(onClick)
    end
    
    return btnFrame
end

-- Функция создания переключателя
local function createToggle(section, label, getState, setState, yPos)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -10, 0, 30)
    toggleFrame.Position = UDim2.new(0, 5, 0, yPos)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = section
    
    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(0.7, 0, 1, 0)
    labelText.Position = UDim2.new(0, 0, 0, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.TextColor3 = Color3.fromRGB(220, 220, 220)
    labelText.TextSize = 11
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Font = Enum.Font.Gotham
    labelText.Parent = toggleFrame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 60, 0, 25)
    toggleBtn.Position = UDim2.new(1, -65, 0, 2.5)
    toggleBtn.BackgroundColor3 = getState() and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(200, 80, 80)
    toggleBtn.Text = getState() and "ON" or "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 11
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Parent = toggleFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = toggleBtn
    
    toggleBtn.MouseButton1Click:Connect(function()
        setState(not getState())
        toggleBtn.BackgroundColor3 = getState() and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(200, 80, 80)
        toggleBtn.Text = getState() and "ON" or "OFF"
    end)
    
    return toggleFrame
end

-- Функция создания поля ввода
local function createInputField(section, label, placeholder, yPos, onEnter)
    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(1, -10, 0, 30)
    inputFrame.Position = UDim2.new(0, 5, 0, yPos)
    inputFrame.BackgroundTransparency = 1
    inputFrame.Parent = section
    
    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(0.35, 0, 1, 0)
    labelText.Position = UDim2.new(0, 0, 0, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.TextColor3 = Color3.fromRGB(220, 220, 220)
    labelText.TextSize = 11
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Font = Enum.Font.Gotham
    labelText.Parent = inputFrame
    
    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(0.6, 0, 1, 0)
    inputBox.Position = UDim2.new(0.35, 0, 0, 0)
    inputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    inputBox.Text = ""
    inputBox.PlaceholderText = placeholder
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.TextSize = 11
    inputBox.Font = Enum.Font.Gotham
    inputBox.Parent = inputFrame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 4)
    inputCorner.Parent = inputBox
    
    if onEnter then
        inputBox.FocusLost:Connect(function(enterPressed)
            if enterPressed and inputBox.Text ~= "" then
                onEnter(inputBox.Text)
                inputBox.Text = ""
            end
        end)
    end
    
    return inputFrame
end

-- =============== СОЗДАЕМ СЕКЦИИ ===============

-- Секция 1: ESP
local espSection = createSection("🎯 ESP", 1)
local espY = 25
createToggle(espSection, "ESP фруктов", function() return fruitEspEnabled end, function(v) 
    fruitEspEnabled = v
    if v then
        fruitEspThread = task.spawn(fruitEspLoop)
        addOutput("✓ ESP фруктов ВКЛЮЧЕН", Color3.fromRGB(100, 255, 100))
    else
        fruitEspThread = nil
        addOutput("⛔ ESP фруктов ВЫКЛЮЧЕН", Color3.fromRGB(255, 100, 100))
    end
end, espY)
espY = espY + 35

createButton(espSection, "📦 Телепорт к ближайшему фрукту", espY, function()
    teleportToNearestFruit()
end)
espY = espY + 35

createButton(espSection, "💾 AutoStore (заготовка)", espY, function()
    addOutput("⚠ AutoStore в разработке", Color3.fromRGB(255, 200, 100))
end)
espY = espY + 35
espSection.Size = UDim2.new(1, -10, 0, espY + 10)

-- Секция 2: Easter Event
local easterSection = createSection("🐣 Easter Event", 2)
local easterY = 25
createToggle(easterSection, "ESP яиц", function() return eggEspEnabled end, function(v) 
    eggEspEnabled = v
    if v then
        eggEspThread = task.spawn(eggEspLoop)
        addOutput("✓ ESP яиц ВКЛЮЧЕН", Color3.fromRGB(100, 255, 100))
    else
        eggEspThread = nil
        addOutput("⛔ ESP яиц ВЫКЛЮЧЕН", Color3.fromRGB(255, 100, 100))
    end
end, easterY)
easterY = easterY + 35

createButton(easterSection, "🥚 Телепорт к ближайшему яйцу", easterY, function()
    teleportToNearestEgg()
end)
easterY = easterY + 35
easterSection.Size = UDim2.new(1, -10, 0, easterY + 10)

-- Секция 3: Боевые функции
local combatSection = createSection("⚔️ Боевые функции", 3)
local combatY = 25
createToggle(combatSection, "Киллаура", function() return auraEnabled end, function(v) 
    if v ~= auraEnabled then
        toggleAura()
    end
end, combatY)
combatY = combatY + 35

createToggle(combatSection, "AIM (по игрокам)", function() return aimbotActive end, function(v) 
    aimbotActive = v
    addOutput(v and "✓ AIM ВКЛЮЧЕН" or "⛔ AIM ВЫКЛЮЧЕН", Color3.fromRGB(100, 255, 100))
end, combatY)
combatY = combatY + 35

createToggle(combatSection, "AIM (по мобам)", function() return aimEnabled end, function(v) 
    if v ~= aimEnabled then
        toggleAim()
    end
end, combatY)
combatY = combatY + 35
combatSection.Size = UDim2.new(1, -10, 0, combatY + 10)

-- Секция 4: Фарм
local farmSection = createSection("🌾 Фарм", 4)
local farmY = 25
createToggle(farmSection, "Автофарм уровня", function() return farmEnabled end, function(v) 
    if v ~= farmEnabled then
        farmEnabled = v
        if v then
            addOutput("✓ АВТОФАРМ уровня ВКЛЮЧЁН", Color3.fromRGB(100, 255, 100))
            farmThread = task.spawn(function()
                task.spawn(auraLoop)
                autoFlyToEnemies()
            end)
        else
            addOutput("⛔ АВТОФАРМ уровня ВЫКЛЮЧЕН", Color3.fromRGB(255, 100, 100))
            farmThread = nil
        end
    end
end, farmY)
farmY = farmY + 35

createToggle(farmSection, "Сбор сундуков", function() return chestFarmRunning end, function(v) 
    if v then
        startChestFarm()
    else
        stopChestFarm()
    end
end, farmY)
farmY = farmY + 35

createInputField(farmSection, "Мастерка:", "melee/sword/gun/fruit/off", farmY, function(value)
    local cmd = "/mastery " .. value
    processCommand(cmd)
end)
farmY = farmY + 35

createToggle(farmSection, "Режим рейда", function() return raidRunning end, function(v) 
    if v then
        startRaid()
    else
        stopRaid()
    end
end, farmY)
farmY = farmY + 35
farmSection.Size = UDim2.new(1, -10, 0, farmY + 10)

-- Секция 5: Misc
local miscSection = createSection("🔧 Misc", 5)
local miscY = 25
createToggle(miscSection, "Режим полёта", function() return Fly end, function(v) 
    if v ~= Fly then
        toggleFlyMode()
    end
end, miscY)
miscY = miscY + 35

createToggle(miscSection, "Noclip", function() 
    local char = getCharacter()
    if char then
        for _, v in ipairs(char:GetChildren()) do
            if v:IsA("BasePart") and not v.CanCollide then
                return true
            end
        end
    end
    return false
end, function(v) 
    toggleNoclip(v)
    addOutput(v and "✓ Noclip ВКЛЮЧЕН" or "⛔ Noclip ВЫКЛЮЧЕН", Color3.fromRGB(100, 255, 100))
end, miscY)
miscY = miscY + 35

createInputField(miscSection, "Телепорт к игроку:", "ник", miscY, function(value)
    flyToPlayer(value)
end)
miscY = miscY + 35

createInputField(miscSection, "Телепорт к острову:", "название", miscY, function(value)
    flyToIslandByName(value)
end)
miscY = miscY + 35

createButton(miscSection, "📋 Список островов", miscY, function()
    listIslands()
end)
miscY = miscY + 35
miscSection.Size = UDim2.new(1, -10, 0, miscY + 10)

-- Секция 6: Sea Events
local seaSection = createSection("🌊 Sea Events", 6)
local seaY = 25

createInputField(seaSection, "Ник игрока:", "ник", seaY, nil)
seaY = seaY + 35

createInputField(seaSection, "Название лодки:", "лодка", seaY, nil)
seaY = seaY + 35

createInputField(seaSection, "Параметр:", "MaxSpeed / TurnSpeed", seaY, nil)
seaY = seaY + 35

createInputField(seaSection, "Значение:", "число", seaY, function(value)
    addOutput("⚠ Функция настройки лодки в разработке", Color3.fromRGB(255, 200, 100))
    addOutput("  Используйте команду: /boat <ник> <лодка> <параметр> <значение>", Color3.fromRGB(150, 200, 255))
end)
seaY = seaY + 35
seaSection.Size = UDim2.new(1, -10, 0, seaY + 10)

-- Секция 7: Player
local playerSection = createSection("👤 Player", 7)
local playerY = 25

createInputField(playerSection, "Сила прыжка:", "default = 50", playerY, function(value)
    local v = tonumber(value)
    if v then
        setPlayerJumpPower(v)
    else
        addOutput("✗ Значение должно быть числом", Color3.fromRGB(255, 100, 100))
    end
end)
playerY = playerY + 35
playerSection.Size = UDim2.new(1, -10, 0, playerY + 10)

-- Секция 8: Server
local serverSection = createSection("🖥️ Server", 8)
local serverY = 25

local serverUptimeLabel = Instance.new("TextLabel")
serverUptimeLabel.Size = UDim2.new(1, -10, 0, 30)
serverUptimeLabel.Position = UDim2.new(0, 5, 0, serverY)
serverUptimeLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
serverUptimeLabel.BackgroundTransparency = 0.5
serverUptimeLabel.Text = "Аптайм: 00:00:00"
serverUptimeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
serverUptimeLabel.TextSize = 11
serverUptimeLabel.Font = Enum.Font.Gotham
serverUptimeLabel.Parent = serverSection

local uptimeCorner = Instance.new("UICorner")
uptimeCorner.CornerRadius = UDim.new(0, 4)
uptimeCorner.Parent = serverUptimeLabel

serverY = serverY + 35

createButton(serverSection, "📡 Информация о сервере", serverY, function()
    showServerInfo()
end)
serverY = serverY + 35
serverSection.Size = UDim2.new(1, -10, 0, serverY + 10)

-- Обновление аптайма
task.spawn(function()
    while true do
        local uptime = formatServerUptime()
        serverUptimeLabel.Text = "🕐 Аптайм: " .. uptime
        task.wait(2)
    end
end)

-- Обновляем CanvasSize
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, scrollLayout.AbsoluteContentSize.Y)

scrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, scrollLayout.AbsoluteContentSize.Y)
end)

addOutput("✓ Улучшенный GUI интерфейс загружен! (кнопка ⚙️ в правом верхнем углу)", Color3.fromRGB(100, 255, 100))