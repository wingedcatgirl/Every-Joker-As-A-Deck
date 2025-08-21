JDECKS = JDECKS or {}
JDECKS.prefix = SMODS.current_mod.prefix
JDECKS.config = SMODS.current_mod.config

--[[ Dummying for now on the assumption that this won't require lovely patching
if not SMODS.current_mod.lovely then
    NFS.write(SMODS.current_mod.path .. '.lovelyignore', '')
    error("Joker Decks: Lovely patches failed! Please make sure the file structure is not nested. The mod will be automatically disabled on restart.")
end
--]]

--[[ I don't think we need these either
SMODS.current_mod.optional_features = {
    retrigger_joker = true,
    post_trigger = true,
    cardareas = {
        unscored = true,
    },
}
--]]

local files = {
    lib = {
        { name = "configui" },
        { name = "functions" },
    },
    backs = {
        { name = "jimbo" },
        { name = "sinfuls" },
    },
}

for folder, list in pairs(files) do
    for _, data in ipairs(list) do
        if data.dummy then goto nvm end
        local load = true
        local name = data.name
        if load then
            sendTraceMessage("Loading file: "..folder..'/'..name..'.lua', "Joker Decks")
            if not pcall(SMODS.load_file(folder..'/'..name..'.lua')) then
                local _,errormessage = pcall(SMODS.load_file(folder..'/'..name..'.lua'))
                local disable = not JDECKS.config.dev_mode and " The mod will be automatically disabled on restart." or ""
                if not JDECKS.config.dev_mode then
                    NFS.write(SMODS.current_mod.path .. '.lovelyignore', '')
                end
                sendErrorMessage(errormessage, "Joker Decks")
                error("Joker Decks: File '"..folder.."/"..name..".lua' failed to load! Please make sure there's nothing fucky with your file structure."..disable)
            end
        else
            sendTraceMessage("Skipping file: "..folder..'/'..name..'.lua', "Joker Decks")
        end
        ::nvm::
    end
end

JDECKS.lastmoment = function ()
    JDECKS.say("Running last-moment code...")
end
----