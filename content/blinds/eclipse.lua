return {
    name = "The Eclipse",
    key = "eclipse", 
    pos = { x = 0, y = 0 },
    atlas = "blind_atlas",
    dollars = 5, 
    mult = 2, 
    vars = {}, 
    debuff = {},
    boss = {min = 4, max = 10},
    boss_colour = HEX('FFD791'),
    discovered = true,
    loc_txt = {},

    stay_flipped = function(self, area, card)
        if area == G.hand and (card:is_suit('Hearts', true, false) or card:is_suit('Clubs', true, false)) then
            card.ability.wheel_flipped = true
            return true
        end
    end,

    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' and card.ability.wheel_flipped then
                G.hand.cards[i]:flip()
            end
        end
        for k, v in pairs(G.playing_cards) do
            v.ability.wheel_flipped = nil
        end
    end
}
