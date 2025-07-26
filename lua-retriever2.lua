-- Hook loadstring
local old_loadstring = loadstring or load
loadstring = function(source, ...)
    print("Script Loaded:\n", source)
    return old_loadstring(source, ...)
end

-- Simple hook for HttpGet using a direct approach
-- Store the original HttpGet method
local old_HttpGet = game.HttpGet
-- Create a wrapper function
local function HttpGetHook(self, url, ...)
    -- Call the original method
    local success, result = pcall(function()
        return old_HttpGet(self, url, ...)
    end)
    
    -- Log the results
    if success then
        print("URL accessed:", url)
        if type(result) == "string" then
            local preview = result:sub(1, 200)
            print("Content preview:", preview .. (result:len() > 200 and "..." or ""))
        else
            print("Content received (not a string)")
        end
        return result
    else
        print("Error accessing URL:", url)
        print("Error message:", result)
        error(result)
    end
end

-- Try to replace the method
pcall(function()
    game.HttpGet = HttpGetHook
end)
