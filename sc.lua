-- SKYZOX SCRBX — MONOCHROME ANIMATED UI v2
-- Fitur mandiri: Speed, Noclip, Anti-AFK, Info Panel
-- Placeholder: Auto Break, Auto Steal, Safe Zone, Anti Security

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ================= THEME =================
local C = {
    Black   = Color3.fromRGB(0, 0, 0),
    Dark    = Color3.fromRGB(12, 12, 12),
    Panel   = Color3.fromRGB(22, 22, 22),
    Line    = Color3.fromRGB(55, 55, 55),
    White   = Color3.fromRGB(240, 240, 240),
    Gray    = Color3.fromRGB(140, 140, 140),
    Dim     = Color3.fromRGB(80, 80, 80),
}
local FONT      = Enum.Font.Gotham
local FONT_BOLD = Enum.Font.GothamBold
local FONT_MED  = Enum.Font.GothamMedium

-- ================= HELPERS =================
local function corner(o, r) local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 6); c.Parent=o; return c end
local function stroke(o, col, th, tr) local s=Instance.new("UIStroke"); s.Color=col or C.Line; s.Thickness=th or 1; s.Transparency=tr or 0.5; s.Parent=o; return s end
local function tw(o, t, p) TweenService:Create(o, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p):Play() end

-- ================= ROOT =================
local Gui = Instance.new("ScreenGui")
Gui.Name = "SCRBX_Mono_v2"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 999
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ================= SPLASH =================
local Splash = Instance.new("Frame")
Splash.Size = UDim2.fromScale(1,1)
Splash.BackgroundColor3 = C.Black
Splash.BorderSizePixel = 0
Splash.ZIndex = 50
Splash.Parent = Gui
local ST = Instance.new("TextLabel")
ST.Size = UDim2.fromScale(1,1); ST.BackgroundTransparency = 1
ST.Text = "S K Y Z O X"; ST.TextColor3 = C.White
ST.Font = FONT_BOLD; ST.TextSize = 26; ST.TextTransparency = 1; ST.ZIndex = 51
ST.Parent = Splash
tw(ST, 0.5, {TextTransparency = 0})
task.delay(0.7, function()
    tw(ST, 0.4, {TextTransparency = 1})
    tw(Splash, 0.5, {BackgroundTransparency = 1})
    task.delay(0.6, function() Splash:Destroy() end)
end)

-- ================= WINDOW =================
local Win = Instance.new("Frame")
Win.Size = UDim2.fromOffset(560, 420)
Win.Position = UDim2.new(0.5, -280, 0.5, -210)
Win.BackgroundColor3 = C.Dark
Win.BorderSizePixel = 0
Win.Active = true; Win.Draggable = true
Win.ClipsDescendants = true
Win.Parent = Gui
corner(Win, 10)
stroke(Win, C.Line, 1, 0.3)
Win.Size = UDim2.fromOffset(0,0)
task.spawn(function() tw(Win, 0.35, {Size = UDim2.fromOffset(560,420)}) end)

-- ================= TITLE BAR =================
local Bar = Instance.new("Frame")
Bar.Size = UDim2.new(1,0,0,44)
Bar.BackgroundColor3 = C.Black
Bar.BorderSizePixel = 0
Bar.Parent = Win
corner(Bar, 10)

local Line = Instance.new("Frame")
Line.Size = UDim2.new(1,0,0,1)
Line.Position = UDim2.new(0,0,1,-1)
Line.BackgroundColor3 = C.White
Line.BorderSizePixel = 0
Line.Parent = Bar
task.spawn(function()
    while Line.Parent do
        tw(Line, 1.2, {BackgroundTransparency = 0.7}); task.wait(1.2)
        tw(Line, 1.2, {BackgroundTransparency = 0}); task.wait(1.2)
    end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-90,1,0); Title.Position = UDim2.fromOffset(16,0)
Title.BackgroundTransparency = 1
Title.Text = "S K Y Z O X   ·   S C R B X   ·   O W N E R"
Title.TextColor3 = C.White; Title.Font = FONT_BOLD; Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Bar

