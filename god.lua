local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CyberGamingHubV2"
screenGui.ResetOnSpawn = false
screenGui.Parent = pcall(function() return CoreGui.Name end) and CoreGui or player:WaitForChild("PlayerGui")

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 55, 0, 55)
toggleBtn.Position = UDim2.new(0, 15, 0, 15)
toggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
toggleBtn.BackgroundTransparency = 0.2
toggleBtn.Text = "👽"
toggleBtn.Font = Enum.Font.GothamBlack
toggleBtn.TextSize = 30
toggleBtn.Parent = screenGui

Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
local toggleStroke = Instance.new("UIStroke", toggleBtn)
toggleStroke.Color = Color3.fromRGB(0, 255, 255)
toggleStroke.Thickness = 3

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(0, 255, 255)
mainStroke.Thickness = 2
mainStroke.Transparency = 1

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "ABSOLUTE EDITION"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextTransparency = 1
title.Parent = mainFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -60)
scrollFrame.Position = UDim2.new(0, 0, 0, 50)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 850)
scrollFrame.Parent = mainFrame

local layout = Instance.new("UIListLayout", scrollFrame)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

Instance.new("Frame", scrollFrame).Size = UDim2.new(1, 0, 0, 2)

local teleFrame = Instance.new("Frame")
teleFrame.Size = UDim2.new(0, 300, 0, 150)
teleFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
teleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
teleFrame.Visible = false
teleFrame.Active = true
teleFrame.Parent = screenGui
Instance.new("UICorner", teleFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", teleFrame).Color = Color3.fromRGB(255, 0, 255)
Instance.new("UIStroke", teleFrame).Thickness = 2

local teleTitle = Instance.new("TextLabel")
teleTitle.Size = UDim2.new(1, 0, 0, 30)
teleTitle.BackgroundTransparency = 1
teleTitle.Text = "TELEPORT (SLOW FLY)"
teleTitle.TextColor3 = Color3.fromRGB(255, 0, 255)
teleTitle.Font = Enum.Font.GothamBold
teleTitle.TextSize = 18
teleTitle.Parent = teleFrame

local teleInput = Instance.new("TextBox")
teleInput.Size = UDim2.new(0.9, 0, 0, 40)
teleInput.Position = UDim2.new(0.05, 0, 0, 40)
teleInput.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
teleInput.Text = ""
teleInput.PlaceholderText = "Nhập tên người chơi..."
teleInput.TextColor3 = Color3.fromRGB(255, 255, 255)
teleInput.Font = Enum.Font.Gotham
teleInput.TextSize = 16
teleInput.Parent = teleFrame
Instance.new("UICorner", teleInput).CornerRadius = UDim.new(0, 5)

local doTeleBtn = Instance.new("TextButton")
doTeleBtn.Size = UDim2.new(0.9, 0, 0, 40)
doTeleBtn.Position = UDim2.new(0.05, 0, 0, 95)
doTeleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
doTeleBtn.Text = "BAY ĐẾN NGAY"
doTeleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
doTeleBtn.Font = Enum.Font.GothamBold
doTeleBtn.TextSize = 16
doTeleBtn.Parent = teleFrame
Instance.new("UICorner", doTeleBtn).CornerRadius = UDim.new(0, 5)

local uiElements = {mainFrame, mainStroke, title, scrollFrame}
local states = {GodMode = false, Aimbot = false, ESP = false, TeleToggle = false, Hitbox = false, Speed = false, Jump = false, Noclip = false, Spinbot = false, Fullbright = false, AntiAFK = false, WaterWalk = false}
local connections = {}
local espObjects = {}
local buttons = {}
local strokes = {}

local hue = 0
RunService.RenderStepped:Connect(function(dt)
    hue = hue + (dt * 0.15)
    if hue >= 1 then hue = 0 end
    local rgb1 = Color3.fromHSV(hue, 1, 1)
    local rgb2 = Color3.fromHSV((hue + 0.5) % 1, 1, 1)
    toggleStroke.Color = rgb1
    mainStroke.Color = rgb2
    title.TextColor3 = rgb1
end)

local function makeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(toggleBtn)
makeDraggable(mainFrame)
makeDraggable(teleFrame)

local function createToggle(name, id, order, isMaster)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.92, 0, 0, 48)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.Text = name .. " : OFF"
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.BackgroundTransparency = 1
    btn.TextTransparency = 1
    btn.LayoutOrder = order
    btn.Parent = scrollFrame
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = isMaster and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(60, 60, 60)
    stroke.Thickness = 2
    stroke.Transparency = 1
    
    table.insert(uiElements, btn)
    table.insert(uiElements, stroke)
    buttons[id] = btn
    strokes[id] = stroke
