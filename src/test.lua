-- function initFilesystem()
--    print("init filesystem")
--    filesystem.initFileSystem("/dev")
--    filesystem.mount("/dev/" .. filesystem.childs("/dev")[1], "/")
--    local status = pcall(filesystem.doFile, "/test.lua")
--    print(status)
-- end

-- function myerrorhandler( err )
--    print( "ERROR:", err )
-- end

-- if xpcall(initFilesystem, myerrorhandler) then
--    print("Success loading")
-- else
--    print("Failure loading")
-- end

-- main()

function main()
   -- print("Hello World")
   local panel = getComponent("Panel")
   local indicator = getComponent("Indicator")

   local screen = panel:getModule(0, 0)

   -- printMembers(panel)

   debugModules(panel)
   -- debugGpus(screen)
   -- debugConnectors(panel)
   -- debugNetwork(panel)
   -- debugInventories(panel)

   -- doPower("Power")

   -- doSplitterInfo("Splitter")
   -- doIndicator("Indicator")

   doEventLoop(panel, indicator)

   computer.beep()
end

-- screen = component.proxy(screens["1"])
-- printMembers(screen)

-- pipeStorage = component.proxy(storage["pipe"])
-- printMembers(pipeStorage)
-- debugTable(pipeStorage:getInventories())

-- print(pipeStorage.nick)
-- debugTable(storage)

-- inv1 = pipeStorage:getInventories()[1]
-- debugInventory(inv1)
-- printMembers(inv1)
-- print(inv1.size)
-- print(inv1.itemCount)

-- stack1 = inv1:getStack(0)
-- print(stack1.nick)
-- print(stack1.item)
-- printMembers(stack1)

-- printMembers(inv1)

-- debugTable(miners["iron"]["1"])
-- printMembers(ironMiner1)
-- printMembers(ironPole1)
-- doIronPoles()
-- print(miners)
-- print(ironMiner1.standby)
-- light = getComponent("Light")
-- printMembers(light)
-- print(light:getGroup())
-- main()
-- enableIron()
-- printMembers(ironMiner1)
-- print(ironMiner1:getLocation())
-- print(component.proxy(miners["2"]):getLocation())
-- print(component.proxy(miners["3"]):getLocation())
-- print(component.proxy("CCAB02D9441F2A2CCF42FAA698AF8C0A"):getLocation())