local Dot = Instance.new("Frame")
Dot.Size = UDim2.fromOffset(8,8); Dot.Position = UDim2.new(1,-64,0.5,-4)
Dot.BackgroundColor3 = C.White; Dot.BorderSizePixel = 0
Dot.Parent = Bar; corner(Dot, 4)
task.spawn(function()
    while Dot.Parent do
        tw(Dot, 0.8, {BackgroundTransparency = 0.7}); task.wait(0.8)
        tw(Dot, 0.8, {BackgroundTransparency = 0}); task.wait(0.8)
    end
end)

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(28,28)
Close.Position = UDim2.new(1,-40,0.5,-14)
Close.BackgroundColor3 = C.Panel
Close.Text = "×"; Close.TextColor3 = C.White
Close.Font = FONT_BOLD; Close.TextSize = 20; Close.BorderSizePixel = 0
Close.Parent = Bar; corner(Close, 6)
Close.MouseEnter:Connect(function() tw(Close,0.15,{BackgroundColor3=C.White,TextColor3=C.Black}) end)
Close.MouseLeave:Connect(function() tw(Close,0.15,{BackgroundColor3=C.Panel,TextColor3=C.White}) end)
Close.MouseButton1Click:Connect(function()
    tw(Win, 0.25, {Size = UDim2.fromOffset(0,0)})
    task.delay(0.3, function() Gui:Destroy() end)
end)

-- ================= TAB BAR =================
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1,-28,0,32)
TabBar.Position = UDim2.fromOffset(14,54)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Win
local TL = Instance.new("UIListLayout"); TL.FillDirection = Enum.FillDirection.Horizontal; TL.Padding = UDim.new(0,6); TL.Parent = TabBar

-- ================= CONTENT =================
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1,-28,1,-104)
Content.Position = UDim2.fromOffset(14,94)
Content.BackgroundTransparency = 1; Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3; Content.ScrollBarImageColor3 = C.Gray
Content.CanvasSize = UDim2.new()
Content.Parent = Win
local CL = Instance.new("UIListLayout"); CL.Padding = UDim.new(0,8); CL.Parent = Content

-- ================= NOTIF =================
local NH = Instance.new("Frame")
NH.Size = UDim2.fromOffset(240,320)
NH.Position = UDim2.new(1,-252,0,54)
NH.BackgroundTransparency = 1
NH.Parent = Win
local NL = Instance.new("UIListLayout"); NL.Padding = UDim.new(0,6); NL.Parent = NH

local function Notify(msg)
    local n = Instance.new("Frame")
    n.Size = UDim2.new(1,0,0,30); n.BackgroundColor3 = C.Black
    n.BackgroundTransparency = 1; n.BorderSizePixel = 0; n.Parent = NH
    corner(n, 6)
    local s = stroke(n, C.White, 1, 1)
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1,-12,1,0); t.Position = UDim2.fromOffset(6,0)
    t.BackgroundTransparency = 1; t.Text = msg
    t.TextColor3 = C.White; t.Font = FONT_MED; t.TextSize = 10
    t.TextXAlignment = Enum.TextXAlignment.Left; t.TextTransparency = 1
    t.Parent = n
    tw(n, 0.25, {BackgroundTransparency = 0})
    tw(s, 0.25, {Transparency = 0.4})
    tw(t, 0.25, {TextTransparency = 0})
    task.delay(2.2, function()
        tw(n, 0.3, {BackgroundTransparency = 1})
        tw(s, 0.3, {Transparency = 1})
        tw(t, 0.3, {TextTransparency = 1})
        task.wait(0.35); n:Destroy()
    end)
end

-- ================= TAB FACTORY =================
local Tabs = {}
local Active = nil

local function Switch(name)
    for _, t in pairs(Tabs) do
        t.F.Visible = false; t.B.BackgroundColor3 = C.Panel; t.B.TextColor3 = C.Gray
    end
    local tab = Tabs[name]
    tab.F.Visible = true
    tab.B.BackgroundColor3 = C.White; tab.B.TextColor3 = C.Black
    Active = name
