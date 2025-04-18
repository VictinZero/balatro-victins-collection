return {
    key = 'binary_star',
    config = {
        extra = {
            reuses = 1
        }
    },
    rarity = 2,
    pos = {
        x = 8,
        y = 7
    },
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Planet' then
            --context.consumeable:use_consumeable(context.consumeable.area or (context.blueprint and context.blueprint_card.area) or card.area, context.consumeable or (context.blueprint and context.blueprint_card) or card)
            return {
                message = localize('k_again_ex'),
                func = function() context.consumeable:use_consumeable(context.consumeable.area or
                (context.blueprint and context.blueprint_card.area) or card.area,
                context.consumeable or (context.blueprint and context.blueprint_card) or card) end
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {
            key = "cr_vic_binary_star",
            set = "Other"
        }
        return {
            vars = {card.ability.extra.reuses, (card.ability.extra.reuses == 1 and '') or 's'}
        }
    end
}
