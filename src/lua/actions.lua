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

function handleButtonTrigger(eventName, button, arg1, buttonName)
   print("Handling button trigger: "
            .. tostring(eventName)
            .. ", "
            .. tostring(button)
            .. ", "
            .. buttonName
            .. ", "
            .. tostring(arg1))

   -- printMembers(button)
   computer.beep()
   -- log("beep")
end


function doEventLoop(panel, indicator)
   print("starting event loop")

   local buttonDefs = {
      {
         x = 2,
         y = 5,
         name = "button1"
      },
      -- {
      --    x = 5,
      --    y = 5,
      --    name = "button2"
      -- }
   }

   local buttons = {}

   local lastButton

   for _, def in pairs(buttonDefs) do
      local button = panel:getModule(def.x, def.y)

      if button ~= null then
         event.listen(button)
         buttons[button] = def.name
         print(buttons[button])
         lastButton = button
      else
         print("no button")
      end
   end

   -- debugTable(buttons)

   while true do
      computer.skip()
      eventName, button, arg1 = event.pull(1)

      if eventName == "Trigger" then
         print(button)
         print("Is last button: " .. tostring(button == lastButton))
         -- debugTable(buttons)
         local buttonName = buttons[button]
         print(buttonName)
         local lastButtonName = buttons[lastButton]
         print(lastButton)

         handleButtonTrigger(eventName, button, arg1, buttonName or "unknown")
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
