-- [[ VIPER SYNDICATE - REBORN BUILD 3.9 ]] --
-- Features: ALL-IN-ONE (Aimbot, Target, Wallcheck, ESP, Hitbox, Speed)
-- Fixes: Stuck Black Screen, Hello Notification position, Placeholder Key, ESP Lag
-- Status: 100% OPERATIONAL & IMMORTAL 

pcall(function()
    local Viper = {
        Aimbot = {Enabled = false, Target = "Head", Smoothness = 0.05, FOVSize = 150, FOVVisible = true, WallCheck = true},
        ESP = {Enabled = false, Box = false, Tracer = false, Name = false},
        Misc = {Speed = 16, HitboxSize = 2}
    }

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local CoreGui = game:GetService("CoreGui")

    -- [[ 1. NEW KEY SYSTEM UI (ANTI-BUG) ]] --
    local KeyGui = Instance.new("ScreenGui", CoreGui)
    KeyGui.Name = "ViperKeySys"
    KeyGui.DisplayOrder = 100 

    local KeyFrame = Instance.new("Frame", KeyGui)
    KeyFrame.Size = UDim2.new(0, 320, 0, 240)
    KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -120)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    KeyFrame.BorderSizePixel = 0
    Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 8)
    local FrameStroke = Instance.new("UIStroke", KeyFrame)
    FrameStroke.Color = Color3.fromRGB(50, 50, 50)
    FrameStroke.Thickness = 1.5

    local KeyTitle = Instance.new("TextLabel", KeyFrame)
    KeyTitle.Size = UDim2.new(1, 0, 0, 60)
    KeyTitle.Text = "VIPER SYNDICATE"
    KeyTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
    KeyTitle.Font = Enum.Font.GothamBold
    KeyTitle.TextSize = 24
    KeyTitle.BackgroundTransparency = 1

    -- KEY INPUT (Placeholder Fix)
    local KeyInput = Instance.new("TextBox", KeyFrame)
    KeyInput.Size = UDim2.new(0, 260, 0, 50)
    KeyInput.Position = UDim2.new(0.5, -130, 0, 80)
    KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.Font = Enum.Font.GothamSemibold
    KeyInput.TextSize = 18
    KeyInput.Text = ""
    KeyInput.PlaceholderText = "( Enter Key )" 
    KeyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    Instance.new("UICorner", KeyInput)

    local StatusLabel = Instance.new("TextLabel", KeyFrame)
    StatusLabel.Size = UDim2.new(1, 0, 0, 30)
    StatusLabel.Position = UDim2.new(0, 0, 0, 135)
    StatusLabel.Text = ""
    StatusLabel.Font = Enum.Font.GothamSemibold
    StatusLabel.TextSize = 16
    StatusLabel.BackgroundTransparency = 1

    local SubmitBtn = Instance.new("TextButton", KeyFrame)
    SubmitBtn.Size = UDim2.new(0, 260, 0, 50)
    SubmitBtn.Position = UDim2.new(0.5, -130, 0, 165)
    SubmitBtn.Text = "LOGIN"
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.TextSize = 20
    Instance.new("UICorner", SubmitBtn)

    -- [[ 2. MAIN HUB CONSTRUCTION (Hidden initially) ]] --
    local MainGui = Instance.new("ScreenGui", CoreGui)
    MainGui.Name = "ViperHubv39"
    MainGui.Enabled = false
    MainGui.ResetOnSpawn = false

    local function CreateHub()
        local MainFrame = Instance.new("Frame", MainGui)
        MainFrame.Size = UDim2.new(0, 480, 0, 340)
        MainFrame.Position = UDim2.new(0.5, -240, 0.5, -170)
        MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        MainFrame.BorderSizePixel = 0
        Instance.new("UICorner", MainFrame)

        local ToggleIcon = Instance.new("TextButton", MainGui)
        ToggleIcon.Size = UDim2.new(0, 55, 0, 55)
        ToggleIcon.Position = UDim2.new(0, 15, 0.4, 0)
        ToggleIcon.Text = "V"
        ToggleIcon.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
        ToggleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleIcon.Font = Enum.Font.GothamBold
        ToggleIcon.TextSize = 28
        ToggleIcon.Draggable = true -- Floating Icon Fixed
        Instance.new("UICorner", ToggleIcon).CornerRadius = UDim.new(1, 0)
        Instance.new("UIStroke", ToggleIcon).Color = Color3.fromRGB(255, 0, 0)

        ToggleIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

        local Sidebar = Instance.new("Frame", MainFrame)
        Sidebar.Size = UDim2.new(0, 140, 1, 0)
        Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Instance.new("UICorner", Sidebar)

        local PageHolder = Instance.new("Frame", MainFrame)
        PageHolder.Position = UDim2.new(0, 150, 0, 10)
        PageHolder.Size = UDim2.new(1, -160, 1, -20)
        PageHolder.BackgroundTransparency = 1

        local function CreateTab(name, order)
            local b = Instance.new("TextButton", Sidebar)
            b.Size = UDim2.new(1, -10, 0, 38)
            b.Position = UDim2.new(0, 5, 0, 20 + (order * 43))
            b.Text = name b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.Font = Enum.Font.GothamSemibold
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
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            b.Text = txt .. " [OFF]" b.TextColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", b)
            local s = false
            b.MouseButton1Click:Connect(function()
                s = not s
                b.Text = txt .. (s and " [ON]" or " [OFF]")
                b.BackgroundColor3 = s and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(30, 30, 30)
                cb(s)
            end)
        end

        local function AddInput(pnt, plch, cb)
            local box = Instance.new("TextBox", pnt)
            box.Size = UDim2.new(1, -10, 0, 42)
            box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            box.PlaceholderText = plch
            box.Text = "" box.TextColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", box)
            box.FocusLost:Connect(function() cb(box.Text) end)
        end

        -- TABS
        local Combat = CreateTab("Combat", 0)
        AddToggle(Combat, "Aimbot", function(v) Viper.Aimbot.Enabled = v end)
        AddToggle(Combat, "Wall Check", function(v) Viper.Aimbot.WallCheck = v end)
        AddToggle(Combat, "Wallbang", function(v) Viper.Aimbot.Wallbang = v end)
        AddInput(Combat, "Target (Head/Torso/HRP)", function(t) Viper.Aimbot.Target = t end)
        AddInput(Combat, "Smoothness (1-100)", function(t) 
            local n = tonumber(t) if n then Viper.Aimbot.Smoothness = (101 - n) / 500 end 
        end)

        local Visuals = CreateTab("Visuals", 1)
        AddToggle(Visuals, "Master ESP", function(v) Viper.ESP.Enabled = v end)
        AddToggle(Visuals, "ESP Box", function(v) Viper.ESP.Box = v end)
        AddToggle(Visuals, "ESP Tracer", function(v) Viper.ESP.Tracer = v end)
        AddToggle(Visuals, "ESP Name", function(v) Viper.ESP.Name = v end)

        local Misc = CreateTab("Misc", 2)
        AddInput(Misc, "Hitbox Size (1-10)", function(t) Viper.Misc.HitboxSize = tonumber(t) or 2 end)
        AddInput(Misc, "Set Speed", function(t) LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(t) or 16 end)
        
        local Disc = Instance.new("TextButton", Misc)
        Disc.Size = UDim2.new(1, -10, 0, 42)
        Disc.Text = "Copy Discord Link"
        Disc.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        Disc.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", Disc)
        Disc.MouseButton1Click:Connect(function() setclipboard("https://discord.gg/QJJkHmsuX") Disc.Text = "COPIED!" task.wait(2) Disc.Text = "Copy Discord Link" end)

        PageHolder:GetChildren()[1].Visible = true
        
        -- [[ 3. CUSTOM TOP NOTIFICATION (ANTI-BUG) ]] --
        local NotifFrame = Instance.new("Frame", MainGui)
        NotifFrame.Size = UDim2.new(0, 250, 0, 60)
        NotifFrame.Position = UDim2.new(0.5, -125, -0.2, 0) -- Mulai dari atas layar
        NotifFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
        Instance.new("UICorner", NotifFrame)
        Instance.new("UIStroke", NotifFrame).Color = Color3.fromRGB(255, 0, 0)
        
        local NotifTxt = Instance.new("TextLabel", NotifFrame)
        NotifTxt.Size = UDim2.new(1, 0, 1, 0)
        NotifTxt.Text = "Hello :D | Viper Syndicate"
        NotifTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotifTxt.Font = Enum.Font.GothamBold
        NotifTxt.TextSize = 16
        NotifTxt.BackgroundTransparency = 1
        
        -- Animasi notifikasi muncul
        NotifFrame:TweenPosition(UDim2.new(0.5, -125, 0.05, 0), "Out", "Bounce", 0.5)
        task.wait(4)
        NotifFrame:TweenPosition(UDim2.new(0.5, -125, -0.2, 0), "In", "Quad", 0.5)
        task.wait(0.5)
        NotifFrame:Destroy()
    end

    -- [[ 4. KEY CHECK LOGIC (FIX STUCK Hitam) ]] --
    SubmitBtn.MouseButton1Click:Connect(function()
        if KeyInput.Text == "ViperIsTheBest" then
            StatusLabel.Text = "Success!" StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            task.wait(1)
            -- Tween Out Key Gui
            TweenService:Create(KeyFrame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -160, 1.2, 0)}):Play()
            task.wait(0.5)
            KeyGui:Destroy()
            
            CreateHub() -- Bikin menu aslinya
            MainGui.Enabled = true -- Munculkan menu aslinya
            pcall(function() print("Viper Hub Activated!") end)
        else
            StatusLabel.Text = "Fail" StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            task.wait(1) StatusLabel.Text = ""
        end
    end)

    -- [[ 5. STABLE CORE ENGINE (Optimized for Realme) ]] --
    RunService.RenderStepped:Connect(function()
        if MainGui.Enabled then
            pcall(function()
                local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                
                -- POV Circle Persistence
                local POV = MainGui:FindFirstChild("POV") or Instance.new("Frame", MainGui)
                POV.Name = "POV"
                POV.Visible = Viper.Aimbot.FOVVisible and Viper.Aimbot.Enabled
                POV.Size = UDim2.new(0, Viper.Aimbot.FOVSize, 0, Viper.Aimbot.FOVSize)
                POV.Position = UDim2.new(0.5, 0, 0.5, 0)
                POV.AnchorPoint = Vector2.new(0.5, 0.5)
                POV.BackgroundTransparency = 1
                if not POV:FindFirstChild("Stroke") then 
                    Instance.new("UIStroke", POV).Color = Color3.fromRGB(255, 0, 0)
                    Instance.new("UICorner", POV).CornerRadius = UDim.new(1, 0)
                end

                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        local char = p.Character
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        local head = char:FindFirstChild("Head")
                        if hrp and head then
                            -- HITBOX EXPANDER
                            hrp.Size = Vector3.new(Viper.Misc.HitboxSize, Viper.Misc.HitboxSize, Viper.Misc.HitboxSize)
                            hrp.Transparency = 0.7
                            hrp.CanCollide = false

                            -- ESP RENDER
                            local pos, vis = Camera:WorldToViewportPoint(hrp.Position)
                            local folder = MainGui:FindFirstChild(p.Name.."_ESP") or Instance.new("Folder", MainGui)
                            folder.Name = p.Name.."_ESP"

                            if Viper.ESP.Enabled and vis then
                                -- Stable BOX
                                local b = folder:FindFirstChild("B") or Instance.new("Frame", folder)
                                b.Name = "B"; b.Visible = Viper.ESP.Box
                                b.Size = UDim2.new(0, 2500/pos.Z, 0, 3500/pos.Z)
                                b.Position = UDim2.new(0, pos.X - b.Size.X.Offset/2, 0, pos.Y - b.Size.Y.Offset/2)
                                b.BackgroundTransparency = 1
                                if not b:FindFirstChild("S") then Instance.new("UIStroke", b).Color = Color3.fromRGB(255, 0, 0) end
                            else
                                folder:ClearAllChildren()
                            end
                        end
                    end
                end

                -- AIMBOT EXECUTION (With Wallcheck)
                if Viper.Aimbot.Enabled then
                    local target = nil
                    local maxDist = Viper.Aimbot.FOVSize / 2
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character then
                            local part = p.Character:FindFirstChild(Viper.Aimbot.Target) or p.Character:FindFirstChild("HumanoidRootPart")
                            if part then
                                local pos, vis = Camera:WorldToViewportPoint(part.Position)
                                if vis then
                                    -- WALLCHECK
                                    local isVisible = true
                                    if Viper.Aimbot.WallCheck then
                                        local ray = Ray.new(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 500)
                                        local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, p.Character})
                                        if hit then isVisible = false end
                                    end

                                    if isVisible then
                                        local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                                        if dist < maxDist then target = part; maxDist = dist end
                                    end
                                end
                            end
                        end
                    end
                    if target then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), Viper.Aimbot.Smoothness) end
                end
            end)
        end
    end)
end)
