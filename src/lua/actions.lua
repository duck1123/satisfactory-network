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


function doIndicator(selector)
   local components = getComponents(selector)

   for _, c in pairs(components) do
      print("Component: " .. tostring(c))
      printMembers(c)
      c:setColor(0.6, 0.8, 0, 2)
      print("")
   end
end

function handleButtonTrigger(eventName, button, arg1, path)
   print(
      string.format(
         "Handling button trigger: %s, %s, %s, %s",
         eventName,
         button,
         path,
         arg1
      )
   )

   if path ~= null then
      local matchedDef = null

      for _, def in pairs(registry.buttons) do
         if matchedDef == null and def.path == path then
            matchedDef = def
         end
      end

      if matchedDef ~= null then
         print(matchedDef.message)
      else
         print("no def")
      end
   else
      print("Path is not provided")
   end

   -- log("beep")
   computer.beep()
end

function floodMessages()
   addMessage(computer.time())
   addMessage("a")
   addMessage("b")
   addMessage("c")
end


function parsePath(path)
   -- print("Parsing path: " .. tostring(path))
   local pathInfo = {}
   local searchTable = registry
   local segments = {}

   for panelPath,_ in string.gmatch(path, "(.+)%[") do
      for segment,_ in string.gmatch(panelPath, "(%w+)") do
         table.insert(segments, segment)
      end
   end

   -- reduce segments to find the definition that matches the path
   for k, v in pairs(segments) do
      local subpath = searchTable[v]
      searchTable = subpath
   end

   pathInfo.id = searchTable.id

   -- Parse button coordinates
   for k, v in string.gmatch(path, "(%d+),(%d+)") do
      pathInfo.x = k
      pathInfo.y = v
   end

   return pathInfo
end

function listButtons()
   for _, def in pairs(registry.buttons) do
      local path = def.path
      local pathInfo = parsePath(path)
      debugTable(pathInfo)
   end
end

function doEventLoop()
   print("starting event loop")

   local registeredButtons = {}

   for _, def in pairs(registry.buttons) do
      local path = def.path
      local pathInfo = parsePath(path)
      local panel = component.proxy(pathInfo.id)

      if panel ~= null then
         local button = panel:getModule(pathInfo.x, pathInfo.y)

         if button ~= null then
            event.listen(button)
            registeredButtons[path] = button
         else
            print("no button")
         end
      else
         print("Could not find panel")
      end
   end

   -- debugTable(buttons)

   while true do
      computer.skip()
      eventName, button, arg1 = event.pull(1)

      if eventName == "Trigger" then
         local matchedPath = null

         for path, candidateButton in pairs(registeredButtons) do
            if matchedPath == null and button == candidateButton then
               matchedPath = path
            end
         end

         handleButtonTrigger(eventName, button, arg1, matchedPath)
      end
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

function enableIron()
   local ironPole1 = component.proxy(poles["iron"]["1"])
   local ironPole2 = component.proxy(poles["iron"]["2"])
   local ironPole3 = component.proxy(poles["iron"]["3"])

   ironPole1:setConnected(true)
   ironPole2:setConnected(true)
   ironPole3:setConnected(true)
end

function disableIron()
   local ironPole1 = component.proxy(poles["iron"]["1"])
   local ironPole2 = component.proxy(poles["iron"]["2"])
   local ironPole3 = component.proxy(poles["iron"]["3"])

   ironPole1:setConnected(false)
   ironPole2:setConnected(false)
   ironPole3:setConnected(false)
end

function storageReport(verbose)
   verbose = verbose == true

   for name, id in pairs(storage) do
      print(name .. ": ")
      local c = component.proxy(id)

      debugInventories(c, verbose)
   end
end
