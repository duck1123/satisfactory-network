actions = {
   doDisableIron = function()
      local ironPole1 = component.proxy(registry.poles.iron[1])
      local ironPole2 = component.proxy(registry.poles.iron[2])
      local ironPole3 = component.proxy(registry.poles.iron[3])

      ironPole1:setConnected(false)
      ironPole2:setConnected(false)
      ironPole3:setConnected(false)
   end,

   doEnableIron = function()
      local ironPole1 = component.proxy(registry.poles.iron[1])
      local ironPole2 = component.proxy(registry.poles.iron[2])
      local ironPole3 = component.proxy(registry.poles.iron[3])

      ironPole1:setConnected(true)
      ironPole2:setConnected(true)
      ironPole3:setConnected(true)
   end,

   doFloodMessages = function()
      io.addMessage(computer.time())
      -- io.addMessage("a")
      -- io.addMessage("b")
      -- io.addMessage("c")
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
      local ironPole1 = component.proxy(registry.poles.iron[1])
      local ironPole2 = component.proxy(registry.poles.iron[2])
      local ironPole3 = component.proxy(registry.poles.iron[3])

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
         inspect.members(pole)
         connected = pole:isConnected()
         pole:setConnected(true)
      end
   end,

   doProcessInbox = function()
      local path = config.inboxDir
      local messages = filesystem.childs(path)

      for _, fileName in pairs(messages) do
         local fullPath = path .. "/" .. fileName
         events.processMessage(fullPath)
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

   getComponent = function(path, data)
      local id = data.id
      local c = component.proxy(id)

      if c ~= null then
         local types = c:getTypes()

         local response = {
            id = id,
            nick = c.nick,
            members = c:getMembers(),
            types = types,
         }

         for _, t in pairs(types) do
            -- print(t)

            if t == "Factory" then
               response.progress = c.progress
               response.powerConsumProducing = c.powerConsumProducing
               response.productivity = c.productivity
               response.cycleTime = c.cycleTime
               response.maxPotential = c.maxPotential
               response.minPotential = c.minPotential
               response.potential = c.potential
               response.standby = c.standby

               local inventories = c:getInventories()

               local inventoriesTable = {}
               for _, inventory in pairs(inventories) do
                  local inventoryTable = {
                     itemCount = inventory.itemCount,
                     size = inventory.size
                  }

                  local stacksTable = {}

                  for x=0, inventory.size - 1 do
                     local _, stack = inventory:getStack(x)
                     local item = stack.item

                     if item ~= nil then
                        local itemType = item.type

                        local stackTable = {
                           type = itemType:getName(),
                           count = stack.count,
                        }

                        table.insert(stacksTable, stackTable)
                     end
                  end

                  inventoryTable.slots = stacksTable

                  table.insert(inventoriesTable, inventoryTable)
                  -- inventoryTable[tostring(a)] = tostring(b)
               end

               response.inventories = inventoriesTable
            end

            if t == "Manufacturer" then
               -- print("Getting recipe")
               local recipe = c:getRecipe();

               local recipeTable = {
                  name = recipe:getName(),
                  duration = recipe:getDuration(),
               }

               -- inspect.table(recipeTable)
               response.recipe = recipeTable
            end

            if t == "NetworkCard" then
               print("Network Card")
            end

            if t == "TrainPlatform" then
               response.isUnloading = c.isUnloading
               response.isReversed = c.isReversed
               response.isLoading = c.isLoading
               response.fullLoad = c.fullLoad
               response.fullUnload = c.fullUnload
               response.trackPos = table.pack(c:getTrackPos())
            end
         end

         io.addCommand("get-component-response", response)
      else
         print("c i null")
      end
   end,

   getComponents = function(path, data)
      local action, id = table.unpack(data)
      local cs = component.findComponent("")

      local items = {}

      for _, item in pairs(cs) do
         table.insert(items, item)
      end

      local response = {
         items = items,
      }

      io.addCommand("get-components-response", response);
   end,

   getInfo = function(path, data)
      local action, id = table.unpack(data)
      local info = {}
      print(
         string.format(
            "getting info. path = %s, data = %s",
            path,
            data
         )
      )

      local c = component.proxy(id)

      info.nick = c.nick
      info.types = c:getTypes()
      info.location = table.pack(c:getLocation())

      inspect.table(info)
   end,
}