end

createToggle("Master: God Mode", "GodMode", 1, true)
createToggle("Smooth Aimbot", "Aimbot", 2, false)
createToggle("ESP Name & Distance", "ESP", 3, false)
createToggle("Teleport Player (Slow)", "TeleToggle", 4, false)
createToggle("Hitbox Expander", "Hitbox", 5, false)
createToggle("Speed Boost (120)", "Speed", 6, false)
createToggle("Infinite Jump", "Jump", 7, false)
createToggle("Noclip (Ghost)", "Noclip", 8, false)
createToggle("Spinbot", "Spinbot", 9, false)
createToggle("Jesus Walk (Water)", "WaterWalk", 10, false)
createToggle("Fullbright", "Fullbright", 11, false)
createToggle("Anti-AFK", "AntiAFK", 12, false)

local isOpen = false
local twFast = TweenInfo.new(0.2, Enum.EasingStyle.Linear)
local twSmooth = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

toggleBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        mainFrame.Position = UDim2.new(0.5, -200, 0.5, -230)
        mainFrame.Visible = true
        TweenService:Create(mainFrame, twSmooth, {Position = UDim2.new(0.5, -200, 0.5, -250)}):Play()
        for _, el in ipairs(uiElements) do
            if el:IsA("UIStroke") then TweenService:Create(el, twFast, {Transparency = 0}):Play()
            elseif el:IsA("TextLabel") or el:IsA("TextButton") then TweenService:Create(el, twFast, {BackgroundTransparency = 0, TextTransparency = 0}):Play()
            elseif el:IsA("Frame") or el:IsA("ScrollingFrame") then TweenService:Create(el, twFast, {BackgroundTransparency = 0}):Play() end
        end
    else
        TweenService:Create(mainFrame, twSmooth, {Position = UDim2.new(0.5, -200, 0.5, -280)}):Play()
        for _, el in ipairs(uiElements) do
            if el:IsA("UIStroke") then TweenService:Create(el, twFast, {Transparency = 1}):Play()
            elseif el:IsA("TextLabel") or el:IsA("TextButton") then TweenService:Create(el, twFast, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
            elseif el:IsA("Frame") or el:IsA("ScrollingFrame") then TweenService:Create(el, twFast, {BackgroundTransparency = 1}):Play() end
        end
        task.wait(0.3)
        if not isOpen then mainFrame.Visible = false end
    end
end)

