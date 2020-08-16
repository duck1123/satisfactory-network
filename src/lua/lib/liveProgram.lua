-- taken from: https://github.com/CoderDE/FicsIt-Networks/blob/bb9f994e3211a539e89e5c9ab13afcba2d67fbbb/FicsItOS2.0/lib/liveProgram.lua

function runProgramLive(path)
   local programThread = thread.create(filesystem.loadFile(path))
   local listenerThread = thread.create(function()
         while true do
            local e,s,t,p = table.unpack(event.pull())
            if e == "FileSystemUpdate" and t == 2 and p == path then
               programThread:stop()
               local program = filesystem.loadFile(path)
               if program then
                  programThread = thread.create(program)
               end
            end
         end
   end)
end
