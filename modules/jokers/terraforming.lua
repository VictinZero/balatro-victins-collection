return {
    key = 'terraforming',
    config = {},
    rarity = 2,
    pos = { x = 0, y = 8 },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers then
            for i=1, #G.consumeables.cards do
                local target_card = G.consumeables.cards[i]
                if target_card:can_calculate(true) then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.00,
                        func = function()
                            if target_card and not target_card.removed then
                                local p_ = 1
                                for i_ = 1, #G.consumeables.cards do
                                    if #G.consumeables.cards[i_] == target_card then
                                        p_ = 1.15 - (i_ - 0.999) / (##G.consumeables.cards - 0.998) * 0.3
                                        break
                                    end
                                end
                                target_card:flip()
                                play_sound('card1', p_)
                                target_card:juice_up(0.3, 0.3)
                            end
                            return true
                        end
                    }))
                    delay(0.2)

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if target_card and not target_card.removed then
                                --[[local earth = create_card(nil, nil, nil, nil, true, nil, 'c_earth', nil)
                                earth:set_edition(target_card.edition or {}, nil, true)
                                copy_card(earth, target_card)
                                earth:remove()]]
                                target_card:set_ability('c_earth')
                            end
                            return true
                        end
                    }))

                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            if target_card and not target_card.removed then
                                local p_ = 1
                                for i_ = 1, #G.consumeables.cards do
                                    if G.consumeables.cards[i_] == target_card then
                                        p_ = 0.85 + (i_ - 0.999) / (#G.consumeables.cards - 0.998) * 0.3
                                        break
                                    end
                                end
                                target_card:flip()
                                play_sound('tarot2', p_, 0.6)
                                target_card:juice_up(0.3, 0.3)
                            end
                            return true
                        end
                    }))
                    delay(0.05)

                    break
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_earth
    end
}
