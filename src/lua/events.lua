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
   computer.beep()
end

function doEventLoop()
   print("starting event loop")

   local registeredButtons = registerButtons()

   -- debugTable(buttons)

   while true do
      computer.skip()
      eventName, button, arg1, arg2, arg3 = event.pull(1)

      if eventName ~= null then
         if eventName == "FileSystemUpdate" then
            -- print(
            --    string.format(
            --       "%s - %s - %s - %s",
            --       button,
            --       arg1,
            --       arg2,
            --       arg3

            --    )
            -- )

            if arg1 == 0 then
               doProcessInbox()
            end
         end

         if eventName == "Trigger" then
            local def = findButtonDef(registeredButtons, button)
            handleButtonTrigger(eventName, button, arg1, def)
         end
      end
   end
end
