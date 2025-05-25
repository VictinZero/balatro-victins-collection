local misc
local init, error = SMODS.load_file("misc_functions.lua")
if error then
    sendErrorMessage("VictinsCollection :: Failed to load misc_functions with error " .. error)
else
    misc = init()
end

local _count_jokers_of_rarity = function(rarity)
    local count = 0
    for _, v in ipairs(G.jokers.cards) do
        if v.config.center.rarity == rarity then count = count + 1 end
    end
    return count
end

local _generate_main_end = function(card)
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

    if (not card.ability.extra.triggered) or misc.check_hold_key_info() then
        local line_0, line_1, line_2, line_3 = {}, {}, {}, {}

        line_0[#line_0 + 1] = {
            n = G.UIT.T,
            config = {
                text = ' ',
                colour = G.C.UI.TEXT_DARK,
                scale = 0.3 * 0.33
            }
        }
        add_row(nodes_)
        nodes_[#nodes_].nodes = line_0

        add_node(line_1, 'When you first', G.C.UI.TEXT_DARK)
        add_node(line_1, ' get ', G.C.FILTER)
        add_node(line_1, 'this,', G.C.UI.TEXT_DARK)
        add_row(nodes_)
        nodes_[#nodes_].nodes = line_1

        add_node(line_2, 'get ', G.C.FILTER)
        add_node(line_2, 'a copy of it', G.C.UI.TEXT_DARK)
        add_row(nodes_)
        nodes_[#nodes_].nodes = line_2

        add_node(line_3, '(Must have room)', G.C.UI.TEXT_INACTIVE)
        add_row(nodes_)
        nodes_[#nodes_].nodes = line_3

        return { {
            n = G.UIT.C,
            config = {
                align = "bm",
                padding = 0.02
            },
            nodes = nodes_
        } }
    else
        local ret = misc.generate_main_end_hold_key_info(card)
        if G.jokers then
            local active = _count_jokers_of_rarity(card.config.center.rarity) == 2
            local colour = active and G.C.GREEN or G.C.RED
            local txt = active and localize('k_active') or localize('k_vic_inactive')

            table.insert(ret[1].nodes, 1, {
                n = G.UIT.R,
                config = {
                    align = "cm"
                },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "bm", padding = 0.02 },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                                nodes = {
                                    { n = G.UIT.T, config = { text = ' ' .. txt .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                                }
                            }
                        }
                    }
                }
            })
        end
        return ret
    end
end

return {
    key = 'brass_knuckles',
    config = { extra = { xmult = 1.5, knuckles = 2, triggered = false } },
    rarity = 1,
    pos = { x = 0, y = 8 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    add_to_deck = function(self, card, from_debuff)
        if not (from_debuff or card.ability.extra.triggered) then
            card.ability.extra.triggered = true
            if (card.edition and card.edition.card_limit and card.edition.card_limit > 0) or (#G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit - 1 + ((card.edition and card.edition.card_limit) or 0)) then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1 - ((card.edition and card.edition.card_limit) or 0)
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        local new_card = copy_card(card)
                        new_card:add_to_deck()
                        G.jokers:emplace(new_card)

                        G.GAME.joker_buffer = 0
                        return true
                    end)
                }))
                SMODS.calculate_effect({ message = localize('k_plus_joker') }, card)
            else
                SMODS.calculate_effect({ message = localize('k_no_room_ex'), sound = 'tarot2' }, card)
            end
        end
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if _count_jokers_of_rarity(card.config.center.rarity) == 2 then
                return { xmult = card.ability.extra.xmult }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.knuckles, card.ability.extra.xmult }, main_end = _generate_main_end(card) }
    end,
}
