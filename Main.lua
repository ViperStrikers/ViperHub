-- [[ VIPER SYNDICATE - IMMORTAL HUB BUILD 2.7 ]] --
-- Lead Developer: Viper (ViperStrikers)
-- Status: ANTI-BUG, ANTI-LAG, ANTI-KICK
-- Discord: https://discord.gg/QJJkHmsuX

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

    -- [[ 1. GOD-LEVEL ANTI-CHEAT BYPASS ]] --
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "BreakJoints" then return nil end
        return old(self, ...)
    end)
    setreadonly(mt, true)

    -- [[ 2. STABLE UI & POV CONSTRUCTION ]] --
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = "ViperHub_Immortal"

    -- GREETING NOTIF (Hello :D)
    local Notif = Instance.new("TextLabel", ScreenGui)
    Notif.Size = UDim2.new(0, 220, 0, 45)
    Notif.Position = UDim2.new(0.5, -110, 0.1, 0)
    Notif.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Notif.TextColor3 = Color3.fromRGB(255, 0, 0)
    Notif.Text = "Hello :D | Viper Hub Active"
    Notif.Font = Enum.Font.GothamBold
    Notif.TextSize = 15
    Instance.new("UICorner", Notif)
    task.delay(4, function() pcall(function() Notif:Destroy() end) end)

    -- POV CIRCLE (MOBILE STABLE)
    local POVFrame = Instance.new("Frame", ScreenGui)
    POVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    POVFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    POVFrame.BackgroundTransparency = 1
    POVFrame.Visible = false
    local POVStroke = Instance.new("UIStroke", POVFrame)
    POVStroke.Color = Color3.fromRGB(255, 0, 0)
    POVStroke.Thickness = 2
    Instance.new("UICorner", POVFrame).CornerRadius = UDim.new(1, 0)

    -- MAIN FRAME
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    MainFrame.Size = UDim2.new(0, 460, 0, 310)
    MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    MainFrame.Active = true MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame)

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

    local TabHolder = Instance.new("ScrollingFrame", Sidebar)
    TabHolder.Position = UDim2.new(0, 5, 0, 60)
    TabHolder.Size = UDim2.new(1, -10, 1, -70)
    TabHolder.BackgroundTransparency = 1
    TabHolder.ScrollBarThickness = 0
    Instance.new("UIListLayout", TabHolder).Padding = UDim.new(0, 5)

    local PageHolder = Instance.new("Frame", MainFrame)
    PageHolder.Position = UDim2.new(0, 140, 0, 10)
    PageHolder.Size = UDim2.new(1, -150, 1, -20)
    PageHolder.BackgroundTransparency = 1

    local function CreateTab(name)
        local btn = Instance.new("TextButton", TabHolder)
        btn.Size = UDim2.new(1, 0, 0, 35)
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        btn.Text = name btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamSemibold
        Instance.new("UICorner", btn)
        
        local pg = Instance.new("ScrollingFrame", PageHolder)
        pg.Size = UDim2.new(1, 0, 1, 0)
        pg.Visible = false pg.BackgroundTransparency = 1
        pg.ScrollBarThickness = 2
        Instance.new("UIListLayout", pg).Padding = UDim.new(0, 8)
        
        btn.MouseButton1Click:Connect(function()
            for _, p in pairs(PageHolder:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
            pg.Visible = true
        end)
        return pg
    end

    local function AddToggle(parent, text, callback)
        local b = Instance.new("TextButton", parent)
        b.Size = UDim2.new(1, -10, 0, 40)
        b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        b.Text = text .. " [OFF]" b.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", b)
        
        local state = false
        b.MouseButton1Click:Connect(function()
            state = not state
            b.Text = text .. (state and " [ON]" or " [OFF]")
            b.BackgroundColor3 = state and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(30, 30, 30)
            callback(state)
        end)
    end

    -- [[ 3. SETUP PAGES ]] --
    local Combat = CreateTab("Combat")
    AddToggle(Combat, "Master Aimbot", function(v) Viper.Aimbot.Enabled = v end)
    AddToggle(Combat, "Show POV/FOV", function(v) Viper.Aimbot.FOVVisible = v end)

    local Visuals = CreateTab("Visuals")
    AddToggle(Visuals, "ESP Chams", function(v) Viper.ESP.Enabled = v end)

    local PlayerTab = CreateTab("Player")
    AddToggle(PlayerTab, "Super Speed (100)", function(v) LocalPlayer.Character.Humanoid.WalkSpeed = v and 100 or 16 end)
    AddToggle(PlayerTab, "Infinite Jump", function(v) Viper.Player.Jump = v end)
    AddToggle(PlayerTab, "Fly Mode", function(v) Viper.Player.Fly = v end)

    -- [[ 4. CORE LOOP ]] --
    UserInputService.JumpRequest:Connect(function()
        if Viper.Player.Jump then pcall(function() LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end) end
    end)

    RunService.RenderStepped:Connect(function()
        pcall(function()
            local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            POVFrame.Visible = Viper.Aimbot.FOVVisible and Viper.Aimbot.Enabled
            POVFrame.Size = UDim2.new(0, Viper.Aimbot.FOVSize, 0, Viper.Aimbot.FOVSize)
            
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

            if Viper.Player.Fly then LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 2, 0) end

            if Viper.ESP.Enabled then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        local ch = p.Character:FindFirstChild("ViperChams")
                        if not ch then
                            ch = Instance.new("Highlight", p.Character)
                            ch.Name = "ViperChams"
                            ch.FillColor = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end
        end)
    end)

    PageHolder:GetChildren()[1].Visible = true
end)
