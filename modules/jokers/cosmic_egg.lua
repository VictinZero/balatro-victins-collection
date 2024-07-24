return {
    key = 'cosmic_egg',
    config = {},
    rarity = 3,
    pos = { x = 8, y = 8 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.selling_card and context.card ~= card and not context.blueprint then
            card.ability.extra_value = (card.ability.extra_value or 0) + context.card.sell_cost
            card:set_cost()
            card_eval_status_text(card, 'jokers', nil, nil, nil, {message = localize('k_val_up'), colour = G.C.MONEY})
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "cr_vic_quantum_joker", set = "Other"}
    end,
}
