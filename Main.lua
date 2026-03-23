-- [[ VIPER SYNDICATE - SECURE BUILD 3.5 ]] --
-- Fix Bug
pcall(function()
    local Viper = {
        Aimbot = {Enabled = false, Target = "Head", Smoothness = 0.05, FOVSize = 150},
        ESP = {Enabled = false, Box = false},
        Player = {Speed = 16, Fling = false}
    }

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")

    -- [[ 1. FULL SCREEN INTRO & KEY SYSTEM ]] --
    local IntroGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    IntroGui.DisplayOrder = 999
    
    local Blackout = Instance.new("Frame", IntroGui)
    Blackout.Size = UDim2.new(1, 0, 1, 0)
    Blackout.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    
    local HelloTxt = Instance.new("TextLabel", Blackout)
    HelloTxt.Size = UDim2.new(1, 0, 0.4, 0)
    HelloTxt.Position = UDim2.new(0, 0, 0.1, 0)
    HelloTxt.BackgroundTransparency = 1
    HelloTxt.Text = "Hello :D"
    HelloTxt.TextColor3 = Color3.fromRGB(255, 0, 0)
    HelloTxt.Font = Enum.Font.GothamBold
    HelloTxt.TextSize = 50

    -- KEY BOX SETUP
    local KeyFrame = Instance.new("Frame", Blackout)
    KeyFrame.Size = UDim2.new(0, 300, 0, 150)
    KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", KeyFrame)

    local KeyInput = Instance.new("TextBox", KeyFrame)
    KeyInput.Size = UDim2.new(0, 260, 0, 40)
    KeyInput.Position = UDim2.new(0, 20, 0, 30)
    KeyInput.PlaceholderText = "Enter Key Here..."
    KeyInput.Text = ""
    KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", KeyInput)

    local SubmitBtn = Instance.new("TextButton", KeyFrame)
    SubmitBtn.Size = UDim2.new(0, 260, 0, 40)
    SubmitBtn.Position = UDim2.new(0, 20, 0, 85)
    SubmitBtn.Text = "LOGIN"
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", SubmitBtn)

    -- [[ 2. MAIN HUB CONSTRUCTION (Hidden initially) ]] --
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Enabled = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 460, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -230, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Instance.new("UICorner", MainFrame)

    local ToggleIcon = Instance.new("TextButton", ScreenGui)
    ToggleIcon.Size = UDim2.new(0, 50, 0, 50)
    ToggleIcon.Position = UDim2.new(0, 15, 0.4, 0)
    ToggleIcon.Text = "V"
    ToggleIcon.BackgroundColor3 = Color3.fromRGB(25, 0, 0)
    ToggleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleIcon.Active = true ToggleIcon.Draggable = true
    Instance.new("UICorner", ToggleIcon).CornerRadius = UDim.new(1, 0)
    
    ToggleIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

    -- SIDEBAR & TAB SYSTEM (Simplified for Stability)
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 130, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", Sidebar)

    local PageHolder = Instance.new("Frame", MainFrame)
    PageHolder.Position = UDim2.new(0, 140, 0, 10)
    PageHolder.Size = UDim2.new(1, -150, 1, -20)
    PageHolder.BackgroundTransparency = 1

    local function CreateTab(name, order)
        local b = Instance.new("TextButton", Sidebar)
        b.Size = UDim2.new(1, -10, 0, 35)
        b.Position = UDim2.new(0, 5, 0, 20 + (order * 40))
        b.Text = name b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", b)
        local pg = Instance.new("ScrollingFrame", PageHolder)
        pg.Size = UDim2.new(1, 0, 1, 0)
        pg.Visible = false pg.BackgroundTransparency = 1
        pg.ScrollBarThickness = 0
        Instance.new("UIListLayout", pg).Padding = UDim.new(0, 5)
        b.MouseButton1Click:Connect(function()
            for _, p in pairs(PageHolder:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
            pg.Visible = true
        end)
        return pg
    end

    local function AddToggle(pnt, txt, cb)
        local b = Instance.new("TextButton", pnt)
        b.Size = UDim2.new(1, -10, 0, 40)
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

    -- SETUP PAGES
    local Combat = CreateTab("Combat", 0)
    AddToggle(Combat, "Aimbot", function(v) Viper.Aimbot.Enabled = v end)
    
    local PlayerTab = CreateTab("Player", 1)
    AddToggle(PlayerTab, "Walk Fling", function(v) Viper.Player.Fling = v end)

    -- [[ 3. KEY CHECK LOGIC ]] --
    SubmitBtn.MouseButton1Click:Connect(function()
        if KeyInput.Text == "ViperIsTheBest" then
            SubmitBtn.Text = "CORRECT!"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            task.wait(1)
            TweenService:Create(Blackout, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
            TweenService:Create(KeyFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            HelloTxt:Destroy() KeyFrame:Destroy()
            task.wait(1)
            IntroGui:Destroy()
            ScreenGui.Enabled = true -- Munculkan Hub
            PageHolder:GetChildren()[1].Visible = true
        else
            SubmitBtn.Text = "WRONG KEY!"
            task.wait(1)
            SubmitBtn.Text = "LOGIN"
        end
    end)

    -- [[ 4. CORE ENGINE ]] --
    RunService.RenderStepped:Connect(function()
        if Viper.Aimbot.Enabled then
            pcall(function()
                local target = nil
                local dist = Viper.Aimbot.FOVSize
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                        local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                        if vis then
                            local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                            if mag < dist then target = p.Character.Head; dist = mag end
                        end
                    end
                end
                if target then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), Viper.Aimbot.Smoothness) end
            end)
        end
        if Viper.Player.Fling then
            LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.new(0, 20000, 0)
        end
    end)
end)
