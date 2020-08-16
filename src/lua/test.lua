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

   -- debugModules(panel)
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

-- modes = {"r", "w", "a", "+r", "+w", "+a"}

-- f = filesystem.open(logFile, modes[2])
-- print(f:getSize())
-- print(f:read("*all"))
-- print(f:getMode())


-- f:write(computer:time())
-- print(f:seek("end", -2))
-- f:write(computer:time())
-- f:close()

-- print(computer:time())

-- printMembers(computer)

-- storageReport()
-- pipeStorage = component.proxy(storage["motor"])
-- debugInventories(pipeStorage)
-- printMembers(pipeStorage)
-- c = component.proxy("87AB9F5A4BD4EFCF1208D8A9B6085420")
-- debugComponent(c)
-- debugInventories(c)
-- a = c:open()
-- c:send("foo")
-- print(a)
-- filesystem.mount("/dev/" .. driveId .. "/log.txt", "/log.txt")
-- logFile = "/log.txt"
-- print(readData(logFile))
-- writeData(logFile, "food")
-- appendData(logFile, "foo")
-- log("All work and no play makes jack a dull boy")
-- inv = c:getInventories()[1]
-- index, stack = inv:getStack(1)
-- print(index)
-- print(stack)
-- debugTable(stack)
-- item = stack.item
-- debugTable(item)
-- printMembers(inv)
-- debugInventory(inv)
-- debugTypes(inv)
-- debugTypes(c)
