local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local isDrawingSupported = (typeof(Drawing) == "table" and Drawing.new ~= nil)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ViperHub_V4"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

local function applyDarkRedGradient(parent)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
    })
    grad.Rotation = 90
    grad.Parent = parent
end

local SetupFrame = Instance.new("Frame")
SetupFrame.Name = "SetupFrame"
SetupFrame.Size = UDim2.new(0, 400, 0, 250)
SetupFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
SetupFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SetupFrame.BorderSizePixel = 0
SetupFrame.Parent = ScreenGui

local SetupCorner = Instance.new("UICorner")
SetupCorner.CornerRadius = UDim.new(0, 10)
SetupCorner.Parent = SetupFrame

local SetupStroke = Instance.new("UIStroke")
SetupStroke.Thickness = 2
SetupStroke.Color = Color3.fromRGB(255, 0, 0)
SetupStroke.Parent = SetupFrame

applyDarkRedGradient(SetupFrame)

local QuestionText = Instance.new("TextLabel")
QuestionText.Size = UDim2.new(1, 0, 0, 35)
QuestionText.Position = UDim2.new(0, 0, 0, 30)
QuestionText.BackgroundTransparency = 1
QuestionText.Text = "Which device are you using?"
QuestionText.TextColor3 = Color3.fromRGB(255, 255, 255)
QuestionText.Font = Enum.Font.GothamBold
QuestionText.TextSize = 18
QuestionText.Parent = SetupFrame

local randomTexts = {
    "This is not a virus btw :D",
    "Hello! Welcome back.",
    "Loading the god power...",
    "Viper was here.",
    "Stay lethal, stay cool.",
    "Don't get banned lol"
}
local chosenText = randomTexts[math.random(1, #randomTexts)]

local SubText = Instance.new("TextLabel")
SubText.Size = UDim2.new(1, 0, 0, 20)
SubText.Position = UDim2.new(0, 0, 0, 70)
SubText.BackgroundTransparency = 1
SubText.Text = chosenText
SubText.TextColor3 = Color3.fromRGB(200, 200, 200)
SubText.Font = Enum.Font.GothamItalic
SubText.TextSize = 14
SubText.Parent = SetupFrame

local BtnPC = Instance.new("TextButton")
BtnPC.Size = UDim2.new(0, 140, 0, 45)
BtnPC.Position = UDim2.new(0, 40, 0, 150)
BtnPC.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BtnPC.Text = "COMPUTER"
BtnPC.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnPC.Font = Enum.Font.GothamBold
BtnPC.TextSize = 14
BtnPC.Parent = SetupFrame

Instance.new("UICorner", BtnPC).CornerRadius = UDim.new(0, 8)

local BtnPhone = Instance.new("TextButton")
BtnPhone.Size = UDim2.new(0, 140, 0, 45)
BtnPhone.Position = UDim2.new(1, -180, 0, 150)
BtnPhone.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BtnPhone.Text = "MOBILE"
BtnPhone.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnPhone.Font = Enum.Font.GothamBold
BtnPhone.TextSize = 14
BtnPhone.Parent = SetupFrame

Instance.new("UICorner", BtnPhone).CornerRadius = UDim.new(0, 8)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 460, 0, 480)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
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

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "VIPER HUB V4 -- APOCALYPSE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.Parent = MainFrame

local TabBar = Instance.new("ScrollingFrame")
TabBar.Size = UDim2.new(1, -20, 0, 40)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundTransparency = 1
TabBar.ScrollBarThickness = 2
TabBar.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
TabBar.CanvasSize = UDim2.new(1.5, 0, 0, 0)
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 6)
TabListLayout.Parent = TabBar

local espEnabled = {Box = false, Line = false, Skeleton = false, Health = false, NameDistance = false}
local combat = {Aimbot = false, SilentAim = false, FOVCircle = false, FOVRadius = 100, HitboxSize = 2}
local movement = {SpinBot = false, AntiVoid = false}
local misc = {FullBright = false, Fling = false}

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
    pcall(function()
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
end)

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = combat.FOVCircle and combat.FOVRadius or math.huge
    pcall(function()
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
    end)
    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    pcall(function()
        if combat.Aimbot then
            local target = getClosestPlayer()
            if target and target.Character and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
            end
        end
    end)
end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                if combat.HitboxSize > 2 then
                    hrp.Size = Vector3.new(combat.HitboxSize, combat.HitboxSize, combat.HitboxSize)
                    hrp.Transparency = 0.6
                    hrp.BrickColor = BrickColor.new("Bright red")
                    hrp.CanCollide = false
                else
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 0
                    hrp.CanCollide = true
                end
            end
        end
    end)
end)

