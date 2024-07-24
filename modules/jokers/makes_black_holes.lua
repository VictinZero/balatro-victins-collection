return {
    key = 'makes_black_holes',
    config = {extra={remaining=3}},
    rarity = 3,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.selling_card and context.card.area == G.consumeables and context.card.ability.set == 'Planet' then
            if card.ability.extra.remaining > 1 and not context.blueprint then
                card.ability.extra.remaining = card.ability.extra.remaining - 1
            elseif card.ability.extra.remaining <= 1 then
                if not context.blueprint then card.ability.extra.remaining = 3 end
                if G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function() 
                                    local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_black_hole', 'placeholder')
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                    return true
                                end}))   
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = 'black hole placeholder', colour = G.C.PURPLE})
                                G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "c_black_hole", set = "Spectral"}
        return {vars = {card.ability.extra.remaining}}
    end,
}
