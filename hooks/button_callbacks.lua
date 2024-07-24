local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

local reroll_boss_ref = G.FUNCS.reroll_boss

G.FUNCS.reroll_boss = function(e)
	--[[local previous_force_boss = G.FORCE_BOSS
	local changed_force_boss = true]]
	
	sendDebugMessage("Force Boss?")

	G.GAME.VictinsCollection.champions_belt = G.GAME.VictinsCollection.adding_champions_belt or (next(SMODS.find_card('j_vic_champions_belt')) and true) or false
	G.GAME.VictinsCollection.stheno = G.GAME.VictinsCollection.adding_stheno or (next(SMODS.find_card('j_vic_stheno')) and true) or false

	if G.GAME.VictinsCollection.champions_belt then
		sendDebugMessage("Found Champion's Belt!")
		local boss = misc.random_showdown_blind('champions_belt')
		sendDebugMessage("New Boss is "..tostring(boss))
		if boss then G.FORCE_BOSS = boss end
	elseif (not ((G.GAME.round_resets.ante)%G.GAME.win_ante == 0 or G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown)) and G.GAME.VictinsCollection.stheno then
		sendDebugMessage("Found Stheno!")
		G.FORCE_BOSS = 'bl_vic_rock'
	--[[else
		changed_force_boss = false]]
	else
		G.FORCE_BOSS = nil
	end

	--[[local get_new_boss_ref = get_new_boss

	sendDebugMessage("Hook get_new_boss!")
	get_new_boss = function()
		sendDebugMessage("Call original get_new_boss!")
		local get_new_boss_val = get_new_boss_ref()
		if changed_force_boss then
			sendDebugMessage("Revert Force Boss!")
			G.FORCE_BOSS = previous_force_boss
		end
		get_new_boss = get_new_boss_ref
		return get_new_boss_val
	end]]

	sendDebugMessage("Call original reroll_boss!")
	local reroll_boss_val = reroll_boss_ref(e)

	return reroll_boss_val
end

--[[[manifest]
version = "1.0.0"
dump_lua = true
priority = 0

# Champion's Belt
[[patches]
]
[patches.pattern]
target = "functions/common_events.lua"
pattern = "elseif not v.boss.showdown and (v.boss.min <= math.max(1, G.GAME.round_resets.ante) and ((math.max(1, G.GAME.round_resets.ante))%G.GAME.win_ante ~= 0 or G.GAME.round_resets.ante < 2)) then"
position = "before"
payload = '''
elseif next(SMODS.find_card("j_vic_champions_belt")) and v.boss.showdown then
	eligible_bosses[k] = true
elseif next(SMODS.find_card("j_vic_champions_belt")) and not v.boss.showdown then
	eligible_bosses[k] = nil
'''
match_indent = true
]]