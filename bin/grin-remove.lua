local argparse = grin.getPackageAPI("ElvishJerricco/Grin", "argparse")

local parser = argparse.new()
parser
    :argument"package"
parser:usage"Usage: grin-remove <user>/<repo>[/<tag>]"
local options = parser:parse({}, ...)
if not options then
    return
end
if not options.package then
    parser:printUsage()
    return
end

shell.run("rm", "/"..grin.combine(grin.getGrinDir(), "packages", options.package))
grin.refreshPath(shell)