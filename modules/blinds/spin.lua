return {
    name = "The Spin",
    key = "spin", 
    pos = { x = 0, y = 0 },
    atlas = "blind_atlas",
    dollars = 5, 
    mult = 2, 
    vars = {}, 
    debuff = {},
    boss = {min = 1, max = 10},
    boss_colour = HEX('D0D2D6'),
    discovered = true,
    loc_txt = {},

    set_blind = function(self, blind, reset, silent)
        if not reset then
            self.prepped = true
        end
    end,

    drawn_to_hand = function(self)
        sendDebugMessage("The Spin : drawn_to_hand")
        if not self.disabled and self.prepped then
            G.E_MANAGER:add_event(Event({
                --trigger = 'after',
                --delay = 0.7,
                func = function()
                    local any_selected = nil

                    for k, v in ipairs(G.hand.cards) do
                        --G.hand:add_to_highlighted(v, true)
                        G.hand.highlighted[#G.hand.highlighted+1] = v
                        v:highlight(true)
                        any_selected = true
                        play_sound('card1', 1)
                    end
                    if any_selected then
                        G.FUNCS.discard_cards_from_highlighted(nil, true)
                        G.STATE = G.STATES.DRAW_TO_HAND
                        G.E_MANAGER:add_event(Event({
                            trigger = 'immediate',
                            func = function()
                                G.STATE_COMPLETE = false
                                return true
                            end
                        }))
                    end
                    return true
                end
            })) 
            if G.hand.cards[1] then self.triggered = true end
            delay(0.7)
        end
        self.prepped = nil
    end,

    stay_flipped = function(self, area, card)
        sendDebugMessage("The Spin : stay_flipped")
        sendDebugMessage("Disabled? "..tostring(self.disabled))
        sendDebugMessage("Played? "..tostring(G.GAME.current_round.hands_played))
        sendDebugMessage("Discarded? "..tostring(G.GAME.current_round.discards_used))
        sendDebugMessage("Prepped? "..tostring(self.prepped))
        if (not self.disabled) and G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 and self.prepped then
            return true
        end
    end
}
