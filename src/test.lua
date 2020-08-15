-- function initFilesystem()
--   print("init filesystem")
--   filesystem.initFileSystem("/dev")
--   filesystem.mount("/dev/" .. filesystem.childs("/dev")[1], "/")
--   local status = pcall(filesystem.doFile, "/test.lua")
--   print(status)
-- end

-- function myerrorhandler( err )
--    print( "ERROR:", err )
-- end

-- if xpcall(initFilesystem, myerrorhandler) then
--    print("Success loading")
-- else
-- 	print("Failure loading")
-- end

-- main()

screens = {}
screens["1"] = "172E208247AF6A4B655F78961EB6BCEB"

miners = {}
miners["iron"] = {}
miners["iron"]["1"] = {}
miners["iron"]["1"]["1"] = "DA93CF4F4DC76AA6815C72ABE0FEFF01"
miners["iron"]["1"]["2"] = "39002A9041DC5E70AA42728795595C66"
miners["iron"]["1"]["3"] = "B40B97D8430DF848A34473BB4687CCE0"

smelters = {}
smelters["floor2"] = {}
smelters["floor2"]["1"] = "2668BF8A4E3A531D964FCDAFD08C6ADE"
smelters["floor2"]["2"] = "ECEBAF0D480B369CFBA8D587A51F793C"
smelters["floor2"]["3"] = "CE9B96EB4BBDB870DCBA3198DDED1750"
smelters["floor2"]["4"] = "A364C40443FFEABAA3B8AD94BD67EFA6"


poles = {}
poles["floor"] = {}
poles["floor"]["2"] = "B42E2B5F434CADD7A89DB7A3CB3177A7"
poles["floor"]["3"] = "6CB7A6704FC217A24588FA83E3F24F47"
poles["floor"]["4"] = "03EA52734F28F3640AB020939F56381E"

poles["oil"] = {}
poles["oil"]["1"] = "E01184684657F94603C68AB3D2DA0DDC"
poles["copper"] = {}

-- baz2
poles["iron"] = {}
poles["iron"]["1"] = "6EB1A32C4CB7A331A1330B931152249C"
poles["iron"]["2"] = "93331AD848E087108D885B9966808D9E"
poles["iron"]["3"] = "96482685425DE5D39A6862BFD4E9D0BB"


jumpPads = {}
jumpPads["1"] = "3356F3C848F3544EE89074A5BE6A175E"


computers = {}
computers["main"] = "D71ED6D54F6D9DC705D380BD19E4D34F"
computers["floor2"] = "CCAB02D9441F2A2CCF42FAA698AF8C0A"

storage = {}
storage["pipe"] = "95614C8641349210FF8682BB7A9783BE"
storage["rubber"] = "F16835D140C3DDACC0CECBB66C36CED0"
storage["rotor"] = "9A76E21A48FFCED4312F42BDA4A24972"
storage["computer"] = "0C2A83674E98BD7C72847AA8B488F9BF"
storage["motor"] = "F3E2B0E145C8B13D8CC605B7F57C2C61"
storage["circuit"] = "86AA37014D5B0FF9645F25B93CE98CBE"
storage["frame"] = "3571FDDA45EA9D1238A88DBCC001B506"

stations = {}
stations["main"] = "5E7971EE464911F98258D89694BD84F4"


function getComponents(selector)
   return component.proxy(component.findComponent(selector))
end

function getComponent(selector)
   return getComponents(selector)[1]
end

function debugTable(t)
   for id, value in pairs(t) do
      print("  " .. id .. ": " .. tostring(value))
   end
end

function printMembers(c)
   print("Printing members for " .. tostring(c))
   local members = c:getMembers()
   debugTable(members)
end

function debugComponents(components)
   for _, c in pairs(comonents) do
      -- print(c)
      printMembers(c)
   end
end

function debugConnectors(panel)
   local connectors = panel:getFactoryConnectors()
   print("Printing connectors for: " .. tostring(connectors))
   debugTable(connectors)
end

function debugNetwork(c)
   local connectors = c:getNetworkConnectors()
   print("Printing network connectors for: " .. tostring(connectors))
   debugTable(connectors)
end

function debugInventories(com)
   -- print(com:getInventories())
   local inventories = com:getInventories()
   print(inventories)
   debugTable(inventories)
end

function debugModules(component)
   print("debugging modules: " .. tostring(component))
   for x=0,10 do
      for y=0,10 do
	 local c = component:getModule(x,y)

	 if c ~= nuil then
	    print("x: " .. x .. ", y=" .. y .. ", c=" .. tostring(c))
	    -- printMembers(c)
	 end
      end
   end
end

function debugGpus(screen)
   local gpus = computer.getGPUs()

   for i, gpu in pairs(gpus) do
      gpu:bindScreen(screen)
      print(gpu)
      gpu:setText(0, 0, "Hello World")
      gpu:flush()
   end
end

function debugInventory(inv)
   print("Debugging inventory: " .. tostring(inv))

   printMembers(inv)
end


function doSplitterInfo(selector)
   local splitters = getComponents(selector)

   for _, c in pairs(splitters) do
      print(c)
      printMembers(c)
      print(c.potential)
      print(c:getProgress())
   end
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

function main()
   -- print("Hello World")
   local panel = getComponent("Panel")
   local indicator = getComponent("Indicator")
   
   local screen = panel:getModule(0, 0)
   
   -- printMembers(panel)
   
   debugModules(panel)
   -- debugGpus(screen)
   -- debugConnectors(panel)
   -- debugNetwork(panel)
   -- debugInventories(panel)

   -- doPower("Power")
  
   -- doSplitterInfo("Splitter")
   -- doIndicator("Indicator")

   doEventLoop(panel, indicator)

   computer.beep()
end
