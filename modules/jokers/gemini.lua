local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

local loc_vars = function(self, info_queue, card)
    local level = G.GAME.hands[card.ability.extra.hand_type].level
    local repetitions_mod = card.ability.extra.repetitions_mod
    local repetitions = card.ability.extra.base_repetitions + repetitions_mod*(level - 1)
    local plural = (G.SETTINGS.language and repetitions > 1 and 's') or ''

    return {repetitions, plural, repetitions_mod}
end

return {
    key = 'gemini',
    config = {extra={base_repetitions = 1, repetitions_mod = 1, hand_type = 'Two Pair'}},
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
        if context.repetition  and context.cardarea == G.play and context.scoring_name == card.ability.extra.hand_type then
            local level = G.GAME.hands[card.ability.extra.hand_type].level
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.base_repetitions + card.ability.extra.repetitions_mod*(level - 1),
                card = card
            }
        end
    end,

    generate_ui = misc.generate_ui_for_zodiac(loc_vars),

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_vic_zodiac'), G.C.VictinsCollection.OTHERS.Zodiac, G.C.WHITE, 1.2)
    end,
}
