local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- VALIDASI DRAWING API (Wajib buat Skeleton V3)
local isDrawingSupported = (typeof(Drawing) == "table" and Drawing.new ~= nil)

-- 1. SCREEN GUI UTAMA
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ViperHub_V3"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- Gradient Maker Utility
local function applyDarkRedGradient(parent)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
    })
    grad.Rotation = 90
    grad.Parent = parent
end

-- ========================================== --
--          PLATFORM SELECTION SCREEN         --
-- ========================================== --

local SetupFrame = Instance.new("Frame")
SetupFrame.Name = "SetupFrame"
SetupFrame.Size = UDim2.new(0, 340, 0, 180)
SetupFrame.Position = UDim2.new(0.5, -170, 0.5, -90)
SetupFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SetupFrame.BorderSizePixel = 0
SetupFrame.Parent = ScreenGui

local SetupCorner = Instance.new("UICorner")
SetupCorner.CornerRadius = UDim.new(0, 10)
SetupCorner.Parent = SetupFrame

local SetupStroke = Instance.new("UIStroke")
SetupStroke.Thickness = 1.5
SetupStroke.Color = Color3.fromRGB(255, 0, 0)
SetupStroke.Parent = SetupFrame

applyDarkRedGradient(SetupFrame)

local QuestionText = Instance.new("TextLabel")
QuestionText.Size = UDim2.new(1, 0, 0, 60)
QuestionText.Position = UDim2.new(0, 0, 0, 15)
QuestionText.BackgroundTransparency = 1
QuestionText.Text = "You play on your phone or on your PC?"
QuestionText.TextColor3 = Color3.fromRGB(255, 255, 255)
QuestionText.Font = Enum.Font.GothamBold
QuestionText.TextSize = 15
QuestionText.TextWrapped = true
QuestionText.Parent = SetupFrame

local BtnPC = Instance.new("TextButton")
BtnPC.Size = UDim2.new(0, 130, 0, 45)
BtnPC.Position = UDim2.new(0, 25, 0, 100)
BtnPC.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
BtnPC.Text = "ðŸ–¥ï¸ PC"
BtnPC.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnPC.Font = Enum.Font.GothamBold
BtnPC.TextSize = 14
BtnPC.Parent = SetupFrame

local BtnPCCorner = Instance.new("UICorner")
BtnPCCorner.CornerRadius = UDim.new(0, 8)
BtnPCCorner.Parent = BtnPC

local BtnPhone = Instance.new("TextButton")
BtnPhone.Size = UDim2.new(0, 130, 0, 45)
BtnPhone.Position = UDim2.new(1, -155, 0, 100)
BtnPhone.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
BtnPhone.Text = "ðŸ“± PHONE"
BtnPhone.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnPhone.Font = Enum.Font.GothamBold
BtnPhone.TextSize = 14
BtnPhone.Parent = SetupFrame

local BtnPhoneCorner = Instance.new("UICorner")
BtnPhoneCorner.CornerRadius = UDim.new(0, 8)
BtnPhoneCorner.Parent = BtnPhone

-- ========================================== --
--          MAIN HUB UI (APOCALYPSE DESIGN)   --
-- ========================================== --

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 460, 0, 520)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(255, 0, 0)
MainStroke.Parent = MainFrame

applyDarkRedGradient(MainFrame)

-- Title Premium (Fixed Character Error)
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "VIPER HUB -- V3 APOCALYPSE" -- Fixed Text
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

-- TAB BAR
local TabBar = Instance.new("ScrollingFrame")
TabBar.Size = UDim2.new(1, -20, 0, 38)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundTransparency = 1
TabBar.ScrollBarThickness = 2
TabBar.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
TabBar.CanvasSize = UDim2.new(1.3, 0, 0, 0) -- Scrollable Tabs
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.Parent = TabBar

--- ========================================== ---
---          CORE SYSTEM CONFIGURATION V3      ---
--- ========================================== ---

local espEnabled = {Box = false, Line = false, Skeleton = false, Health = false, NameDistance = false, Chams = false}
local combat = {Aimbot = false, SilentAim = false, TriggerBot = false, FOVCircle = false, FOVRadius = 100, HitboxSize = 2}
local movement = {Fly = false, FlySpeed = 50, SpinBot = false, AntiVoid = false, Speed = 16}
local misc = {AntiAFK = false, FullBright = false, Fling = false, Invisible = false}

