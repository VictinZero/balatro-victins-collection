return {
    key = 'nine_lives',
    config = { extra = { lives = 9 } },
    rarity = 3,
    pos = { x = 0, y = 8 },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.after and (G.GAME.chips - G.GAME.blind.chips <= 0) and (G.GAME.current_round.hands_left < 1) and (not context.blueprint) then
            G.GAME.round_resets.hands = 1
            ease_hands_played(1 - G.GAME.current_round.hands_left)
            card.ability.extra.lives = card.ability.extra.lives - 1
            if card.ability.extra.lives <= 0 then
                card.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
            end
            return {
                message = tostring(card.ability.extra.lives)
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.lives } }
    end,
}
