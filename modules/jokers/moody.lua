return {
    key = 'moody',
    config = {extra={level_pos=2, level_neg=1}},
    rarity = 1,
    pos = { x = 2, y = 0 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible then _poker_hands[#_poker_hands+1] = k end
            end
            pseudoshuffle(_poker_hands, pseudoseed("moody"))

            local _hand = _poker_hands[1]
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {
                        handname = _hand,
                        chips = G.GAME.hands[_hand].chips,
                        mult = G.GAME.hands[_hand].mult,
                        level= G.GAME.hands[_hand].level})
            level_up_hand(card, _hand, nil, card.ability.extra.level_pos)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
            delay(0.1)

            for i = 2, #_poker_hands do
                _hand = _poker_hands[i]
                local levels_to_decrease = math.max(1 - G.GAME.hands[_hand].level, -card.ability.extra.level_neg)

                if levels_to_decrease < 0 then
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {
                            handname = _hand,
                            chips = G.GAME.hands[_hand].chips,
                            mult = G.GAME.hands[_hand].mult,
                            level = G.GAME.hands[_hand].level})
                    level_up_hand(card, _hand, nil, levels_to_decrease)
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
                    break
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.level_pos, card.ability.extra.level_neg}}
    end,
}
