return {
    key = 'trapezist',
    config = {
        extra = {
            chips = 35,
            low = true
        }
    },
    rarity = 1,
    pos = {
        x = 3,
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
        if context.joker_main and (not context.blueprint) then
            card.ability.extra.low = not card.ability.extra.low
        end
        if context.individual and context.cardarea == G.play and not SMODS.has_no_rank(context.other_card) and
            ((card.ability.extra.low and context.other_card:get_id() <= 7) or
                (not card.ability.extra.low and context.other_card:get_id() >= 8)) then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {(card.ability.extra.low and "rank 7 or lower") or "rank 8 or higher", card.ability.extra.chips}
        }
    end
}
