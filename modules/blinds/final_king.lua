return {
    name = "The Red King",
    key = "final_king",
    pos = {
        x = 0,
        y = 0
    },
    atlas = "showdown_atlas",
    dollars = 8,
    mult = 2,
    vars = {},
    debuff = {},
    boss = {
        showdown = true,
        min = 1
    },
    boss_colour = HEX('9c1517'),
    discovered = true,
    loc_txt = {},

    set_blind = function(self, reset, silent)
        local base_height, height_diff = -1.25, 0.5

        G.E_MANAGER:add_event(Event({
            blocking = false,
            blockable = false,
            func = function()
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blocking = false,
                    delay = G.SETTINGS.GAMESPEED * (G.SETTINGS.GAMESPEED * ((#G.GAME.blind.loc_debuff_text) * 0.035 + 0.6)),
                    func = function()
                        local hold_time = G.SETTINGS.GAMESPEED * (15 * 0.135 + 1.5)
                        local disp_text = "What a beautiful day..."
                        attention_text({
                            scale = 1.2,
                            text = disp_text,
                            maxw = 12,
                            hold = hold_time,
                            align = 'cm',
                            offset = {
                                x = 0,
                                y = base_height - height_diff
                            },
                            major = G.play -- colour = G.GAME.blind.config.blind.boss_colour
                        })
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            blocking = false,
                            delay = G.SETTINGS.GAMESPEED * (15 * 0.135 + 1.3) * 0.5,
                            func = function()
                                local hold_time = G.SETTINGS.GAMESPEED * ((15 * 0.135)*0.5 + 1.5 - 1.3*0.5)
                                local disp_text = "for a war."
                                attention_text({
                                    scale = 1.2,
                                    text = disp_text,
                                    maxw = 12,
                                    hold = hold_time,
                                    align = 'cm',
                                    offset = {
                                        x = 0,
                                        y = base_height + height_diff
                                    },
                                    major = G.play -- colour = G.GAME.blind.config.blind.boss_colour
                                })
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return true
            end
        }))
    end,

    calculate = function(self, blind, context)
        if context.vic_replay_hand then
            G.GAME.VictinsCollection.replay_hand = true
            return {
                repetitions = 1
            }
        end
    end
}
