return {
    key = 'champion',
    config = {extra={difficulty=1.5, dollars=9}},
    rarity = 1,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    calc_dollar_bonus = function (self, card)
        return card.ability.extra.dollars
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not self.getting_sliced and not context.blueprint then
            local create_champion_event = function()
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.8, func = function()
                    if G.hand_text_area.blind_chips then
                        local new_chips = math.floor(G.GAME.blind.chips * card.ability.extra.difficulty)
                        local mod_text = number_format(math.floor(G.GAME.blind.chips * card.ability.extra.difficulty) - G.GAME.blind.chips)
                        G.GAME.blind.chips = new_chips
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        
                        local chips_UI = G.hand_text_area.blind_chips
                        G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                        G.HUD_blind:recalculate() 

                        attention_text({
                            text = '+'..mod_text,
                            scale = 0.8, 
                            hold = 0.7,
                            cover = chips_UI.parent,
                            cover_colour = G.C.RED,
                            align = 'cm',
                        })

                        chips_UI:juice_up()

                        play_sound('chips2')
                    else
                        create_champion_event()
                    end
                    return true end
                }))
            end
            create_champion_event()
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.difficulty, card.ability.extra.dollars}}
    end,
    
    subtitle = {
        text = {"The game just got harder!",}
    }
}
