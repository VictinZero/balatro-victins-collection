local misc = SMODS.load_file("misc_functions.lua")()

local eval_UI = function(card)
    local mult = 0
    local txt = 0
    local colour = G.C.RED
    local order

    if not misc.is_in_your_collection(card) then
        local handname, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)

        local backwards = false
        for k, v in pairs(G.hand.highlighted) do
            if v.facing == 'back' then
                backwards = true
                break
            end
        end

        local active = (not backwards)
        if handname and handname ~= 'NULL' then
            for k, v in ipairs(G.handlist) do
                if not order and handname == v then
                    order = k
                end
                if order and order < k then
                    mult = mult + G.GAME.hands[v].level
                end
            end
        end

        colour = (backwards and G.C.FILTER) or G.C.RED
        txt = (backwards and "???") or card.ability.extra.mult*mult
    end

    return {
        txt = txt,
        colour = colour
    }
end

return {
    key = 'clownfish',
    config = {
        extra = {
            mult = 2,
            cache = {}
        }
    },
    rarity = 1,
    pos = {
        x = 0,
        y = 8
    },
    atlas = 'joker_atlas',
    cost = 1,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main then
            local mult = 0
            local order

            for k, v in ipairs(G.handlist) do
                if not order and context.scoring_name == v then
                    order = k
                end
                if order and order < k then
                    mult = mult + G.GAME.hands[v].level
                end
            end

            if mult > 0 then
                return {
                    mult = card.ability.extra.mult * mult
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        local UI_data = eval_UI(card)
        return {
            vars = {
                card.ability.extra.mult,
                UI_data.txt,
                colours = {UI_data.colour}
            }
        }
    end
}
