local registeredButtons = registerButtons()

while true do
   computer.skip()
   eventName, c, arg1, arg2, arg3 = event.pull()

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
