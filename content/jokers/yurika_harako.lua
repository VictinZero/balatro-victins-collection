return {
    key = 'yurika_harako',
    config = {
        extra = {
            eureka = false,
            ingredients_rank = 2,
            ingredients_suit = 2
        }
    },
    rarity = 2,
    pos = {
        x = 6,
        y = 0
    },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.pre_discard and not context.hook then
            if G.GAME.current_round.discards_used == 0 then
                local discarded_ranks = {}
                local rank_counter = 0
                local discarded_suits = {}
                local suit_counter = 0

                for i = 1, #context.full_hand do
                    local card_ = context.full_hand[i]
                    if not SMODS.has_no_rank(card_) then
                        if not discarded_ranks[card_.base.id] then
                            rank_counter = rank_counter + 1
                        end
                        discarded_ranks[card_.base.id] = true
                    end
                    if not SMODS.has_no_suit(card_) then
                        if (not discarded_suits[card_.base.suit]) or SMODS.has_any_suit(card_) then
                            suit_counter = suit_counter + 1
                        end
                        discarded_suits[card_.base.suit] = true
                    end
                    if rank_counter >= card.ability.extra.ingredients_rank and suit_counter >=
                        card.ability.extra.ingredients_suit then
                        card.ability.extra.eureka = true
                        return {
                            message = localize('k_vic_eureka'),
                            colour = G.C.PURPLE
                        }
                    end
                end
            end
            card.ability.extra.eureka = false
            return
        end
        if context.discard and context.other_card and G.GAME.current_round.discards_used == 0 then
            if card.ability.extra.eureka then
                local card_ = context.other_card
                local new_enhancement = SMODS.poll_enhancement {
                    key = 'j_vic_yurika_eureka',
                    guaranteed = true
                }

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.00,
                    func = function()
                        if card_ and not card_.removed then
                            local p_ = 1
                            for i_ = 1, #G.hand.cards do
                                if G.hand.cards[i_] == card_ then
                                    p_ = 1.15 - (i_ - 0.999) / (#G.hand.cards - 0.998) * 0.3
                                    break
                                end
                            end
                            card_:flip()
                            play_sound('card1', p_)
                            card_:juice_up(0.3, 0.3)
                        end
                        return true
                    end
                }))
                delay(0.2)

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        if card_ and not card_.removed then
                            card_:set_ability(G.P_CENTERS[new_enhancement])
                        end
                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        if card_ and not card_.removed then
                            local p_ = 1
                            for i_ = 1, #G.hand.cards do
                                if G.hand.cards[i_] == card_ then
                                    p_ = 0.85 + (i_ - 0.999) / (#G.hand.cards - 0.998) * 0.3
                                    break
                                end
                            end
                            card_:flip()
                            play_sound('tarot2', p_, 0.6)
                            card_:juice_up(0.3, 0.3)
                        end
                        return true
                    end
                }))
                delay(0.75)
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.ingredients_rank, card.ability.extra.ingredients_suit}
        }
    end
}
