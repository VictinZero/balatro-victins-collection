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

	-- Forcing Bosses

	G.GAME.VictinsCollection.champions_belt = G.GAME.VictinsCollection.adding_champions_belt or (next(SMODS.find_card('j_vic_champions_belt')) and true) or false
	G.GAME.VictinsCollection.stheno = G.GAME.VictinsCollection.adding_stheno or (next(SMODS.find_card('j_vic_stheno')) and true) or false

	if G.GAME.VictinsCollection.champions_belt then
		local boss = misc.random_showdown_blind('champions_belt')
		if boss then G.FORCE_BOSS = boss end
	elseif (not (G.GAME.round_resets.ante%G.GAME.win_ante == 0 or (G.GAME.round_resets.blind_choices.Boss and G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown))) and G.GAME.VictinsCollection.stheno then
		G.FORCE_BOSS = 'bl_vic_rock'
	else
		G.FORCE_BOSS = nil
	end

	local get_new_boss_val = get_new_boss_ref()

	G.FORCE_BOSS = nil

	return get_new_boss_val
end
