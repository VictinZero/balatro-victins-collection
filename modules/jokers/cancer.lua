local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

local loc_vars = function(self, info_queue, card)
    local level = G.GAME.hands[card.ability.extra.hand_type].level
    local Xmult = card.ability.extra.base_Xmult + card.ability.extra.Xmult_mod*(level - 1)
    local dollars = card.ability.extra.base_dollars + card.ability.extra.dollars_mod*(level - 1)

    return {
        G.GAME and G.GAME.probabilities.normal or 1,
        card.ability.extra.Xmult_den,
        Xmult,
        G.GAME and G.GAME.probabilities.normal or 1,
        card.ability.extra.dollars_den,
        dollars,
        card.ability.extra.Xmult_mod,
        card.ability.extra.dollars_mod,
    }
end

return {
    key = 'cancer',
    config = {extra={base_Xmult=2, Xmult_mod=0.5, Xmult_den = 3, base_dollars = 20, dollars_mod = 5, dollars_den = 15, hand_type = 'Three of a Kind'}},
    rarity = 2,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == card.ability.extra.hand_type then
            local level = G.GAME.hands[card.ability.extra.hand_type].level
            if pseudorandom('vic_cancer_Xmult') < G.GAME.probabilities.normal/card.ability.extra.Xmult_den then
                local Xmult = card.ability.extra.base_Xmult + card.ability.extra.Xmult_mod*(level - 1)
                SMODS.eval_this(card, {Xmult_mod = Xmult, message = localize{type = 'variable', key = 'a_xmult', vars = {Xmult}}, color = G.C.MULT})
            end

            if pseudorandom('vic_cancer_dollars') < G.GAME.probabilities.normal/card.ability.extra.dollars_den then
                local dollars = card.ability.extra.base_dollars + card.ability.extra.dollars_mod*(level - 1)
                
                ease_dollars(dollars)
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + dollars
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                
                return {
                            message = localize('$')..dollars,
                            dollars = dollars,
                            colour = G.C.MONEY
                        }
            end
        end
    end,

    generate_ui = misc.generate_ui_for_zodiac(loc_vars),

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_vic_zodiac'), G.C.VictinsCollection.OTHERS.Zodiac, G.C.WHITE, 1.2)
    end,
}
