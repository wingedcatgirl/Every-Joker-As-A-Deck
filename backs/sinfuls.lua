local greedy = "j_greedy_joker"
local lusty = "j_lusty_joker"
local wrathful = "j_wrathful_joker"
local gluttonous = "j_gluttenous_joker"

SMODS.Back{
    key = "greedy",
    unlocked = false,
    prefix_config = { atlas = false },
    atlas = "Joker",
    pos = G.P_CENTERS[greedy].pos,
    config = {
        joker = greedy,
        extra = {
            suit = "Diamonds",
            s_mult = 3
        }
    },
    loc_vars = function (self, info_queue, back)
        return {
            vars = {
                self.config.extra.suit,
                self.config.extra.s_mult,
				colours = {
					G.C.SUITS[self.config.extra.suit],
				},
            }
        }
    end,
    locked_loc_vars = function (self, info_queue, back)
        return {
            key = "b_jokerdecks_locked",
            set = "Back",
            vars = {
                localize{type = 'name_text', key = self.config.joker, set = 'Joker'},
            }
        }
    end,
    check_for_unlock = function (self, args)
        if args.type == 'win_custom' and SMODS.find_card(self.config.joker, true) then
            unlock_card(self)
        end
    end,
    calculate = function (self, back, context)
            if context.cardarea == G.play and context.individual and context.other_card:is_suit(self.config.extra.suit) then
            return {
                mult = self.config.extra.s_mult
            }
        end
    end
}

SMODS.Back{
    key = "lusty",
    unlocked = false,
    prefix_config = { atlas = false },
    atlas = "Joker",
    pos = G.P_CENTERS[lusty].pos,
    config = {
        joker = lusty,
        extra = {
            suit = "Hearts",
            s_mult = 3
        }
    },
    loc_vars = function (self, info_queue, back)
        return {
            vars = {
                self.config.extra.suit,
                self.config.extra.s_mult,
				colours = {
					G.C.SUITS[self.config.extra.suit],
				},
            }
        }
    end,
    locked_loc_vars = function (self, info_queue, back)
        return {
            key = "b_jokerdecks_locked",
            set = "Back",
            vars = {
                localize{type = 'name_text', key = self.config.joker, set = 'Joker'},
            }
        }
    end,
    check_for_unlock = function (self, args)
        if args.type == 'win_custom' and SMODS.find_card(self.config.joker, true) then
            unlock_card(self)
        end
    end,
    calculate = function (self, back, context)
            if context.cardarea == G.play and context.individual and context.other_card:is_suit(self.config.extra.suit) then
            return {
                mult = self.config.extra.s_mult
            }
        end
    end
}

SMODS.Back{
    key = "wrathful",
    unlocked = false,
    prefix_config = { atlas = false },
    atlas = "Joker",
    pos = G.P_CENTERS[wrathful].pos,
    config = {
        joker = wrathful,
        extra = {
            suit = "Spades",
            s_mult = 3
        }
    },
    loc_vars = function (self, info_queue, back)
        return {
            vars = {
                self.config.extra.suit,
                self.config.extra.s_mult,
				colours = {
					G.C.SUITS[self.config.extra.suit],
				},
            }
        }
    end,
    locked_loc_vars = function (self, info_queue, back)
        return {
            key = "b_jokerdecks_locked",
            set = "Back",
            vars = {
                localize{type = 'name_text', key = self.config.joker, set = 'Joker'},
            }
        }
    end,
    check_for_unlock = function (self, args)
        if args.type == 'win_custom' and SMODS.find_card(self.config.joker, true) then
            unlock_card(self)
        end
    end,
    calculate = function (self, back, context)
            if context.cardarea == G.play and context.individual and context.other_card:is_suit(self.config.extra.suit) then
            return {
                mult = self.config.extra.s_mult
            }
        end
    end
}

SMODS.Back{
    key = "gluttonous",
    unlocked = false,
    prefix_config = { atlas = false },
    atlas = "Joker",
    pos = G.P_CENTERS[gluttonous].pos,
    config = {
        joker = gluttonous,
        extra = {
            suit = "Clubs",
            s_mult = 3
        }
    },
    loc_vars = function (self, info_queue, back)
        return {
            vars = {
                self.config.extra.suit,
                self.config.extra.s_mult,
				colours = {
					G.C.SUITS[self.config.extra.suit],
				},
            }
        }
    end,
    locked_loc_vars = function (self, info_queue, back)
        return {
            key = "b_jokerdecks_locked",
            set = "Back",
            vars = {
                localize{type = 'name_text', key = self.config.joker, set = 'Joker'},
            }
        }
    end,
    check_for_unlock = function (self, args)
        if args.type == 'win_custom' and SMODS.find_card(self.config.joker, true) then
            unlock_card(self)
        end
    end,
    calculate = function (self, back, context)
            if context.cardarea == G.play and context.individual and context.other_card:is_suit(self.config.extra.suit) then
            return {
                mult = self.config.extra.s_mult
            }
        end
    end
}