return {
    key = 'bone',
    config = {},
    rarity = 1,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 1,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.discard and not context.blueprint and context.other_card and #context.full_hand == 1 then
            for i = 1, #G.hand.cards do
                local target_card = G.hand.cards[i]
                target_card.ability.perma_bonus = (target_card.ability.perma_bonus or 0) + context.other_card:get_chip_bonus()
            end
            return {
                remove = true,
                card = card
            }
        end
    end,
}
