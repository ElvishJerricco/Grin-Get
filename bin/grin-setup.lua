local grinDir = shell.resolve("/"..fs.combine(fs.getDir(shell.getRunningProgram()), ".."))

local grinPackagePath = "/" .. fs.combine(grinDir, "packages/ElvishJerricco/Grin/")
local grinInstallPath = "/" .. fs.combine(grinPackagePath, "1.1")
shell.run("pastebin", "run", "VuBNx3va", "-u", "ElvishJerricco", "-r", "Grin", "-t", "1.1", grinInstallPath)
local githubApiResponse = assert(http.get("https://api.github.com/repos/ElvishJerricco/Grin/releases"))
assert(githubApiResponse.getResponseCode() == 200, "Failed github response")
local fh = fs.open(fs.combine(grinPackagePath, "releases.json"), "w")
fh.write(githubApiResponse.readAll())
fh.close()

shell.run("grin/bin/grin-startup.lua")

print("It is recommended that your startup file run grin/bin/grin-startup.lua")