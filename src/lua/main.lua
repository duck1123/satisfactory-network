fsuSignals = {
   add = 0,
   remove = 1,
   change = 2,
   rename = 3,
   mount = 4,
   unmount = 5,
}

fsuTypes = {
   file = 0,
   directory = 1,
   other = 2,
}

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
         if arg1 == fsuSignals.add then
            doProcessInbox()
         end
      end

      if eventName == "Trigger" then
         local def = findButtonDef(registeredButtons, c)
         handleButtonTrigger(eventName, c, arg1, def)
      end
   end
end
