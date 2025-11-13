local misc = SMODS.load_file("misc_functions.lua")()

local _generate_main_end = function(card)
    if not misc.is_in_your_collection(card) then
        local add_node = misc.add_node

        local nodes_ = {}

        add_node(nodes_, '(Currently ', G.C.UI.TEXT_INACTIVE)
        add_node(nodes_, tostring(card.ability.extra.blinds_defeated), G.C.FILTER)
        add_node(nodes_, '/', G.C.UI.TEXT_INACTIVE)
        add_node(nodes_, tostring(card.ability.extra.blinds_to_defeat), G.C.FILTER)
        add_node(nodes_, ')', G.C.UI.TEXT_INACTIVE)

        return {{
            n = G.UIT.C,
            config = {
                align = "bm",
                padding = 0.02
            },
            nodes = {{
                n = G.UIT.R,
                config = {
                    align = "cm"
                },
                nodes = nodes_
            }}
        }}
    end
end

return {
    key = 'double_negative',
    config = {
        extra = {
            blinds_defeated = 0,
            blinds_to_defeat = 2
        }
    },
    rarity = 2,
    pos = {
        x = 5,
        y = 1
    },
    atlas = 'joker_atlas',
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    soul_pos = nil,

    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('negative_shine', nil, card.ARGS.send_to_shader)
        end
    end,

    calculate = function(self, card, context)
        if context.selling_self and card.ability.extra.blinds_defeated >= card.ability.extra.blinds_to_defeat then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_negative'))
                    add_tag(Tag('tag_negative'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
        end
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            card.ability.extra.blinds_defeated = card.ability.extra.blinds_defeated + 1
            if card.ability.extra.blinds_defeated >= card.ability.extra.blinds_to_defeat then
                local eval = function(card_)
                    return not card_.REMOVED
                end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.blinds_defeated >= card.ability.extra.blinds_to_defeat and
                    localize('k_active_ex')) or tostring(card.ability.extra.blinds_defeated) .. '/' ..
                    tostring(card.ability.extra.blinds_to_defeat),
                colour = G.C.FILTER
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_negative

        return {
            vars = {card.ability.extra.blinds_to_defeat},
            main_end = _generate_main_end(card)
        }
    end
}
