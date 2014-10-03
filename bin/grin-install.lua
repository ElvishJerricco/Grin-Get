local json = grin.getPackageAPI("ElvishJerricco/Grin", "json")
local argparse = grin.getPackageAPI("ElvishJerricco/Grin", "argparse")

local parser = argparse.new()
parser
    :argument"package"
parser:usage"Usage: grin-install <user>/<repo>[/<tag>]"
local options = parser:parse({}, ...)
if not options then
    return
end
if not options.package then
    parser:printUsage()
    return
end

local user, repo, tag = grin.packageNameComponents(options.package)

local releaseInfo = grin.getReleaseInfoFromGithub(grin.combine(user, repo))
local release
for i,v in ipairs(releaseInfo) do
    if v.tag_name == tag then
        release = v
        break
    end
end
assert(release, "Tag not found " .. tag)

local grinPrg = grin.resolveInPackage("ElvishJerricco/Grin", "grin")
shell.run(grinPrg, "-u", user, "-r", repo, "-t", release.tag_name,
    grin.combine(grin.getGrinDir(), "packages", user, repo, release.tag_name))


local packageGrinData = grin.getPackageGrinJSON(grin.combine(user, repo, release.tag_name))
if packageGrinData and packageGrinData.dependencies then
    local tDep = {}
    if type(packageGrinData.dependencies) == "string" then
        for v in packageGrinData.dependencies:gmatch("[^:]+") do
            table.insert(tDep, v)
        end
    elseif type(packageGrinData.dependencies) == "table" then
        for i,v in ipairs(packageGrinData.dependencies) do
            table.insert(tDep, v)
        end
    end

    for i,v in ipairs(tDep) do
        shell.run("/"..shell.getRunningProgram(), v)
    end
end


grin.refreshPath(shell)