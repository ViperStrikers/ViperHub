-- [[ VIPER SYNDICATE - ULTIMATE HUB BUILD 2.2 ]] --
-- Lead Developer: Viper
-- Status: ALL FIXED & STABLE
-- Discord: https://discord.gg/QJJkHmsuX

local Viper = {
    Aimbot = {
        Enabled = false,
        Target = "Head",
        Smoothness = 0.1, -- Makin kecil makin nempel
        FOVSize = 100,
        FOVVisible = true,
        WallCheck = true
    },
    ESP = {Enabled = false},
    UI = {
        MainColor = Color3.fromRGB(12, 12, 12),
        Accent = Color3.fromRGB(255, 0, 0), -- Merah
        Locked = Color3.fromRGB(255, 255, 255) -- Putih pas Lock
    }
}

-- [ SERVICES ] --
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- [[ 1. SECURITY (ANTI-KICK) ]] --
local function SecureBoot()
    pcall(function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldNamecall = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            if getnamecallmethod() == "Kick" and self == LocalPlayer then return nil end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end)
end
SecureBoot()

-- [[ 2. DRAWING FOV CIRCLE ]] --
local FOVCircle = nil
pcall(function()
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness = 1.2
    FOVCircle.NumSides = 100
    FOVCircle.Filled = false
    FOVCircle.Transparency = 1
    FOVCircle.Color = Viper.UI.Accent
    FOVCircle.Visible = false
end)

-- [[ 3. AIMBOT LOGIC ]] --
local function IsVisible(part)
    if not Viper.Aimbot.WallCheck then return true end
    local char = LocalPlayer.Character
    if not char then return false end
    local hit = Camera:WorldToViewportPoint(part.Position)
    local ray = Camera:ViewportPointToRay(hit.X, hit.Y)
    local raycastResult = workspace:FindPartOnRayWithIgnoreList(Ray.new(ray.Origin, (part.Position - ray.Origin).Unit * 5000), {char, part.Parent})
    return raycastResult == nil or raycastResult:IsDescendantOf(part.Parent)
end

local function GetClosestTarget()
    local target = nil
    local dist = Viper.Aimbot.FOVSize
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild(Viper.Aimbot.Target) then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local part = p.Character[Viper.Aimbot.Target]
                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen and IsVisible(part) then
                    local mouseDist = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                    if mouseDist < dist then
                        dist = mouseDist
                        target = part
                    end
                end
            end
        end
    end
    return target
end

-- [[ 4. UI CONSTRUCTION (BUG-FREE SYSTEM) ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ViperHub_v22"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Viper.UI.MainColor
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Active = true MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Sidebar.Size = UDim2.new(0, 140, 1, 0)
Instance.new("UICorner", Sidebar)

local Title = Instance.new("TextLabel")
Title.Parent = Sidebar
Title.Text = "( Viper Hub )"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20 Title.Font = Enum.Font.GothamBold
Title.Size = UDim2.new(1, 0, 0, 60)

local PageHolder = Instance.new("Frame")
PageHolder.Parent = MainFrame
PageHolder.BackgroundTransparency = 1
PageHolder.Position = UDim2.new(0, 150, 0, 10)
PageHolder.Size = UDim2.new(1, -160, 1, -20)

local TabHolder = Instance.new("Frame")
TabHolder.Parent = Sidebar
TabHolder.Position = UDim2.new(0, 10, 0, 60)
TabHolder.Size = UDim2.new(1, -20, 1, -70)
TabHolder.BackgroundTransparency = 1
Instance.new("UIListLayout", TabHolder).Padding = UDim.new(0, 6)

local Tabs = {} local Pages = {}
local function CreateTab(name)
    local btn = Instance.new("TextButton")
    btn.Parent = TabHolder
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local pg = Instance.new("ScrollingFrame")
    pg.Parent = PageHolder
    pg.Size = UDim2.new(1, 0, 1, 0)
    pg.Visible = false pg.BackgroundTransparency = 1
    pg.ScrollBarThickness = 1
    Instance.new("UIListLayout", pg).Padding = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, t in pairs(Tabs) do t.BackgroundColor3 = Color3.fromRGB(25, 25, 25) end
        pg.Visible = true btn.BackgroundColor3 = Viper.UI.Accent
    end)
    Tabs[name] = btn Pages[name] = pg
    return pg
end

local function AddButton(parent, text, cb)
    local b = Instance.new("TextButton")
    b.Parent = parent
    b.Size = UDim2.new(1, -10, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.Text = text b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- [[ 5. FEATURES ]] --
local Home = CreateTab("General")
AddButton(Home, "Join Discord Syndicate", function() setclipboard("https://discord.gg/QJJkHmsuX") end)

local Combat = CreateTab("Combat")
AddButton(Combat, "Master Aimbot: ON/OFF", function() Viper.Aimbot.Enabled = not Viper.Aimbot.Enabled end)
AddButton(Combat, "Aimbot FOV: ON/OFF", function() Viper.Aimbot.FOVVisible = not Viper.Aimbot.FOVVisible end)
AddButton(Combat, "FOV +20", function() Viper.Aimbot.FOVSize = Viper.Aimbot.FOVSize + 20 end)
AddButton(Combat, "FOV -20", function() Viper.Aimbot.FOVSize = math.max(20, Viper.Aimbot.FOVSize - 20) end)
AddButton(Combat, "Wallcheck: ON/OFF", function() Viper.Aimbot.WallCheck = not Viper.Aimbot.WallCheck end)

local Visuals = CreateTab("Visuals")
AddButton(Visuals, "ESP Chams: ON/OFF", function() Viper.ESP.Enabled = not Viper.ESP.Enabled end)

-- [[ 6. LOOPS ]] --
RunService.RenderStepped:Connect(function()
    -- FOV Circle logic
    if FOVCircle then
        FOVCircle.Position = UserInputService:GetMouseLocation()
        FOVCircle.Radius = Viper.Aimbot.FOVSize
        FOVCircle.Visible = Viper.Aimbot.FOVVisible and Viper.Aimbot.Enabled
    end
    
    -- Aimbot Execution
    if Viper.Aimbot.Enabled then
        local target = GetClosestTarget()
        if target then
            if FOVCircle then FOVCircle.Color = Viper.UI.Locked end
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), Viper.Aimbot.Smoothness)
        else
            if FOVCircle then FOVCircle.Color = Viper.UI.Accent end
        end
    end

    -- ESP Execution
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local highlight = p.Character:FindFirstChild("ViperChams")
            if Viper.ESP.Enabled then
                if not highlight then
                    highlight = Instance.new("Highlight", p.Character)
                    highlight.Name = "ViperChams"
                    highlight.FillColor = Viper.UI.Accent
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                end
                highlight.Enabled = true
            elseif highlight then
                highlight.Enabled = false
            end
        end
    end
end)

Pages["General"].Visible = true
Tabs["General"].BackgroundColor3 = Viper.UI.Accent
print("Viper Hub Build 2.2 - Final Fix Loaded!")
