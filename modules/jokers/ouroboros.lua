local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

local _generate_main_end = function(card)
    local main_end = nil
    if not misc.is_in_your_collection(card) then
        local active = G.STATE == G.STATES.SELECTING_HAND

        local colour = (active and G.C.GREEN) or G.C.RED
        local txt = (active and localize('k_active')) or localize('k_vic_inactive')
        main_end = {
            {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                {n=G.UIT.C, config={align = "m", colour = colour, r = 0.05, padding = 0.05}, nodes={
                    {n=G.UIT.T, config={text = ' '..txt..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                }}
            }}
        }
    end
    return main_end
end

return {
    key = 'ouroboros',
    config = {},
    rarity = 1,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.selling_self and G.STATE == G.STATES.SELECTING_HAND then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local discards = math.max(G.GAME.round_resets.discards - G.GAME.current_round.discards_left, 0)
                    local hands = math.max(G.GAME.round_resets.hands - G.GAME.current_round.hands_left, 0)
                    if hands > 0 then ease_hands_played(hands) end
                    if discards > 0 then ease_discard(discards) end
                    G.FUNCS.draw_from_discard_to_deck()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            G.FUNCS.draw_from_deck_to_hand(nil)
                            return true
                        end
                    }))
                    return true
                end
            }))
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {main_end = _generate_main_end(card)}
    end
}
