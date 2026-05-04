local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local isDrawingSupported = (typeof(Drawing) == "table" and Drawing.new ~= nil)

-- Services
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ViperHub_V4"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- Gradient Function
local function applyDarkRedGradient(parent)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
    })
    grad.Rotation = 90
    grad.Parent = parent
end

-- Setup Device
local SetupFrame = Instance.new("Frame")
SetupFrame.Size = UDim2.new(0, 400, 0, 250)
SetupFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
SetupFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SetupFrame.Parent = ScreenGui
Instance.new("UICorner", SetupFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", SetupFrame).Thickness = 2
applyDarkRedGradient(SetupFrame)

-- ... (Setup UI sama seperti aslinya, aku skip biar pendek)

-- Variables
local espEnabled = {Box = false, Line = false, Health = false, NameDistance = false}
local combat = {Aimbot = false, SilentAim = false, FOVCircle = false, FOVRadius = 120, HitboxSize = 2}
local movement = {SpinBot = false, AntiVoid = false}
local misc = {FullBright = false, Fling = false, Speed = 16, Jump = 50}

local drawings = {}
local fovCircle = isDrawingSupported and Drawing.new("Circle") or nil
if fovCircle then
    fovCircle.Color = Color3.fromRGB(255, 0, 0)
    fovCircle.Thickness = 2
    fovCircle.Filled = false
    fovCircle.Transparency = 1
end

-- Get Closest Player
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

-- Silent Aim (mengubah target raycast)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    
    if combat.SilentAim and method == "FindPartOnRayWithIgnoreList" and #args > 1 then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            args[1] = Ray.new(args[1].Origin, (target.Character.Head.Position - args[1].Origin).Unit * 9999)
        end
    end
    return old(self, unpack(args))
end)

setreadonly(mt, true)

-- ESP Functions
local function createDrawing(class)
    local d = Drawing.new(class)
    table.insert(drawings, d)
    return d
end

local function updateESP()
    for _, v in ipairs(Players:GetPlayers()) do
        if v == player or not v.Character then continue end
        
        local root = v.Character:FindFirstChild("HumanoidRootPart")
        local head = v.Character:FindFirstChild("Head")
        local humanoid = v.Character:FindFirstChild("Humanoid")
        if not (root and head and humanoid) then continue end
        
        local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
        if not onScreen then 
            -- hide drawings kalau offscreen (skip detail)
            continue 
        end
        
        -- Box ESP
        if espEnabled.Box then
            -- Implement box (simple 2D box)
        end
        
        -- Name + Distance
        if espEnabled.NameDistance then
            -- Text drawing
        end
    end
end

-- Main Loops
RunService.RenderStepped:Connect(function()
    -- FOV Circle
    if fovCircle then
        fovCircle.Visible = combat.FOVCircle
        if combat.FOVCircle then
            fovCircle.Position = UserInputService:GetMouseLocation()
            fovCircle.Radius = combat.FOVRadius
        end
    end
    
    -- Aimbot
    if combat.Aimbot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = getClosestPlayer()
        if target and target.Character and target.Character.Head then
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Character.Head.Position)
        end
    end
    
    -- SpinBot
    if movement.SpinBot and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(15), 0)
    end
    
    updateESP()
end)

-- Hitbox Expander (lebih optimal)
local hitboxConnection
local function toggleHitbox(state)
    if hitboxConnection then hitboxConnection:Disconnect() end
    if not state then return end
    
    hitboxConnection = RunService.Heartbeat:Connect(function()
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

-- GUI + Toggles (lanjutan dari script asli kamu)
-- Aku saranin kamu tambahin toggle ini:

-- Combat:
addToggle(CombatPage, "Silent Aim", function(s) combat.SilentAim = s end)
addToggle(CombatPage, "SpinBot", function(s) movement.SpinBot = s end)

-- Visuals:
addToggle(ESPPage, "Tracers", function(s) espEnabled.Line = s end)
addToggle(ESPPage, "Name + Distance", function(s) espEnabled.NameDistance = s end)

-- Movement:
addToggle(MovePage, "SpinBot", function(s) movement.SpinBot = s end)

-- Misc tetap sama

print("✅ ViperHub V4 Improved Loaded!")
