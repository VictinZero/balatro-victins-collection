local misc = SMODS.load_file("misc_functions.lua")()

local get_new_boss_ref = get_new_boss
get_new_boss = function()
	-- Tyrian Patriarch
	local possible_patriarch_blinds = G.GAME.VictinsCollection.random_blind_whitelist
	pseudoshuffle(possible_patriarch_blinds, pseudoseed('vic_patriarch'))
	G.GAME.VictinsCollection.patriarch_blinds = {possible_patriarch_blinds[1], possible_patriarch_blinds[2]}

    -- The Mask
    local possible_mask_blinds = G.GAME.VictinsCollection.random_blind_whitelist
    pseudoshuffle(possible_mask_blinds, pseudoseed('vic_mask_setup'))
	G.GAME.VictinsCollection.mask_blinds = {possible_mask_blinds[1], possible_mask_blinds[2], possible_mask_blinds[3]}

    -- Malachite Mask
    local possible_malachite_blinds = G.GAME.VictinsCollection.random_showdown_whitelist
    pseudoshuffle(possible_malachite_blinds, pseudoseed('vic_final_mask_setup'))
	G.GAME.VictinsCollection.malachite_blinds = {possible_malachite_blinds[1], possible_malachite_blinds[2], possible_malachite_blinds[3]}

	local get_new_boss_val = get_new_boss_ref()

	return get_new_boss_val
end
