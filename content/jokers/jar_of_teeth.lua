return {
    key = 'jar_of_teeth',
    config = {
        extra = {
            payout = 12,
            penalty = 1
        }
    },
    rarity = 2,
    pos = {
        x = 0,
        y = 8
    },
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.individual and (context.cardarea == G.play or context.cardarea == 'unscored') then
            return {
                dollars = -card.ability.extra.penalty
            }
        end
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.payout
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.penalty, card.ability.extra.payout}
        }
    end
}
