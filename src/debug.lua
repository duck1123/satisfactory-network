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

