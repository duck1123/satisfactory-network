--[[
   This example shows how you can use the FicsIt-OS-2.0
   for your advantage for way easier code development.
   When you run this file with a initialized OS,
   it will run the program.lua file.
   If you then do changes to the program.lua file, and save it,
   this example will detect it and restart the execution of the program.lua
   so it always runs up to date code so you can directly see
   the changes you made in your code.
]]--
-- print("Running run2")

-- filesystem.doFile("/lib/liveProgram.lua")

filesystem.doFile("/main.lua")
-- runProgramLive("/main.lua")

-- thread.run()
