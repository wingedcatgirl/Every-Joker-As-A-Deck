local joker = "j_joker"

SMODS.Back{
    key = "jimbo",
    unlocked = false,
    prefix_config = { atlas = false },
    atlas = "Joker",
    pos = G.P_CENTERS[joker].pos,
    config = {
        joker = "j_joker",
        extra = {
            mult = 4
        }
    },
    loc_vars = function (self, info_queue, back)
        return {
            vars = {
                self.config.extra.mult
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
        if context.final_scoring_step then
            return {
                mult = self.config.extra.mult,
            }
        end
    end
}