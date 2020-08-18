-- taken from: https://github.com/CoderDE/FicsIt-Networks/blob/bb9f994e3211a539e89e5c9ab13afcba2d67fbbb/FicsItOS2.0/lib/liveProgram.lua

function runProgramLive(path)
   local loading = false
   local loadingQueued = false
   local programThread = thread.create(filesystem.loadFile(path))

   local reloader = thread.create(function()
         while true do
            if loading then
               programThread:stop()
               reloadSystem()
               -- local program = filesystem.loadFile(path)

               -- if program then
               --    status, programThread1 = pcall(thread.create, program)

               --    if status then
               --       programThread = programThread1
               --    else
               --       print("failed")
               --    end
               -- end

               -- sleep(5)
               print("done loading"  .. tostring(loading))
               sleep(5)
               print("done loading sleep done");
               loadingQueued = false
            end

            loading = loadingQueued

            if loading then
               print("Reset queue")
               -- sleep(5)
               -- print("done sleeping")
               loadingQueued = false
            else
               print("reload loop sleep")
               sleep(2)
               print("reload loop sleep stop")
            end
            -- print("done sleeping"  .. tostring(loading))
         end
   end)

   local listenerThread = thread.create(function()
         while true do
            local e,s,t,p = event.pull(0.1)

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
                           print("Reload event"  .. tostring(loading))
                           loadingQueued = true
                        else
                           print("already queued")
                        end
                     end
                  end
               end
            end

            coroutine.yield()
         end
   end)
end
