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
   -- loc, loc2 = c:getLocation()

   -- print(loc)
   -- print(lo2)

   print(
      "Printing members for "
         .. tostring(c)
      -- .. " = "
      -- .. c.nick
   )
   local members = c:getMembers()
   debugTable(members)
end

function debugComponents(components)
   for _, c in pairs(comonents) do
      -- print(c)
      printMembers(c)
   end
end

function debugTypes(c)
   local types = c:getTypes()
   debugTable(types)
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

function debugInventory(inv)
   local itemCount = inv.itemCount
   print("item count: " .. itemCount .. " / " .. inv.size)

   for x=1,inv.size do
      local msg = "  " .. x .. ": "
      local _, stack = inv:getStack(x)

      if (stack ~= null) then
         local item = stack.item

         if (item ~= null) then
            msg = msg .. tostring(item.type) .. " - " .. stack.count
         else
            msg = msg .. "no item"
         end
      else
         msg = msg .. "empty"
      end

      -- log(msg)
      print(msg)
   end
end

function debugInventories(com, verbose)
   -- print("debugging inventories for " .. tostring(com))

   if (verbose == null or verbose) then
      print(tostring(com) .. ": ")
   end

   local inventories = com:getInventories()

   for i, inv in pairs(inventories) do
      if (verbose == null or verbose) then
         print("inventory " .. i .. ": ")
      end

      -- print(inv)
      debugInventory(inv)
   end
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

function doSplitterInfo(selector)
   local splitters = getComponents(selector)

   for _, c in pairs(splitters) do
      print(c)
      printMembers(c)
      print(c.potential)
      print(c:getProgress())
   end
end

function debugComponent(c)
   printMembers(c)
end

logFile = "/log.txt"

function listFiles()
   debugTable(filesystem.childs("/"))
end
