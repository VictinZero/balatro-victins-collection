return {
    name = "The Chaos",
    key = "chaos", 
    pos = { x = 0, y = 0 },
    atlas = "blind_atlas",
    dollars = 5, 
    mult = 2, 
    vars = {}, 
    debuff = {},
    boss = {min = 1, max = 10},
    boss_colour = HEX('D0D2D6'),
    discovered = true,
    loc_txt = {},

    debuff_card = function(self, card, from_blind)
        if not self.disabled and card.area ~= G.jokers then --[[card:set_debuff(true);]] return true end
        --card:set_debuff(false)
        return false
    end,

    debuff_hand = function(self, cards, hand, handname, check)
        if check == nil and next(hand['Straight']) or next(hand['Flush']) then
            for k, v in ipairs(cards) do
                v:set_debuff(false)
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    G.GAME.blind:disable()
                    return true
                end
            }))
        end
        return false
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
