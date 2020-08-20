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

-- function main()
--    doEventLoop()
--    computer.beep()
-- end

-- printMembers(panel)

-- debugModules(panel)
-- debugGpus(screen)
-- debugConnectors(panel)
-- debugNetwork(panel)
-- debugInventories(panel)

-- doPower("Power")

-- doSplitterInfo("Splitter")
-- doIndicator("Indicator")

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

-- light = getComponent("Light")
-- printMembers(light)
-- print(light:getGroup())

-- modes = {"r", "w", "a", "+r", "+w", "+a"}

-- f = filesystem.open(logFile, modes[2])
-- print(f:getSize())
-- print(f:read("*all"))
-- print(f:getMode())

-- f:write(computer:time())
-- print(f:seek("end", -2))
-- f:write(computer:time())
-- f:close()

-- c = component.proxy("87AB9F5A4BD4EFCF1208D8A9B6085420")
-- debugComponent(c)
-- debugInventories(c)
-- a = c:open()
-- c:send("foo")
-- print(a)
