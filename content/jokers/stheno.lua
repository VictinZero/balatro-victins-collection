local misc
local init, error = SMODS.load_file("misc_functions.lua")
if error then
    sendErrorMessage("VictinsCollection :: Failed to load misc_functions with error " .. error)
else
    misc = init()
end

return {
    key = 'stheno',
    config = {},
    rarity = 2,
    pos = { x = 0, y = 8 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        if (not (G.GAME.blind and G.GAME.blind:get_type() == 'Boss')) and (not G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown) and (G.GAME.round_resets.blind_choices.Boss ~= 'bl_vic_rock') and not from_debuff then
                            G.from_boss_tag = true
                            G.FUNCS.reroll_boss()
                        end
                        return true
                    end
                }))
                return true
            end
        }))
    end,

    calculate = function(self, card, context)
        if context.vic_modify_boss_pool then
            if context.vic_boss_key == 'bl_vic_rock' then
                return { vic_add_to_pool = true, add_to_hand = true }
            elseif context.vic_boss_blind.boss and not (context.vic_boss_blind.boss.showdown) then
                return { vic_remove_from_pool = true, remove_from_hand = true }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        if misc.check_hold_key_info() then
            info_queue[#info_queue+1] = {key = "aux_vic_stheno", set = "Other"}
            info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        end
        return {main_end = misc.generate_main_end_hold_key_info(card)}
    end,
}
