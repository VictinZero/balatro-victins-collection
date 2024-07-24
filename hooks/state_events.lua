local end_round_ref = end_round
end_round = function()
	if G.GAME.VictinsCollection.jagganoth then
		sendDebugMessage("Skipping end of round…")
	else
		end_round_ref()
	end
end

local draw_from_deck_to_hand_ref = G.FUNCS.draw_from_deck_to_hand
G.FUNCS.draw_from_deck_to_hand = function(e)
	if G.GAME.VictinsCollection.jagganoth then
		sendDebugMessage("Skipping draw to hand…")
	else
		draw_from_deck_to_hand_ref(e)
	end
end

local draw_from_play_to_discard_ref = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
	draw_from_play_to_discard_ref(e)
	local jagganoths = SMODS.find_card("j_vic_jagganoth")
	if next(jagganoths) then
		for i = 1, #jagganoths do
			--test if there are hands remaining
			if i ~= 1 then break end
			local _joker = jagganoths[i]
			if true then --G.GAME.current_round.hands_left > 0 then
				if _joker.ability.extra.cycles <= 99 then
					_joker.ability.extra.cycles = _joker.ability.extra.cycles + 1
					G.GAME.VictinsCollection.jagganoth = true
					G.E_MANAGER:add_event(Event({
					    trigger = 'before',
					    func = function()
					    	if G.GAME.current_round.hands_left >= 0 then
						        card_eval_status_text(_joker, 'extra', nil, nil, nil, {message = localize('k_again_ex')})
						        G.E_MANAGER:add_event(Event({
					                trigger = 'before',
					                func = function()
					                	sendDebugMessage("Trying to draw…")
					                    for k, _card in ipairs(_joker.ability.extra.highlighted_cards) do
					                 		if _card and not _card.removed then
					                 			sendDebugMessage("Drawn!")
								    			draw_card(_card.area or G.discard, G.hand, k*100/#_joker.ability.extra.highlighted_cards,'up', nil , _card, 0.005, k%2==0, nil, math.max((21-k)/20, 0.7))
								    		else sendDebugMessage("Nothing to draw…") end
								    	end
								    	local is_in_highlighted_cards = function(v)
								    		for k, _v in ipairs(_joker.ability.extra.highlighted_cards) do
								    			if _v == v then return k end
								    		end
								    		return nil
								    	end
								    	G.E_MANAGER:add_event(Event({
								    		trigger = 'immediate',
								    		func = function()
								    			table.sort(G.hand.cards, function (a, b)
								    				sendDebugMessage("Sorting…")
								    				for k, _v in ipairs(_joker.ability.extra.highlighted_cards) do
										    			sendDebugMessage(tostring(k).." is "..tostring(_v.base.value).." of "..tostring(_v.base.suit))
										    		end
										    		local is_a_highlighted = is_in_highlighted_cards(a)
										    		local is_b_highlighted = is_in_highlighted_cards(b)
										    		if is_a_highlighted and is_b_highlighted then
										    			return is_a_highlighted < is_b_highlighted
										    		elseif is_a_highlighted or is_b_highlighted then
										    			return (is_b_highlighted and true) or false
										    		else
										    			return a.T.x < b.T.x
										    		end
										    	end )
								    			return true
								    		end
								    	}))
								    	return true
					                end
					            }))

						        G.E_MANAGER:add_event(Event({
					                trigger = 'before',
					                func = function()
					                	sendDebugMessage("Trying to highlight…")
					                	G.hand:unhighlight_all()
					                    for _, _card in ipairs(_joker.ability.extra.highlighted_cards) do
					                    	if _card and not _card.removed then sendDebugMessage("Highlighted!"); G.hand:add_to_highlighted(_card) else sendDebugMessage("Nothing to highlight…") end
										end
								    	return true
					                end
					            }))
					            G.E_MANAGER:add_event(Event({
								    		trigger = 'immediate',
								    		func = function()
								    			local is_in_highlighted_cards = function(v)
										    		for k, _v in ipairs(_joker.ability.extra.highlighted_cards) do
										    			if _v == v then return k end
										    		end
										    		return nil
										    	end
								    			table.sort(G.hand.cards, function (a, b)
								    				sendDebugMessage("Sorting…")
								    				for k, _v in ipairs(_joker.ability.extra.highlighted_cards) do
										    			sendDebugMessage(tostring(k).." is "..tostring(_v.base.value).." of "..tostring(_v.base.suit))
										    		end
										    		local is_a_highlighted = is_in_highlighted_cards(a)
										    		local is_b_highlighted = is_in_highlighted_cards(b)
										    		if is_a_highlighted and is_b_highlighted then
										    			return is_a_highlighted < is_b_highlighted
										    		elseif is_a_highlighted or is_b_highlighted then
										    			return (is_b_highlighted and true) or false
										    		else
										    			return a.T.x < b.T.x
										    		end
										    	end )
								    			return true
								    		end
								    	}))
					            G.E_MANAGER:add_event(Event({
					                trigger = 'immediate',
					                func = function()
					                	if G.GAME.current_round.hands_left <= 0 or _joker.ability.extra.cycles >= 100 or (G.GAME.chips - G.GAME.blind.chips >= 0) or G.STATE == G.STATES.NEW_ROUND then
					                		for i=1, #G.hand.highlighted do
									            draw_card(G.hand, G.play, i*100/#G.hand.highlighted, 'up', nil, G.hand.highlighted[i])
									        end
									        G.E_MANAGER:add_event(Event({
									        	trigger = 'immediate',
									        	func = function()
											    	for j=1, #G.jokers.cards do
												        eval_card(G.jokers.cards[j], {cardarea = G.jokers, remove_playing_cards = true, removed = G.play.cards})
												    end
											        for i=1, #G.play.cards do
												        G.E_MANAGER:add_event(Event({
												            func = function()
												                if G.play.cards[i].ability.name == 'Glass Card' then 
												                    G.play.cards[i]:shatter()
												                else
												                    G.play.cards[i]:start_dissolve()
												                end
												            	return true
												            end
												        }))
											        end
											        G.GAME.VictinsCollection.jagganoth = false
											        G.STATE_COMPLETE = false
											        G:update_hand_played(0)
											    	return true
											    end
										    }))
    									else
					                    	G.FUNCS.play_cards_from_highlighted()
					                    end
								    	return true
					                end
					            }))
					        end
					        return true
					    end
					}))
				end
			else
				break
			end
		end
	end
end
