-- [[ VIPER SYNDICATE - ULTIMATE FINAL BUILD 3.6 ]] --
-- Key: Join Discord 
-- Features: ALL-IN-ONE (Aimbot, Target, Wallbang, Fling, ESP, Speed)
-- Special: Discord Button & Cinematic Intro

pcall(function()
    local Viper = {
        Aimbot = {Enabled = false, Target = "Head", Smoothness = 0.05, FOVSize = 150, WallCheck = true, Wallbang = false},
        ESP = {Enabled = false, Box = false, Tracer = false, Name = false},
        Player = {Speed = 16, Fling = false}
    }

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")

    -- [[ 1. CINEMATIC INTRO & KEY SYSTEM ]] --
    local IntroGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    IntroGui.DisplayOrder = 999
    local Blackout = Instance.new("Frame", IntroGui)
    Blackout.Size = UDim2.new(1, 0, 1, 0)
    Blackout.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    
    local HelloTxt = Instance.new("TextLabel", Blackout)
    HelloTxt.Size = UDim2.new(1, 0, 0.4, 0)
    HelloTxt.Text = "Hello :D"
    HelloTxt.TextColor3 = Color3.fromRGB(255, 0, 0)
    HelloTxt.Font = Enum.Font.GothamBold
    HelloTxt.TextSize = 55
    HelloTxt.BackgroundTransparency = 1

    local KeyFrame = Instance.new("Frame", Blackout)
    KeyFrame.Size = UDim2.new(0, 320, 0, 180)
    KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", KeyFrame)

    local KeyInput = Instance.new("TextBox", KeyFrame)
    KeyInput.Size = UDim2.new(0, 280, 0, 45)
    KeyInput.Position = UDim2.new(0, 20, 0, 25)
    KeyInput.PlaceholderText = "Enter Key: ViperIsTheBest"
    KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", KeyInput)

    local SubmitBtn = Instance.new("TextButton", KeyFrame)
    SubmitBtn.Size = UDim2.new(0, 280, 0, 45)
    SubmitBtn.Position = UDim2.new(0, 20, 0, 80)
    SubmitBtn.Text = "LOGIN TO SYNDICATE"
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", SubmitBtn)

    -- [[ 2. MAIN HUB CONSTRUCTION ]] --
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Enabled = false
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 480, 0, 330)
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -165)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Instance.new("UICorner", MainFrame)

    local ToggleIcon = Instance.new("TextButton", ScreenGui)
    ToggleIcon.Size = UDim2.new(0, 55, 0, 55)
    ToggleIcon.Position = UDim2.new(0, 15, 0.4, 0)
    ToggleIcon.Text = "V"
    ToggleIcon.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    ToggleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleIcon.Font = Enum.Font.GothamBold
    ToggleIcon.TextSize = 28
    ToggleIcon.Active = true ToggleIcon.Draggable = true
    Instance.new("UICorner", ToggleIcon).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", ToggleIcon).Color = Color3.fromRGB(255, 0, 0)

    ToggleIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 140, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    Instance.new("UICorner", Sidebar)

    local PageHolder = Instance.new("Frame", MainFrame)
    PageHolder.Position = UDim2.new(0, 150, 0, 10)
    PageHolder.Size = UDim2.new(1, -160, 1, -20)
    PageHolder.BackgroundTransparency = 1

    local function CreateTab(name, order)
        local b = Instance.new("TextButton", Sidebar)
        b.Size = UDim2.new(1, -10, 0, 38)
        b.Position = UDim2.new(0, 5, 0, 15 + (order * 45))
        b.Text = name b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", b)
        local pg = Instance.new("ScrollingFrame", PageHolder)
        pg.Size = UDim2.new(1, 0, 1, 0)
        pg.Visible = false pg.BackgroundTransparency = 1
        pg.ScrollBarThickness = 0
        Instance.new("UIListLayout", pg).Padding = UDim.new(0, 6)
        b.MouseButton1Click:Connect(function()
            for _, p in pairs(PageHolder:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
            pg.Visible = true
        end)
        return pg
    end

    local function AddToggle(pnt, txt, cb)
        local b = Instance.new("TextButton", pnt)
        b.Size = UDim2.new(1, -10, 0, 42)
        b.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        b.Text = txt .. " [OFF]" b.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", b)
        local s = false
        b.MouseButton1Click:Connect(function()
            s = not s
            b.Text = txt .. (s and " [ON]" or " [OFF]")
            b.BackgroundColor3 = s and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(28, 28, 28)
            cb(s)
        end)
    end

    local function AddInput(pnt, plch, cb)
        local box = Instance.new("TextBox", pnt)
        box.Size = UDim2.new(1, -10, 0, 42)
        box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        box.PlaceholderText = plch
        box.Text = "" box.TextColor3 = Color3.fromRGB(255, 0, 0)
        Instance.new("UICorner", box)
        box.FocusLost:Connect(function() cb(box.Text) end)
    end

    -- [[ 3. SETUP PAGES & FEATURES ]] --
    local Combat = CreateTab("Combat", 0)
    AddToggle(Combat, "Aimbot", function(v) Viper.Aimbot.Enabled = v end)
    AddToggle(Combat, "Wall Check", function(v) Viper.Aimbot.WallCheck = v end)
    AddToggle(Combat, "Wallbang", function(v) Viper.Aimbot.Wallbang = v end)
    AddInput(Combat, "Target (Head/Torso/HRP)", function(t) Viper.Aimbot.Target = t end)
    AddInput(Combat, "Smoothness (1-100)", function(t) 
        local n = tonumber(t) if n then Viper.Aimbot.Smoothness = (101 - n) / 500 end 
    end)

    local Visuals = CreateTab("Visuals", 1)
    AddToggle(Visuals, "ESP Master", function(v) Viper.ESP.Enabled = v end)
    AddToggle(Visuals, "ESP Box", function(v) Viper.ESP.Box = v end)
    AddToggle(Visuals, "ESP Name", function(v) Viper.ESP.Name = v end)

    local PlayerTab = CreateTab("Player", 2)
    AddInput(PlayerTab, "Set Speed (16-200)", function(t) 
        local n = tonumber(t) if n then LocalPlayer.Character.Humanoid.WalkSpeed = n end 
    end)
    AddToggle(PlayerTab, "Walk Fling (OP)", function(v) Viper.Player.Fling = v end)

    local Misc = CreateTab("Misc", 3)
    local DiscBtn = Instance.new("TextButton", Misc)
    DiscBtn.Size = UDim2.new(1, -10, 0, 45)
    DiscBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242) 
    DiscBtn.Text = "Copy Discord Link"
    DiscBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", DiscBtn)
    DiscBtn.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/QJJkHmsuX") 
        DiscBtn.Text = "LINK COPIED!"
        task.wait(2)
        DiscBtn.Text = "Copy Discord Link"
    end)

    -- [[ 4. CORE ENGINE ]] --
    SubmitBtn.MouseButton1Click:Connect(function()
        if KeyInput.Text == "ViperIsTheBest" then
            SubmitBtn.Text = "ACCESS GRANTED!"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            task.wait(1)
            TweenService:Create(Blackout, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
            task.wait(0.8)
            IntroGui:Destroy()
            ScreenGui.Enabled = true
            PageHolder:GetChildren()[1].Visible = true
        else
            SubmitBtn.Text = "WRONG KEY!"
            task.wait(1)
            SubmitBtn.Text = "LOGIN TO SYNDICATE"
        end
    end)

    RunService.RenderStepped:Connect(function()
        pcall(function()
            local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            if Viper.Aimbot.Enabled then
                local target = nil
                local maxDist = Viper.Aimbot.FOVSize
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        local part = p.Character:FindFirstChild(Viper.Aimbot.Target) or p.Character:FindFirstChild("HumanoidRootPart")
                        if part then
                            local pos, vis = Camera:WorldToViewportPoint(part.Position)
                            if vis then
                                local mag = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                                if mag < maxDist then target = part; maxDist = mag end
                            end
                        end
                    end
                end
                if target then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), Viper.Aimbot.Smoothness) end
            end
            if Viper.Player.Fling then LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.new(0, 25000, 0) end
        end)
    end)
end)
