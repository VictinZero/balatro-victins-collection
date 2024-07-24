return {
    key = 'the_one',
    config = {extra={Xmult = 6, type = 'High Card',  rank = 'Ace', suit = 'Spades'}},
    rarity = 3,
    pos = { x = 1, y = 0 },
    atlas = 'joker_atlas',
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == card.ability.extra.type and next(context.poker_hands[card.ability.extra.type]) then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 14 and context.scoring_hand[i]:is_suit('Spades') then
                    return {
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                        colour = G.C.RED,
                        Xmult_mod = card.ability.extra.Xmult
                    }
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "cr_vic_the_one", set = "Other"}
        return {vars = {card.ability.extra.Xmult, localize(card.ability.extra.type, 'poker_hands'), localize(card.ability.extra.rank, 'ranks'), localize(card.ability.extra.suit, 'suits_plural')}}
    end,
}
