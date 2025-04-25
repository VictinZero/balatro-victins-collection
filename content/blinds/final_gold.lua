return {
    name = "Black Gold",
    key = "final_gold",
    pos = { x = 0, y = 1 },
    atlas = "showdown_atlas",
    dollars = 8,
    mult = 2,
    vars = {},
    debuff = {},
    boss = {showdown = true, min = 1, max = 10},
    boss_colour = HEX('494949'),
    discovered = true,
    loc_txt = {},

    calculate = function(self, blind, context)
        if (context.hand_drawn or context.press_play or context.pre_discard or context.selling_card or
            context.card_added) and not blind.disabled then
            for i = 1, #G.jokers.cards do
                local card = G.jokers.cards[i]
                if card.sell_cost >= 5 then card:set_debuff(true) else card:set_debuff(false) end
            end
            --[[for i = 1, #G.consumeables.cards do
                local card = G.consumeables.cards[i]
                if card.sell_cost >= 5 then card:set_debuff(true) else card:set_debuff(false) end
            end]]
        end
    end,

    disable = function(self)
        for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(true)
        end
        --[[for i = 1, #G.consumeables.cards do
            G.consumeables.cards[i]:set_debuff(true)
        end]]
    end
}
