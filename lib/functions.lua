---Debug messages
---@param message string Message to send
---@param level? string Log level, DEBUG by default, TRACE won't send unless dev mode is active since DebugPlus doesn't have that filter fsr
function JDECKS.say(message, level)
    message = message or "???"
    level = level or "DEBUG"
    while #level < 5 do
        level = level.." "
    end
    if level == "TRACE" and not (JDECKS.config.dev_mode and not JDECKS.config.suppress_trace) then
        return
    end
    sendMessageToConsole(level, "Minty's Mod", message)
end

---Checks whether a card is in the collection (as opposed to e.g. the hand or Jokers tray)
---@param card table Card to check
---@return boolean
JDECKS.in_collection = function (card)
    if G.your_collection then
        for k, v in pairs(G.your_collection) do
            if card.area == v then
                return true
            end
        end
    end
    return false
end

---Do the tarot flip thing to all of G.hand.highlighted
---@param card Card
---@param args table `rank`, `suit`, `enh`, `edi` = keys of the appropriate target modifications. alternately `random_ranks`, `random_suits`, `random_enhs`, `random_edis` are tables of same keys to pick one at random, in which case you need `seed` to seed the seed. Note: To clear an edition, pass the string "base", "none", "false", or "remove" as the edition key.
JDECKS.tarotflip = function (card, args)
    if not args then
        JDECKS.say("hey you forgor to say anything when trying to change these cards", "ERROR")
        return
    end
    local rank = args.rank
    local ranks = args.random_ranks
    local suit = args.suit
    local suits = args.random_suits
    local enh = args.enh
    local enhs = args.random_enhs
    local edi = args.edi
    local edis = args.random_edis
    local seed = args.seed or "minty_tarotflip_seedless_probably_shouldn't_happen_tbh"
    local sound = args.sound
    if not (rank or ranks or suit or suits or enh or enhs or edi or edis) or (rank and ranks) or (suit and suits) or (enh and enhs) or (edi and edis) or ((ranks or suits or enhs or edis) and not args.seed) then
        JDECKS.say("hey you didn't type the right arguments?", "ERROR")
        tprint(args or {})
    end

    if card then
        G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true
        end }))
    end

    if (rank or ranks or suit or suits or enh or enhs) then
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand.highlighted[i]:flip()
                play_sound('card1', percent)
                G.hand.highlighted[i]:juice_up(0.3, 0.3)
                return true
            end
            }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                if ranks then rank = pseudorandom_element(ranks, pseudoseed(seed)) end
                if suits then suit = pseudorandom_element(suits, pseudoseed(seed)) end
                if enhs then enh = pseudorandom_element(enhs, pseudoseed(seed)) end
                if rank or suit then
                    assert(SMODS.change_base(G.hand.highlighted[i], suit, rank))
                end
                if enh then
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[enh])
                end
                return true
            end
            }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + ( i - 0.999 ) / ( #G.hand.highlighted - 0.998 ) * 0.3
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand.highlighted[i]:flip()
                play_sound(sound or 'tarot2', percent, 0.6)
                G.hand.highlighted[i]:juice_up(0.3, 0.3)
                return true
            end
            }))
        end
    end

    if (edi or edis) then
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                if edis then edi = pseudorandom_element(edis, pseudoseed(seed)) end
                if edi then
                    if edi == "base" or edi == "none" or edi == "false" or edi == "remove" then edi = nil end
                    G.hand.highlighted[i]:set_edition(edi)
                    G.hand.highlighted[i]:juice_up(0.3,0.3)
                end
                return true
            end
            }))
        end
    end

    G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.15,
    func = function()
        G.hand:unhighlight_all()
        return true
    end
    }))
    delay(0.5)
end

---Checks whether any of the specified rank exist in the player's entire deck
---@param rank string Key of the rank to find
---@return boolean
function JDECKS.find_rank(rank)
    if not G.playing_cards then return true end
    for k, v in ipairs(G.playing_cards) do
        if v:get_id() == SMODS.Ranks[rank].id then
            return true
        end
    end
    return false
end

--Talisman compatibility compatibility
to_big = to_big or function(x)
    return x
end

to_number = to_number or function(x)
    return x
end

function SMODS.current_mod.reset_game_globals(init)

end

SMODS.current_mod.set_debuff = function (card)

end