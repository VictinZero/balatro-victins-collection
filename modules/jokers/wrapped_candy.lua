return {
    key = 'wrapped_candy',
    config = {
        extra = {
            discards = 3,
            candies = 5
        }
    },
    rarity = 1,
    pos = {
        x = 0,
        y = 8
    },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            ease_discard(card.ability.extra.discards, true)
            if not context.blueprint then
                card.ability.extra.candies = card.ability.extra.candies - 1
                if card.ability.extra.candies <= 0 then
                    card.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            if card and card.ability.extra.candies <= 0 and not card.removed and not card.getting_sliced then
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
                                        return true
                                    end
                                }))
                            end
                            return true
                        end
                    }))
                else
                    card:juice_up(0.6, 0.1)
                end
            end
            return {
                colour = G.C.RED,
                message = card.ability.extra.candies <= 0 and localize('k_eaten_ex') or localize {
                    type = 'variable',
                    key = 'a_remaining',
                    vars = {card.ability.extra.candies}
                }
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.discards, card.ability.extra.candies}
        }
    end
}
