return {
    key = 'butcher_vanity',
    config = {},
    rarity = 3,
    pos = {
        x = 4,
        y = 5
    },
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.first_hand_drawn then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _card = create_playing_card({
                        front = pseudorandom_element(G.P_CARDS, pseudoseed('vic_butvan')),
                        center = G.P_CENTERS.m_vic_flesh
                    }, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                    G.GAME.blind:debuff_card(_card)
                    G.hand:sort()
                    return true
                end
            }))
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_vic_flesh
    end,

    subtitle = "Neither patience a virtue nor gluttony a sin.",
}
