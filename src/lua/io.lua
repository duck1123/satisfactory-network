-- io.lua

io = {
   addMessage = function(message)
      local outboxDir = config.outboxDir
      local path = findAvailableFile(outboxDir)
      writeData(path, message)
   end,

   appendData = function(filename, data)
      local oldData = readData(filename)
      writeData(filename, oldData .. data)
   end,

   assertDirectory = function(path)
      if (not filesystem.exists(path)) then
         print("creating path: " .. path)
         filesystem.createDir(path)
      end

      return path
   end,

   findAvailableFile = function(baseDir)
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
   end,

   log = function(data)
      appendData(config.logFile, computer.time() .. " - " .. data .. "\n")
   end,

   readData = function(filename)
      local f = filesystem.open(filename, "r")
      local l = f:read("*all")
      f:close()
      return l
   end,

   writeData = function(filename, data)
      local f = filesystem.open(filename, "w")
      f:write(data)
      f:close()
   end,
}
