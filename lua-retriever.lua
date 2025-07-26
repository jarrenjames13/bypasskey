-- Hook loadstring
local old_loadstring = loadstring or load
loadstring = function(source, ...)
    print("Script Loaded:\n", source)
    return old_loadstring(source, ...)
end

-- Hook HttpGet
local old_httpget = game.HttpGet
game.HttpGet = function(self, url, ...)
    local response = old_httpget(self, url, ...)
    print("URL:", url)
    print("Loaded Script:\n", response)
    return response
end
