local misc = SMODS.load_file("misc_functions.lua")()

local loc_vars = function(self, info_queue, card)
    local level = G.GAME and G.GAME.VictinsCollection.zodiac.cancer or card.ability.extra.level
    local Xmult = card.ability.extra.base_Xmult + card.ability.extra.Xmult_mod * (level - 1)
    local dollars = card.ability.extra.base_dollars + card.ability.extra.dollars_mod * (level - 1)

    local numerator_Xmult, denominator_Xmult = SMODS.get_probability_vars(card, 1, card.ability.extra.Xmult_den)
    local numerator_dollars, denominator_dollars = SMODS.get_probability_vars(card, 1, card.ability.extra.dollars_den)

    return {numerator_Xmult, denominator_Xmult, Xmult,
            numerator_dollars, denominator_dollars, dollars,
            card.ability.extra.Xmult_mod, card.ability.extra.dollars_mod}
end

return {
    key = 'cancer',
    config = {
        extra = {
            level = 0,
            base_Xmult = 2,
            Xmult_mod = 0.5,
            Xmult_den = 3,
            base_dollars = 20,
            dollars_mod = 5,
            dollars_den = 15,
            hand_type = 'Three of a Kind',
            zodiac = 'cancer'
        }
    },
    rarity = 'vic_auxiliary',
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,
    no_collection = true,

    in_pool = function(self)
        return false
    end,

    calculate = function(self, card, context)
        if G.GAME.VictinsCollection.zodiac.cancer > 0 and context.joker_main and context.scoring_name ==
            card.ability.extra.hand_type then
            card.ability.extra.level = G.GAME.VictinsCollection.zodiac.cancer
            local level = card.ability.extra.level

            local xmult = 0

            if SMODS.pseudorandom_probability(card, 'vic_cancer_Xmult', 1, card.ability.extra.Xmult_den) then
                xmult = card.ability.extra.base_Xmult + card.ability.extra.Xmult_mod * (level - 1)
            end

            local dollars = 0

            if SMODS.pseudorandom_probability(card, 'vic_cancer_dollars', 1, card.ability.extra.dollars_den) then
                dollars = card.ability.extra.base_dollars + card.ability.extra.dollars_mod * (level - 1)
            end

            return {
                xmult = xmult,
                extra = {
                    dollars = dollars
                }
            }
        end
    end,

    generate_ui = misc.generate_ui_for_zodiac(loc_vars),

    set_badges = function(self, card, badges)
        badges[#badges + 1] =
            create_badge(localize('k_vic_zodiac'), G.C.VictinsCollection.OTHERS.Zodiac, G.C.WHITE, 1.2)
    end
}
