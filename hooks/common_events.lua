local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

local get_new_boss_ref = get_new_boss
get_new_boss = function()
	-- Tyrian Patriarch

	local possible_patriarch_blinds = {
		'bl_hook',
		'bl_ox',
		'bl_wall',
		'bl_wheel',
		'bl_arm',
		'bl_club',
		'bl_fish',
		'bl_psychic',
		'bl_goad',
		'bl_window',
		'bl_manacle',
		'bl_eye',
		'bl_mouth',
		'bl_plant',
		'bl_serpent',
		'bl_pillar',
		'bl_head',
		'bl_tooth',
		'bl_flint',
		'bl_mark',
		'bl_vic_worm',
		'bl_vic_rock',
		'bl_vic_bell',
		'bl_vic_spin',
		'bl_vic_chaos'
	}

	pseudoshuffle(possible_patriarch_blinds, pseudoseed('patriarch'))

	G.GAME.VictinsCollection.patriarch_blinds = {possible_patriarch_blinds[1], possible_patriarch_blinds[2]}

	local get_new_boss_val = get_new_boss_ref()

	return get_new_boss_val
end
