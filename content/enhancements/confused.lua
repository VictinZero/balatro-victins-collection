return {
    key = 'confused',
    atlas = 'enhancement_atlas',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            disenhancement = true
        }
    },
    weight = 0.,

    draw = function(self, card, layer)
        G.VictinsCollection.shared_sprites.confused_extra.role.draw_major = card
        G.VictinsCollection.shared_sprites.confused_extra:draw_shader('dissolve', nil, nil, nil, card.children.center,
            nil, nil, 7. * G.CARD_W / 12., -7. * G.CARD_H / 24.)
    end,

    calculate = function(self, card, context, effect)
        if context.hand_drawn or context.other_drawn then
            for i = 1, #SMODS.drawn_cards do
                if SMODS.drawn_cards[i] == card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.00,
                        func = function()
                            if card and not card.removed then
                                local p_ = 1
                                for i_ = 1, #G.hand.cards do
                                    if G.hand.cards[i_] == card then
                                        p_ = 1.15 - (i_ - 0.999) / (#G.hand.cards - 0.998) * 0.3
                                        break
                                    end
                                end
                                card:flip()
                                play_sound('card1', p_)
                                card:juice_up(0.3, 0.3)
                            end
                            return true
                        end
                    }))
                    delay(0.2)

                    local suit_ = pseudorandom_element(SMODS.Suits, pseudoseed('vic_confused_suit')).key
                    local rank_ = pseudorandom_element(SMODS.Ranks, pseudoseed('vic_confused_rank')).key

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if card and not card.removed then
                                SMODS.change_base(card, suit_, rank_)
                            end
                            return true
                        end
                    }))

                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            if card and not card.removed then
                                local p_ = 1
                                for i_ = 1, #G.hand.cards do
                                    if G.hand.cards[i_] == card then
                                        p_ = 0.85 + (i_ - 0.999) / (#G.hand.cards - 0.998) * 0.3
                                        break
                                    end
                                end
                                card:flip()
                                play_sound('tarot2', p_, 0.6)
                                card:juice_up(0.3, 0.3)
                            end
                            return true
                        end
                    }))
                    delay(0.05)
                    break
                end
            end
        end
    end
}
