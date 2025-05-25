local is_fibonacci = function(card)
    return card:get_id() == 2 or card:get_id() == 3 or card:get_id() == 5 or card:get_id() == 8 or card:get_id() == 14
end

return {
    key = 'golden_ratio',
    config = { extra = { dollars = 2 } },
    rarity = 1,
    pos = { x = 7, y = 0 },
    atlas = 'joker_atlas',
    cost = 1,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.end_of_round and context.individual and context.cardarea == G.hand then
            local target_card = context.other_card
            if target_card:can_calculate() and is_fibonacci(target_card) then
                return { dollars = card.ability.extra.dollars }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end
}
