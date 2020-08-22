lastLoad = lastLoad or 0

function init()
   local now = computer.millis()
   local diff = now - lastLoad

   if lastLoad == 0 or diff > 1000 then
      event.ignoreAll()
      event.clear()

      filesystem.doFile("/lib/string.split.lua")
      filesystem.doFile("/config.lua")
      filesystem.doFile("/registry.lua")
      filesystem.doFile("/io.lua")
      filesystem.doFile("/inspect.lua")
      filesystem.doFile("/eventutils.lua")
      filesystem.doFile("/actions.lua")
      filesystem.doFile("/handlers.lua")
      filesystem.doFile("/events.lua")

      io.assertDirectory(config.outboxDir)
      io.assertDirectory(config.inboxDir)

      registeredButtons = registerButtons()
      computer.beep()
   end

   lastLoad = now
end
