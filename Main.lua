local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- VALIDATE DRAWING API
local isDrawingSupported = (typeof(Drawing) == "table" and Drawing.new ~= nil)

-- 1. SCREEN GUI MAIN
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ViperHub_V4"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- Gradient Maker Utility
local function applyDarkRedGradient(parent)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
    })
    grad.Rotation = 90
    grad.Parent = parent
end

-- ========================================== --
--          SETUP SCREEN (FULL ENGLISH)       --
-- ========================================== --

local SetupFrame = Instance.new("Frame")
SetupFrame.Name = "SetupFrame"
SetupFrame.Size = UDim2.new(0, 340, 0, 180)
SetupFrame.Position = UDim2.new(0.5, -170, 0.5, -90)
SetupFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SetupFrame.BorderSizePixel = 0
SetupFrame.Parent = ScreenGui

local SetupCorner = Instance.new("UICorner")
SetupCorner.CornerRadius = UDim.new(0, 10)
SetupCorner.Parent = SetupFrame

local SetupStroke = Instance.new("UIStroke")
SetupStroke.Thickness = 2
SetupStroke.Color = Color3.fromRGB(255, 0, 0)
SetupStroke.Parent = SetupFrame

applyDarkRedGradient(SetupFrame)

local QuestionText = Instance.new("TextLabel")
QuestionText.Size = UDim2.new(1, 0, 0, 50)
QuestionText.Position = UDim2.new(0, 0, 0, 10)
QuestionText.BackgroundTransparency = 1
QuestionText.Text = "Which device are you using?"
QuestionText.TextColor3 = Color3.fromRGB(255, 255, 255)
QuestionText.Font = Enum.Font.GothamBold
QuestionText.TextSize = 16
QuestionText.Parent = SetupFrame

-- RANDOM GREETINGS
local randomTexts = {
    "This is not a virus btw :D",
    "Hello! Welcome back.",
    "Loading the god power...",
    "Viper was here.",
    "Stay lethal, stay cool.",
    "Don't get banned lol"
}
local chosenText = randomTexts[math.random(1, #randomTexts)]

local SubText = Instance.new("TextLabel")
SubText.Size = UDim2.new(1, 0, 0, 20)
SubText.Position = UDim2.new(0, 0, 0, 60)
SubText.BackgroundTransparency = 1
SubText.Text = chosenText
SubText.TextColor3 = Color3.fromRGB(200, 200, 200)
SubText.Font = Enum.Font.GothamItalic
SubText.TextSize = 13
SubText.Parent = SetupFrame

local BtnPC = Instance.new("TextButton")
BtnPC.Size = UDim2.new(0, 130, 0, 45)
BtnPC.Position = UDim2.new(0, 25, 0, 110)
BtnPC.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BtnPC.Text = "COMPUTER"
BtnPC.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnPC.Font = Enum.Font.GothamBold
BtnPC.TextSize = 14
BtnPC.Parent = SetupFrame

local BtnPCCorner = Instance.new("UICorner")
BtnPCCorner.CornerRadius = UDim.new(0, 8)
BtnPCCorner.Parent = BtnPC

local BtnPhone = Instance.new("TextButton")
BtnPhone.Size = UDim2.new(0, 130, 0, 45)
BtnPhone.Position = UDim2.new(1, -155, 0, 110)
BtnPhone.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BtnPhone.Text = "MOBILE"
BtnPhone.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnPhone.Font = Enum.Font.GothamBold
BtnPhone.TextSize = 14
BtnPhone.Parent = SetupFrame

local BtnPhoneCorner = Instance.new("UICorner")
BtnPhoneCorner.CornerRadius = UDim.new(0, 8)
BtnPhoneCorner.Parent = BtnPhone

-- ========================================== --
--          MAIN HUB UI (CLEAN ENGLISH)       --
-- ========================================== --

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 460, 0, 500)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(255, 0, 0)
MainStroke.Parent = MainFrame

applyDarkRedGradient(MainFrame)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "VIPER HUB V4 -- APOCALYPSE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.Parent = MainFrame

-- TAB BAR
local TabBar = Instance.new("ScrollingFrame")
TabBar.Size = UDim2.new(1, -20, 0, 40)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundTransparency = 1
TabBar.ScrollBarThickness = 2
TabBar.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
TabBar.CanvasSize = UDim2.new(1.5, 0, 0, 0)
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 6)
TabListLayout.Parent = TabBar

--- ========================================== ---
---                 TAB CREATOR                ---
--- ========================================== ---

local tabs = {}
local pages = {}

local function createTab(tabName, isDefault)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0, 95, 1, 0)
    TabButton.BackgroundColor3 = isDefault and Color3.fromRGB(50, 0, 0) or Color3.fromRGB(25, 25, 25)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 11
    TabButton.Parent = TabBar

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = TabButton

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, -20, 1, -110)
    Page.Position = UDim2.new(0, 10, 0, 100)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 2
    Page.Visible = isDefault
    Page.Parent = MainFrame

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 6)
    PageLayout.Parent = Page

    TabButton.MouseButton1Click:Connect(function()
        for _, btn in pairs(tabs) do btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25) end
        for _, pg in pairs(pages) do pg.Visible = false end
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
        Page.Visible = true
    end)

    tabs[tabName] = TabButton
    pages[tabName] = Page
    return Page
end

local function addToggle(parentPage, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = "  " .. text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = parentPage

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
        btn.BackgroundColor3 = active and Color3.fromRGB(40, 0, 0) or Color3.fromRGB(20, 20, 20)
        callback(active)
    end)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
end

-- LOADING ENGINE
local function LoadHub(isMobile)
    SetupFrame:Destroy()
    MainFrame.Visible = true
    
    if isMobile then
        local MobileToggle = Instance.new("TextButton")
        MobileToggle.Size = UDim2.new(0, 50, 0, 50)
        MobileToggle.Position = UDim2.new(0, 15, 0.5, -25)
        MobileToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        MobileToggle.Text = "V4"
        MobileToggle.TextColor3 = Color3.fromRGB(255, 0, 0)
        MobileToggle.Font = Enum.Font.GothamBold
        MobileToggle.TextSize = 20
        MobileToggle.Active = true
        MobileToggle.Draggable = true
        MobileToggle.Parent = ScreenGui
        Instance.new("UICorner", MobileToggle).CornerRadius = UDim.new(1, 0)
        
        MobileToggle.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)
    end
end

BtnPC.MouseButton1Click:Connect(function() LoadHub(false) end)
BtnPhone.MouseButton1Click:Connect(function() LoadHub(true) end)

-- CREATE TABS
local CombatPage = createTab("Combat", true)
local ESPPage = createTab("Visuals", false)
local MovePage = createTab("Movement", false)
local MiscPage = createTab("Others", false)

-- ADDING TOGGLES
addToggle(CombatPage, "Aimbot (Right Click)", function(s) end)
addToggle(CombatPage, "Silent Aim", function(s) end)
addToggle(ESPPage, "Box ESP", function(s) end)
addToggle(ESPPage, "Health ESP", function(s) end)
addToggle(MovePage, "Speed Hack", function(s) end)
addToggle(MiscPage, "Anti-Void", function(s) end)
addToggle(MiscPage, "Full Bright", function(s) end)

-- CLOSE BUTTON
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 7)
Close.BackgroundTransparency = 1
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 0, 0)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 16
Close.Parent = MainFrame
Close.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
