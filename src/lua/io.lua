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

function addMessage(message)
   local outboxDir = config.outboxDir

   if (not filesystem.exists(outboxDir)) then
      print("creating directory")
      filesystem.createDir(outboxDir)
   end

   local id = math.floor(computer.time() * 10)
   local index = 0
   local path
   local exists = true

   while exists do
      print(id .. "-" .. index)

      path = outboxDir
         .. "/"
         .. id
         .. "-"
         .. index
         .. ".txt"

      exists = filesystem.exists(path)
      index = index + 1
      -- if filesystem.exists(path) then
      --    print("already exists")
      -- end

   end


   writeData(path, message)
end

function processMessage(path)
   -- print("processing message: " .. path);
   local data = readData(path)
   print(data)
   return data
end

function processInbox()
   print("listing inbox")
   local path = config.outboxDir
   local messages = filesystem.childs(path)
   -- debugTable(messages)

   for _, fileName in pairs(messages) do
      local fullPath = path .. "/" .. fileName
      print(fileName)
      processMessage(fullPath)
      filesystem.remove(fullPath)
   end
end
