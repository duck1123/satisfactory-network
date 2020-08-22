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
   addMessage("lights-on")
end

function handleMessageButton(eventName, button, arg1, def)
   addMessage(def.message)
end

function handleButton2(eventName, button, arg1, def)
   addMessage("ping")
end

function handleButton3(eventName, button, arg1, def)
   addMessage("lights-out")
end
