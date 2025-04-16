return {
    key = 'flush_diamonds',
    config = {
        extra = {
            suit = 'Diamonds',
            reward = 'c_devil'
        }
    },
    rarity = 1,
    pos = {
        x = 0,
        y = 8
    },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands['Flush']) then
            local has_suit
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit(card.ability.extra.suit) then
                    has_suit = true;
                    break
                end
            end

            if has_suit and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        SMODS.add_card{key = card.ability.extra.reward, area = G.consumeables}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = '',
                    colour = G.C.SECONDARY_SET.Tarot,
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_devil
    end
}
