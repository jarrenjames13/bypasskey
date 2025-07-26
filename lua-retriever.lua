-- Hook loadstring
local old_loadstring = loadstring or load
loadstring = function(source, ...)
    print("Script Loaded:\n", source)
    return old_loadstring(source, ...)
end

-- Hook HttpGet
local old_httpget = game.HttpGet
if old_httpget then
    -- For older Roblox versions that might use dot notation
    game.HttpGet = function(self, url, ...)
        local response = old_httpget(self, url, ...)
        print("URL:", url)
        print("Loaded Script:\n", response)
        return response
    end
else
    -- For newer Roblox versions that use the proper method call with colon
    local mt = getmetatable(game)
    local old_index = mt.__index
    mt.__index = newcclosure(function(self, key)
        if key == "HttpGet" then
            return function(self, url, ...)
                local response = game:HttpGet(url, ...)
                print("URL:", url)
                print("Loaded Script:\n", response)
                return response
            end
        end
        return old_index(self, key)
    end)
end
