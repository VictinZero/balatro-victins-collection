return {
    key = 'pippi_panini',
    config = {
        extra = {
            payout = 20,
            penalty = 2,
            odds = 4
        }
    },
    rarity = 1,
    pos = {
        x = 5,
        y = 0
    },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calc_dollar_bonus = function(self, card)
        if (pseudorandom('vic_pippi_panini') < G.GAME.probabilities.normal / card.ability.extra.odds) then
            -- card_eval_status_text(card, 'dollars', card.ability.extra.payout)
            return card.ability.extra.payout
        else
            -- card_eval_status_text(card, 'dollars', -card.ability.extra.penalty)
            return -card.ability.extra.penalty
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {G.GAME and G.GAME.probabilities.normal or 1, card.ability.extra.odds, card.ability.extra.payout,
                    card.ability.extra.penalty}
        }
    end
}
