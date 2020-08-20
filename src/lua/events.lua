function processMessage(path)
   local data = readData(path)

   print(
      string.format(
         "processing message: %s - %s",
         path,
         data
      )
   )

   local handler = registry.commands[data]

   if handler ~= null then
      actions[handler](path, data)
   end

   return data
end

function handleButtonTrigger(eventName, button, arg1, def)
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
         local handler = _G[action]

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

   -- log("beep")
   -- computer.beep()
end

function doEventLoop()
   print("starting event loop")

   local registeredButtons = registerButtons()

   -- debugTable(buttons)

   while true do
      computer.skip()
      eventName, c, arg1, arg2, arg3 = event.pull(1)

      if eventName ~= null then
         print(
            string.format(
               "mainloop eventName = %s, c = %s, arg1 = %s, arg2 = %s, arg3 = %s",
               eventName, c, arg1, arg2, arg3
            )
         )

         if eventName == "FileSystemUpdate" then
            if arg1 == 0 then
               doProcessInbox()
            end
         end

         if eventName == "Trigger" then
            local def = findButtonDef(registeredButtons, c)
            handleButtonTrigger(eventName, c, arg1, def)
         end
      end
   end
end
