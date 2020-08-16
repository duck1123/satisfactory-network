function doDisableIron()
   local ironPole1 = component.proxy(poles["iron"]["1"])
   local ironPole2 = component.proxy(poles["iron"]["2"])
   local ironPole3 = component.proxy(poles["iron"]["3"])

   ironPole1:setConnected(false)
   ironPole2:setConnected(false)
   ironPole3:setConnected(false)
end

function doEnableIron()
   local ironPole1 = component.proxy(poles["iron"]["1"])
   local ironPole2 = component.proxy(poles["iron"]["2"])
   local ironPole3 = component.proxy(poles["iron"]["3"])

   ironPole1:setConnected(true)
   ironPole2:setConnected(true)
   ironPole3:setConnected(true)
end

function doFloodMessages()
   addMessage(computer.time())
   -- addMessage("a")
   -- addMessage("b")
   -- addMessage("c")
end

function doIndicator(selector)
   local components = getComponents(selector)

   for _, c in pairs(components) do
      print("Component: " .. tostring(c))
      printMembers(c)
      c:setColor(0.6, 0.8, 0, 2)
      print("")
   end
end

function doIronPoles()
   local ironPole1 = component.proxy(poles["iron"]["1"])
   local ironPole2 = component.proxy(poles["iron"]["2"])
   local ironPole3 = component.proxy(poles["iron"]["3"])

   print(ironPole1:isConnected())
   print(ironPole2:isConnected())
   print(ironPole3:isConnected())
   ironPole1:setConnected(false)
   ironPole2:setConnected(false)
   ironPole3:setConnected(false)
end

function doPower(selector)
   local powerComponents = getComponents(selector)
   for _, pole in pairs(powerComponents) do
      printMembers(pole)
      connected = pole:isConnected()
      pole:setConnected(true)
      print(connected)
      print("Connected: " .. tostring(pole:isConnected()))
      -- print(component.proxy(c))
   end
end

function doProcessInbox()
   local path = config.inboxDir
   local messages = filesystem.childs(path)

   for _, fileName in pairs(messages) do
      local fullPath = path .. "/" .. fileName
      processMessage(fullPath)
      filesystem.remove(fullPath)
   end
end

function doStorageReport(verbose)
   verbose = verbose == true

   for name, id in pairs(storage) do
      print(name .. ": ")
      local c = component.proxy(id)

      debugInventories(c, verbose)
   end
end

actions = {
   doLightsOut = function()
      print("lights out")

      for _, id in pairs(registry.lights) do
         local light = component.proxy(id)
         light:setMode(0)
         print(light:getMode())
         -- printMembers(light)

      end

   end,

   doLightsOn = function()
      print("lights on")

      for _, id in pairs(registry.lights) do
         local light = component.proxy(id)
         light:setMode(1)
         print(light:getMode())
         -- printMembers(light)
      end
   end,

   doPanic = function()
      local c = component.proxy(registry.speakers[1])
      c:playSound("alarm")

   end,

   doPong = function()
      computer.beep()
   end,
}
