local retrigger_count = function(x)
    return math.floor(math.log(x / 25.) / math.log(2.))
end

return {
    key = 'mammon',
    config = {
        extra = {}
    },
    rarity = 4,
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'joker_atlas',
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and (G.GAME.dollars + (G.GAME.dollar_buffer or 0)) >= 50 then
            return {
                message = localize('k_again_ex'),
                repetitions = retrigger_count(G.GAME.dollars + (G.GAME.dollar_buffer or 0)),
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        local dollars = (G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)
        return {
            vars = {(dollars < 50 and 0) or retrigger_count(dollars), retrigger_count(dollars) == 1 and '' or 's',
                    (dollars < 50 and 50) or (50 * 2 ^ (retrigger_count(dollars)))}
        }
    end
}
