return {
    name = "The Worm",
    key = "worm", 
    pos = { x = 0, y = 1 },
    atlas = "blind_atlas",
    dollars = 5, 
    mult = 2, 
    vars = {}, 
    debuff = {},
    boss = {min = 1, max = 10},
    boss_colour = HEX('F6C0DC'),
    discovered = true,
    loc_txt = {},

    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        G.GAME.blind.triggered = true
        return mult, math.max(5*G.GAME.hands[text].level, 1), true
    end
}
