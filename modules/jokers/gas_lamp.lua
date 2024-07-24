return {
    key = 'gas_lamp',
    config = {extra={extra_draw = 4, h_size = 1}},
    rarity = 1,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    add_to_deck = function(self, card, from_debuff)
        sendDebugMessage("Added Gas Lamp to deck")
        G.hand:change_size(-card.ability.extra.h_size)
    end,

    calculate = function(self, card, context)
        if context.first_hand_drawn and #G.deck.cards > 0 then
            local cards_to_draw = math.min(#G.deck.cards, card.ability.extra.extra_draw)
            if cards_to_draw > 0 then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = 'gaslight', colour = G.C.PURPLE})
            end
            for i = 1, math.min(#G.deck.cards, card.ability.extra.extra_draw) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        G.GAME.VictinsCollection.n_flipped_cards = (G.GAME.VictinsCollection.n_flipped_cards or 0) + 1
                        draw_card(G.deck, G.hand, i*100/card.ability.extra.extra_draw, 'up', true)
                        return true
                    end
                }))
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        sendDebugMessage("Removed Gas Lamp from deck")
        G.hand:change_size(card.ability.extra.h_size)
    end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.extra_draw, card.ability.extra.h_size}}
    end,
}
