return {
    name = "Black Gold",
    key = "final_gold", 
    pos = { x = 0, y = 1 },
    atlas = "showdown_atlas",
    dollars = 8, 
    mult = 2, 
    vars = {}, 
    debuff = {},
    boss = {showdown = true, min = 10, max = 10},
    boss_colour = HEX('494949'),
    discovered = true,
    loc_txt = {},

    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        G.GAME.blind.triggered = true
        return mult, math.max(math.min(hand_chips, math.floor(0.5*(G.GAME.dollars + (G.GAME.dollar_buffer or 0)))), 1), true
    end,
}
