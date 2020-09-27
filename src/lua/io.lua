-- io.lua

io = {
   addCommand = function(command, args)
      local response = args
      response.command = command
      local msg = toEdn(response)
      computer.skip()
      print(msg)
      io.addMessage(msg)
   end,

   addMessage = function(message)
      -- print("Adding message: " .. message)
      local outboxDir = config.outboxDir
      local path = io.findAvailableFile(outboxDir)
      io.writeData(path, message)
   end,

   appendData = function(filename, data)
      local oldData = io.readData(filename)
      io.writeData(filename, oldData .. data)
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


   listFiles = function()
      inspect.table(filesystem.childs("/"))
   end,

   log = function(data)
      io.appendData(config.logFile, computer.time() .. " - " .. data .. "\n")
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
