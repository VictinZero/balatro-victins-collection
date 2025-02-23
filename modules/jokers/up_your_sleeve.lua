return {
    key = 'up_your_sleeve',
    config = {
        extra = {
            rank = 'Ace',
            suit = 'Spades'
        }
    },
    rarity = 1,
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.first_hand_drawn then
            G.E_MANAGER:add_event(Event({
                func = function()
                    --[[SMODS.add_card {
                        set = 'Default',
                        area = G.hand,
                        edition = 'e_negative',
                        stickers = {'vic_temporary'}
                    }]]

                    local card_ = create_playing_card({
                        front = G.P_CARDS['S_A'],
                        center = G.P_CENTERS.c_base
                    }, G.hand, nil, false, {G.C.DARK_EDITION})
                    card_:set_edition('e_negative', true, true)
                    SMODS.Stickers.vic_temporary:apply(card_, true)

                    G.GAME.blind:debuff_card(card_)
                    G.hand:sort()
                    playing_card_joker_effects({true})
                    return true
                end
            }))
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {
            set = 'Other',
            key = 'vic_temporary'
        }
        info_queue[#info_queue + 1] = {
            set = 'Edition',
            key = 'e_negative_playing_card',
            config = {
                extra = G.P_CENTERS['e_negative'].config.card_limit
            }
        }
        return {
            vars = {localize(card.ability.extra.rank, 'ranks'), localize(card.ability.extra.suit, 'suits_plural')}
        }
    end
}