-- 1. FOV Circle Drawing Safe Loader
local fovCircle = nil
if isDrawingSupported then
    pcall(function()
        fovCircle = Drawing.new("Circle")
        fovCircle.Color = Color3.fromRGB(255, 0, 0)
        fovCircle.Thickness = 1
        fovCircle.Filled = false
        fovCircle.Transparency = 1
    end)
end

RunService.RenderStepped:Connect(function()
    if isDrawingSupported and fovCircle then
        if combat.FOVCircle then
            fovCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
            fovCircle.Radius = combat.FOVRadius
            fovCircle.Visible = true
        else
            fovCircle.Visible = false
        end
    end
end)

-- 2. Aimbot Logic
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = combat.FOVCircle and combat.FOVRadius or math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
            local pos, onScreen = Camera:WorldToViewportPoint(v.Character.Head.Position)
            if onScreen then
                local mouseLocation = UserInputService:GetMouseLocation()
                local mag = (Vector2.new(mouseLocation.X, mouseLocation.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if mag < shortestDistance then
                    closestPlayer = v
                    shortestDistance = mag
                end
            end
        end
    end
    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    if combat.Aimbot then
        local target = getClosestPlayer()
        if target and target.Character and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
        end
    end
end)

-- 3. Hitbox Expander Logic
RunService.RenderStepped:Connect(function()
    if combat.HitboxSize > 2 then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    local hrp = v.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(combat.HitboxSize, combat.HitboxSize, combat.HitboxSize)
                    hrp.Transparency = 0.6
                    hrp.BrickColor = BrickColor.new("Bright red")
                    hrp.CanCollide = false
                end)
            end
        end
    end
end)

-- 4. Trigger Bot Logic
local mouse = player:GetMouse()
RunService.RenderStepped:Connect(function()
    if combat.TriggerBot and mouse.Target then
        local targetChar = mouse.Target.Parent
        if targetChar:FindFirstChildOfClass("Humanoid") and Players:GetPlayerFromCharacter(targetChar) ~= player then
            pcall(function() mouse1click() end)
        end
    end
end)

-- 5. FullBright Logic
local origBrightness = Lighting.Brightness
local origClockTime = Lighting.ClockTime
RunService.RenderStepped:Connect(function()
    if misc.FullBright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 786543
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = origBrightness
        Lighting.ClockTime = origClockTime
    end
end)

-- 6. Anti-Void Logic
local antiVoidPart = Instance.new("Part")
antiVoidPart.Size = Vector3.new(2048, 1, 2048)
antiVoidPart.Transparency = 1
antiVoidPart.Anchored = true
antiVoidPart.CanCollide = true
RunService.RenderStepped:Connect(function()
    if movement.AntiVoid then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            antiVoidPart.Position = Vector3.new(player.Character.HumanoidRootPart.Position.X, player.Character.HumanoidRootPart.Position.Y - 5, player.Character.HumanoidRootPart.Position.Z)
            antiVoidPart.Parent = workspace
        end
    else
        antiVoidPart.Parent = nil
    end
end)

-- 7. Fling Mode Logic (V3 BUG FIXED: No more Self-Fling)
RunService.RenderStepped:Connect(function()
    if misc.Fling and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        -- Improved fling logic, targets other players collision
        local closestEnemy = nil
        local dist = math.huge
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local m = (hrp.Position - v.Character.HumanoidRootPart.Position).Magnitude
                if m < 15 and m < dist then -- Fling only when close
                    closestEnemy = v
                    dist = m
                end
            end
        end
        
        if closestEnemy then
            hrp.Velocity = Vector3.new(99999, 99999, 99999) -- Extreme fling velocity to enemy
            hrp.RotVelocity = Vector3.new(0, 99999, 0)
        else
            hrp.Velocity = Vector3.new(0,0,0) -- Stabilize when no enemy near
            hrp.RotVelocity = Vector3.new(0,0,0)
        end
    end
end)

-- Spin Bot Logic
RunService.RenderStepped:Connect(function()
    if movement.SpinBot and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(45), 0)
    end
end)

-- Invisible Logic (V3 NEW)
local origTransparencies = {}
local function setInvisible(state)
    if player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                if state then
                    origTransparencies[part] = part.Transparency
                    part.Transparency = 1
                else
                    part.Transparency = origTransparencies[part] or 0
                end
            end
        end
    end
end

-- Anti-AFK Logic
player.Idled:Connect(function()
    if misc.AntiAFK then
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

--- ========================================== ---
---              ESP & DRAWING API (V3 Skeleton Fix) ---
--- ========================================== ---

local skeletonJoints = {
    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"},
    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"},
    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}
}

