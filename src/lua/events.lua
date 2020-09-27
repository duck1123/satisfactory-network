events = {
   handleButtonTrigger = function(eventName, button, arg1, def)
      -- print(
      --    string.format(
      --       "Handling button trigger: %s, %s, %s, %s",
      --       eventName,
      --       button,
      --       def,
      --       arg1
      --    )
      -- )

      if def ~= nil then
         local action = def.action

         if action ~= nil then
            local handler = handlers[action]

            if handler ~= nil then
               print(
                  string.format(
                     "Calling handler: %s(%s, %s, %s)",
                     action,
                     def.path,
                     eventName,
                     arg1
                  )
               )
               handler(eventName, button, arg1, def)
            else
               print(string.format("Handler not defined: %s", action))
            end
         else
            print(def.message)
         end
      else
         print("no def")
      end
   end,

   processMessage = function(path)
      print(
         string.format(
            "processing message: %s",
            path
         )
      )

      local segments = {}
      local currentSegment = {}
      local f = filesystem.loadFile(path)

      if f ~= nil then
         print(type(f))

         if type(f) == "string" then
            print(f)
         else
            f()

         end

         if response ~= nil then
            inspect.table(response)

            local command = response.command

            if command ~= nil then
               local handler = registry.commands[command]

               if handler ~= nil then
                  actions[handler](path, response)
               end
            else
               print("command not specified")
            end
         else
            print("nil")
         end
      else
         print("failed to load message")
      end
   end,

   reloadSystem = function()
      filesystem.doFile("/init.lua")
      init()
   end,
}
