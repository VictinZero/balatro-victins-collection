return {
    key = 'quantum_joker',
    config = {},
    rarity = 3,
    pos = { x = 7, y = 8 },
    atlas = 'joker_atlas',
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.selling_card and context.card.area == G.consumeables and not context.card.edition then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local card = create_card(context.card.ability.set or 'Planet', G.consumeables, nil, nil, nil, nil, nil, 'quantum')
                            card:set_edition({negative = true}, true)
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            return true
                        end}))   
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_vic_quantum'), colour = G.C.PURPLE})                       
                    return true
                end
            }))
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "cr_vic_quantum_joker", set = "Other"}
        info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
    end,
}