local function applyFullESP(v)
    if v == player or not isDrawingSupported then return end

    local box, line, nameDist, healthBg, healthBar
    local skelLines = {}
    
    pcall(function()
        box = Drawing.new("Square") box.Color = Color3.fromRGB(255,0,0) box.Thickness = 1 box.Filled = false
        line = Drawing.new("Line") line.Color = Color3.fromRGB(255,0,0) line.Thickness = 1
        nameDist = Drawing.new("Text") nameDist.Color = Color3.fromRGB(255,255,255) nameDist.Size = 13 nameDist.Center = true nameDist.Outline = true
        healthBg = Drawing.new("Square") healthBg.Color = Color3.fromRGB(40,0,0) healthBg.Filled = true
        healthBar = Drawing.new("Square") healthBar.Color = Color3.fromRGB(0,255,0) healthBar.Filled = true
        for i = 1, #skeletonJoints do
            skelLines[i] = Drawing.new("Line")
            skelLines[i].Color = Color3.fromRGB(255,255,255)
            skelLines[i].Thickness = 1
        end
    end)

    local renderConn
    renderConn = RunService.RenderStepped:Connect(function()
        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
            local char = v.Character
            local hrp = char.HumanoidRootPart
            local hum = char.Humanoid
            
            local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            local dist = (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) and math.floor((player.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) or 0
            
            -- Chams logic
            if espEnabled.Chams then
                pcall(function()
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Color = Color3.fromHSV(tick() % 3 / 3, 1, 1)
                        end
                    end
                end)
            end

            if onScreen and isDrawingSupported then
                -- 1. BOX & HEALTH
                if espEnabled.Box or espEnabled.Health then
                    local headPos = Camera:WorldToViewportPoint(char.Head.Position + Vector3.new(0, 0.5, 0))
                    local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                    local boxHeight = math.abs(headPos.Y - legPos.Y)
                    local boxWidth = boxHeight / 1.8
                    local boxPos = Vector2.new(hrpPos.X - boxWidth / 2, hrpPos.Y - boxHeight / 2)
                    
                    if espEnabled.Box then
                        box.Size = Vector2.new(boxWidth, boxHeight)
                        box.Position = boxPos
                        box.Visible = true
                    else box.Visible = false end

                    if espEnabled.Health then
                        healthBg.Size = Vector2.new(3, boxHeight)
                        healthBg.Position = Vector2.new(boxPos.X - 5, boxPos.Y)
                        healthBg.Visible = true
                        local healthFactor = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                        healthBar.Size = Vector2.new(3, boxHeight * healthFactor)
                        healthBar.Position = Vector2.new(boxPos.X - 5, boxPos.Y + (boxHeight * (1 - healthFactor)))
                        healthBar.Visible = true
                    else healthBg.Visible = false healthBar.Visible = false end
                else
                    box.Visible = false healthBg.Visible = false healthBar.Visible = false
                end

                -- 2. TRACERS
                if espEnabled.Line then
                    line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    line.To = Vector2.new(hrpPos.X, hrpPos.Y)
                    line.Visible = true
                else line.Visible = false end

                -- 3. NAME & DISTANCE
                if espEnabled.NameDistance then
                    nameDist.Position = Vector2.new(hrpPos.X, hrpPos.Y - 25)
                    nameDist.Text = v.Name .. " [" .. dist .. "m]"
                    nameDist.Visible = true
                else nameDist.Visible = false end

                -- 4. SKELETON V3 FIX
                if espEnabled.Skeleton then
                    for i, joint in pairs(skeletonJoints) do
                        local part1 = char:FindFirstChild(joint[1])
                        local part2 = char:FindFirstChild(joint[2])
                        if part1 and part2 then
                            local p1, os1 = Camera:WorldToViewportPoint(part1.Position)
                            local p2, os2 = Camera:WorldToViewportPoint(part2.Position)
                            if os1 and os2 then
                                skelLines[i].From = Vector2.new(p1.X, p1.Y)
                                skelLines[i].To = Vector2.new(p2.X, p2.Y)
                                skelLines[i].Visible = true
                            else skelLines[i].Visible = false end
                        else skelLines[i].Visible = false end
                    end
                else
                    for _, sLine in pairs(skelLines) do sLine.Visible = false end
                end
            else
                box.Visible = false line.Visible = false nameDist.Visible = false healthBg.Visible = false healthBar.Visible = false
                for _, sLine in pairs(skelLines) do sLine.Visible = false end
            end
        else
            box.Visible = false line.Visible = false nameDist.Visible = false healthBg.Visible = false healthBar.Visible = false
            for _, sLine in pairs(skelLines) do sLine.Visible = false end
            if not v or not v:Parent() then
                pcall(function()
                    box:Remove() line:Remove() nameDist:Remove() healthBg:Remove() healthBar:Remove()
                    for _, sLine in pairs(skelLines) do sLine:Remove() end
                end)
                renderConn:Disconnect()
            end
        end
    end)
end

for _, v in pairs(Players:GetPlayers()) do applyFullESP(v) end
Players.PlayerAdded:Connect(applyFullESP)

--- ========================================== ---
---                 TAB CREATOR                ---
--- ========================================== ---

local tabs = {}
local pages = {}

local function createTab(tabName, isDefault)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0, 85, 1, 0) -- Fixed Width Tabs
    TabButton.BackgroundColor3 = isDefault and Color3.fromRGB(35, 0, 0) or Color3.fromRGB(20, 20, 20)
    TabButton.Text = tabName
    TabButton.TextColor3 = isDefault and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 11
    TabButton.Parent = TabBar

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = TabButton

    local TabStroke = Instance.new("UIStroke")
    TabStroke.Thickness = 1
    TabStroke.Color = isDefault and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(40, 40, 40)
    TabStroke.Parent = TabButton

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, -20, 1, -110)
    Page.Position = UDim2.new(0, 10, 0, 95)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
    Page.Visible = isDefault
    Page.Parent = MainFrame

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 6)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Parent = Page

    TabButton.MouseButton1Click:Connect(function()
        for _, btn in pairs(tabs) do
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            btn.TextColor3 = Color3.fromRGB(160, 160, 160)
            btn:FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(40, 40, 40)
        end
        for _, pg in pairs(pages) do pg.Visible = false end

        TabButton.BackgroundColor3 = Color3.fromRGB(45, 0, 0)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabStroke.Color = Color3.fromRGB(255, 0, 0)
        Page.Visible = true
    end)

    tabs[tabName] = TabButton
    pages[tabName] = Page

    return Page
