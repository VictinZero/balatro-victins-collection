return {
    key = 'burning',
    atlas = 'enhancement_atlas',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            discards = 1
        }
    },

    calculate = function(self, card, context, effect)
        if context.press_play then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local any_selected = nil
                    local _cards = {}
                    for k, v in ipairs(G.hand.cards) do
                        _cards[#_cards + 1] = v
                    end
                    for i = 1, card.ability.extra.discards do
                        if G.hand.cards[i] then
                            local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('m_vic_burning'))
                            G.hand:add_to_highlighted(selected_card, true)
                            table.remove(_cards, card_key)
                            any_selected = true
                            play_sound('card1', 1)
                        end
                    end
                    if any_selected then
                        G.FUNCS.discard_cards_from_highlighted(nil, true)
                    end
                    return true
                end
            }))
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {self.config.extra.discards}
        }
    end
}
