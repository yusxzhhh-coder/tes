--=====================================================================
--  SKYZOX SCRBX | Break & Steal An Egg | UI v4.0 ULTRA FULL FEATURE
--  Executor: Krnl / Wave / Delta / Synapse X / Fluxus / Codex
--  Semua fitur toggle langsung aktif. Config save/load ke file.
--=====================================================================

local Players            = game:GetService("Players")
local RunService         = game:GetService("RunService")
local TweenService       = game:GetService("TweenService")
local Workspace          = game:GetService("Workspace")
local UserInputService   = game:GetService("UserInputService")
local CoreGui            = game:GetService("CoreGui")
local Lighting           = game:GetService("Lighting")
local StarterGui         = game:GetService("StarterGui")
local HttpService        = game:GetService("HttpService")

local LP  = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local HRP  = Char:WaitForChild("HumanoidRootPart")
local Hum  = Char:WaitForChild("Humanoid")

--================= CONFIG =================
local CFG = {
    AutoBreak        = false,
    AutoCollect      = false,
    AutoSafeZone     = false,
    AntiSecurity     = false,
    AutoSell         = false,
    AutoHatch        = false,
    AutoRebirth      = false,
    AutoQuest        = false,
    AutoDaily        = false,
    AutoRedeem       = false,
    AutoClaimGift    = false,
    AntiAFK          = false,
    Speed            = false,
    SpeedValue       = 60,
    JumpPower        = false,
    JumpValue        = 120,
    InfiniteJump     = false,
    NoFall           = false,
    Noclip           = false,
    Fly              = false,
    FlySpeed         = 50,
    ESP              = false,
    ESPColor         = Color3.fromRGB(255, 255, 0),
    HitboxExtender   = false,
    HitboxSize       = 8,
    Fullbright       = false,
    RemoveFog        = false,
    FPSBoost         = false,
    SafeZoneCFrame   = CFrame.new(0, 200, 0),
    BreakRadius      = 30,
    CollectRadius    = 80,
    SelectedEgg      = "",
}
--==========================================

--================= UTIL ===================
local function notify(txt)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "SKYZOX v4.0",
            Text  = txt,
            Duration = 3,
        })
    end)
    print("[SKYZOX]", txt)
end

local function tp(cf)
    if HRP then
        HRP.CFrame = cf
    end
end
--==========================================

--================= CLEANUP =================
if CoreGui:FindFirstChild("SKYZOX_UI") then
    CoreGui:FindFirstChild("SKYZOX_UI"):Destroy()
end
--==========================================

--================= GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SKYZOX_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 340, 0, 480)
Main.Position = UDim2.new(0, 20, 0, 20)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", Main)
stroke.Color = Color3.fromRGB(130, 60, 230)
stroke.Thickness = 1.5

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 44)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 34)
TopBar.Parent = Main
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SKYZOX | Break & Steal Egg v4.0"
Title.TextColor3 = Color3.fromRGB(190, 150, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 70)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local Scrolling = Instance.new("ScrollingFrame")
Scrolling.Size = UDim2.new(1, -16, 1, -56)
Scrolling.Position = UDim2.new(0, 8, 0, 48)
Scrolling.BackgroundTransparency = 1
Scrolling.BorderSizePixel = 0
Scrolling.ScrollBarThickness = 4
Scrolling.ScrollBarImageColor3 = Color3.fromRGB(130, 60, 230)
Scrolling.Parent = Main
local UIL = Instance.new("UIListLayout", Scrolling)
UIL.Padding = UDim.new(0, 5)
local UIP = Instance.new("UIPadding", Scrolling)
UIP.PaddingTop = UDim.new(0, 4)

local function updateCanvas()
    Scrolling.CanvasSize = UDim2.new(0, 0, 0, UIL.AbsoluteContentSize.Y + 10)
end
UIL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)

