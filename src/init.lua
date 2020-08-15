function init()
   -- print("initializing library")
   filesystem.doFile("/registry.lua")
   filesystem.doFile("/debug.lua")
   filesystem.doFile("/actions.lua")
   filesystem.doFile("/test.lua")
   -- print("done")
end
   
