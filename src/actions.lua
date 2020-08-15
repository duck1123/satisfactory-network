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


function doEventLoop(panel, indicator)
   -- event.listen(panel)
   local button = panel:getModule(5, 5)
   -- button:setColor(0.3, 0.3, 0.3, 0.3)
   event.listen(button)

   printMembers(button)
   print("starting event loop")

   while true do
      computer.skip()
      e, s, arg1 = event.pull(1)
      
      -- if (e ~= nil) then
      -- 	 computer.beep()
      -- 	print(e)
      -- end
      
      if e == "Trigger" then
      	-- indicator:setColor(0, 1, 0, 5)
      	computer.beep()
      
      	local switch = getComponent("Power 3")
	printMembers(switch)
      	local connected = switch:isConnected()
	print(connected)
	
      	switch:setConnected(not(connected))
      	-- indicator:setColor(1, 0, 0, 5)
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