local function updateUI(id, prefix, colorOn)
    local btn = buttons[id]
    local stroke = strokes[id]
    if states[id] then
        btn.Text = prefix .. " : ON"
        TweenService:Create(btn, twFast, {TextColor3 = colorOn}):Play()
        TweenService:Create(stroke, twFast, {Color = colorOn}):Play()
    else
        btn.Text = prefix .. " : OFF"
        TweenService:Create(btn, twFast, {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
        TweenService:Create(stroke, twFast, {Color = id == "GodMode" and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(60, 60, 60)}):Play()
    end
end

local function clearESP()
    for _, obj in pairs(espObjects) do
        if obj then obj:Destroy() end
    end
    espObjects = {}
end

local function disableAll()
    local funcs = {"Aimbot", "ESP", "TeleToggle", "Hitbox", "Speed", "Jump", "Noclip", "Spinbot", "Fullbright", "AntiAFK", "WaterWalk"}
    local titles = {
        Aimbot = "Smooth Aimbot", ESP = "ESP Name & Distance", TeleToggle = "Teleport Player (Slow)", 
        Hitbox = "Hitbox Expander", Speed = "Speed Boost (120)", Jump = "Infinite Jump", 
        Noclip = "Noclip (Ghost)", Spinbot = "Spinbot", Fullbright = "Fullbright", AntiAFK = "Anti-AFK", WaterWalk = "Jesus Walk (Water)"
    }
    for _, fn in ipairs(funcs) do
        states[fn] = false
        updateUI(fn, titles[fn], Color3.fromRGB(0, 255, 128))
    end
    teleFrame.Visible = false
    clearESP()
    for k, v in pairs(connections) do
        if k ~= "God" and v then v:Disconnect() connections[k] = nil end
    end
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
    end
    for _, v in ipairs(Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("Head") then
            v.Character.Head.Size = Vector3.new(1.2, 1.2, 1.2)
        end
    end
    Lighting.Ambient = Color3.fromRGB(128, 128, 128)
    Lighting.GlobalShadows = true
end

buttons.GodMode.MouseButton1Click:Connect(function()
    states.GodMode = not states.GodMode
    updateUI("GodMode", "Master: God Mode", Color3.fromRGB(255, 50, 50))
    if states.GodMode then
        if connections.God then connections.God:Disconnect() end
        connections.God = RunService.RenderStepped:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
                player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            end
        end)
    else
        if connections.God then connections.God:Disconnect() connections.God = nil end
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        end
        disableAll()
    end
end)

local function handleToggle(id, prefix, fnOn, fnOff)
    buttons[id].MouseButton1Click:Connect(function()
        if not states.GodMode then
            TweenService:Create(strokes[id], twFast, {Color = Color3.fromRGB(255, 0, 0)}):Play()
            task.wait(0.2)
            TweenService:Create(strokes[id], twFast, {Color = Color3.fromRGB(60, 60, 60)}):Play()
            return
        end
        states[id] = not states[id]
        updateUI(id, prefix, Color3.fromRGB(0, 255, 255))
        if states[id] then fnOn() else fnOff() end
    end)
end

handleToggle("Aimbot", "Smooth Aimbot", function()
    connections.Aimbot = RunService.RenderStepped:Connect(function()
        local nearest, dist = nil, math.huge
        local cam = Workspace.CurrentCamera
        local mPos = UserInputService:GetMouseLocation()
        for _, v in ipairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local pt, on = cam:WorldToViewportPoint(v.Character.Head.Position)
                if on then
                    local mag = (Vector2.new(pt.X, pt.Y) - mPos).Magnitude
                    if mag < dist then dist = mag nearest = v end
                end
            end
        end
        if nearest then
            local targetCFrame = CFrame.new(cam.CFrame.Position, nearest.Character.Head.Position)
            cam.CFrame = cam.CFrame:Lerp(targetCFrame, 0.15)
        end
    end)
end, function()
    if connections.Aimbot then connections.Aimbot:Disconnect() connections.Aimbot = nil end
end)

local function createESP(plr)
    if plr == player then return end
    local bgui = Instance.new("BillboardGui")
    bgui.Name = plr.Name .. "ESP"
    bgui.AlwaysOnTop = true
    bgui.Size = UDim2.new(0, 200, 0, 50)
    bgui.StudsOffset = Vector3.new(0, 3, 0)
    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 14
    txt.TextColor3 = Color3.fromRGB(0, 255, 255)
    txt.TextStrokeTransparency = 0
    txt.Parent = bgui
    
    local hl = Instance.new("Highlight")
    hl.FillColor = Color3.fromRGB(0, 255, 255)
    hl.FillTransparency = 0.5
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    
    local upd = RunService.RenderStepped:Connect(function()
        if plr.Character and plr.Character:FindFirstChild("Head") and player.Character and player.Character:FindFirstChild("Head") then
            bgui.Parent = plr.Character.Head
            hl.Parent = plr.Character
            local d = (player.Character.Head.Position - plr.Character.Head.Position).Magnitude
            txt.Text = plr.Name .. "\n[" .. math.floor(d) .. "m]"
        else
            bgui.Parent = nil
            hl.Parent = nil
        end
    end)
    table.insert(espObjects, bgui)
    table.insert(espObjects, hl)
    table.insert(espObjects, upd)
end

handleToggle("ESP", "ESP Name & Distance", function()
    for _, v in ipairs(Players:GetPlayers()) do createESP(v) end
    connections.ESPAdd = Players.PlayerAdded:Connect(createESP)
end, function()
    if connections.ESPAdd then connections.ESPAdd:Disconnect() connections.ESPAdd = nil end
    clearESP()
end)

handleToggle("TeleToggle", "Teleport Player (Slow)", function()
    teleFrame.Visible = true
end, function()
    teleFrame.Visible = false
end)

local currentTeleTween = nil
doTeleBtn.MouseButton1Click:Connect(function()
    if not states.GodMode or not states.TeleToggle then return end
    local targetName = string.lower(teleInput.Text)
    local targetPlr = nil
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= player and string.find(string.lower(v.Name), targetName) then
            targetPlr = v break
        end
    end
    if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local myRoot = player.Character.HumanoidRootPart
        local targetPos = targetPlr.Character.HumanoidRootPart.Position
        local dist = (myRoot.Position - targetPos).Magnitude
        local timeToFly = dist / 350
        
        if currentTeleTween then currentTeleTween:Cancel() end
        
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Parent = myRoot
        
        local ti = TweenInfo.new(timeToFly, Enum.EasingStyle.Linear)
        currentTeleTween = TweenService:Create(myRoot, ti, {CFrame = targetPlr.Character.HumanoidRootPart.CFrame})
        currentTeleTween:Play()
        currentTeleTween.Completed:Connect(function()
            bv:Destroy()
        end)
    end
end)

handleToggle("Hitbox", "Hitbox Expander", function()
    connections.Hitbox = RunService.RenderStepped:Connect(function()
        for _, v in ipairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
                v.Character.Head.Size = Vector3.new(5, 5, 5)
                v.Character.Head.Transparency = 0.5
                v.Character.Head.CanCollide = false
            end
        end
    end)
end, function()
    if connections.Hitbox then connections.Hitbox:Disconnect() connections.Hitbox = nil end
    for _, v in ipairs(Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("Head") then
            v.Character.Head.Size = Vector3.new(1.2, 1.2, 1.2)
            v.Character.Head.Transparency = 0
        end
    end
end)

handleToggle("Speed", "Speed Boost (120)", function()
    connections.Speed = RunService.RenderStepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = 120 end
    end)
end, function()
    if connections.Speed then connections.Speed:Disconnect() connections.Speed = nil end
    if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = 16 end
end)

handleToggle("Jump", "Infinite Jump", function()
    connections.Jump = UserInputService.JumpRequest:Connect(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end, function()
    if connections.Jump then connections.Jump:Disconnect() connections.Jump = nil end
end)

handleToggle("Noclip", "Noclip (Ghost)", function()
    connections.Noclip = RunService.Stepped:Connect(function()
        if player.Character then
            for _, p in ipairs(player.Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end)
end, function()
    if connections.Noclip then connections.Noclip:Disconnect() connections.Noclip = nil end
end)

handleToggle("Spinbot", "Spinbot", function()
    connections.Spinbot = RunService.RenderStepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(60), 0)
        end
    end)
end, function()
    if connections.Spinbot then connections.Spinbot:Disconnect() connections.Spinbot = nil end
end)

handleToggle("WaterWalk", "Jesus Walk (Water)", function()
    connections.WaterWalk = RunService.RenderStepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = player.Character.HumanoidRootPart.Position
            local state = Workspace.Terrain:GetWaterWaveHeight()
            if Workspace:Raycast(pos, Vector3.new(0, -5, 0)) == nil then
                local material = Workspace.Terrain:GetMaterial(pos - Vector3.new(0, 3, 0))
                if material == Enum.Material.Water then
                    player.Character.HumanoidRootPart.Velocity = Vector3.new(player.Character.HumanoidRootPart.Velocity.X, 0, player.Character.HumanoidRootPart.Velocity.Z)
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, math.max(pos.Y, Workspace.Terrain.Position.Y + 2), pos.Z)
                end
            end
        end
    end)
end, function()
    if connections.WaterWalk then connections.WaterWalk:Disconnect() connections.WaterWalk = nil end
end)

handleToggle("Fullbright", "Fullbright", function()
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.GlobalShadows = false
end, function()
    Lighting.Ambient = Color3.fromRGB(128, 128, 128)
    Lighting.GlobalShadows = true
end)

handleToggle("AntiAFK", "Anti-AFK", function()
    connections.AntiAFK = player.Idled:Connect(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end)
end, function()
    if connections.AntiAFK then connections.AntiAFK:Disconnect() connections.AntiAFK = nil end
end)