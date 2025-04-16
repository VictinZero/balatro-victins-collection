return {
    key = 'ophiucus',
    name = "Ophiucus",
    config = {},
    set = "Zodiac",
    cost = 4,
    pos = {x = 0, y = 0},
    atlas = 'joker_atlas',
    loc_txt = {},
    discovered = true,
    hidden = true,

    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        for _, v in ipairs(G.ca_vic_zodiac.cards) do
            local zodiac = v.ability.extra.zodiac
            G.GAME.VictinsCollection.zodiac[zodiac] = G.GAME.VictinsCollection.zodiac[zodiac] + 1
            v.ability.extra.level = G.GAME.VictinsCollection.zodiac[zodiac]
            v:juice_up()
        end
    end
}
