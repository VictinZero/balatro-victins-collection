return {
    key = 'growing_tree',
    config = {extra={chips=0, chip_mod = 5}},
    rarity = 1,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.chip_mod
            if not context.blueprint then card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod end
            return {
                extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                card = card
            }
        elseif context.joker_main then
            return {
                message = localize{type='variable', key='a_chips', vars={card.ability.extra.chips}},
                chip_mod = card.ability.extra.chips, 
                colour = G.C.CHIPS
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chip_mod, card.ability.extra.chips}}
    end,
}
