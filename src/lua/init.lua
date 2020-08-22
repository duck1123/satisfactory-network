function init()
   filesystem.doFile("/lib/string.split.lua")
   filesystem.doFile("/lib/event.lua")
   filesystem.doFile("/lib/thread.lua")
   filesystem.doFile("/lib/liveProgram.lua")

   filesystem.doFile("/config.lua")
   filesystem.doFile("/registry.lua")
   filesystem.doFile("/io.lua")
   filesystem.doFile("/inspect.lua")
   filesystem.doFile("/eventutils.lua")
   filesystem.doFile("/actions.lua")
   filesystem.doFile("/handlers.lua")
   filesystem.doFile("/events.lua")
   filesystem.doFile("/test.lua")

   assertDirectory(config.outboxDir)
   assertDirectory(config.inboxDir)

   registeredButtons = registerButtons()
   computer.beep()
end
