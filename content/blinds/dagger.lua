return {
    name = "The Dagger",
    key = "dagger",
    pos = {
        x = 0,
        y = 13
    },
    atlas = "blind_atlas",
    dollars = 5,
    mult = 2,
    vars = {},
    debuff = {},
    boss = {
        min = 1,
        max = 10
    }, -- {min = 4, max = 10},
    boss_colour = HEX('F03C3C'),
    discovered = true,
    loc_txt = {},

    debuff_hand = function(self, cards, hand, handname, check)
        for i = 1, #G.playing_cards do
            if G.playing_cards[i] and not G.playing_cards[i].removed then
                G.playing_cards[i].ability.vic_dagger_mark = nil
            end
        end
        if not G.GAME.blind.disabled then
            for k, v in ipairs(cards) do
                if v and not v.removed then
                    v.ability.vic_dagger_mark = true
                end
            end
        end
        return false
    end,

    defeat = function(self)
        if not G.GAME.blind.disabled then
            G.GAME.blind.triggered = true
            for i = 1, #G.playing_cards do
                if G.playing_cards[i] and not G.playing_cards[i].removed then
                    G.playing_cards[i].ability.vic_dagger_mark = nil
                end
            end
        end
        return
    end,

    disable = function(self)
        for i = 1, #G.playing_cards do
            if G.playing_cards[i] and not G.playing_cards[i].removed then
                G.playing_cards[i].ability.vic_dagger_mark = nil
            end
        end
    end
}
