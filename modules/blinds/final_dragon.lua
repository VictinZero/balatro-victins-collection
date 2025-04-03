local blind_size = 2
local scaling_factor = 0.5

return {
    name = "The Golden Dragon",
    key = "final_dragon",
    pos = {
        x = 0,
        y = 0
    },
    atlas = "showdown_atlas",
    dollars = 8,
    mult = blind_size,
    vars = {},
    debuff = {},
    boss = {
        showdown = true,
        min = 1,
        max = 10
    },
    boss_colour = HEX('cc8217'),
    discovered = true,
    loc_txt = {},

    calculate = function(self, blind, context)
        if (context.setting_blind) and not blind.disabled then
            local difficulty = -10
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i]:can_calculate(true) and G.jokers.cards[i].area and G.jokers.cards[i].area ==
                    G.jokers then
                    difficulty = difficulty + G.jokers.cards[i].sell_cost
                end
            end
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i]:can_calculate(true) and G.consumeables.cards[i].area and
                    G.consumeables.cards[i].area == G.consumeables then
                    difficulty = difficulty + G.consumeables.cards[i].sell_cost
                end
            end
            difficulty = math.max(0, difficulty)

            if difficulty > 0 then
                local create_dragon_event = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.8,
                        func = function()
                            if G.hand_text_area.blind_chips then
                                local new_chips = G.GAME.blind.chips +
                                                      math.floor(
                                        get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling *
                                            scaling_factor * difficulty)
                                local mod_text = number_format(math.floor(
                                    get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling *
                                        scaling_factor * difficulty))

                                G.GAME.blind.chips = new_chips
                                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)

                                local chips_UI = G.hand_text_area.blind_chips
                                G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                                G.HUD_blind:recalculate()

                                attention_text({
                                    text = '+' .. mod_text,
                                    scale = 0.8,
                                    hold = 0.7,
                                    cover = chips_UI.parent,
                                    cover_colour = G.C.RED,
                                    align = 'cm'
                                })

                                chips_UI:juice_up()

                                play_sound('chips2')
                            else
                                return false
                            end
                            return true
                        end
                    }))
                end
                create_dragon_event()
            end
        end
    end,

    disable = function(self)
        local create_dragon_event = function()
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.8,
                func = function()
                    if G.hand_text_area.blind_chips then
                        local new_chips = get_blind_amount(G.GAME.round_resets.ante) * blind_size *
                                              G.GAME.starting_params.ante_scaling
                        local mod_text = number_format(G.GAME.blind.chips - new_chips)

                        G.GAME.blind.chips = new_chips
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)

                        local chips_UI = G.hand_text_area.blind_chips
                        G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                        G.HUD_blind:recalculate()

                        attention_text({
                            text = '-' .. mod_text,
                            scale = 0.8,
                            hold = 0.7,
                            cover = chips_UI.parent,
                            cover_colour = G.C.GREEN,
                            align = 'cm'
                        })

                        chips_UI:juice_up()

                        play_sound('chips2')

                        if G.GAME.chips >= G.GAME.blind.chips then
                            G.E_MANAGER:add_event(Event({
                                trigger = 'immediate',
                                func = function()
                                    if G.STATE == G.STATES.SELECTING_HAND then
                                        G.STATE = G.STATES.HAND_PLAYED
                                        G.STATE_COMPLETE = true
                                        end_round()
                                    end
                                    return true
                                end
                            }))
                        end
                    else
                        return false
                    end
                    return true
                end
            }))
        end
        create_dragon_event()
    end,

    loc_vars = function(self)
        return {
            vars = {number_format(math.floor(get_blind_amount(G.GAME.round_resets.ante) *
                                                 G.GAME.starting_params.ante_scaling * scaling_factor))}
        }
    end,

    collection_loc_vars = function(self)
        return {
            vars = {'X' .. number_format(scaling_factor)}
        }
    end
}
