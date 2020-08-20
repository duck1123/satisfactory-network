-- taken from: https://github.com/CoderDE/FicsIt-Networks/blob/bb9f994e3211a539e89e5c9ab13afcba2d67fbbb/FicsItOS2.0/lib/liveProgram.lua

function runProgramLive(path)
   local loading = false
   local loadingQueued = false
   local programThread = thread.create(filesystem.loadFile(path))

   local reloader = thread.create(function()
         while true do
            if loading then
               programThread:stop()
               local program = filesystem.loadFile(path)

               if program then
                  status, programThread1 = pcall(thread.create, program)

                  if status then
                     programThread = programThread1
                  end
               end

               loadingQueued = false
            end

            loading = loadingQueued

            if loading then
               loadingQueued = false
            end
         end
   end)

   local listenerThread = thread.create(function()
         while true do
            local e,s,t,p = event.pull()

            if e ~= null then
               print(
                  string.format(
                     "liveprogram e = %s, s = %s, t = %s, p = %s",
                     e, s, t, p
                  )
               )

               if e == "FileSystemUpdate" then
                  if t == 2 then
                     if q then
                        if not loadingQueued then
                           loadingQueued = true
                        end
                     end
                  end
               end
            end
         end
   end)
end
