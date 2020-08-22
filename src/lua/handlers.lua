handlers = {
   handleButton1 = function(eventName, button, arg1, def)
      -- print(
      --    string.format(
      --       "button1: %s, %s, %s, %s",
      --       eventName,
      --       button,
      --       arg1,
      --       def
      --    )
      -- )
      io.addMessage("lights-on")
   end,

   handleButton2 = function (eventName, button, arg1, def)
      io.addMessage("ping")
   end,

   handleButton3 = function (eventName, button, arg1, def)
      io.addMessage("lights-out")
   end,

   handleMessageButton = function (eventName, button, arg1, def)
      local response = {
         command = def.message,
         args = def.args,
      }

      io.addMessage(toEdn(response))
   end,
}
