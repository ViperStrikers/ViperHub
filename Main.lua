-- [[ VIPER SYNDICATE - MASTER HUB BUILD 3.0 ]] --
-- Final Fix: Smoothness 1-100, Icon V, No-Bug ESP, Anti-Cheat
-- Author: Viper (ViperStrikers) & Gemini AI
-- Status: IMMORTAL & STABLE

pcall(function()
    print("Hello :D")
    
    local Viper = {
        Aimbot = {Enabled = false, Target = "Head", Smoothness = 0.05, FOVSize = 150, FOVVisible = true},
        ESP = {Enabled = false},
        Player = {Speed = 16, Jump = false, Fly = false}
    }

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")

    -- [[ 1. UI SETUP & ICON TOGGLE ]] --
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = "ViperHub_FinalV3"
    ScreenGui.ResetOnSpawn = false

    -- FLOATING ICON [V] (Draggable)
    local ToggleIcon = Instance.new("TextButton", ScreenGui)
    ToggleIcon.Size = UDim2.new(0, 50, 0, 50)
    ToggleIcon.Position = UDim2.new(0, 15, 0.4, 0)
    ToggleIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ToggleIcon.Text = "V"
    ToggleIcon.TextColor3 = Color3.fromRGB(255, 0, 0)
    ToggleIcon.TextSize = 28
    ToggleIcon.Font = Enum.Font.GothamBold
    ToggleIcon.Active = true ToggleIcon.Draggable = true
    Instance.new("UICorner", ToggleIcon).CornerRadius = UDim.new(1, 0)
    local IconStroke = Instance.new("UIStroke", ToggleIcon)
    IconStroke.Color = Color3.fromRGB(255, 0, 0)
    IconStroke.Thickness = 2

    -- MAIN FRAME
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    MainFrame.Size = UDim2.new(0, 450, 0, 310)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -155)
    MainFrame.Visible = true
    Instance.new("UICorner", MainFrame)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(40, 40, 40)

    ToggleIcon.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- SIDEBAR
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    Sidebar.Size = UDim2.new(0, 130, 1, 0)
    Instance.new("UICorner", Sidebar)

    local Title = Instance.new("TextLabel", Sidebar)
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Text = "VIPER HUB"
    Title.TextColor3 = Color3.fromRGB(255, 0, 0)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18

    local PageHolder = Instance.new("Frame", MainFrame)
    PageHolder.Position = UDim2.new(0, 140, 0, 10)
    PageHolder.Size = UDim2.new(1, -150, 1, -20)
    PageHolder.BackgroundTransparency = 1

    local function CreateTab(name, order)
        local btn = Instance.new("TextButton", Sidebar)
        btn.Size = UDim2.new(1, -10, 0, 35)
        btn.Position = UDim2.new(0, 5, 0, 55 + (order * 40))
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.Text = name btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamSemibold
        Instance.new("UICorner", btn)
        
        local pg = Instance.new("ScrollingFrame", PageHolder)
        pg.Size = UDim2.new(1, 0, 1, 0)
        pg.Visible = false pg.BackgroundTransparency = 1
        pg.ScrollBarThickness = 0
        Instance.new("UIListLayout", pg).Padding = UDim.new(0, 8)
        
        btn.MouseButton1Click:Connect(function()
            for _, p in pairs(PageHolder:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
            pg.Visible = true
        end)
        return pg
    end

    local function AddToggle(parent, text, cb)
        local b = Instance.new("TextButton", parent)
        b.Size = UDim2.new(1, -10, 0, 40)
        b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        b.Text = text .. " [OFF]" b.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", b)
        local s = false
        b.MouseButton1Click:Connect(function()
            s = not s
            b.Text = text .. (s and " [ON]" or " [OFF]")
            b.BackgroundColor3 = s and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(25, 25, 25)
            cb(s)
        end)
    end

    local function AddInput(parent, placeholder, cb)
        local box = Instance.new("TextBox", parent)
        box.Size = UDim2.new(1, -10, 0, 40)
        box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        box.PlaceholderText = placeholder
        box.Text = "" box.TextColor3 = Color3.fromRGB(255, 0, 0)
        Instance.new("UICorner", box)
        box.FocusLost:Connect(function()
            cb(box.Text)
        end)
    end

    -- [[ 2. FEATURES SETUP ]] --
    local Combat = CreateTab("Combat", 0)
    AddToggle(Combat, "Master Aimbot", function(v) Viper.Aimbot.Enabled = v end)
    AddToggle(Combat, "Show POV Circle", function(v) Viper.Aimbot.FOVVisible = v end)
    AddInput(Combat, "Smoothness (1-100)", function(t) 
        local n = tonumber(t)
        if n then Viper.Aimbot.Smoothness = (101 - n) / 500 end
    end)

    local Visuals = CreateTab("Visuals", 1)
    AddToggle(Visuals, "ESP Chams", function(v) Viper.ESP.Enabled = v end)

    local PlayerTab = CreateTab("Player", 2)
    AddToggle(PlayerTab, "Speed Hack (100)", function(v) LocalPlayer.Character.Humanoid.WalkSpeed = v and 100 or 16 end)
    AddToggle(PlayerTab, "Fly Mode", function(v) Viper.Player.Fly = v end)

    -- [[ 3. CORE LOGIC (STABLE LOOP) ]] --
    local POVFrame = Instance.new("Frame", ScreenGui)
    POVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    POVFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    POVFrame.BackgroundTransparency = 1
    POVFrame.Visible = false
    local POVStroke = Instance.new("UIStroke", POVFrame)
    POVStroke.Color = Color3.fromRGB(255, 0, 0)
    POVStroke.Thickness = 1.5
    Instance.new("UICorner", POVFrame).CornerRadius = UDim.new(1, 0)

    RunService.RenderStepped:Connect(function()
        pcall(function()
            local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            POVFrame.Visible = Viper.Aimbot.FOVVisible and Viper.Aimbot.Enabled
            POVFrame.Size = UDim2.new(0, Viper.Aimbot.FOVSize, 0, Viper.Aimbot.FOVSize)
            
            -- AIMBOT EXECUTION
            if Viper.Aimbot.Enabled then
                local target = nil
                local maxDist = Viper.Aimbot.FOVSize / 2
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                        local pos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
                        if onScreen then
                            local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                            if dist < maxDist then target = p.Character.Head; maxDist = dist end
                        end
                    end
                end
                if target then
                    POVStroke.Color = Color3.fromRGB(255, 255, 255)
                    Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), Viper.Aimbot.Smoothness)
                else
                    POVStroke.Color = Color3.fromRGB(255, 0, 0)
                end
            end

            -- ESP CHAMS (AUTO-CLEANUP)
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local ch = p.Character:FindFirstChild("ViperChams")
                    if Viper.ESP.Enabled then
                        if not ch then
                            ch = Instance.new("Highlight", p.Character)
                            ch.Name = "ViperChams"
                            ch.FillColor = Color3.fromRGB(255, 0, 0)
                        end
                    elseif ch then
                        ch:Destroy()
                    end
                end
            end
            
            -- FLY EXECUTION
            if Viper.Player.Fly then LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 2, 0) end
        end)
    end)

    -- Sapaan Hello :D
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Viper Hub", Text = "Hello :D", Duration = 3})
    PageHolder:GetChildren()[1].Visible = true
end)
