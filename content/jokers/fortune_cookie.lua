return {
    key = 'fortune_cookie',
    config = {
        extra = {
            fortune = 1,
            fortune_mod = 1,
            odds = 6
        }
    },
    rarity = 3,
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator + card.ability.extra.fortune,
            }
        end
        if context.end_of_round and context.game_over ~= nil and not context.blueprint then -- and not context.repetition and not context.blueprint then
            sendDebugMessage("Trying to calculate Fortune Cookie")
            if SMODS.pseudorandom_probability(card, 'vic_fortune_cookie', 0, card.ability.extra.odds) then
                sendDebugMessage("Eaten!")
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_eaten_ex')
                })
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
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card_ = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil,
                                'vic_fortune_cookie_card')
                            card_:set_edition('e_vic_golden', true)
                            card_:add_to_deck()
                            G.consumeables:emplace(card_)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
            else
                sendDebugMessage("Not eaten!")
                card.ability.extra.fortune = card.ability.extra.fortune + 1
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_vic_golden

        local numerator, denominator = SMODS.get_probability_vars(card, 0, card.ability.extra.odds)
        return {
            vars = { card.ability.extra.fortune, numerator, denominator,
                (card.ability.extra.fortune == 1 and "... ?") or "!!!", card.ability.extra.fortune_mod }
        }
    end
}
