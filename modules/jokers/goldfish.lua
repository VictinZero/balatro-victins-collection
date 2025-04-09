return {
    key = 'goldfish',
    config = {},
    rarity = 2,
    pos = { x = 0, y = 8 },
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calc_dollar_bonus = function(self, card)
        for k, v in ipairs(G.handlist) do
            if G.GAME.last_hand_played == v then
                return #G.handlist - k + 1
            end
        end
    end,
}
