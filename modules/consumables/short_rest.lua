return {
    key = 'short_rest',
    name = "Short Rest",
    config = {},
    set = "Token",
    cost = 0,
    pos = {x = 0, y = 0},
    atlas = 'joker_atlas',
    loc_txt = {},
    discovered = true,

    can_use = function(self, card)
        return G.STATE == G.STATES.SELECTING_HAND
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                local discards = math.max(G.GAME.round_resets.discards - G.GAME.current_round.discards_left, 0)
                local hands = math.max(G.GAME.round_resets.hands - G.GAME.current_round.hands_left, 0)
                if hands > 0 then ease_hands_played(hands) end
                if discards > 0 then ease_discard(discards) end
                G.FUNCS.draw_from_discard_to_deck()
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.FUNCS.draw_from_deck_to_hand(nil)
                        return true
                    end
                }))
                return true
            end
        }))
    end
}