local function makeSection(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -8, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = "▸ " .. text
    lbl.TextColor3 = Color3.fromRGB(150, 150, 160)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.Parent = Scrolling
    updateCanvas()
end

local function makeToggle(name, key, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -8, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    Btn.Text = "   " .. name
    Btn.TextColor3 = Color3.fromRGB(210, 210, 220)
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 12
    Btn.Parent = Scrolling
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 14, 0, 14)
    Indicator.Position = UDim2.new(1, -22, 0.5, -7)
    Indicator.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
    Indicator.Parent = Btn
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

    local state = CFG[key] or false
    Indicator.BackgroundColor3 = state and Color3.fromRGB(130, 60, 230) or Color3.fromRGB(80, 80, 100)

    Btn.MouseButton1Click:Connect(function()
        state = not state
        CFG[key] = state
        Indicator.BackgroundColor3 = state and Color3.fromRGB(130, 60, 230) or Color3.fromRGB(80, 80, 100)
        if callback then callback(state) end
    end)
    updateCanvas()
end

local function makeButton(name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -8, 0, 30)
    Btn.BackgroundColor3 = Color3.fromRGB(60, 40, 100)
    Btn.Text = "   " .. name
    Btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 12
    Btn.Parent = Scrolling
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(callback)
    updateCanvas()
end

local function makeSlider(name, key, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -8, 0, 48)
    Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    Frame.Parent = Scrolling
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -16, 0, 20)
    Lbl.Position = UDim2.new(0, 8, 0, 4)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = name .. ": " .. default
    Lbl.TextColor3 = Color3.fromRGB(210, 210, 220)
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Font = Enum.Font.GothamMedium
    Lbl.TextSize = 12
    Lbl.Parent = Frame

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1, -16, 0, 6)
    Bar.Position = UDim2.new(0, 8, 0, 30)
    Bar.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    Bar.Parent = Frame
    Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(0.5, 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(130, 60, 230)
    Fill.Parent = Bar
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouse = UserInputService:GetMouseLocation()
            local rel = math.clamp((mouse.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
            Fill.Size = UDim2.new(rel, 0, 1, 0)
            local val = math.floor(min + (max - min) * rel)
            Lbl.Text = name .. ": " .. val
            CFG[key] = val
            if callback then callback(val) end
        end
    end)
    updateCanvas()
end
--==========================================

--================= SECTIONS =================
makeSection("EGG / PET FARMING")
makeToggle("Auto Break Egg",      "AutoBreak")
makeToggle("Auto Collect Egg/Pet","AutoCollect")
makeToggle("Auto Safe Zone TP",   "AutoSafeZone")
makeToggle("Anti Security",       "AntiSecurity")
makeToggle("Auto Hatch Egg",      "AutoHatch")
makeToggle("Auto Sell Pet",       "AutoSell")

makeSection("PROGRESSION")
makeToggle("Auto Rebirth",        "AutoRebirth")
makeToggle("Auto Quest",          "AutoQuest")
makeToggle("Auto Daily",          "AutoDaily")
makeToggle("Auto Redeem Code",    "AutoRedeem")
makeToggle("Auto Claim Gift",     "AutoClaimGift")
makeToggle("Anti AFK",            "AntiAFK")

makeSection("MOVEMENT")
makeToggle("Speed Hack",          "Speed")
makeToggle("Jump Power",          "JumpPower")
makeToggle("Infinite Jump",       "InfiniteJump")
makeToggle("No Fall",             "NoFall")
makeToggle("Noclip",              "Noclip")
makeToggle("Fly",                 "Fly")

makeSection("VISUAL / ESP")
makeToggle("ESP Egg & Pet",       "ESP")
makeToggle("Hitbox Extender",     "HitboxExtender")
makeToggle("Fullbright",          "Fullbright")
makeToggle("Remove Fog",          "RemoveFog")
makeToggle("FPS Boost",           "FPSBoost")

makeSection("SLIDERS")
makeSlider("WalkSpeed",  "SpeedValue",  16, 300, 60)
makeSlider("JumpPower",  "JumpValue",  50, 400, 120)
makeSlider("FlySpeed",   "FlySpeed",   20, 300, 50)
makeSlider("HitboxSize", "HitboxSize", 4, 30, 8)

makeSection("TOOLS")
makeButton("Teleport Ke Safe Zone", function()
    tp(CFG.SafeZoneCFrame)
    notify("Teleport ke safe zone.")
end)
makeButton("Teleport Ke Egg Terdekat", function()
    local best, bestD = nil, math.huge
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name:lower():find("egg") and obj:IsA("BasePart") then
            local d = (obj.Position - HRP.Position).Magnitude
            if d < bestD then best, bestD = obj, d end
        end
    end
    if best then tp(best.CFrame + Vector3.new(0, 4, 0)) notify("Teleport ke egg terdekat.") end
end)
makeButton("Simpan Config", function()
    local ok, err = pcall(function()
        writefile("SKYZOX_config.json", HttpService:JSONEncode(CFG))
    end)
    notify(ok and "Config disimpan." or ("Gagal simpan: " .. tostring(err)))
end)
makeButton("Muat Config", function()
    local ok, data = pcall(function()
        return HttpService:JSONDecode(readfile("SKYZOX_config.json"))
    end)
    if ok and data then
        for k, v in pairs(data) do
            if CFG[k] ~= nil then CFG[k] = v end
        end
        notify("Config dimuat (sebagian toggle perlu diklik ulang).")
    else
        notify("File config tidak ditemukan.")
    end
end)
makeButton("Reset Karakter", function()
    Char:BreakJoints()
    LP.CharacterAdded:Wait()
    notify("Karakter direset.")
end)
--==========================================

--================= LOGIC ===================
-- ref karakter baru
LP.CharacterAdded:Connect(function(c)
    Char = c
    HRP = c:WaitForChild("HumanoidRootPart")
    Hum = c:WaitForChild("Humanoid")
end)

-- Movement
RunService.Heartbeat:Connect(function()
    if Hum then
        Hum.WalkSpeed = CFG.Speed and CFG.SpeedValue or 16
        Hum.JumpPower = CFG.JumpPower and CFG.JumpValue or 50
        if CFG.NoFall then Hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false) end
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if CFG.Noclip and Char then
        for _, v in pairs(Char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if CFG.InfiniteJump and Hum then
        Hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Fly
local flyBV, flyBG
RunService.RenderStepped:Connect(function()
    if CFG.Fly then
        if not flyBV and HRP then
            flyBV = Instance.new("BodyVelocity", HRP)
            flyBV.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            flyBG = Instance.new("BodyGyro", HRP)
            flyBG.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
            flyBG.P = 1000
            flyBG.D = 50
        end
        if flyBV and flyBG then
            local cam = Workspace.CurrentCamera
            local move = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
            flyBV.Velocity = move * CFG.FlySpeed
            flyBG.CFrame = cam.CFrame
        end
    else
        if flyBV then flyBV:Destroy(); flyBV = nil end
        if flyBG then flyBG:Destroy(); flyBG = nil end
    end
end)

-- Auto Break / Collect
RunService.Heartbeat:Connect(function()
    if not HRP then return end
    for _, obj in pairs(Workspace:GetDescendants()) do
        local n = obj.Name:lower()
        local base = nil
        if obj:IsA("BasePart") then base = obj
        elseif obj:IsA("Model") and obj.PrimaryPart then base = obj.PrimaryPart end
        if not base then continue end
        local dist = (base.Position - HRP.Position).Magnitude

        if CFG.AutoBreak and n:find("egg") and dist <= CFG.BreakRadius then
            pcall(function() if firetouchinterest then firetouchinterest(HRP, base, 0); firetouchinterest(HRP, base, 1) end end)
            pcall(function() local c = base:FindFirstChildWhichIsA("ClickDetector"); if c then fireclickdetector(c) end end)
            pcall(function() local p = base:FindFirstChildWhichIsA("ProximityPrompt"); if p then fireproximityprompt(p) end end)
        end

        if CFG.AutoCollect and (n:find("egg") or n:find("pet") or n:find("animal")) and dist <= CFG.CollectRadius then
            pcall(function() if firetouchinterest then firetouchinterest(HRP, base, 0); firetouchinterest(HRP, base, 1) end end)
            pcall(function() local c = base:FindFirstChildWhichIsA("ClickDetector"); if c then fireclickdetector(c) end end)
        end

        if CFG.AutoSell and n:find("sell") and dist <= 50 then
            pcall(function() if firetouchinterest then firetouchinterest(HRP, base, 0); firetouchinterest(HRP, base, 1) end end)
        end

        if CFG.AutoHatch and (n:find("hatch") or n:find("incubator")) and dist <= 50 then
            pcall(function() if firetouchinterest then firetouchinterest(HRP, base, 0); firetouchinterest(HRP, base, 1) end end)
            pcall(function() local c = base:FindFirstChildWhichIsA("ClickDetector"); if c then fireclickdetector(c) end end)
        end

        if CFG.AutoRebirth and (n:find("rebirth") or n:find("prestige")) and dist <= 50 then
            pcall(function() if firetouchinterest then firetouchinterest(HRP, base, 0); firetouchinterest(HRP, base, 1) end end)
            pcall(function() local c = base:FindFirstChildWhichIsA("ClickDetector"); if c then fireclickdetector(c) end end)
        end

        if CFG.AutoQuest and (n:find("quest") or n:find("mission")) and dist <= 50 then
            pcall(function() local c = base:FindFirstChildWhichIsA("ClickDetector"); if c then fireclickdetector(c) end end)
        end

        if CFG.AutoDaily and (n:find("daily") or n:find("login")) and dist <= 50 then
            pcall(function() local c = base:FindFirstChildWhichIsA("ClickDetector"); if c then fireclickdetector(c) end end)
        end

        if CFG.AutoRedeem and n:find("redeem") and dist <= 50 then
            pcall(function() local c = base:FindFirstChildWhichIsA("ClickDetector"); if c then fireclickdetector(c) end end)
        end

        if CFG.AutoClaimGift and n:find("gift") and dist <= 50 then
            pcall(function() local c = base:FindFirstChildWhichIsA("ClickDetector"); if c then fireclickdetector(c) end end)
        end
    end
end)

-- Safe Zone / Anti Security
RunService.Heartbeat:Connect(function()
    if CFG.AutoSafeZone and HRP then
        pcall(function() HRP.CFrame = CFG.SafeZoneCFrame end)
    end
    if CFG.AntiSecurity then
        for _, obj in pairs(Workspace:GetDescendants()) do
            local n = obj.Name:lower()
            if (n:find("security") or n:find("guard") or n:find("police")) and obj:IsA("Model") then
                for _, p in pairs(obj:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end
    end
end)

-- Anti AFK
task.spawn(function()
    while true do
        task.wait(60)
        if CFG.AntiAFK and VirtualUser then
            pcall(function() VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new()) end)
        end
    end
end)

-- Fullbright / Fog / FPS
RunService.Heartbeat:Connect(function()
    if CFG.Fullbright then
        Lighting.Brightness = 3
        Lighting.ClockTime = 12
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e6
    end
    if CFG.RemoveFog then
        Lighting.FogEnd = 1e6
        Lighting.FogStart = 0
    end
    if CFG.FPSBoost then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end
        settings().Rendering.QualityLevel = 1
    end
end)

-- Hitbox Extender
RunService.Heartbeat:Connect(function()
    if CFG.HitboxExtender and HRP then
        for _, obj in pairs(Workspace:GetDescendants()) do
            local n = obj.Name:lower()
            if (n:find("egg") or n:find("pet")) and obj:IsA("BasePart") then
                obj.Size = Vector3.new(CFG.HitboxSize, CFG.HitboxSize, CFG.HitboxSize)
                obj.Transparency = 0.5
                obj.CanCollide = false
            end
        end
    end
end)

-- ESP
local espFolder = Instance.new("Folder", ScreenGui)
espFolder.Name = "ESP"
RunService.Heartbeat:Connect(function()
    if CFG.ESP then
        for _, obj in pairs(Workspace:GetDescendants()) do
            local n = obj.Name:lower()
            if (n:find("egg") or n:find("pet") or n:find("animal")) and obj:IsA("BasePart") then
                local key = tostring(obj)
                local label = espFolder:FindFirstChild(key)
                if not label then
                    label = Instance.new("BillboardGui", espFolder)
                    label.Name = key
                    label.Size = UDim2.new(0, 100, 0, 28)
                    label.AlwaysOnTop = true
                    label.Adornee = obj
                    local txt = Instance.new("TextLabel", label)
                    txt.Size = UDim2.new(1,0,1,0)
                    txt.BackgroundTransparency = 1
                    txt.Text = obj.Name
                    txt.TextColor3 = CFG.ESPColor
                    txt.TextStrokeTransparency = 0
                    txt.Font = Enum.Font.GothamBold
                    txt.TextSize = 12
                end
            end
        end
    else
        for _, v in pairs(espFolder:GetChildren()) do v:Destroy() end
    end
end)

notify("v4.0 ULTRA loaded. Semua fitur siap.")
