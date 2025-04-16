local misc = SMODS.load_file("misc_functions.lua")()

return {
    key = 'slingshot',
    config = {
        extra = {
            xmult = 1.75,
            xmult_planet = 2.5,
            active = false,
            is_planet = false
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
        if context.joker_main then
            local target_card
            for i = 1, #G.consumeables.cards do
                local candidate = G.consumeables.cards[i]
                if candidate and candidate:can_calculate(true) then
                    target_card = candidate
                    target_card.getting_sliced = true
                    card.ability.extra.active = true
                    card.ability.extra.is_planet = target_card.ability.set == 'Planet'
                    break
                end
            end
            if not target_card then
                return
            end
            misc.destroy_cards({target_card})
            return {
                xmult = target_card.ability.set == 'Planet' and card.ability.extra.xmult_planet or
                    card.ability.extra.xmult
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.xmult, card.ability.extra.xmult_planet}
        }
    end
}
