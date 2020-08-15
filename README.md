# satisfactory-network
Collection of Ficsit Network helper scripts for Satisfactory

This is the lua script that I am using to power my modded Satisfactory playthrough

Add the following to your terminal:

```lua
filesystem.initFileSystem("/dev")
filesystem.mount("/dev/" .. filesystem.childs("/dev")[1], "/")
filesystem.doFile("/init.lua")
init()
```