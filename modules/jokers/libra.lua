local misc = SMODS.load_file("misc_functions.lua")()

local loc_vars = function(self, info_queue, card)
    local level = G.GAME and G.GAME.VictinsCollection.zodiac.libra or card.ability.extra.level

    return {}
end

return {
    key = 'libra',
    config = {
        extra = {
            level = 0,
            hand_type = 'Full House',
            zodiac = 'libra'
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
        if card.ability.extra.level > 0 and context.scoring_name ==
            card.ability.extra.hand_type then
            card.ability.extra.level = G.GAME.VictinsCollection.zodiac.libra
        end
    end,

    generate_ui = misc.generate_ui_for_zodiac(loc_vars),

    set_badges = function(self, card, badges)
        badges[#badges + 1] =
            create_badge(localize('k_vic_zodiac'), G.C.VictinsCollection.OTHERS.Zodiac, G.C.WHITE, 1.2)
    end
}
