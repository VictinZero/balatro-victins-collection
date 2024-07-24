return {
    key = 'grappling_hook',
    config = {},
    rarity = 1,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.after then
            if not G.GAME.VictinsCollection.post_discard_draw then G.GAME.VictinsCollection.post_discard_draw = {} end
            G.GAME.VictinsCollection.post_discard_draw[#G.GAME.VictinsCollection.post_discard_draw + 1] = context.full_hand[1]
        end
    end,
}
