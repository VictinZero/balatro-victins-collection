return {
    key = 'tour_guide',
    config = {},
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
        if context.first_hand_drawn and #G.deck.cards > 0 then
            for i = 1, #G.deck.cards do
                local _card = G.deck.cards[i]
                sendDebugMessage("Sightseeing… "..tostring(_card:get_id()))
                if _card:get_id() == 3 then
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = 'tour guide', colour = G.C.PURPLE})
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            if _card and not _card.removed and _card.area == G.deck then
                                draw_card(G.deck, G.hand, nil,'up', true, _card)
                            end
                            return true
                        end
                    }))
                    break
                end
            end
        end
    end,
}
