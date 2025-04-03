local misc = SMODS.load_file("misc_functions.lua")()

local loc_vars = function(self, info_queue, card)
    local level = G.GAME and G.GAME.VictinsCollection.zodiac.cancer or card.ability.extra.level
    local Xmult = card.ability.extra.base_Xmult + card.ability.extra.Xmult_mod * level
    local dollars = card.ability.extra.base_dollars + card.ability.extra.dollars_mod * level

    return {G.GAME and G.GAME.probabilities.normal or 1, card.ability.extra.Xmult_den, Xmult,
            G.GAME and G.GAME.probabilities.normal or 1, card.ability.extra.dollars_den, dollars,
            card.ability.extra.Xmult_mod, card.ability.extra.dollars_mod}
end

return {
    key = 'cancer',
    name = "Cancer",
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
    set = "Zodiac",
    cost = 4,
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'joker_atlas',
    loc_txt = {},
    discovered = true,

    set_ability = function(self, card, initial, delay_sprites)
        if not misc.is_in_your_collection and G.ca_vic_zodiac then
            for _, v in ipairs(G.ca_vic_zodiac.cards) do
                if v.config.center.key == 'j_vic_cancer' then
                    for k_, v_ in pairs(v.ability.extra) do
                        card.ability.extra[k_] = v_
                    end
                    return
                end
            end
        end
    end,

    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        for _, v in ipairs(G.ca_vic_zodiac.cards) do
            if v.config.center.key == 'j_vic_cancer' then
                G.GAME.VictinsCollection.zodiac.cancer = G.GAME.VictinsCollection.zodiac.cancer + 1
                v.ability.extra.level = G.GAME.VictinsCollection.zodiac.cancer
                v:juice_up()
                break
            end
        end
    end,

    generate_ui = misc.generate_ui_for_zodiac(loc_vars)
}
