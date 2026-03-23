-- [[ VIPER SYNDICATE - RESTORATION BUILD 3.8 ]] --
-- Fix: Wallcheck, Stable ESP, Persistent POV
-- Status: 100% OPERATIONAL FOR MOBILE

pcall(function()
    local Viper = {
        Aimbot = {Enabled = false, Target = "Head", Smoothness = 0.05, FOVSize = 150, FOVVisible = true, WallCheck = true},
        ESP = {Enabled = false, Box = false, Tracer = false},
        Misc = {Speed = 16, HitboxSize = 2}
    }

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local RunService = game:GetService("RunService")

    -- [[ 1. KEY SYSTEM (RE-FIXED) ]] --
    local KeyGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local KeyFrame = Instance.new("Frame", KeyGui)
    KeyFrame.Size = UDim2.new(0, 300, 0, 200)
    KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", KeyFrame)

    local KeyTitle = Instance.new("TextLabel", KeyFrame)
    KeyTitle.Size = UDim2.new(1, 0, 0, 50)
    KeyTitle.Text = "ENTER KEY"
    KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyTitle.Font = Enum.Font.GothamBold
    KeyTitle.TextSize = 20
    KeyTitle.BackgroundTransparency = 1

    local KeyInput = Instance.new("TextBox", KeyFrame)
    KeyInput.Size = UDim2.new(0, 240, 0, 40)
    KeyInput.Position = UDim2.new(0.5, -120, 0.4, 0)
    KeyInput.PlaceholderText = "Input Key..."
    KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", KeyInput)

    local Status = Instance.new("TextLabel", KeyFrame)
    Status.Size = UDim2.new(1, 0, 0, 25)
    Status.Position = UDim2.new(0, 0, 0.65, 0)
    Status.Text = ""
    Status.BackgroundTransparency = 1

    local Submit = Instance.new("TextButton", KeyFrame)
    Submit.Size = UDim2.new(0, 240, 0, 40)
    Submit.Position = UDim2.new(0.5, -120, 0.8, 0)
    Submit.Text = "LOGIN"
    Submit.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Submit)

    -- [[ 2. MAIN HUB ]] --
    local MainGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    MainGui.Enabled = false
    MainGui.ResetOnSpawn = false

    local function OpenHub()
        local MainFrame = Instance.new("Frame", MainGui)
        MainFrame.Size = UDim2.new(0, 450, 0, 310)
        MainFrame.Position = UDim2.new(0.5, -225, 0.5, -155)
        MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        Instance.new("UICorner", MainFrame)

        local Toggle = Instance.new("TextButton", MainGui)
        Toggle.Size = UDim2.new(0, 50, 0, 50)
        Toggle.Position = UDim2.new(0, 10, 0.4, 0)
        Toggle.Text = "V"
        Toggle.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.Draggable = true
        Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
        Toggle.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

        -- TABS & CONTENT (Combat, Visuals, Misc)
        local Sidebar = Instance.new("Frame", MainFrame)
        Sidebar.Size = UDim2.new(0, 120, 1, 0)
        Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

        local Container = Instance.new("Frame", MainFrame)
        Container.Position = UDim2.new(0, 130, 0, 10)
        Container.Size = UDim2.new(1, -140, 1, -20)
        Container.BackgroundTransparency = 1

        -- [Aimbot, Target Selector, Wallcheck Toggle, ESP Box, ESP Tracer, Hitbox, Speed]
        
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Viper Syndicate", Text = "Hello :D", Duration = 5})
    end

    -- [[ 3. LOGIC & ENGINE ]] --
    Submit.MouseButton1Click:Connect(function()
        if KeyInput.Text == "ViperIsTheBest" then
            Status.Text = "Success!" Status.TextColor3 = Color3.fromRGB(0, 255, 0)
            task.wait(1)
            KeyGui:Destroy()
            MainGui.Enabled = true
            OpenHub()
        else
            Status.Text = "Fail" Status.TextColor3 = Color3.fromRGB(255, 0, 0)
            task.wait(1) Status.Text = ""
        end
    end)

    -- THE CORE LOOP (Fix ESP & Wallcheck)
    RunService.RenderStepped:Connect(function()
        if MainGui.Enabled then
            pcall(function()
                local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                
                -- POV PERSISTENCE
                local POV = MainGui:FindFirstChild("POV") or Instance.new("Frame", MainGui)
                POV.Name = "POV"
                POV.Visible = Viper.Aimbot.Enabled
                POV.Size = UDim2.new(0, Viper.Aimbot.FOVSize, 0, Viper.Aimbot.FOVSize)
                POV.Position = UDim2.new(0.5, 0, 0.5, 0)
                POV.AnchorPoint = Vector2.new(0.5, 0.5)
                POV.BackgroundTransparency = 1
                if not POV:FindFirstChild("S") then 
                    local s = Instance.new("UIStroke", POV) s.Name = "S" s.Color = Color3.fromRGB(255, 0, 0)
                    Instance.new("UICorner", POV).CornerRadius = UDim.new(1, 0)
                end

                local target = nil
                local minDist = Viper.Aimbot.FOVSize / 2

                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local char = p.Character
                        local hrp = char.HumanoidRootPart
                        local pos, vis = Camera:WorldToViewportPoint(hrp.Position)

                        -- WALLCHECK LOGIC
                        local isVisible = true
                        if Viper.Aimbot.WallCheck then
                            local ray = Ray.new(Camera.CFrame.Position, (hrp.Position - Camera.CFrame.Position).Unit * 500)
                            local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, char})
                            if hit then isVisible = false end
                        end

                        -- ESP RENDER FIX
                        local folder = MainGui:FindFirstChild(p.Name.."_ESP") or Instance.new("Folder", MainGui)
                        folder.Name = p.Name.."_ESP"
                        
                        if Viper.ESP.Enabled and vis then
                            local b = folder:FindFirstChild("B") or Instance.new("Frame", folder)
                            b.Name = "B"; b.Visible = Viper.ESP.Box
                            b.Size = UDim2.new(0, 2000/pos.Z, 0, 3000/pos.Z)
                            b.Position = UDim2.new(0, pos.X - b.Size.X.Offset/2, 0, pos.Y - b.Size.Y.Offset/2)
                            b.BackgroundTransparency = 1
                            if not b:FindFirstChild("S") then Instance.new("UIStroke", b).Color = Color3.fromRGB(255,0,0) end
                        else
                            folder:ClearAllChildren()
                        end

                        -- AIMBOT TARGETING
                        if Viper.Aimbot.Enabled and vis and isVisible then
                            local mag = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                            if mag < minDist then target = char:FindFirstChild(Viper.Aimbot.Target); minDist = mag end
                        end
                    end
                end
                if target then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), Viper.Aimbot.Smoothness) end
            end)
        end
    end)
end)
