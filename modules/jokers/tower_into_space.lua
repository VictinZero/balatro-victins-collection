return {
    key = 'tower_into_space',
    config = {},
    rarity = 2,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,
    enhancement_gate = 'm_stone',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local first_stone = nil
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name == 'Stone Card' then first_stone = context.scoring_hand[i]; break end
            end
            if context.other_card == first_stone and G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                local hand_type = context.scoring_name
                G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.0,
                    func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            local _planet = 0
                            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                                if v.config.hand_type == hand_type then
                                    _planet = v.key
                                end
                            end
                            if _planet ~= 0 then
                                local _card = create_card('Planet', G.consumeables, nil, nil, nil, nil, _planet, 'tower_into_space')
                                _card:add_to_deck()
                                G.consumeables:emplace(_card)
                            end
                            G.GAME.consumeable_buffer = 0
                        end
                        return true
                    end
                }))
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    end,
}
