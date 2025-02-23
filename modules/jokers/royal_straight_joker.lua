return {
    key = 'royal_straight_joker',
    config = {},
    rarity = 3,
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'joker_atlas',
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.hand_drawn and (G.GAME.current_round.hands_left == 1) and #G.deck.cards > 0 then
            local cards_to_draw = {{10, false}, {11, false}, {12, false}, {13, false}, {14, false}}

            for _, v in ipairs(cards_to_draw) do
                local rank = v[1]
                sendDebugMessage("Rank is " .. tostring(rank))
                for i = 1, #G.deck.cards do
                    local _card = G.deck.cards[i]
                    if _card:get_id() == rank then
                        v[2] = _card;
                        sendDebugMessage("Found a " .. tostring(rank) .. "!");
                        break
                    end
                end
            end

            local tmp = false
            for _, v in ipairs(cards_to_draw) do
                local _card = v[2]
                if _card then
                    if not tmp then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                            message = 'rsj happy',
                            colour = G.C.PURPLE
                        })
                        tmp = true
                    end
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            if _card and not _card.removed and _card.area == G.deck then
                                draw_card(G.deck, G.hand, nil, 'up', true, _card)
                                _card.ability.vic_temporary = true
                            end
                            return true
                        end
                    }))
                end
            end
            if not tmp then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                    message = 'rsj sad',
                    colour = G.C.PURPLE
                })
            end
        end
    end
}