end

local function addToggle(parentPage, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    btn.Text = "  " .. text
    btn.TextColor3 = Color3.fromRGB(210, 210, 210)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = parentPage

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(40, 40, 40)
    stroke.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        stroke.Color = active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(40, 40, 40)
        btn.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(210, 210, 210)
        callback(active)
    end)
end

local function addButton(parentPage, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = parentPage

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(255, 0, 0)
    stroke.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

-- ========================================== --
--          MAIN INTERFACE SYSTEM             --
-- ========================================== --

local function LoadHub(isMobile)
    SetupFrame:Destroy()
    MainFrame.Visible = true
    
    if isMobile then
        local MobileToggle = Instance.new("TextButton")
        MobileToggle.Size = UDim2.new(0, 48, 0, 48)
        MobileToggle.Position = UDim2.new(0, 20, 0.4, -24)
        MobileToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        MobileToggle.Text = "V3"
        MobileToggle.TextColor3 = Color3.fromRGB(255, 0, 0)
        MobileToggle.Font = Enum.Font.GothamBold
        MobileToggle.TextSize = 20
        MobileToggle.Active = true
        MobileToggle.Draggable = true
        MobileToggle.Parent = ScreenGui
        
        local MTCache = Instance.new("UICorner")
        MTCache.CornerRadius = UDim.new(1, 0)
        MTCache.Parent = MobileToggle

        local MTStroke = Instance.new("UIStroke")
        MTStroke.Thickness = 1.5
        MTStroke.Color = Color3.fromRGB(255, 0, 0)
        MTStroke.Parent = MobileToggle
        
        MobileToggle.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)
    end
end

BtnPC.MouseButton1Click:Connect(function() LoadHub(false) end)
BtnPhone.MouseButton1Click:Connect(function() LoadHub(true) end)

--- ========================================== ---
---               TABS CREATION V3             ---
--- ========================================== ---

local CombatPage = createTab("Combat", true)
local ESPPage = createTab("ESP", false)
local MovePage = createTab("Move", false)
local OPPage = createTab("OP Mods", false) -- NEW TAB
local MiscPage = createTab("Misc", false)
local CreditPage = createTab("Credits", false)

