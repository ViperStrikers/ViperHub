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

-- Setup Frame 
local SetupFrame = Instance.new("Frame")
SetupFrame.Name = "SetupFrame"
SetupFrame.Size = UDim2.new(0, 400, 0, 250)
SetupFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
SetupFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SetupFrame.Parent = ScreenGui
Instance.new("UICorner", SetupFrame).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", SetupFrame)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255, 0, 0)
applyDarkRedGradient(SetupFrame)

-- Question & Buttons
local QuestionText = Instance.new("TextLabel")
QuestionText.Size = UDim2.new(1, 0, 0, 35)
QuestionText.Position = UDim2.new(0, 0, 0, 30)
QuestionText.BackgroundTransparency = 1
QuestionText.Text = "Which device are you using?"
QuestionText.TextColor3 = Color3.fromRGB(255, 255, 255)
QuestionText.Font = Enum.Font.GothamBold
QuestionText.TextSize = 18
QuestionText.Parent = SetupFrame

local randomTexts = {"This is not a virus btw :D", "Hello! Welcome back.", "Viper was here.", "Stay lethal."}
local SubText = Instance.new("TextLabel")
SubText.Size = UDim2.new(1, 0, 0, 20)
SubText.Position = UDim2.new(0, 0, 0, 70)
SubText.BackgroundTransparency = 1
SubText.Text = randomTexts[math.random(1, #randomTexts)]
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

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 460, 0, 480)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", MainFrame)
mainStroke.Thickness = 2
mainStroke.Color = Color3.fromRGB(255, 0, 0)
applyDarkRedGradient(MainFrame)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "VIPER HUB V4 -- IMPROVED"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.Parent = MainFrame

-- Variables
local espEnabled = {Box = false, Line = false, Health = false, NameDistance = false}
local combat = {Aimbot = false, SilentAim = false, FOVCircle = false, FOVRadius = 120, HitboxSize = 2}
local movement = {SpinBot = false, AntiVoid = false}
local misc = {FullBright = false, Fling = false}

local drawings = {}
local fovCircle = nil
if isDrawingSupported then
    pcall(function()
        fovCircle = Drawing.new("Circle")
        fovCircle.Color = Color3.fromRGB(255, 0, 0)
        fovCircle.Thickness = 2
        fovCircle.Filled = false
        fovCircle.Transparency = 0.8
    end)
end

-- Silent Aim
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if combat.SilentAim and getnamecallmethod() == "FindPartOnRayWithIgnoreList" then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local origin = args[1].Origin
            args[1] = Ray.new(origin, (target.Character.Head.Position - origin).Unit * 1000)
        end
    end
    return oldNamecall(self, unpack(args))
end)
setreadonly(mt, true)

local function getClosestPlayer()
    local closest, dist = nil, math.huge
    local mousePos = UserInputService:GetMouseLocation()
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
            local pos, onScreen = Camera:WorldToViewportPoint(v.Character.Head.Position)
            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                if mag < dist and mag < (combat.FOVCircle and combat.FOVRadius or 9999) then
                    closest = v
                    dist = mag
                end
            end
        end
    end
    return closest
end
local function updateESP()
    for _, d in ipairs(drawings) do d.Visible = false end
    for _, v in ipairs(Players:GetPlayers()) do
        if v == player or not v.Character then continue end
        local root = v.Character:FindFirstChild("HumanoidRootPart")
        local head = v.Character:FindFirstChild("Head")
        if not (root and head) then continue end

        local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
        if not onScreen then continue end

        if espEnabled.Line and fovCircle then
            
        end
    end
end

RunService.RenderStepped:Connect(function()
    if fovCircle then
        fovCircle.Visible = combat.FOVCircle
        if combat.FOVCircle then
            fovCircle.Position = UserInputService:GetMouseLocation()
            fovCircle.Radius = combat.FOVRadius
        end
    end

    if combat.Aimbot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = getClosestPlayer()
        if target and target.Character and target.Character.Head then
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Character.Head.Position)
        end
    end

    if movement.SpinBot and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(20), 0)
    end

    updateESP()
end)


local hitboxConn
local function updateHitbox()
    if hitboxConn then hitboxConn:Disconnect() end
    if combat.HitboxSize <= 2 then return end
    hitboxConn = RunService.Heartbeat:Connect(function()
        for _, v in ipairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                hrp.Size = Vector3.new(combat.HitboxSize, combat.HitboxSize, combat.HitboxSize)
                hrp.Transparency = 0.7
                hrp.BrickColor = BrickColor.new("Bright red")
                hrp.CanCollide = false
            end
        end
    end)
end


local tabs = {}
local pages = {}

local function createTab(tabName, isDefault)
    
end

local function addToggle(parentPage, text, callback)
    
end

-- Load Hub
local function LoadHub(isMobile)
    SetupFrame:Destroy()
    MainFrame.Visible = true

    local CombatPage = createTab("Combat", true)
    local ESPPage = createTab("Visuals", false)
    local MovePage = createTab("Movement", false)
    local MiscPage = createTab("Others", false)

    addToggle(CombatPage, "Aimbot (Hold RMB)", function(s) combat.Aimbot = s end)
    addToggle(CombatPage, "Silent Aim", function(s) combat.SilentAim = s end)
    addToggle(CombatPage, "FOV Circle", function(s) combat.FOVCircle = s end)
    addToggle(CombatPage, "Hitbox Expander", function(s) 
        combat.HitboxSize = s and 10 or 2 
        updateHitbox()
    end)

    addToggle(ESPPage, "Box ESP", function(s) espEnabled.Box = s end)
    addToggle(ESPPage, "Tracers", function(s) espEnabled.Line = s end)
    addToggle(ESPPage, "Name + Distance", function(s) espEnabled.NameDistance = s end)

    addToggle(MovePage, "SpinBot", function(s) movement.SpinBot = s end)
    addToggle(MovePage, "Anti-Void", function(s) movement.AntiVoid = s end)

    addToggle(MiscPage, "Full Bright", function(s) misc.FullBright = s end)
    addToggle(MiscPage, "Fling Mode", function(s) misc.Fling = s end)
end

BtnPC.MouseButton1Click:Connect(function() LoadHub(false) end)
BtnPhone.MouseButton1Click:Connect(function() LoadHub(true) end)

print("✅ ViperHub Improved Loaded by Viper")
