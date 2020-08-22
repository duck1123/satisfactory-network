function getComponents(selector)
   return component.proxy(component.findComponent(selector))
end

function getComponent(selector)
   return getComponents(selector)[1]
end

inspect = {
   component = function(c)
      printMembers(c)
   end,

   components = function(components)
      for _, c in pairs(comonents) do
         printMembers(c)
      end
   end,

   connectors = function(panel)
      local connectors = panel:getFactoryConnectors()
      inspect.table(connectors)
   end,

   files = function()
      inspect.table(filesystem.childs("/"))
   end,

   gpus = function(screen)
      local gpus = computer.getGPUs()

      for i, gpu in pairs(gpus) do
         gpu:bindScreen(screen)
         print(gpu)
         gpu:setText(0, 0, "Hello World")
         gpu:flush()
      end
   end,

   inventories = function(com, verbose)
      if (verbose == null or verbose) then
         print(tostring(com) .. ": ")
      end

      local inventories = com:getInventories()

      for i, inv in pairs(inventories) do
         if (verbose == null or verbose) then
            print("inventory " .. i .. ": ")
         end

         inspect.inventory(inv)
      end
   end,

   inventory = function(inv)
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

         print(msg)
      end
   end,

   members = function(c)
      print(
         "Printing members for "
            .. tostring(c)
         -- .. " = "
         -- .. c.nick
      )

      local members = c:getMembers()
      inspect.table(members)
   end,

   modules = function(component)
      print("debugging modules: " .. tostring(component))
      for x=0,10 do
         for y=0,10 do
            local c = component:getModule(x,y)

            if c ~= nuil then
               print("x: " .. x .. ", y=" .. y .. ", c=" .. tostring(c))
            end
         end
      end
   end,

   network = function(c)
      local connectors = c:getNetworkConnectors()
      inspect.table(connectors)
   end,

   splitter = function(selector)
      local splitters = getComponents(selector)

      for _, c in pairs(splitters) do
         print(c)
         inspect.members(c)
         print(c.potential)
         print(c:getProgress())
      end
   end,

   table = function(table, depth)
      depth = depth or 0

      for id, value in pairs(table) do
         buf = ""

         for i=0,depth do
            buf = buf .. " "
         end

         buf = buf .. tostring(id)
         buf = buf .. ": "

         if type(value) == "table" then
            print(buf)
            inspect.table(value, depth + 2)
         else
            buf = buf .. tostring(value)
            print(buf)
         end
      end
   end,

   types = function(c)
      local types = c:getTypes()
      inspect.table(types)
   end,
}
