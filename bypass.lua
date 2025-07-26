--// Simple Custom Loader (No Key, No Check)
repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game:GetService("Players").LocalPlayer

--// Optional GUI notification
local function notify(msg)
    local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "LoaderNotification"

    local label = Instance.new("TextLabel", gui)
    label.Text = msg
    label.Size = UDim2.new(0.3, 0, 0.05, 0)
    label.Position = UDim2.new(0.35, 0, 0.9, 0)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    label.BackgroundTransparency = 0.3
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold

    task.delay(3, function() gui:Destroy() end)
end

-- Notify and load
notify("Loading No Lag Hub...")

local success, result = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/untitled.lua")
end)

if success then
    notify("Script loaded successfully!")
    loadstring(result)()
else
    notify("Failed to load script.")
    warn("Error loading No Lag Hub:", result)
end