end

local function MakeTab(name)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(110,30); b.BackgroundColor3 = C.Panel
    b.Text = name; b.TextColor3 = C.Gray; b.Font = FONT_MED; b.TextSize = 10
    b.BorderSizePixel = 0; b.AutoButtonColor = false; b.Parent = TabBar; corner(b, 6)
    b.MouseEnter:Connect(function() if Active ~= name then tw(b,0.15,{BackgroundColor3=C.Dim,TextColor3=C.White}) end end)
    b.MouseLeave:Connect(function() if Active ~= name then tw(b,0.15,{BackgroundColor3=C.Panel,TextColor3=C.Gray}) end end)
    b.MouseButton1Click:Connect(function() Switch(name) end)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,0); f.BackgroundTransparency = 1; f.Visible = false; f.Parent = Content
    local fl = Instance.new("UIListLayout"); fl.Padding = UDim.new(0,8); fl.Parent = f
    Tabs[name] = {B=b, F=f}
    return Tabs[name]
end

-- ================= ROW FACTORY =================
local function Section(p, label)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,-8,0,16); f.BackgroundTransparency = 1; f.Parent = p
    local t = Instance.new("TextLabel")
    t.Size = UDim2.fromScale(1,1); t.BackgroundTransparency = 1
    t.Text = "— " .. label .. " —"; t.TextColor3 = C.Dim
    t.Font = FONT_BOLD; t.TextSize = 9; t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = f
end

local function Toggle(p, label, default, cb)
    local r = Instance.new("Frame")
    r.Size = UDim2.new(1,-8,0,34); r.BackgroundColor3 = C.Panel
    r.BorderSizePixel = 0; r.Parent = p; corner(r, 6); stroke(r, C.Line, 1, 0.6)
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1,-70,1,0); t.Position = UDim2.fromOffset(12,0)
    t.BackgroundTransparency = 1; t.Text = label
    t.TextColor3 = C.White; t.Font = FONT; t.TextSize = 11
    t.TextXAlignment = Enum.TextXAlignment.Left; t.Parent = r
    local pill = Instance.new("Frame")
    pill.Size = UDim2.fromOffset(40,20); pill.Position = UDim2.new(1,-52,0.5,-10)
    pill.BackgroundColor3 = C.Black; pill.BorderSizePixel = 0; pill.Parent = r
    corner(pill, 10); stroke(pill, C.Line, 1, 0.3)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(14,14); knob.Position = UDim2.fromOffset(3,3)
    knob.BackgroundColor3 = C.Gray; knob.BorderSizePixel = 0; knob.Parent = pill
    corner(knob, 7)
    local st = default
    local function render()
        if st then
            tw(pill, 0.18, {BackgroundColor3 = C.White})
            tw(knob, 0.18, {Position = UDim2.fromOffset(23,3), BackgroundColor3 = C.Black})
        else
            tw(pill, 0.18, {BackgroundColor3 = C.Black})
            tw(knob, 0.18, {Position = UDim2.fromOffset(3,3), BackgroundColor3 = C.Gray})
        end
    end
    render()
    pill.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            st = not st; render(); if cb then cb(st) end
        end
    end)
end

local function Button(p, label, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-8,0,32); b.BackgroundColor3 = C.Panel
    b.Text = label; b.TextColor3 = C.White; b.Font = FONT_MED; b.TextSize = 11
    b.BorderSizePixel = 0; b.AutoButtonColor = false; b.Parent = p; corner(b, 6)
    local s = stroke(b, C.Line, 1, 0.4)
    b.MouseEnter:Connect(function() tw(b,0.15,{BackgroundColor3=C.White,TextColor3=C.Black}); tw(s,0.15,{Transparency=1}) end)
    b.MouseLeave:Connect(function() tw(b,0.15,{BackgroundColor3=C.Panel,TextColor3=C.White}); tw(s,0.15,{Transparency=0.4}) end)
    b.MouseButton1Click:Connect(function() if cb then cb() end end)
end

