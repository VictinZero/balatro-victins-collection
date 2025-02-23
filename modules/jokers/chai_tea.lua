return {
    key = 'chai_tea',
    config = { extra = {cups = 4} },
    rarity = 3,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card and i < #G.jokers.cards and context.other_card == G.jokers.cards[i+1] then
                    return {
                        message = localize("k_again_ex"),
                        repetitions = 1,
                        card = card,
                    }
                end
            end
            return nil, true
		end

        if context.end_of_round and context.game_over ~= nil and not context.blueprint then
            card.ability.extra.cups = card.ability.extra.cups - 1
            if card.ability.extra.cups == 0 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_drank_ex')})
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true
                            end
                        }))
                        return true
                    end
                }))
            else
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "-1"})
            end
        end
	end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.cups, card.ability.extra.cups == 1 and '' or 's'}}
    end,
}
