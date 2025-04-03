local misc
local init, error = SMODS.load_file("misc_functions.lua")
if error then
    sendErrorMessage("VictinsCollection :: Failed to load misc_functions with error " .. error)
else
    misc = init()
end

local _generate_main_end = function(card)
    if not misc.is_in_your_collection(card) then
        local add_node = function(nodes, text, colour)
            nodes[#nodes + 1] = {
                n = G.UIT.T,
                config = {
                    text = text,
                    colour = colour,
                    scale = 0.3
                }
            }
        end

        local add_row = function(nodes)
            nodes[#nodes + 1] = {
                n = G.UIT.R,
                config = {
                    align = "cm"
                }
            }
        end

        local nodes_ = {}

        local node_chips, node_mult, node_xmult, node_xchips, node_p_dollars, node_h_dollars = {}, {}, {}, {}, {}, {}

        if card.ability.extra.chips > 0 then
            add_node(node_chips, '+', G.C.UI.TEXT_INACTIVE)
            add_node(node_chips, tostring(card.ability.extra.chips), G.C.BLUE)
            add_node(node_chips, ' chips', G.C.UI.TEXT_INACTIVE)
            add_row(nodes_)
            nodes_[#nodes_].nodes = node_chips
        end

        if card.ability.extra.mult > 0 then
            add_node(node_mult, '+', G.C.UI.TEXT_INACTIVE)
            add_node(node_mult, tostring(card.ability.extra.mult), G.C.RED)
            add_node(node_mult, ' mult', G.C.UI.TEXT_INACTIVE)
            add_row(nodes_)
            nodes_[#nodes_].nodes = node_mult
        end

        if card.ability.extra.xmult > 1 then
            local node_col, node_inner = {
                n = G.UIT.C,
                config = {
                    align = "m",
                    colour = G.C.RED,
                    r = 0.05,
                    padding = 0.03,
                    res = 0.15
                }
            }, {}
            add_node(node_inner, ' X' .. tostring(card.ability.extra.xmult) .. ' ', G.C.WHITE)
            node_col.nodes = node_inner
            node_xmult[#node_xmult + 1] = node_col
            add_node(node_xmult, ' mult', G.C.UI.TEXT_INACTIVE)
            add_row(nodes_)
            nodes_[#nodes_].nodes = node_xmult
        end

        if card.ability.extra.xchips > 1 then
            local node_col, node_inner = {
                n = G.UIT.C,
                config = {
                    align = "m",
                    colour = G.C.BLUE,
                    r = 0.05,
                    padding = 0.03,
                    res = 0.15
                }
            }, {}
            add_node(node_inner, ' X' .. tostring(card.ability.extra.xchips) .. ' ', G.C.WHITE)
            node_col.nodes = node_inner
            node_xchips[#node_xmult + 1] = node_col
            add_node(node_xchips, ' chips', G.C.UI.TEXT_INACTIVE)
            add_row(nodes_)
            nodes_[#nodes_].nodes = node_xchips
        end

        if card.ability.extra.p_dollars > 0 then
            add_node(node_p_dollars, '$' .. tostring(card.ability.extra.p_dollars), G.C.MONEY)
            add_node(node_p_dollars, ' when playing a hand', G.C.UI.TEXT_INACTIVE)
            add_row(nodes_)
            nodes_[#nodes_].nodes = node_p_dollars
        end

        if card.ability.extra.h_dollars > 0 then
            add_node(node_h_dollars, '$' .. tostring(card.ability.extra.h_dollars), G.C.MONEY)
            add_node(node_h_dollars, ' at the end of round', G.C.UI.TEXT_INACTIVE)
            add_row(nodes_)
            nodes_[#nodes_].nodes = node_h_dollars
        end

        add_row(nodes_)
        nodes_[#nodes_].nodes = misc.generate_main_end_hold_key_info(card)[1].nodes[1].nodes

        if #nodes_ > 0 then
            return {{
                n = G.UIT.C,
                config = {
                    align = "bm",
                    padding = 0.02
                },
                nodes = nodes_
            }}
        end
    else
        return misc.generate_main_end_hold_key_info(card)
    end
end

return {
    key = 'joker_devouring_its_son',
    config = {
        extra = {
            chips = 0,
            mult = 0,
            xmult = 0,
            xchips = 0,
            p_dollars = 0,
            h_dollars = 0,
            consumed = false
        }
    },
    rarity = 3,
    pos = {
        x = 3,
        y = 5
    },
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            card.ability.extra.consumed = false
            return {
                chips = card.ability.extra.chips > 0 and card.ability.extra.chips or nil,
                mult = card.ability.extra.mult > 0 and card.ability.extra.mult or nil,
                xmult = card.ability.extra.xmult > 1 and card.ability.extra.xmult or nil,
                xchips = card.ability.extra.xchips > 1 and card.ability.extra.xchips or nil,
                dollars = card.ability.extra.p_dollars > 0 and card.ability.extra.p_dollars or nil
            }
        end
        if context.destroy_card and context.cardarea == G.hand and (not card.ability.extra.consumed) and
            next(context.poker_hands['Straight']) and not context.blueprint then
            local consuming_card = card
            local consumed_card

            for i = 1, #G.hand.cards do
                local candidate = G.hand.cards[i]
                if candidate and candidate:can_calculate(true) and candidate == context.destroy_card then
                    consumed_card = candidate
                    consumed_card.getting_sliced = true
                    card.ability.extra.consumed = true
                    break
                end
            end

            local old_debuff = consumed_card.debuff
            consumed_card.debuff = nil

            consuming_card.ability.extra.chips = consuming_card.ability.extra.chips + consumed_card:get_chip_bonus() +
                                                     consumed_card:get_chip_h_bonus()
            consuming_card.ability.extra.mult = consuming_card.ability.extra.mult + consumed_card:get_chip_mult() +
                                                    consumed_card:get_chip_h_mult()
            consuming_card.ability.extra.xmult = consuming_card.ability.extra.xmult + consumed_card:get_chip_x_mult() +
                                                     consumed_card:get_chip_h_x_mult()
            consuming_card.ability.extra.xchips =
                consuming_card.ability.extra.xchips + consumed_card:get_chip_x_bonus() +
                    consumed_card:get_chip_h_x_bonus()
            consuming_card.ability.extra.p_dollars = consuming_card.ability.extra.p_dollars +
                                                         consumed_card:get_p_dollars()
            consuming_card.ability.extra.h_dollars = consuming_card.ability.extra.h_dollars +
                                                         consumed_card:get_h_dollars()

            consumed_card.debuff = old_debuff

            return {
                message = "CONSUME!",
                colour = G.C.RED,
                message_card = card
            }
        end
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.h_dollars > 0 and card.ability.extra.h_dollars or nil
    end,

    loc_vars = function(self, info_queue, card)
        if misc.check_hold_key_info() then
            info_queue[#info_queue + 1] = {
                key = "vic_consume",
                set = "Other"
            }
        end
        return {
            main_end = _generate_main_end(card)
        }
    end
}
