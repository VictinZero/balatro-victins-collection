return {
    key = 'blue_dwarf',
    config = {},
    rarity = 2,
    pos = { x = 9, y = 8 },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_left == 0 and G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer then
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
                            local _card = create_card('Planet', G.consumeables, nil, nil, nil, nil, _planet, 'blue_dwarf')
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
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "cr_vic_quantum_joker", set = "Other"}
    end,
}
