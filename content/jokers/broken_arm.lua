return {
    key = 'broken_arm',
    config = {
        extra = {
            downgrade = 1,
            dollars = 6
        }
    },
    rarity = 2,
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
        if context.before and context.cardarea == G.jokers and G.GAME.hands[context.scoring_name].level >
            card.ability.extra.downgrade then
            return {
                level_up = -card.ability.extra.downgrade,
                dollars = card.ability.extra.dollars
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.dollars}
        }
    end
}
