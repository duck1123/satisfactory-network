function init()
   -- print("initializing library")
   filesystem.doFile("/config.lua")
   filesystem.doFile("/registry.lua")
   filesystem.doFile("/io.lua")
   filesystem.doFile("/debug.lua")
   filesystem.doFile("/eventutils.lua")
   filesystem.doFile("/actions.lua")
   filesystem.doFile("/handlers.lua")
   filesystem.doFile("/events.lua")
   filesystem.doFile("/test.lua")

   assertDirectory(config.outboxDir)
   assertDirectory(config.inboxDir)

   -- print("done")
end
