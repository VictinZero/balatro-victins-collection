return {
    name = "The Wind",
    key = "wind",
    pos = { x = 0, y = 0 },
    atlas = "blind_atlas",
    dollars = 5,
    mult = 2,
    vars = {},
    debuff = {},
    boss = { min = 1, max = 10 },
    boss_colour = HEX('D0D2D6'),
    discovered = true,
    loc_txt = {},

    calculate = function(self, blind, context)
        if context.press_play and not blind.disabled then
            ease_discard(-1, true)
        end
        if context.pre_discard and not blind.disabled then
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            ease_hands_played(-1, true)
                            return true
                        end
                    }))
                    return true
                end
            }))
        end
    end
}