-- TAB 1: COMBAT
addToggle(CombatPage, "Camera Aimbot (RMB)", function(s) combat.Aimbot = s end)
addToggle(CombatPage, "Silent Aim (Mouse Hit)", function(s) combat.SilentAim = s end)
addToggle(CombatPage, "Draw FOV Circle", function(s) combat.FOVCircle = s end)
addToggle(CombatPage, "Hitbox Expander (Size 10)", function(s) combat.HitboxSize = s and 10 or 2 end)

-- TAB 2: ESP (Skeleton Fixed)
addToggle(ESPPage, "Player Box", function(s) espEnabled.Box = s end)
addToggle(ESPPage, "Line Tracers", function(s) espEnabled.Line = s end)
addToggle(ESPPage, "Skeleton ESP (Fix V3)", function(s) espEnabled.Skeleton = s end)
addToggle(ESPPage, "Health Bar", function(s) espEnabled.Health = s end)
addToggle(ESPPage, "Name & Distance", function(s) espEnabled.NameDistance = s end)

-- TAB 3: MOVE
addToggle(MovePage, "Speed Hack (65)", function(s)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = s and 65 or 16
    end
end)
addToggle(MovePage, "Jump Power (120)", function(s)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = s and 120 or 50
    end
end)
addToggle(MovePage, "Infinite Jump", function(s)
    UserInputService.JumpRequest:Connect(function()
        if s and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)
addToggle(MovePage, "Anti-Void Floor", function(s) movement.AntiVoid = s end)

-- TAB 4: OP MODS (Tsunami Fitur Baru!)
addButton(OPPage, "Nuke Server (Crash Server)", function()
    for i = 1, 1000 do
        task.spawn(function()
            local p = Instance.new("Part", workspace)
            p.Size = Vector3.new(100,100,100)
            p.Velocity = Vector3.new(999999, 999999, 999999)
        end)
    end
end)
addButton(OPPage, "Kill All Players (OP)", function()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") then
            pcall(function()
                v.Character.Humanoid.Health = 0
            end)
        end
    end
end)
addToggle(OPPage, "Invisible Mode", function(s) setInvisible(s) end)
addToggle(OPPage, "Teleport All Cars To You", function(s)
    if s then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("VehicleSeat") or v.Name == "DriveSeat" then
                pcall(function()
                    v.Parent.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)
                end)
            end
        end
    end
end)

-- TAB 5: MISC
addToggle(MiscPage, "Always Day (FullBright)", function(s) misc.FullBright = s end)
addToggle(MiscPage, "Fling Mode (Fix V3: Attack)", function(s) misc.Fling = s end)
addToggle(MiscPage, "Ctrl + Click TP", function(s) clickTP = s end)
addToggle(MiscPage, "Spin Bot", function(s) movement.SpinBot = s end)

-- TAB 6: CREDITS (Improved Look)
local function addCredit(role, name, status)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 52)
    f.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    f.Parent = CreditPage
    local fs = Instance.new("UIStroke") fs.Thickness = 1.5 fs.Color = Color3.fromRGB(255, 0, 0) fs.Parent = f
    local fc = Instance.new("UICorner") fc.CornerRadius = UDim.new(0, 7) fc.Parent = f

    local rLabel = Instance.new("TextLabel") rLabel.Size = UDim2.new(1, -15, 0, 24) rLabel.Position = UDim2.new(0, 10, 0, 4) rLabel.BackgroundTransparency = 1 rLabel.Text = role rLabel.TextColor3 = Color3.fromRGB(255, 0, 0) rLabel.Font = Enum.Font.GothamBold rLabel.TextSize = 13 rLabel.TextXAlignment = Enum.TextXAlignment.Left rLabel.Parent = f
    local nLabel = Instance.new("TextLabel") nLabel.Size = UDim2.new(1, -15, 0, 20) nLabel.Position = UDim2.new(0, 10, 0, 26) nLabel.BackgroundTransparency = 1 nLabel.Text = name .. " - " .. status nLabel.TextColor3 = Color3.fromRGB(255, 255, 255) nLabel.Font = Enum.Font.GothamMedium nLabel.TextSize = 11 nLabel.TextXAlignment = Enum.TextXAlignment.Left nLabel.Parent = f
end
addCredit("OWNER & CHIEF DEV", "Viper", "Fully Active")
addCredit("AI LOGIC ENGINE", "Gemini Pro API", "God System")
addCredit("SERVER INFILTRATION", "Syndicate V3 Encrypted", "Untraceable")

-- CLOSE BUTTON
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 32, 0, 32)
Close.Position = UDim2.new(1, -38, 0, 6)
Close.BackgroundTransparency = 1
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 0, 0)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 15
Close.Parent = MainFrame
Close.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
