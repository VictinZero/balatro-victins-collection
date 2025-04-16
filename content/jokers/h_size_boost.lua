return {
    key = 'h_size_boost',
    config = {extra={h_size = 6, flag = false}},
    rarity = 2,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if (context.after or context.first_hand_drawn) and (G.GAME.current_round.hands_left == 1) then
            G.hand:change_size(card.ability.extra.h_size)
            card.ability.extra.flag = true
        elseif context.end_of_round and context.game_over ~= nil and card.ability.extra.flag then
            G.hand:change_size(-card.ability.extra.h_size)
            card.ability.extra.flag = false
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        if G.GAME.current_round.hands_left == 1 and not from_debuff then G.hand:change_size(-card.ability.extra.h_size) end
    end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.h_size}}
    end,
}
