-- io.lua

function readData(filename)
   local f = filesystem.open(filename, "r")
   local l = f:read("*all")
   f:close()
   return l
end

function writeData(filename, data)
   local f = filesystem.open(filename, "w")
   f:write(data)
   f:close()
end

function appendData(filename, data)
   local oldData = readData(filename)
   writeData(filename, oldData .. data)
end

function log(data)
   appendData(logFile, computer.time() .. " - " .. data .. "\n")
end

function findAvailableFile(baseDir)
   local id = math.floor(computer.time() * 10)
   local index = 0
   local path
   local exists = true

   while exists do
      path = string.format(
         "%s/%s-%s.txt",
         outboxDir,
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
      filesystem.createDir(path)
   end

   return path
end

function addMessage(message)
   local outboxDir = assertDirectory(config.outboxDir)
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

   return data
end

function processInbox()
   local path = config.outboxDir
   local messages = filesystem.childs(path)

   for _, fileName in pairs(messages) do
      local fullPath = path .. "/" .. fileName
      processMessage(fullPath)
      filesystem.remove(fullPath)
   end
end
