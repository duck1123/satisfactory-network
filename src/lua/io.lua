-- io.lua

function readData(filename)
   local f = filesystem.open(filename, "r")
   local l = f:read("*all")
   f:close()
   return l
end

function writeData(filename, data)
   -- print(string.format("Writing data: %s = %s", filename, data))
   local f = filesystem.open(filename, "w")
   f:write(data)
   f:close()
end

function appendData(filename, data)
   local oldData = readData(filename)
   writeData(filename, oldData .. data)
end

function log(data)
   appendData(config.logFile, computer.time() .. " - " .. data .. "\n")
end

function findAvailableFile(baseDir)
   local id = math.floor(computer.time() * 10)
   local index = 0
   local path
   local exists = true

   while exists do
      path = string.format(
         "%s/%s-%s.txt",
         baseDir,
         id,
         index
      )

      exists = filesystem.exists(path)
      index = index + 1
   end

   return path
end

function assertDirectory(path)
   if (not filesystem.exists(path)) then
      print("creating path: " .. path)
      filesystem.createDir(path)
   end

   return path
end

function addMessage(message)
   local outboxDir = config.outboxDir
   local path = findAvailableFile(outboxDir)
   writeData(path, message)
end

function processMessage(path)
   local data = readData(path)

   print(
      string.format(
         "processing message: %s - %s",
         path,
         data
      )
   )

   if data == "pong" then
      computer.beep()
   end

   if data == "lights-out" then
      print("lights out")

      for _, id in pairs(registry.lights) do
         local light = component.proxy(id)
         light:setMode(0)
         print(light:getMode())
         -- printMembers(light)

      end
   end

   if data == "lights-on" then
      print("lights on")

      for _, id in pairs(registry.lights) do
         local light = component.proxy(id)
         light:setMode(1)
         print(light:getMode())
         -- printMembers(light)
      end

   end

   return data
end
