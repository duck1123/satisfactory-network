print("running main7")

computer.beep()

while true do
   local eprime, s, t, p, q, r  = event.pull()

   if eprime == "FileSystemUpdate" then
      print(
         string.format(
            "eprime p = %s, q = %s, t = %s",
            p, q, t
         )
      )
   end
end
