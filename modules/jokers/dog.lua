return {
    key = 'dog',
    config = {
        extra = {
            chips = 0,
            chips_mod = 10,
            mult = 0,
            mult_mod = 2
        }
    },
    rarity = 1,
    pos = {
        x = 0,
        y = 1
    },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
        if context.card_added and (not context.blueprint) and (not card.getting_sliced) and
            (context.card.ability.set == 'Joker') then
            local message, colour
            if pseudorandom(pseudoseed('vic_dog')) < 0.5 then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
                message = localize {
                    type = 'variable',
                    key = 'a_chips',
                    vars = {card.ability.extra.chips_mod}
                }
            else
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                message = localize {
                    type = 'variable',
                    key = 'a_mult',
                    vars = {card.ability.extra.mult_mod}
                }
            end
            return {
                message = message,
                colour = G.C.FILTER
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.chips_mod, card.ability.extra.mult_mod, card.ability.extra.chips,
                    card.ability.extra.mult}
        }
    end
}
