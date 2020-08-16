function handleButton1(eventName, button, arg1, def)
   -- print(
   --    string.format(
   --       "button1: %s, %s, %s, %s",
   --       eventName,
   --       button,
   --       arg1,
   --       def
   --    )
   -- )
   -- debugTable(def)
   doFloodMessages()
end

function handleButton2(eventName, button, arg1, def)
   -- print("button2")
   -- debugTable(def)
   doProcessInbox()
end
