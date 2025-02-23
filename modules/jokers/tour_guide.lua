return {
    key = 'tour_guide',
    config = {},
    rarity = 1,
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.first_hand_drawn and #G.deck.cards > 0 then
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                func = function()
                    local _cards = {}
                    for i = 1, #G.deck.cards do
                        local _card = G.deck.cards[i]
                        if _card:get_id() == 3 and not _card.ability.vic_drawing then
                            _cards[#_cards + 1] = _card
                        end
                    end
                    if #_cards > 0 then
                        local _card = pseudorandom_element(_cards, pseudoseed("j_vic_tour_guide"))
                        _card.ability.vic_drawing = true
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                            message = 'tour guide',
                            colour = G.C.PURPLE,
                            instant = true
                        })
                        -- if _card and not _card.removed and _card.area == G.deck then
                        draw_card(G.deck, G.hand, nil, 'up', true, _card)
                        -- end
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.1,
                            func = function()
                                _card.ability.vic_drawing = nil
                                return true
                            end
                        }))
                    end
                    return true
                end
            }))
        end
    end
}
