return {
    key = 'nadia_om',
    config = {extra={peaches=7, court_size=2}},
    rarity = 4,
    pos = { x = 0, y = 0 },
    atlas = 'joker_soul_atlas',
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then my_pos = i; break end
            end

            local target = nil
            --[[for i = 1, #G.jokers.cards do
                local possible_target = G.jokers.cards[i]
                if not ((possible_target.edition and possible_target.edition.negative) or possible_target == card or possible_target.getting_sliced or possible_target.ability.eternal) then target = possible_target; break end
            end]]

            if my_pos then
                local possible_target = G.jokers.cards[my_pos+1]
                if possible_target and not (--[[(possible_target.edition and possible_target.edition.negative) or --]]possible_target.getting_sliced or possible_target.ability.eternal) then target = possible_target end
            end

            if target then
                target.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        -- Dagger
                        G.GAME.joker_buffer = 0
                        card:juice_up(0.8, 0.8)
                        target:start_dissolve({HEX("57ecab")}, nil, 1.6)
                        play_sound('slice1', 0.96+math.random()*0.08)
                        ease_dollars(card.ability.extra.peaches)

                        for i=1,card.ability.extra.court_size do
                            -- Judgement
                            play_sound('timpani')
                            local new_card = nil--create_card('Joker', G.jokers, false, nil, nil, nil, nil, 'nadia_om')
                            local it = 0
                            while (not (new_card and new_card.config.center.perishable_compat and new_card.config.center.rarity == 1)) and it < 100 do
                                if new_card then new_card:remove() end
                                new_card = create_card('Joker', G.jokers, false, nil, nil, nil, nil, 'nadia_om')
                                it = it + 1
                            end
                            if not (new_card and new_card.config.center.perishable_compat and new_card.config.center.rarity == 1) then
                                if new_card then new_card:remove() end
                                new_card = create_card('Joker', G.jokers, false, nil, nil, nil, 'j_joker', 'nadia_om')
                            end

                            new_card:set_edition({negative = true}, true)
                            new_card:set_perishable(true)
                            new_card:set_rental(true)
                            new_card:add_to_deck()
                            G.jokers:emplace(new_card)
                            card:juice_up(0.3, 0.5)
                        end

                        return true
                    end
                }))
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'e_negative', set = 'Edition', config = {extra = 1}}
        info_queue[#info_queue+1] = {key = 'vic_perishable', set = 'Other', vars = {G.GAME.perishable_rounds or 1}}
        info_queue[#info_queue+1] = {key = 'rental', set = 'Other', vars = {G.GAME.rental_rate or 1}}
        return {vars = {card.ability.extra.peaches, card.ability.extra.court_size}}
    end,
}
