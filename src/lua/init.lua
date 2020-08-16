config = {
   -- inboxDir = "/inbox",
   inboxDir = "/outbox",
   logFile = "/log.txt",
   outboxDir = "/outbox",
}

function init()
   -- print("initializing library")
   filesystem.doFile("/registry.lua")
   filesystem.doFile("/io.lua")
   filesystem.doFile("/debug.lua")
   filesystem.doFile("/eventutils.lua")
   filesystem.doFile("/actions.lua")
   filesystem.doFile("/handlers.lua")
   filesystem.doFile("/events.lua")
   filesystem.doFile("/test.lua")
   -- print("done")
end
