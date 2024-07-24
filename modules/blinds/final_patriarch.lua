local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

return {
    name = "The Tyrian Patriarch",
    key = "final_patriarch", 
    pos = { x = 0, y = 4 },
    atlas = "showdown_atlas",
    dollars = 8,
    mult = 2, 
    vars = {}, 
    debuff = {},
    boss = {showdown = true, min = 1, max = 10},--showdown = true
    boss_colour = HEX('973ba5'),
    discovered = true,
    loc_txt = {},

    vic_tooltip = function(blind_choice)
        local tooltip_blinds = {
            G.GAME.VictinsCollection.patriarch_blinds[1] or 'bl_goad',
            G.GAME.VictinsCollection.patriarch_blinds[2] or 'bl_plant'
        }

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
        if (not G.GAME.blind.vic_patriarch_blinds) and (not G.GAME.blind.disabled) then
            sendDebugMessage("Setting Final Patriarch when there are no Patriarch Blinds")
            local original_blind = G.GAME.blind.config.blind.key

            local blind_1 = G.GAME.VictinsCollection.patriarch_blinds[1] or 'bl_goad'
            local blind_2 = G.GAME.VictinsCollection.patriarch_blinds[2] or 'bl_plant'
            local blinds = {blind_1, blind_2, 'bl_vic_final_patriarch'}

            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    local card = create_card('Token', G.consumeables, nil, nil, nil, nil, 'c_vic_short_rest', 'placeholder')
                    card:set_edition({negative = true})
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    return true
                end
            }))

            local next_blind = table.remove(blinds, 1)

            sendDebugMessage("Original blind is "..tostring(original_blind))

            sendDebugMessage("Next blind is "..tostring(next_blind))

            sendNestedMessage(G.P_BLINDS[next_blind])

            G.GAME.blind:set_blind(G.P_BLINDS[next_blind])
            G.GAME.blind.dollars = G.P_BLINDS[original_blind].dollars
            G.GAME.current_round.dollars_to_be_earned = G.GAME.blind.dollars > 0 and (string.rep(localize('$'), G.GAME.blind.dollars)..'') or ('')
            G.GAME.blind.vic_original_blind = original_blind
            G.GAME.blind.vic_patriarch_blinds = blinds
            sendDebugMessage("Finish setting Final Patriarch when there are no Patriarch Blinds")
        end
    end,

    disable = function(self)
        self.disabled = true
    end,
}
