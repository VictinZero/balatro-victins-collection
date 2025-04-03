local misc = SMODS.load_file("misc_functions.lua")()

local loc_vars = function(self, info_queue, card)
    local level = G.GAME and G.GAME.VictinsCollection.zodiac.gemini or card.ability.extra.level
    local repetitions_mod = card.ability.extra.repetitions_mod
    local repetitions = card.ability.extra.base_repetitions + repetitions_mod * level
    local plural = (G.SETTINGS.language and repetitions > 1 and 's') or ''

    return {repetitions, plural, repetitions_mod}
end

return {
    key = 'gemini',
    name = "Gemini",
    config = {
        extra = {
            level = 0,
            base_repetitions = 1,
            repetitions_mod = 1,
            hand_type = 'Two Pair',
            zodiac = 'gemini'
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
                if v.config.center.key == 'j_vic_gemini' then
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
            if v.config.center.key == 'j_vic_gemini' then
                G.GAME.VictinsCollection.zodiac.gemini = G.GAME.VictinsCollection.zodiac.gemini + 1
                v.ability.extra.level = G.GAME.VictinsCollection.zodiac.gemini
                v:juice_up()
            end
        end
    end,

    generate_ui = misc.generate_ui_for_zodiac(loc_vars)
}
