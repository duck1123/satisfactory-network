actions = {
   doDisableIron =   function ()
      local ironPole1 = component.proxy(poles["iron"]["1"])
      local ironPole2 = component.proxy(poles["iron"]["2"])
      local ironPole3 = component.proxy(poles["iron"]["3"])

      ironPole1:setConnected(false)
      ironPole2:setConnected(false)
      ironPole3:setConnected(false)
   end,

   doEnableIron = function ()
      local ironPole1 = component.proxy(poles["iron"]["1"])
      local ironPole2 = component.proxy(poles["iron"]["2"])
      local ironPole3 = component.proxy(poles["iron"]["3"])

      ironPole1:setConnected(true)
      ironPole2:setConnected(true)
      ironPole3:setConnected(true)
   end,

   doFloodMessages = function()
      addMessage(computer.time())
      -- addMessage("a")
      -- addMessage("b")
      -- addMessage("c")
   end,

   doGetName = function(path, data)
      print(
         string.format(
            "get name: %s = %s",
            path,
            data
         )
      )
   end,

   doIndicator = function(selector)
      local components = getComponents(selector)

      for _, c in pairs(components) do
         c:setColor(0.6, 0.8, 0, 2)
      end
   end,

   doIronPoles = function()
      local ironPole1 = component.proxy(poles["iron"]["1"])
      local ironPole2 = component.proxy(poles["iron"]["2"])
      local ironPole3 = component.proxy(poles["iron"]["3"])

      print(ironPole1:isConnected())
      print(ironPole2:isConnected())
      print(ironPole3:isConnected())
      ironPole1:setConnected(false)
      ironPole2:setConnected(false)
      ironPole3:setConnected(false)
   end,

   doLightsOut = function()
      print("lights out")

      for _, id in pairs(registry.lights) do
         local light = component.proxy(id)
         light:setMode(0)
      end
   end,

   doLightsOn = function()
      print("lights on")

      for _, id in pairs(registry.lights) do
         local light = component.proxy(id)
         light:setMode(1)
      end
   end,

   doPanic = function()
      local c = component.proxy(registry.speakers[1])
      c:playSound("alarm")
   end,

   doPong = function()
      computer.beep()
   end,

   doPower = function(selector)
      local powerComponents = getComponents(selector)
      for _, pole in pairs(powerComponents) do
         printMembers(pole)
         connected = pole:isConnected()
         pole:setConnected(true)
      end
   end,

   doProcessInbox = function()
      local path = config.inboxDir
      local messages = filesystem.childs(path)

      for _, fileName in pairs(messages) do
         local fullPath = path .. "/" .. fileName
         processMessage(fullPath)
         filesystem.remove(fullPath)
      end
   end,

   doStorageReport = function(verbose)
      verbose = verbose == true

      for name, id in pairs(storage) do
         print(name .. ": ")
         local c = component.proxy(id)
         inspect.inventories(c, verbose)
      end
   end,

   getInfo = function(path, data)
      print(
         string.format(
            "getting info. path = %s, data = %s",
            path,
            data
         )
      )
   end,
}
