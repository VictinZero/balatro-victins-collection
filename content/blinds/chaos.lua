return {
    name = "The Chaos",
    key = "chaos",
    pos = { x = 0, y = 13 },
    atlas = "blind_atlas",
    dollars = 5,
    mult = 2,
    vars = {},
    debuff = {},
    boss = {min = 1, max = 10},
    boss_colour = HEX('D0D2D6'),
    discovered = true,
    loc_txt = {},

    recalc_debuff = function(self, card, from_blind)
        if not self.disabled and (card.ability.set == 'Default' or card.ability.set == 'Enhanced') then return true end
        return false
    end,

    calculate = function(self, blind, context)
        if context.before and (next(context.poker_hands['Straight']) or next(context.poker_hands['Flush'])) then
            blind.disabled = true
            for _, v in ipairs(G.playing_cards) do
                blind:debuff_card(v)
            end
            G.GAME.blind:set_text()
            G.GAME.blind:wiggle()
        end
    end,

    disable = function(self)
        self.disabled = true
        for _, v in ipairs(G.playing_cards) do
            self:debuff_card(v)
        end
        G.GAME.blind:set_text()
        G.GAME.blind:wiggle()
    end,
}
