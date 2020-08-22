function parsePath(path)
   local pathInfo = {}
   local searchTable = registry
   local segments = {}

   for panelPath,_ in string.gmatch(path, "(.+)%[") do
      for segment,_ in string.gmatch(panelPath, "(%w+)") do
         table.insert(segments, segment)
      end
   end

   -- reduce segments to find the definition that matches the path
   for k, v in pairs(segments) do
      local subpath = searchTable[v]
      searchTable = subpath
   end

   pathInfo.id = searchTable.id

   -- Parse button coordinates
   for k, v in string.gmatch(path, "(%d+),(%d+)") do
      pathInfo.x = k
      pathInfo.y = v
   end

   return pathInfo
end

function listButtons()
   for _, def in pairs(registry.buttons) do
      local path = def.path
      local pathInfo = parsePath(path)
      inspect.table(pathInfo)
   end
end

function registerButtons()
   local registeredButtons = {}

   for _, def in pairs(registry.buttons) do
      local path = def.path
      local pathInfo = parsePath(path)
      local panel = component.proxy(pathInfo.id)

      if panel ~= null then
         local button = panel:getModule(pathInfo.x, pathInfo.y)

         if button ~= null then
            event.listen(button)
            registeredButtons[path] = button
         else
            print("no button")
         end
      else
         print("Could not find panel")
      end
   end

   return registeredButtons
end

function findButtonDef(registeredButtons, button)
   local matchedPath = null
   local matchedDef = null

   for path, candidateButton in pairs(registeredButtons) do
      if matchedPath == null and button == candidateButton then
         matchedPath = path
      end
   end

   if matchedPath ~= null then
      for _, def in pairs(registry.buttons) do
         if matchedDef == null and def.path == matchedPath then
            matchedDef = def
         end
      end
   else
      print("Could not find path")
   end

   return matchedDef
end
