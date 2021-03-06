-- taken from: https://github.com/CoderDE/FicsIt-Networks/blob/bb9f994e3211a539e89e5c9ab13afcba2d67fbbb/FicsItOS2.0/lib/thread.lua

thread = {
   threads = {},
   current = 1
}

function thread.create(func)
   local t = {}
   t.co = coroutine.create(func)

   function t:stop()
      for i,th in pairs(thread.threads) do
         if th == t then
            table.remove(thread.threads, i)
         end
      end
   end

   table.insert(thread.threads, t)
   return t
end

function thread.run()
   while true do
      if #thread.threads < 1 then
         return
      end

      if thread.current > #thread.threads then
         thread.current = 1
      end

      coroutine.resume(true, thread.threads[thread.current].co)
      thread.current = thread.current + 1
   end
end
