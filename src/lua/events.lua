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

      if def ~= null then
         local action = def.action

         if action ~= null then
            local handler = handlers[action]

            if handler ~= null then
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

      if f ~= null then
         print(type(f))

         if type(f) == "string" then
            print(f)
         else
            f()

         end

         if response ~= null then
            inspect.table(response)

            local command = response.command

            if command ~= null then
               local handler = registry.commands[command]

               if handler ~= null then
                  actions[handler](path, response)
               end
            else
               print("command not specified")
            end
         else
            print("null")
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
