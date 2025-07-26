-- Wait for game to load
repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Player
local player = Players.LocalPlayer

-- Main GUI container
local gui = Instance.new("ScreenGui")
gui.Name = "NoLagUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Notification colors
local colors = {
    background = Color3.fromRGB(20, 20, 25),
    text = Color3.fromRGB(240, 240, 240),
    accent = Color3.fromRGB(255, 255, 255),
    success = Color3.fromRGB(85, 255, 85),
    error = Color3.fromRGB(255, 85, 85)
}

-- Simple notification
local function showNotification(text, color)
    color = color or colors.text
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0.3, 0, 0.05, 0)
    notification.Position = UDim2.new(0.5, -150, 0.9, 0)
    notification.BackgroundColor3 = colors.background
    notification.BackgroundTransparency = 0.2
    notification.TextColor3 = color
    notification.Text = text
    notification.Font = Enum.Font.GothamBold
    notification.TextSize = 16
    notification.AnchorPoint = Vector2.new(0.5, 0.5)
    notification.Parent = gui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 6)
    uiCorner.Parent = notification

    TweenService:Create(notification, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    task.wait(3)
    TweenService:Create(notification, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    task.delay(0.4, function() notification:Destroy() end)
end

-- ✅ Directly load the No-Lag script (no key system)
local success, err = pcall(function()
    showNotification("Loading No-Lag Script...", colors.accent)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/untitled.lua"))()
    showNotification("No-Lag Script Loaded!", colors.success)
end)

if not success then
    showNotification("Failed to load script.", colors.error)
    warn(err)
end
