local misc = SMODS.load_file("misc_functions.lua")()

return {
    key = "final_mask",
    pos = { x = 0, y = 5 },
    atlas = "showdown_atlas",
    dollars = 8,
    mult = 2,
    vars = {},
    debuff = {},
    boss = { min = 4, max = 10 },
    boss_colour = HEX('0bda51'),
    discovered = true,
    loc_txt = {},

    vic_tooltip = function(blind_choice)
        local tooltip_blinds = G.GAME.VictinsCollection.malachite_blinds or {'bl_final_bell', 'bl_final_leaf', 'bl_final_vessel'}

        local function tmp()
            local tooltips_to_be_added = {}
            for k, v in ipairs(tooltip_blinds) do
                table.insert(tooltips_to_be_added, k, misc.create_UIBox_blind_popup_with_icon(v, true))
            end

            local nodes_to_be_added = {}
            for k, v in ipairs(tooltips_to_be_added) do
                table.insert(nodes_to_be_added,
                    {
                        n=G.UIT.C,
                        config={
                            align = "cm",
                            padding = 0.05,
                            colour = lighten(G.C.JOKER_GREY, 0.5),
                            r = 0.1,
                            emboss = 0.05
                        },
                        nodes = v,
                    }
                )
            end

            return nodes_to_be_added
        end

        misc.create_blind_tooltip(blind_choice, tmp)
    end,

    set_blind = function(self)
        if (not G.GAME.blind.disabled) then
            local original_blind = G.GAME.blind.config.blind.key

            local options = G.GAME.VictinsCollection.malachite_blinds or {'bl_final_bell', 'bl_final_leaf', 'bl_final_vessel'}

            local next_blind = pseudorandom_element(options, pseudoseed('vic_final_mask'))

            G.GAME.blind:set_blind(G.P_BLINDS[next_blind])
            G.GAME.blind.dollars = G.P_BLINDS[original_blind].dollars
            G.GAME.current_round.dollars_to_be_earned = G.GAME.blind.dollars > 0 and (string.rep(localize('$'), G.GAME.blind.dollars)..'') or ('')
            G.GAME.blind.vic_original_blind = original_blind
        end
    end,

    disable = function(self)
        self.disabled = true
    end,
}
