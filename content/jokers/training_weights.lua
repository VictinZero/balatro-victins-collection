return {
    key = 'training_weights',
    config = { extra = { remaining = 13 } },
    rarity = 2,
    pos = { x = 0, y = 8 },
    atlas = 'joker_atlas',
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card:can_calculate(true) and card.ability.extra.remaining > 0 then
            local target_card = context.destroy_card

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.00,
                func = function()
                    if target_card and not target_card.removed then
                        local p_ = 1
                        for i_ = 1, #G.play.cards do
                            if G.play.cards[i_] == target_card then
                                p_ = 1.15 - (i_ - 0.999) / (#G.play.cards - 0.998) * 0.3
                                break
                            end
                        end
                        target_card:flip()
                        play_sound('card1', p_)
                        target_card:juice_up(0.3, 0.3)
                    end
                    return true
                end
            }))
            delay(0.2)

            G.E_MANAGER:add_event(Event({
                func = function()
                    if target_card and not target_card.removed then
                        assert(SMODS.modify_rank(target_card, 1))
                    end
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                func = function()
                    if target_card and not target_card.removed then
                        local p_ = 1
                        for i_ = 1, #G.play.cards do
                            if G.play.cards[i_] == target_card then
                                p_ = 0.85 + (i_ - 0.999) / (#G.play.cards - 0.998) * 0.3
                                break
                            end
                        end
                        target_card:flip()
                        play_sound('tarot2', p_, 0.6)
                        target_card:juice_up(0.3, 0.3)
                    end
                    return true
                end
            }))
            delay(0.05)

            if not context.blueprint then
                card.ability.extra.remaining = card.ability.extra.remaining - 1
                if card.ability.extra.remaining <= 0 then
                    card.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if card and not card.removed then
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
                                        if card and not card.removed then
                                            G.jokers:remove_card(card)
                                            card:remove()
                                            card = nil
                                        end
                                        return true;
                                    end
                                }))
                            end
                            return true
                        end
                    }))
                    return { message = localize('k_eaten_ex') }
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.remaining } }
    end,
}
