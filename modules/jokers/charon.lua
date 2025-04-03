return {
    key = 'charon',
    config = {
        extra = {
            value_mod = 2,
            chips_factor = 5
        }
    },
    rarity = 1,
    pos = {
        x = 0,
        y = 8
    },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            card.ability.extra_value = card.ability.extra_value + #context.removed * card.ability.extra.value_mod
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips_factor * card.sell_cost
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.value_mod, card.ability.extra.chips_factor,
                    card.ability.extra.chips_factor * card.sell_cost}
        }
    end
}
