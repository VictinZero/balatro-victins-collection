return {
    key = 'neat',
    config = {extra = {hand_size = 2, status = false}},
    rarity = 1,
    pos = { x = 3, y = 2 },
    atlas = 'joker_soul_atlas',
    cost = 1,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = { x = 3, y = 3},

    add_to_deck = function(self, card, from_debuff)
        if G.GAME.last_hand_played == 'Straight' then
            G.hand:change_size(card.ability.extra.hand_size)
            card.ability.extra.status = true
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.status then
            G.hand:change_size(-card.ability.extra.hand_size)
            card.ability.extra.status = false
        end
    end,

    calc_dollar_bonus = function(self, card)
        if G.GAME.last_hand_played == 'Straight' and (not card.ability.extra.status) then
            G.hand:change_size(card.ability.extra.hand_size)
            card.ability.extra.status = true
        end
        if (not G.GAME.last_hand_played == 'Straight') and card.ability.extra.status then
            G.hand:change_size(-card.ability.extra.hand_size)
            card.ability.extra.status = false
        end

        return nil
    end,
}
