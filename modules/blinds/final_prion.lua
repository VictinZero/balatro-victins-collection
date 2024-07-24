return {
    name = "Purpura Prion",
    key = "final_prion", 
    pos = { x = 0, y = 0 },
    atlas = "blind_atlas",
    dollars = 8, 
    mult = 2, 
    vars = {}, 
    debuff = {},
    boss = {showdown = true, min = 10, max = 10},
    boss_colour = HEX('66023C'),
    discovered = true,
    loc_txt = {},

    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        G.GAME.blind.triggered = true
        return math.max(G.GAME.hands[text].level, 1), 5*math.max(G.GAME.hands[text].level, 1), true
    end
}
