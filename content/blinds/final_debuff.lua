return {
    name = "The Debuff",
    key = "final_debuff",
    pos = {
        x = 0,
        y = 0
    },
    atlas = "showdown_atlas",
    dollars = 8,
    mult = 2,
    vars = {},
    debuff = {},
    boss = {
        showdown = true,
        min = 1,
        max = 10
    },
    boss_colour = HEX('FE5F55'),
    discovered = true,
    loc_txt = {},

    calculate = function(self, blind, context)
        if (context.hand_drawn or context.press_play or context.pre_discard or context.selling_card or
            context.card_added) and not blind.disabled then
            for i = 1, #G.jokers.cards do
                G.jokers.cards[i]:set_debuff(false)
            end
            if G.jokers.cards[5] then
                for i = 5, #G.jokers.cards do
                    G.jokers.cards[i]:set_debuff(true)
                end
            end
        end
    end,

    disable = function(self)
        for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(true)
        end
    end
}
