return {
    key = "final_dragon",
    pos = { x = 0, y = 0 },
    atlas = "showdown_atlas",
    dollars = 8,
    mult = 2,
    vars = {},
    debuff = {},
    boss = {showdown = true, min = 1, max = 10},
    boss_colour = HEX('cc8217'),
    discovered = true,
    loc_txt = {},

    --[[calculate = function(self, blind, context)
        if context.final_scoring_step and not blind.disabled then
            local new_chips = math.max(math.min(hand_chips, math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0)))), 1)
            new_chips = mod_chips(new_chips)

            return {chips = new_chips - hand_chips}
        end
    end,]]

    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        G.GAME.blind.triggered = true
        return mult, math.max(math.min(hand_chips, math.floor(0.5*(G.GAME.dollars + (G.GAME.dollar_buffer or 0)))), 1), true
    end
}
