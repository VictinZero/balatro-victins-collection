-- Repeat Wild Cards; or
-- Repeat hand containing Wild Card

return {
    key = 'paradise_parrot',
    config = {extra={repetitions = 1}},
    rarity = 1,
    pos = { x = 0, y = 8 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,
    enhancement_gate = 'm_wild',

    calculate = function(self, card, context)
        if context.repetition and SMODS.has_enhancement(context.other_card.ability.name, 'm_wild') then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.repetitions,
            }
        end
    end,
}
