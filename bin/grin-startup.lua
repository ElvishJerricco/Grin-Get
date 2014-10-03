local grinDir = shell.resolve("/"..fs.combine(fs.getDir(shell.getRunningProgram()), ".."))

if grin then
    os.unloadAPI("grin")
end
assert(os.loadAPI(fs.combine(grinDir, "lib/grin")), "Failed to load Grin API")

if json then
    os.unloadAPI("json")
end
local jsonAPIPath = grin.combine(grinDir, "packages/ElvishJerricco/Grin/1.1/lib/json")
assert(os.loadAPI(jsonAPIPath), "Failed to load JSON API") -- grin requires a minimum of the json API

grin.setGrinDir(grinDir)
grin.refreshPath(shell)