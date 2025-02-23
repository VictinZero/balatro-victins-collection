return {
    key = 'morning',
    atlas = 'enhancement_morning',
    pos = { x = 0, y = 0 },
    config = { extra = { shader = false }},
    weight = 0.,

    calculate = function(self, card, context, effect)
        if not card.ability.extra.shader then card:set_edition("e_vic_chowder", true, true); card.ability.extra.shader = true end
    end,
}
