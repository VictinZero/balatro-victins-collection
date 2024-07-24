local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

local init_game_object_ref = Game.init_game_object

function Game:init_game_object()
	local init_game_object_val = init_game_object_ref(self)
	init_game_object_val.VictinsCollection = {
		equalize = false,
		jagganoth = false,
		champions_belt = false, adding_champions_belt = false,
		stheno = false, adding_stheno = false,
		
		post_discard_draw = false,
		guarantee_enhancement = false,

		dagger = false,
		patriarch_blinds = {'bl_goad', 'bl_plant'},

		n_flipped_cards = 0,
	}
	return init_game_object_val
end

local update_ref = Game.update
function Game:update(dt)
    update_ref(self, dt)

    local suit_colors = self.C["SO_"..(self.SETTINGS.colourblind_option and 2 or 1)]
    local ordered_suit_colors = {suit_colors['Spades'], suit_colors['Hearts'], suit_colors['Clubs'], suit_colors['Diamonds']}

    misc.create_gradient(self.C.VictinsCollection.ENHANCEMENTS.Wild, ordered_suit_colors, 1.25, nil, nil, self)

	local ordered_poker_hands = {
		'High Card',
		'Pair',
		'Two Pair',
		'Three of a Kind',
		'Straight',
		'Flush',
		'Full House',
		'Four of a Kind',
		'Straight Flush',
		'Five of a Kind',
		'Flush House',
		'Five of a Flush',
	}
	local hand_colors = {}

	for k, v in ipairs(ordered_poker_hands) do
		hand_colors[k] = self.C.VictinsCollection.POKER_HANDS[v]
	end

	misc.create_gradient(self.C.VictinsCollection.OTHERS.Zodiac, hand_colors, 0.85, nil, nil, self)

    if G.ARGS.LOC_COLOURS then
    	G.ARGS.LOC_COLOURS["vic_purple"] = G.C.VictinsCollection.OTHERS.Purple
    	G.ARGS.LOC_COLOURS["vic_wild"] = G.C.VictinsCollection.ENHANCEMENTS.Wild
    	G.ARGS.LOC_COLOURS["vic_zodiac"] = G.C.VictinsCollection.OTHERS.Zodiac
    end

end

-- Crimson Noon and Crimson Dusk switching to lower tier
local update_new_round_ref = Game.update_new_round
function Game.update_new_round(self, dt)
    if self.buttons then self.buttons:remove(); self.buttons = nil end
    if self.shop then self.shop:remove(); self.shop = nil end

    if (not G.STATE_COMPLETE) and (G.GAME.blind.config.blind.key == "bl_vic_final_ribbon" or (G.GAME.blind.config.blind.key == "bl_vic_loop" and not G.GAME.blind.vic_looped)) and (not G.GAME.blind.disabled) then
        
        local original_blind = G.GAME.blind.vic_original_blind and G.GAME.blind.vic_original_blind or G.GAME.blind.config.blind.key
        local looped = (G.GAME.blind.config.blind.key == "bl_vic_loop")
        
        if G.GAME.current_round.hands_left <= 0 and not (G.GAME.chips >= G.GAME.blind.chips) then --to_big(G.GAME.chips) >= to_big(G.GAME.blind.chips) then
            G.GAME.blind.vic_original_blind = nil
            G.STATE_COMPLETE = true
            end_round()
            return
        end

        G.STATE = G.STATES.DRAW_TO_HAND
        G.E_MANAGER:add_event(Event({
            trigger = 'ease',
            blocking = false,
            ref_table = G.GAME,
            ref_value = 'chips',
            ease_to = 0,
            delay = 0.5 * G.SETTINGS.GAMESPEED,
            func = (function(t) return math.floor(t) end)
        }))

        G.GAME.blind:set_blind(G.P_BLINDS["bl_vic_loop"])
        G.GAME.blind.dollars = G.P_BLINDS[original_blind].dollars
        G.GAME.current_round.dollars_to_be_earned = G.GAME.blind.dollars > 0 and (string.rep(localize('$'), G.GAME.blind.dollars)..'') or ('')
        G.GAME.blind.vic_original_blind = original_blind
        G.GAME.blind.vic_looped = looped

    elseif (not G.STATE_COMPLETE) and (G.GAME.blind.vic_patriarch_blinds) and (#G.GAME.blind.vic_patriarch_blinds > 0) then
    	
    	local original_blind = G.GAME.blind.vic_original_blind and G.GAME.blind.vic_original_blind or G.GAME.blind.config.blind.key
        local blinds = G.GAME.blind.vic_patriarch_blinds

        if G.GAME.current_round.hands_left <= 0 and not (G.GAME.chips >= G.GAME.blind.chips) then
            G.GAME.blind.vic_original_blind = nil
            G.STATE_COMPLETE = true
            end_round()
            return
        end

        G.STATE = G.STATES.DRAW_TO_HAND
        G.E_MANAGER:add_event(Event({
            trigger = 'ease',
            blocking = false,
            ref_table = G.GAME,
            ref_value = 'chips',
            ease_to = 0,
            delay = 0.5 * G.SETTINGS.GAMESPEED,
            func = (function(t) return math.floor(t) end)
        }))

        local next_blind = table.remove(blinds, 1)

        G.GAME.blind:set_blind(G.P_BLINDS[next_blind])
        G.GAME.blind.dollars = G.P_BLINDS[original_blind].dollars
        G.GAME.current_round.dollars_to_be_earned = G.GAME.blind.dollars > 0 and (string.rep(localize('$'), G.GAME.blind.dollars)..'') or ('')
        G.GAME.blind.vic_original_blind = original_blind
        G.GAME.blind.vic_patriarch_blinds = blinds

        if #blinds == 0 then
        	local hold_time = G.SETTINGS.GAMESPEED*(5*0.035 + 1.3)
            local disp_text = localize('k_vic_magnificent')
            attention_text({
                scale = 1.2, text = disp_text, maxw = 12, hold = hold_time, align = 'cm', offset = {x = 0,y = -1}, major = G.play, --colour = G.GAME.blind.config.blind.boss_colour
            })
        end

    end

    if G.STATE ~= G.STATES.DRAW_TO_HAND then
        update_new_round_ref(self, dt)
    end
end
