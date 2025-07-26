repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character

local scripts = {
    [126884695634066] = "7a953911595e67e8494c3d3446b8be5b", 
    [126509999114328] = "c67687e7d7ae30e2e9fd5658f34e8292",
}

-- Load necessary services once
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- Load API and directly load the script
local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/untitled.lua"))()

-- Function to show notifications when needed
local function showNotification(text, color)
    -- Create a simple notification
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SimpleNotification"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    notification.BackgroundTransparency = 0.1
    notification.BorderSizePixel = 0
    notification.Size = UDim2.new(0.25, 0, 0.06, 0)
    notification.Position = UDim2.new(0.85, 0, 0.85, 0)
    notification.AnchorPoint = Vector2.new(0.5, 0.5)
    notification.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = notification

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "Text"
    textLabel.Text = text
    textLabel.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 14
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(0.9, 0, 0.8, 0)
    textLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    textLabel.Font = Enum.Font.GothamMedium
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notification

    -- Auto-remove after a few seconds
    task.delay(3, function()
        local tween = TweenService:Create(
            notification,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
        )
        
        local textTween = TweenService:Create(
            textLabel,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {TextTransparency = 1}
        )
        
        tween:Play()
        textTween:Play()
        
        task.delay(0.5, function()
            screenGui:Destroy()
        end)
    end)
end

-- Check if the game is supported and load directly
local url = scripts[game.PlaceId]
if url then
    api.script_id = url
    
    -- Set any stored key if available
    local success, storedKey = pcall(function()
        if readfile and isfile and isfile("NoLagKey.txt") then
            return readfile("NoLagKey.txt")
        end
        return nil
    end)
    
    if success and storedKey and #storedKey > 0 then
        api.key = storedKey
    else
        -- Generate a fake key
        api.key = HttpService:GenerateGUID(false):gsub("-", "")
    end
    
    -- Bypass the key system
    showNotification("Loading script...", Color3.fromRGB(85, 255, 85))
    
    -- Hook the check_key function to always return valid
    local original_check_key = api.check_key
    api.check_key = function(key)
        return {code = "KEY_VALID", message = "Success"}
    end
    
    -- Load the script
    task.spawn(function()
        api.load_script()
    end)
else
    showNotification("This game is not supported.", Color3.fromRGB(255, 85, 85))
end