-- ================= TAB 1 : AUTO STEAL (PLACEHOLDER) =================
local T1 = MakeTab("Auto Steal")
Section(T1.F, "BREAK & GRAB")
Toggle(T1.F, "Auto Break Egg", false, function(v)
    Notify("Break Egg: " .. (v and "ON" or "OFF"))
    -- [[ LOGIKA GAME: butuh nama RemoteEvent break dari eksplorasi ]]
end)
Toggle(T1.F, "Auto Ambil Hewan", false, function(v)
    Notify("Ambil Hewan: " .. (v and "ON" or "OFF"))
    -- [[ LOGIKA GAME: butuh nama ProximityPrompt / remote take ]]
end)
Toggle(T1.F, "Auto Safe Zone", false, function(v)
    Notify("Safe Zone: " .. (v and "ON" or "OFF"))
    -- [[ LOGIKA GAME: butuh CFrame safe zone dari Workspace ]]
end)
Toggle(T1.F, "Anti Security", false, function(v)
    Notify("Anti Security: " .. (v and "ON" or "OFF"))
    -- [[ LOGIKA GAME: butuh nama NPC guardian & logika jarak ]]
end)
Section(T1.F, "EKSEKUSI")
Button(T1.F, "▶  MULAI LOOP", function() Notify("Loop dimulai — isi logika game dulu") end)
Button(T1.F, "■  STOP LOOP", function() Notify("Loop dihentikan") end)

-- ================= TAB 2 : MOVEMENT (BERFUNGSI) =================
local T2 = MakeTab("Movement")
Section(T2.F, "GERAKAN")
Toggle(T2.F, "Speed Boost (60)", false, function(v)
    Notify("Speed: " .. (v and "ON" or "OFF"))
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = v and 60 or 16
end)
local noclipConn = nil
Toggle(T2.F, "Noclip", false, function(v)
    Notify("Noclip: " .. (v and "ON" or "OFF"))
    if v then
        noclipConn = RunService.Stepped:Connect(function()
            local c = LocalPlayer.Character
            if c then
                for _, p in ipairs(c:GetDescendants()) do
                    if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
    end
end)
Toggle(T2.F, "Anti AFK", false, function(v)
    Notify("Anti AFK: " .. (v and "ON" or "OFF"))
    if v then
        LocalPlayer.Idled:Connect(function()
            local vu = game:GetService("VirtualUser")
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end)
    end
end)

-- ================= TAB 3 : INFO =================
local T3 = MakeTab("Info")
Section(T3.F, "SESSION")
local info = Instance.new("TextLabel")
info.Size = UDim2.new(1,-8,0,120)
info.BackgroundColor3 = C.Panel
info.Text = "Executor : OK\nPlaceId  : " .. tostring(game.PlaceId) .. "\nJobId    : " .. string.sub(tostring(game.JobId),1,16) .. "…\nMode     : OWNER\n\nFitur Movement berfungsi.\nAuto Steal butuh isi\n[[ LOGIKA GAME ]] manual."
info.TextColor3 = C.Gray; info.Font = FONT; info.TextSize = 10
info.TextXAlignment = Enum.TextXAlignment.Left; info.TextYAlignment = Enum.TextYAlignment.Top
info.TextWrapped = true; info.Parent = T3.F; corner(info, 6)
local pad = Instance.new("UIPadding")
pad.PaddingLeft = UDim.new(0,10); pad.PaddingTop = UDim.new(0,10)
pad.Parent = info

Section(T3.F, "PANEL")
Button(T3.F, "Reset Posisi Window", function()
    tw(Win, 0.3, {Position = UDim2.new(0.5,-280,0.5,-210)})
    Notify("Window direset")
end)
Button(T3.F, "Tutup Panel", function()
    tw(Win, 0.25, {Size = UDim2.fromOffset(0,0)})
    task.delay(0.3, function() Gui:Destroy() end)
end)

-- ================= BOOT =================
Switch("Auto Steal")
task.delay(0.4, function() Notify("OWNER mode aktif") end)

CL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Content.CanvasSize = UDim2.new(0,0,0,CL.AbsoluteContentSize.Y + 20)
end)
