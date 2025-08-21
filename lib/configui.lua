local devonlytoggle = function(t)
    if JDECKS.config.dev_mode then
        return create_toggle(t)
    end
end

G.FUNCS.jdecks_optcycle = function(args)
    local refval = args.cycle_config.ref_value
    JDECKS.config[refval].current_option = args.cycle_config.current_option
    JDECKS.config[refval].option_value = args.to_val
end

SMODS.current_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tl", padding = 0.2, colour = G.C.BLACK}, nodes = {
        {n = G.UIT.C, config = {minw=1, minh=1, align = "tl", colour = G.C.CLEAR, padding = 0.15}, nodes = {
        create_toggle({
            label = "Dev mode",
            ref_table = JDECKS.config,
            ref_value = 'dev_mode',
        }),
        devonlytoggle({
            label = "Suppress trace messages",
            ref_table = JDECKS.config,
            ref_value = "suppress_trace",
        }),
        devonlytoggle({
            label = "Test option",
            ref_table = JDECKS.config,
            ref_value = "test_button",
        }),
        }}
    }}
end