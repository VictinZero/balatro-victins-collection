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
        if SMODS.pseudorandom_probability(card, 'vic_pippi_panini', 1, card.ability.extra.odds) then
            -- card_eval_status_text(card, 'dollars', card.ability.extra.payout)
            return card.ability.extra.payout
        else
            -- card_eval_status_text(card, 'dollars', -card.ability.extra.penalty)
            return -card.ability.extra.penalty
        end
    end,

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)

        return {
            vars = {numerator, denominator, card.ability.extra.payout,
                    card.ability.extra.penalty}
        }
    end
}
