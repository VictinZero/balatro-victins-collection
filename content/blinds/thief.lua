return {
    key = "thief",
    pos = { x = 0, y = 13 },
    atlas = "blind_atlas",
    dollars = 5,
    mult = 2,
    vars = {},
    debuff = {},
    boss = { min = 5, max = 10 },
    boss_colour = HEX('191970'),
    discovered = true,
    loc_txt = {},

    set_blind = function(self)
        if not self.prepped then
            G.GAME.VictinsCollection.thief_countdown = 4
            self.prepped = true
        end
    end,

    calculate = function(self, blind, context)
        if (context.press_play or context.pre_discard) and not blind.disabled then
            G.GAME.VictinsCollection.thief_countdown = G.GAME.VictinsCollection.thief_countdown - 1
        end
        if context.hand_drawn and G.GAME.VictinsCollection.thief_countdown <= 0 and not blind.disabled then
            if G.hand_text_area.blind_chips then
                local new_chips = G.GAME.chips or 0
                local mod_text = number_format(
                    math.ceil(G.GAME.chips - G.GAME.blind.chips)
                )

                G.GAME.blind.chips = new_chips
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)

                local chips_UI = G.hand_text_area.blind_chips
                G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                G.HUD_blind:recalculate()

                if chips_UI then
                    attention_text({
                        text = '-' .. mod_text,
                        scale = 0.8,
                        hold = 0.7,
                        cover = chips_UI.parent,
                        cover_colour = G.C.GREEN,
                        align = 'cm'
                    })

                    chips_UI:juice_up()
                end

                attention_text({
                    text = "Escaped!",
                    scale = 1,
                    hold = 1.0,
                    rotate = math.pi / 8,
                    backdrop_colour = G.GAME.blind.boss_colour,
                    align = "cm",
                    major = G.GAME.blind,
                    offset = {x = 0, y = 0.1}
                })

                play_sound('chips2')

                local stolen_money = math.max(G.GAME.dollars + (G.GAME.dollar_buffer or 0), 0)
                if stolen_money > 0 then
                    -- G.GAME.VictinsCollection.thief_stolen_money = stolen_money
                    ease_dollars(-stolen_money)
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - stolen_money
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            G.GAME.dollar_buffer = 0; return true
                        end)
                    }))
                end

                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.STATE = G.STATES.NEW_ROUND
                        G.STATE_COMPLETE = false
                        return true
                    end
                }))
            end
        end
    end,

    disable = function(self)
        G.GAME.VictinsCollection.thief_countdown = 4
    end,

    loc_vars = function(self)
        return { vars = { G.GAME.VictinsCollection.thief_countdown or 5 } }
    end,

    collection_loc_vars = function(self)
        return { vars = { G.GAME and G.GAME.VictinsCollection and G.GAME.VictinsCollection.thief_countdown or 5 } }
    end,
}
