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

print("Starting main4")

actions.doProcessInbox()

print("inbox done")

while true do
   computer.skip()
   eventName, c, arg1, arg2, arg3 = event.pull()

   print(eventName)

   if eventName ~= nil then
      print(
         string.format(
            "mainloop eventName = %s, c = %s, arg1 = %s, arg2 = %s, arg3 = %s",
            eventName, c, arg1, arg2, arg3
         )
      )

      actions.doProcessInbox()

      if eventName == "FileSystemUpdate" then
         if arg1 == fsuSignals.change and arg3 == fsuTypes.file then
            events.reloadSystem()
         end
      end

      if eventName == "Trigger" then
         local def = findButtonDef(registeredButtons, c)
         events.handleButtonTrigger(eventName, c, arg1, def)
      end
   end
end
