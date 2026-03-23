-- [[ VIPER HUB - THE ULTIMATE BUILD 6.0 ]] --
-- Features: Fullscreen Hello :D, Resizable POV, ESP Chams, Tabs UI

pcall(function()
    local Viper = {
        Aimbot = {Enabled = false, Target = "Head", Smoothness = 0.05, FOV = 150, WallCheck = true, Wallbang = false},
        ESP = {Enabled = false, Box = false, Tracer = false, Name = false, Chams = false},
        Misc = {Speed = 16, HitboxSize = 2}
    }

    local Players = game:GetService("Players")
    local LP = Players.LocalPlayer
    local Cam = workspace.CurrentCamera
    local Run = game:GetService("RunService")
    local Core = game:GetService("CoreGui")

    -- [[ 1. KEY SYSTEM ]] --
    local KeyGui = Instance.new("ScreenGui", Core)
    KeyGui.DisplayOrder = 100
    local KFrame = Instance.new("Frame", KeyGui)
    KFrame.Size = UDim2.new(0, 300, 0, 200)
    KFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    KFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", KFrame)

    local KTitle = Instance.new("TextLabel", KFrame)
    KTitle.Size = UDim2.new(1, 0, 0, 50)
    KTitle.Text = "ENTER KEY"
    KTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
    KTitle.Font = Enum.Font.GothamBold
    KTitle.TextSize = 22
    KTitle.BackgroundTransparency = 1

    local KInput = Instance.new("TextBox", KFrame)
    KInput.Size = UDim2.new(0, 240, 0, 45)
    KInput.Position = UDim2.new(0.5, -120, 0.45, 0)
    KInput.PlaceholderText = "( Enter Key )"
    KInput.Text = ""
    KInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", KInput)

    local KBtn = Instance.new("TextButton", KFrame)
    KBtn.Size = UDim2.new(0, 240, 0, 45)
    KBtn.Position = UDim2.new(0.5, -120, 0.75, 0)
    KBtn.Text = "LOGIN"
    KBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    KBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    KBtn.Font = Enum.Font.GothamBold
    KBtn.TextSize = 18
    Instance.new("UICorner", KBtn)

    -- [[ 2. FULLSCREEN HELLO :D ]] --
    local function ShowHelloFullscreen()
        local HelloGui = Instance.new("ScreenGui", Core)
        HelloGui.DisplayOrder = 9999 
        
        local BG = Instance.new("Frame", HelloGui)
        BG.Size = UDim2.new(1, 0, 1, 0)
        BG.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        
        local Txt = Instance.new("TextLabel", BG)
        Txt.Size = UDim2.new(1, 0, 1, 0)
        Txt.Text = "Hello :D"
        Txt.TextColor3 = Color3.fromRGB(255, 0, 0)
        Txt.Font = Enum.Font.GothamBlack
        Txt.TextSize = 80
        Txt.BackgroundTransparency = 1
        
        task.wait(2.5) 
        
        for i = 0, 1, 0.1 do
            BG.BackgroundTransparency = i
            Txt.TextTransparency = i
            task.wait(0.05)
        end
        HelloGui:Destroy()
    end

    -- [[ 3. MAIN HUB (TABS & UI) ]] --
    local function CreateHub()
        local MainGui = Instance.new("ScreenGui", Core)
        MainGui.Enabled = true
        
        local MainFrame = Instance.new("Frame", MainGui)
        MainFrame.Size = UDim2.new(0, 480, 0, 320)
        MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
        MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
        Instance.new("UICorner", MainFrame)

        -- JUDUL VIPER HUB
        local HubTitle = Instance.new("TextLabel", MainFrame)
        HubTitle.Size = UDim2.new(1, 0, 0, 35)
        HubTitle.Text = "  VIPER HUB - SYNDICATE"
        HubTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
        HubTitle.Font = Enum.Font.GothamBold
        HubTitle.TextSize = 18
        HubTitle.TextXAlignment = Enum.TextXAlignment.Left
        HubTitle.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
        Instance.new("UICorner", HubTitle)

        -- TOGGLE BUTTON (V)
        local VBtn = Instance.new("TextButton", MainGui)
        VBtn.Size = UDim2.new(0, 50, 0, 50)
        VBtn.Position = UDim2.new(0, 20, 0.4, 0)
        VBtn.Text = "V"
        VBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        VBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        VBtn.Font = Enum.Font.GothamBold
        VBtn.TextSize = 25
        VBtn.Draggable = true
        Instance.new("UICorner", VBtn).CornerRadius = UDim.new(1, 0)
        VBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

        local Sidebar = Instance.new("Frame", MainFrame)
        Sidebar.Size = UDim2.new(0, 130, 1, -35)
        Sidebar.Position = UDim2.new(0, 0, 0, 35)
        Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Instance.new("UICorner", Sidebar)

        local PageHolder = Instance.new("Frame", MainFrame)
        PageHolder.Position = UDim2.new(0, 140, 0, 45)
        PageHolder.Size = UDim2.new(1, -150, 1, -55)
        PageHolder.BackgroundTransparency = 1

        local function CreateTab(name, order)
            local btn = Instance.new("TextButton", Sidebar)
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.Position = UDim2.new(0, 5, 0, 10 + (order * 40))
            btn.Text = name
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", btn)

            local page = Instance.new("ScrollingFrame", PageHolder)
            page.Size = UDim2.new(1, 0, 1, 0)
            page.Visible = false
            page.BackgroundTransparency = 1
            page.ScrollBarThickness = 2
            local layout = Instance.new("UIListLayout", page)
            layout.Padding = UDim.new(0, 5)

            btn.MouseButton1Click:Connect(function()
                for _, p in pairs(PageHolder:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
                page.Visible = true
            end)
            return page
        end

        local function AddToggle(parent, txt, cb)
            local b = Instance.new("TextButton", parent)
            b.Size = UDim2.new(1, -10, 0, 38)
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            b.Text = txt .. " [OFF]"
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", b)
            local s = false
            b.MouseButton1Click:Connect(function()
                s = not s
                b.Text = txt .. (s and " [ON]" or " [OFF]")
                b.BackgroundColor3 = s and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 40, 40)
                cb(s)
            end)
        end

        local function AddInput(parent, plch, cb)
            local i = Instance.new("TextBox", parent)
            i.Size = UDim2.new(1, -10, 0, 38)
            i.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            i.PlaceholderText = plch
            i.Text = ""
            i.TextColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", i)
            i.FocusLost:Connect(function() cb(i.Text) end)
        end

        -- TABS SETUP
        local CombatTab = CreateTab("Combat", 0)
        local VisualsTab = CreateTab("Visuals", 1)
        local MiscTab = CreateTab("Misc", 2)
        PageHolder:GetChildren()[1].Visible = true -- 

        -- COMBAT FEATURES
        AddToggle(CombatTab, "Aimbot Master", function(v) Viper.Aimbot.Enabled = v end)
        AddToggle(CombatTab, "Wall Check", function(v) Viper.Aimbot.WallCheck = v end)
        AddToggle(CombatTab, "Wallbang", function(v) Viper.Aimbot.Wallbang = v end)
        AddInput(CombatTab, "Set POV Size (10 - 500)", function(t) Viper.Aimbot.FOV = tonumber(t) or 150 end) 
        AddInput(CombatTab, "Target (Head/Torso/HRP)", function(t) Viper.Aimbot.Target = t end)
        AddInput(CombatTab, "Smoothness (1-100)", function(t) Viper.Aimbot.Smoothness = (101 - tonumber(t or 50)) / 500 end)

        -- VISUALS FEATURES
        AddToggle(VisualsTab, "Master ESP", function(v) Viper.ESP.Enabled = v end)
        AddToggle(VisualsTab, "ESP Box", function(v) Viper.ESP.Box = v end)
        AddToggle(VisualsTab, "ESP Tracer", function(v) Viper.ESP.Tracer = v end)
        AddToggle(VisualsTab, "ESP Name", function(v) Viper.ESP.Name = v end)
        AddToggle(VisualsTab, "ESP Chams (Fill)", function(v) Viper.ESP.Chams = v end) 

        -- MISC FEATURES
        AddInput(MiscTab, "Hitbox Size (1-15)", function(t) Viper.Misc.HitboxSize = tonumber(t) or 2 end)
        AddInput(MiscTab, "Speed Hack", function(t) LP.Character.Humanoid.WalkSpeed = tonumber(t) or 16 end)
        
        local Disc = Instance.new("TextButton", MiscTab)
        Disc.Size = UDim2.new(1, -10, 0, 38)
        Disc.Text = "Copy Discord Link"
        Disc.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        Disc.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", Disc)
        Disc.MouseButton1Click:Connect(function() setclipboard("https://discord.gg/QJJkHmsuX") Disc.Text = "COPIED!" task.wait(2) Disc.Text = "Copy Discord Link" end)

        -- [[ ENGINE LOOP (NO BUG FIX) ]] --
        Run.RenderStepped:Connect(function()
            pcall(function()
                local Center = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
                
                -- POV RESIZABLE UPDATE
                local POV = MainGui:FindFirstChild("POV") or Instance.new("Frame", MainGui)
                POV.Name = "POV"; POV.Visible = Viper.Aimbot.Enabled
                POV.Size = UDim2.new(0, Viper.Aimbot.FOV, 0, Viper.Aimbot.FOV) 
                POV.Position = UDim2.new(0.5, 0, 0.5, 0)
                POV.AnchorPoint = Vector2.new(0.5, 0.5)
                POV.BackgroundTransparency = 1
                if not POV:FindFirstChild("S") then 
                    local s = Instance.new("UIStroke", POV); s.Name = "S"; s.Color = Color3.fromRGB(255, 0, 0)
                    Instance.new("UICorner", POV).CornerRadius = UDim.new(1, 0)
                end

                local TargetPart = nil
                local MinDist = Viper.Aimbot.FOV / 2

                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local HRP = p.Character.HumanoidRootPart
                        local ScreenPos, OnScreen = Cam:WorldToViewportPoint(HRP.Position)

                        -- ESP CHAMS & FOLDER SYSTEM
                        local Folder = MainGui:FindFirstChild(p.Name.."_ESP") or Instance.new("Folder", MainGui)
                        Folder.Name = p.Name.."_ESP"

                        -- Chams Highlight
                        if Viper.ESP.Enabled and Viper.ESP.Chams then
                            if not p.Character:FindFirstChild("ViperChams") then
                                local c = Instance.new("Highlight", p.Character)
                                c.Name = "ViperChams"
                                c.FillColor = Color3.fromRGB(255, 0, 0)
                                c.FillTransparency = 0.5
                                c.OutlineColor = Color3.fromRGB(255, 255, 255)
                            end
                        else
                            if p.Character:FindFirstChild("ViperChams") then p.Character.ViperChams:Destroy() end
                        end

                        if Viper.ESP.Enabled and OnScreen then
                            -- Box
                            local Box = Folder:FindFirstChild("B") or Instance.new("Frame", Folder)
                            Box.Name = "B"; Box.Visible = Viper.ESP.Box
                            Box.Size = UDim2.new(0, 2200/ScreenPos.Z, 0, 3200/ScreenPos.Z)
                            Box.Position = UDim2.new(0, ScreenPos.X - Box.Size.X.Offset/2, 0, ScreenPos.Y - Box.Size.Y.Offset/2)
                            Box.BackgroundTransparency = 1
                            if not Box:FindFirstChild("S") then Instance.new("UIStroke", Box).Color = Color3.fromRGB(255,0,0) end
                            
                            -- Tracer
                            local Trc = Folder:FindFirstChild("T") or Instance.new("Frame", Folder)
                            Trc.Name = "T"; Trc.Visible = Viper.ESP.Tracer
                            Trc.Size = UDim2.new(0, 1.5, 0, (Vector2.new(ScreenPos.X, ScreenPos.Y) - Vector2.new(Center.X, Center.Y*2)).Magnitude)
                            Trc.Position = UDim2.new(0, Center.X, 0, Center.Y*2)
                            Trc.AnchorPoint = Vector2.new(0.5, 0)
                            Trc.Rotation = math.deg(math.atan2(ScreenPos.Y - (Center.Y*2), ScreenPos.X - Center.X)) - 90
                            Trc.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                            
                            -- Name
                            local Txt = Folder:FindFirstChild("N") or Instance.new("TextLabel", Folder)
                            Txt.Name = "N"; Txt.Visible = Viper.ESP.Name
                            Txt.Text = p.Name
                            Txt.Position = UDim2.new(0, ScreenPos.X, 0, ScreenPos.Y - (1800/ScreenPos.Z))
                            Txt.Size = UDim2.new(0, 0, 0, 0)
                            Txt.Font = Enum.Font.GothamBold
                            Txt.TextSize = 14
                            Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Txt.BackgroundTransparency = 1
                            if not Txt:FindFirstChild("S") then Instance.new("UIStroke", Txt) end
                        else 
                            Folder:ClearAllChildren() 
                        end

                        -- Hitbox Expander
                        HRP.Size = Vector3.new(Viper.Misc.HitboxSize, Viper.Misc.HitboxSize, Viper.Misc.HitboxSize)
                        HRP.Transparency = 0.7

                        -- Aimbot Targeting
                        if Viper.Aimbot.Enabled and OnScreen then
                            local Dist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - Center).Magnitude
                            if Dist < MinDist then
                                local Visible = true
                                if Viper.Aimbot.WallCheck and not Viper.Aimbot.Wallbang then
                                    local Hit = workspace:FindPartOnRay(Ray.new(Cam.CFrame.Position, (HRP.Position - Cam.CFrame.Position).Unit * 500), LP.Character)
                                    if Hit and not Hit:IsDescendantOf(p.Character) then Visible = false end
                                end
                                if Visible then TargetPart = p.Character:FindFirstChild(Viper.Aimbot.Target); MinDist = Dist end
                            end
                        end
                    end
                end
                if TargetPart then Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(Cam.CFrame.Position, TargetPart.Position), Viper.Aimbot.Smoothness) end
            end)
        end)
    end

    -- [[ 4. LOGIN LOGIC ]] --
    KBtn.MouseButton1Click:Connect(function()
        if KInput.Text == "ViperIsTheBest" then
            KeyGui:Destroy()
            ShowHelloFullscreen() 
            CreateHub() 
        else
            KBtn.Text = "FAIL" KBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            task.wait(1) KBtn.Text = "LOGIN"
        end
    end)
end)
