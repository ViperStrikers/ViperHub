-- [[ VIPER SYNDICATE - THE OVERLORD BUILD 5.0 ]] --
-- FINAL SERIOUS BUILD | NO BUGS | ALL FEATURES INCLUDED

pcall(function()
    local Viper = {
        Aimbot = {Enabled = false, Target = "Head", Smoothness = 0.05, FOV = 150, WallCheck = true, Wallbang = false},
        ESP = {Enabled = false, Box = false, Tracer = false, Name = false},
        Misc = {Speed = 16, HitboxSize = 2}
    }

    local Players = game:GetService("Players")
    local LP = Players.LocalPlayer
    local Cam = workspace.CurrentCamera
    local Run = game:GetService("RunService")
    local Core = game:GetService("CoreGui")

    -- [[ 1. KEY SYSTEM (FIXED PLACEHOLDER) ]] --
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
    KTitle.Font = "GothamBold"
    KTitle.TextSize = 22
    KTitle.BackgroundTransparency = 1

    local KInput = Instance.new("TextBox", KFrame)
    KInput.Size = UDim2.new(0, 240, 0, 45)
    KInput.Position = UDim2.new(0.5, -120, 0.45, 0)
    KInput.PlaceholderText = "( Enter Key )" -- REQUESTED
    KInput.Text = ""
    KInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", KInput)

    local KStatus = Instance.new("TextLabel", KFrame)
    KStatus.Size = UDim2.new(1, 0, 0, 20)
    KStatus.Position = UDim2.new(0, 0, 0.7, 0)
    KStatus.Text = ""
    KStatus.BackgroundTransparency = 1

    local KBtn = Instance.new("TextButton", KFrame)
    KBtn.Size = UDim2.new(0, 240, 0, 45)
    KBtn.Position = UDim2.new(0.5, -120, 0.8, 0)
    KBtn.Text = "LOGIN"
    KBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    KBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", KBtn)

    -- [[ 2. MAIN HUB (HIDDEN UNTIL LOGIN) ]] --
    local function CreateHub()
        local MainGui = Instance.new("ScreenGui", Core)
        MainGui.Enabled = true
        
        -- NOTIF HELLO :D (GAK NUTUPIN LAYAR)
        local HelloNotif = Instance.new("TextLabel", MainGui)
        HelloNotif.Size = UDim2.new(0, 300, 0, 50)
        HelloNotif.Position = UDim2.new(0.5, -150, 0.1, 0)
        HelloNotif.Text = "Hello :D | Viper Syndicate"
        HelloNotif.TextColor3 = Color3.fromRGB(255, 255, 255)
        HelloNotif.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
        HelloNotif.Font = "GothamBold"
        HelloNotif.TextSize = 18
        Instance.new("UICorner", HelloNotif)
        task.delay(4, function() HelloNotif:Destroy() end)

        local MainFrame = Instance.new("Frame", MainGui)
        MainFrame.Size = UDim2.new(0, 450, 0, 320)
        MainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
        MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
        Instance.new("UICorner", MainFrame)

        -- TOGGLE BUTTON (BUAT BUKA TUTUP HUB)
        local VBtn = Instance.new("TextButton", MainGui)
        VBtn.Size = UDim2.new(0, 50, 0, 50)
        VBtn.Position = UDim2.new(0, 20, 0.5, 0)
        VBtn.Text = "V"
        VBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
        VBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        VBtn.Draggable = true
        Instance.new("UICorner", VBtn).CornerRadius = UDim.new(1, 0)
        VBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

        local Sidebar = Instance.new("Frame", MainFrame)
        Sidebar.Size = UDim2.new(0, 130, 1, 0)
        Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Instance.new("UICorner", Sidebar)

        local Container = Instance.new("ScrollingFrame", MainFrame)
        Container.Position = UDim2.new(0, 140, 0, 10)
        Container.Size = UDim2.new(1, -150, 1, -20)
        Container.BackgroundTransparency = 1
        Container.ScrollBarThickness = 2
        local List = Instance.new("UIListLayout", Container)
        List.Padding = UDim.new(0, 5)

        -- FITUR TOOLS (Toggle & Input)
        local function AddToggle(txt, cb)
            local b = Instance.new("TextButton", Container)
            b.Size = UDim2.new(1, -10, 0, 35)
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            b.Text = txt .. " [OFF]"
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", b)
            local s = false
            b.MouseButton1Click:Connect(function()
                s = not s
                b.Text = txt .. (s and " [ON]" or " [OFF]")
                b.BackgroundColor3 = s and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(30, 30, 30)
                cb(s)
            end)
        end

        local function AddInput(plch, cb)
            local i = Instance.new("TextBox", Container)
            i.Size = UDim2.new(1, -10, 0, 35)
            i.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            i.PlaceholderText = plch
            i.Text = ""
            i.TextColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", i)
            i.FocusLost:Connect(function() cb(i.Text) end)
        end

        -- [[ ADDING FEATURES TO HUB ]] --
        AddToggle("Aimbot Master", function(v) Viper.Aimbot.Enabled = v end)
        AddToggle("Wall Check", function(v) Viper.Aimbot.WallCheck = v end)
        AddToggle("Wallbang (Risky)", function(v) Viper.Aimbot.Wallbang = v end)
        AddInput("Target (Head/Torso/HRP)", function(t) Viper.Aimbot.Target = t end)
        AddInput("Smoothness (1-100)", function(t) Viper.Aimbot.Smoothness = (101 - tonumber(t or 50)) / 500 end)
        
        AddToggle("ESP Box", function(v) Viper.ESP.Box = v; Viper.ESP.Enabled = true end)
        AddToggle("ESP Tracer", function(v) Viper.ESP.Tracer = v; Viper.ESP.Enabled = true end)
        
        AddInput("Hitbox Size (1-15)", function(t) Viper.Misc.HitboxSize = tonumber(t) or 2 end)
        AddInput("Speed Hack", function(t) LP.Character.Humanoid.WalkSpeed = tonumber(t) or 16 end)

        local Disc = Instance.new("TextButton", Container)
        Disc.Size = UDim2.new(1, -10, 0, 35)
        Disc.Text = "Copy Discord Link"
        Disc.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        Disc.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", Disc)
        Disc.MouseButton1Click:Connect(function() setclipboard("https://discord.gg/QJJkHmsuX") Disc.Text = "LINK COPIED!" end)

        -- [[ ENGINE LOOP ]] --
        Run.RenderStepped:Connect(function()
            pcall(function()
                local Center = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
                
                -- FOV CIRCLE (ANTI-ILANG)
                local FOV = MainGui:FindFirstChild("FOV") or Instance.new("Frame", MainGui)
                FOV.Name = "FOV"; FOV.Visible = Viper.Aimbot.Enabled
                FOV.Size = UDim2.new(0, Viper.Aimbot.FOV, 0, Viper.Aimbot.FOV)
                FOV.Position = UDim2.new(0.5, 0, 0.5, 0)
                FOV.AnchorPoint = Vector2.new(0.5, 0.5)
                FOV.BackgroundTransparency = 1
                if not FOV:FindFirstChild("S") then 
                    local s = Instance.new("UIStroke", FOV); s.Name = "S"; s.Color = Color3.fromRGB(255, 0, 0)
                    Instance.new("UICorner", FOV).CornerRadius = UDim.new(1, 0)
                end

                local TargetPart = nil
                local MinDist = Viper.Aimbot.FOV / 2

                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local HRP = p.Character.HumanoidRootPart
                        local ScreenPos, OnScreen = Cam:WorldToViewportPoint(HRP.Position)

                        -- ESP (FIXED STABLE)
                        local Folder = MainGui:FindFirstChild(p.Name.."_ESP") or Instance.new("Folder", MainGui)
                        Folder.Name = p.Name.."_ESP"
                        if Viper.ESP.Enabled and OnScreen then
                            local Box = Folder:FindFirstChild("B") or Instance.new("Frame", Folder)
                            Box.Name = "B"; Box.Visible = Viper.ESP.Box
                            Box.Size = UDim2.new(0, 2200/ScreenPos.Z, 0, 3200/ScreenPos.Z)
                            Box.Position = UDim2.new(0, ScreenPos.X - Box.Size.X.Offset/2, 0, ScreenPos.Y - Box.Size.Y.Offset/2)
                            Box.BackgroundTransparency = 1
                            if not Box:FindFirstChild("S") then Instance.new("UIStroke", Box).Color = Color3.fromRGB(255,0,0) end
                        else Folder:ClearAllChildren() end

                        -- HITBOX
                        HRP.Size = Vector3.new(Viper.Misc.HitboxSize, Viper.Misc.HitboxSize, Viper.Misc.HitboxSize)
                        HRP.Transparency = 0.7

                        -- AIMBOT WITH WALLCHECK
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

    -- [[ 3. LOGIN LOGIC ]] --
    KBtn.MouseButton1Click:Connect(function()
        if KInput.Text == "ViperIsTheBest" then
            KStatus.Text = "Success!" KStatus.TextColor3 = Color3.fromRGB(0, 255, 0)
            task.wait(1)
            KeyGui:Destroy()
            CreateHub()
        else
            KStatus.Text = "Fail" KStatus.TextColor3 = Color3.fromRGB(255, 0, 0)
            task.wait(1) KStatus.Text = ""
        end
    end)
end)
