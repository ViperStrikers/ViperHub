-- [[ VIPER SYNDICATE - GODSPEED BUILD 4.0 ]] --
-- OPTIMIZED FOR ANDROID
-- FIX: ESP, AIMBOT LAG, NOTIFICATION, KEY SYSTEM

pcall(function()
    local Viper = {
        Aimbot = {Enabled = false, Target = "Head", Smooth = 0.1, FOV = 120},
        ESP = {Enabled = false, Color = Color3.fromRGB(255, 0, 0)},
        Misc = {Speed = 16, Hitbox = 2}
    }

    local Players = game:GetService("Players")
    local lp = Players.LocalPlayer
    local mouse = lp:GetMouse()
    local cam = workspace.CurrentCamera
    local run = game:GetService("RunService")

    -- [[ 1. KEY SYSTEM UI ]] --
    local kgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    kgui.DisplayOrder = 999
    
    local kframe = Instance.new("Frame", kgui)
    kframe.Size = UDim2.new(0, 280, 0, 180)
    kframe.Position = UDim2.new(0.5, -140, 0.5, -90)
    kframe.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Instance.new("UICorner", kframe)

    local klabel = Instance.new("TextLabel", kframe)
    klabel.Size = UDim2.new(1, 0, 0, 40)
    klabel.Text = "ENTER KEY"
    klabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    klabel.Font = "GothamBold"
    klabel.TextSize = 20
    klabel.BackgroundTransparency = 1

    local kinput = Instance.new("TextBox", kframe)
    kinput.Size = UDim2.new(0, 220, 0, 40)
    kinput.Position = UDim2.new(0.5, -110, 0.4, 0)
    kinput.PlaceholderText = "( Enter Key )"
    kinput.Text = ""
    kinput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    kinput.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", kinput)

    local kbtn = Instance.new("TextButton", kframe)
    kbtn.Size = UDim2.new(0, 220, 0, 40)
    kbtn.Position = UDim2.new(0.5, -110, 0.75, 0)
    kbtn.Text = "LOGIN"
    kbtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    kbtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", kbtn)

    -- [[ 2. MAIN ENGINE ]] --
    local function StartViper()
        local mgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        local mframe = Instance.new("Frame", mgui)
        mframe.Size = UDim2.new(0, 400, 0, 250)
        mframe.Position = UDim2.new(0.5, -200, 0.5, -125)
        mframe.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
        mframe.Visible = true
        Instance.new("UICorner", mframe)

        -- HELLO NOTIF (TENGAH LAYAR)
        local hello = Instance.new("TextLabel", mgui)
        hello.Size = UDim2.new(0, 200, 0, 50)
        hello.Position = UDim2.new(0.5, -100, 0.2, 0)
        hello.Text = "Hello :D"
        hello.TextColor3 = Color3.fromRGB(255, 0, 0)
        hello.Font = "GothamBold"
        hello.TextSize = 30
        hello.BackgroundTransparency = 1
        task.delay(3, function() hello:Destroy() end)

        -- DISCORD BUTTON 
        local dbtn = Instance.new("TextButton", mframe)
        dbtn.Size = UDim2.new(0, 150, 0, 30)
        dbtn.Position = UDim2.new(0.6, 0, 0.05, 0)
        dbtn.Text = "Copy Discord Link"
        dbtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        dbtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", dbtn)
        dbtn.MouseButton1Click:Connect(function() setclipboard("https://discord.gg/QJJkHmsuX") dbtn.Text = "COPIED!" end)

        -- TOGGLES (Combat & ESP)
        local function toggle(txt, pos, cb)
            local b = Instance.new("TextButton", mframe)
            b.Size = UDim2.new(0, 180, 0, 35)
            b.Position = pos
            b.Text = txt .. " [OFF]"
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", b)
            local s = false
            b.MouseButton1Click:Connect(function()
                s = not s
                b.Text = txt .. (s and " [ON]" or " [OFF]")
                b.BackgroundColor3 = s and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(30, 30, 30)
                cb(s)
            end)
        end

        toggle("Aimbot", UDim2.new(0.05, 0, 0.2, 0), function(v) Viper.Aimbot.Enabled = v end)
        toggle("Wallcheck", UDim2.new(0.05, 0, 0.4, 0), function(v) Viper.Aimbot.WallCheck = v end)
        toggle("ESP Box", UDim2.new(0.55, 0, 0.2, 0), function(v) Viper.ESP.Enabled = v end)
        toggle("Big Hitbox", UDim2.new(0.55, 0, 0.4, 0), function(v) Viper.Misc.Hitbox = v and 10 or 2 end)

        -- (PERFORMANCE MODE)
        run.RenderStepped:Connect(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local char = p.Character
                    local hrp = char.HumanoidRootPart
                    
                    -- ESP BOX (RE-FIXED)
                    if Viper.ESP.Enabled then
                        if not char:FindFirstChild("ViperESP") then
                            local h = Instance.new("Highlight", char)
                            h.Name = "ViperESP"
                            h.FillTransparency = 0.5
                            h.OutlineColor = Color3.fromRGB(255, 0, 0)
                        end
                    else
                        if char:FindFirstChild("ViperESP") then char.ViperESP:Destroy() end
                    end

                    -- HITBOX
                    hrp.Size = Vector3.new(Viper.Misc.Hitbox, Viper.Misc.Hitbox, Viper.Misc.Hitbox)
                end
            end

            -- AIMBOT (NO LAG)
            if Viper.Aimbot.Enabled then
                local target = nil
                local dist = Viper.Aimbot.FOV
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= lp and p.Character and p.Character:FindFirstChild(Viper.Aimbot.Target) then
                        local part = p.Character[Viper.Aimbot.Target]
                        local pos, vis = cam:WorldToViewportPoint(part.Position)
                        if vis then
                            local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                            if mag < dist then
                                -- Wallcheck
                                local ray = Ray.new(cam.CFrame.Position, (part.Position - cam.CFrame.Position).Unit * 500)
                                local hit = workspace:FindPartOnRayWithIgnoreList(ray, {lp.Character, p.Character})
                                if not hit then target = part; dist = mag end
                            end
                        end
                    end
                end
                if target then cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Position), Viper.Aimbot.Smooth) end
            end
        end)
    end

    -- [[ 3. KEY CHECK ]] --
    kbtn.MouseButton1Click:Connect(function()
        if kinput.Text == "ViperIsTheBest" then
            kframe:Destroy()
            StartViper()
        else
            kbtn.Text = "FAIL"
            kbtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            task.wait(1)
            kbtn.Text = "LOGIN"
        end
    end)
end)
