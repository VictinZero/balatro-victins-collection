local misc = SMODS.load_file("misc_functions.lua")()

local loc_vars = function(self, info_queue, card)
    local level = G.GAME and G.GAME.VictinsCollection.zodiac.pisces or card.ability.extra.level

    return {}
end

return {
    key = 'pisces',
    name = "Pisces",
    config = {
        extra = {
            level = 0,
            hand_type = 'Five of a Flush',
            zodiac = 'pisces'
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
                if v.config.center.key == 'j_vic_pisces' then
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
            if v.config.center.key == 'j_vic_pisces' then
                G.GAME.VictinsCollection.zodiac.pisces = G.GAME.VictinsCollection.zodiac.pisces + 1
                v.ability.extra.level = G.GAME.VictinsCollection.zodiac.pisces
                v:juice_up()
            end
        end
    end,

    generate_ui = misc.generate_ui_for_zodiac(loc_vars)
}
