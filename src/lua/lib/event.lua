-- taken from: https://github.com/CoderDE/FicsIt-Networks/blob/bb9f994e3211a539e89e5c9ab13afcba2d67fbbb/FicsItOS2.0/lib/event.lua

local oldPull = event.pull
local pulling = {}

function handlePull(co)
   if not (pulling[co].signal == nil) then
      return true
   end
   local signal = {oldPull(0)}
   if #signal < 1 then
      return false
   end
   for t,s in pairs(pulling) do
      if s.signal == nil then
         s.signal = signal
      end
   end
   return true
end

function event.pull(timeout)
   local co = coroutine.running()
   pulling[co] = {}

   while not handlePull(co) do
      coroutine.yield()
   end

   local pullData = pulling[co]
   pulling[co] = nil

   if pullData.signal == nil then
      return
   end

   local data = pullData.signal
   pullData.signal = nil
   return table.unpack(data)
end

function sleep(timeout)
   timeout = timeout * 1000
   local start = computer.millis()

   while (computer.millis() - start) < timeout do
      event.pull((timeout - (computer.millis() - start)) / 1000)
   end
end