local origBrightness = Lighting.Brightness
local origClockTime = Lighting.ClockTime
RunService.RenderStepped:Connect(function()
    pcall(function()
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
end)

local antiVoidPart = Instance.new("Part")
antiVoidPart.Size = Vector3.new(2048, 1, 2048)
antiVoidPart.Transparency = 1
antiVoidPart.Anchored = true
antiVoidPart.CanCollide = true
RunService.RenderStepped:Connect(function()
    pcall(function()
        if movement.AntiVoid then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                antiVoidPart.Position = Vector3.new(player.Character.HumanoidRootPart.Position.X, player.Character.HumanoidRootPart.Position.Y - 5, player.Character.HumanoidRootPart.Position.Z)
                antiVoidPart.Parent = workspace
            end
        else
            antiVoidPart.Parent = nil
        end
    end)
end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        if misc.Fling and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local closestEnemy = nil
            local dist = math.huge
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local m = (hrp.Position - v.Character.HumanoidRootPart.Position).Magnitude
                    if m < 15 and m < dist then
                        closestEnemy = v
                        dist = m
                    end
                end
            end
            if closestEnemy then
                hrp.Velocity = Vector3.new(99999, 99999, 99999)
                hrp.RotVelocity = Vector3.new(0, 99999, 0)
            else
                hrp.Velocity = Vector3.new(0,0,0)
                hrp.RotVelocity = Vector3.new(0,0,0)
            end
        end
    end)
end)

local tabs = {}
local pages = {}

local function createTab(tabName, isDefault)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0, 95, 1, 0)
    TabButton.BackgroundColor3 = isDefault and Color3.fromRGB(50, 0, 0) or Color3.fromRGB(25, 25, 25)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 11
    TabButton.Parent = TabBar

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = TabButton

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, -20, 1, -110)
    Page.Position = UDim2.new(0, 10, 0, 100)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 2
    Page.Visible = isDefault
    Page.Parent = MainFrame

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 6)
    PageLayout.Parent = Page

    TabButton.MouseButton1Click:Connect(function()
        for _, btn in pairs(tabs) do btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25) end
        for _, pg in pairs(pages) do pg.Visible = false end
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
        Page.Visible = true
    end)

    tabs[tabName] = TabButton
    pages[tabName] = Page
    return Page
end

local function addToggle(parentPage, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = "  " .. text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = parentPage

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
        btn.BackgroundColor3 = active and Color3.fromRGB(40, 0, 0) or Color3.fromRGB(20, 20, 20)
        callback(active)
    end)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
end

local function LoadHub(isMobile)
    SetupFrame:Destroy()
    MainFrame.Visible = true
    
    if isMobile then
        local MobileToggle = Instance.new("TextButton")
        MobileToggle.Size = UDim2.new(0, 50, 0, 50)
        MobileToggle.Position = UDim2.new(0, 15, 0.5, -25)
        MobileToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        MobileToggle.Text = "V4"
        MobileToggle.TextColor3 = Color3.fromRGB(255, 0, 0)
        MobileToggle.Font = Enum.Font.GothamBold
        MobileToggle.TextSize = 20
        MobileToggle.Active = true
        MobileToggle.Draggable = true
        MobileToggle.Parent = ScreenGui
        Instance.new("UICorner", MobileToggle).CornerRadius = UDim.new(1, 0)
        
        MobileToggle.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)
    end
end

BtnPC.MouseButton1Click:Connect(function() LoadHub(false) end)
BtnPhone.MouseButton1Click:Connect(function() LoadHub(true) end)

local CombatPage = createTab("Combat", true)
local ESPPage = createTab("Visuals", false)
local MovePage = createTab("Movement", false)
local MiscPage = createTab("Others", false)

addToggle(CombatPage, "Aimbot (Right Click)", function(s) combat.Aimbot = s end)
addToggle(CombatPage, "FOV Circle", function(s) combat.FOVCircle = s end)
addToggle(CombatPage, "Hitbox Expander", function(s) combat.HitboxSize = s and 10 or 2 end)

addToggle(ESPPage, "Box ESP", function(s) espEnabled.Box = s end)
addToggle(ESPPage, "Health ESP", function(s) espEnabled.Health = s end)

addToggle(MovePage, "Speed Hack (70)", function(s) 
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = s and 70 or 16 
        end
    end)
end)
addToggle(MovePage, "Jump Power (120)", function(s)
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = s and 120 or 50
        end
    end)
end)

addToggle(MiscPage, "Anti-Void", function(s) movement.AntiVoid = s end)
addToggle(MiscPage, "Full Bright", function(s) misc.FullBright = s end)
addToggle(MiscPage, "Fling Mode", function(s) misc.Fling = s end)

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 7)
Close.BackgroundTransparency = 1
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 0, 0)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 16
Close.Parent = MainFrame
Close.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
