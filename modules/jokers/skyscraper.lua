local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

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

        if G.hand and G.hand.highlighted and #G.hand.highlighted > 0 then
            local order = {}
            for _, vh in ipairs(G.hand.cards) do
                for _, v in ipairs(G.hand.highlighted) do
                    if vh == v then
                        order[#order + 1] = v
                        break
                    end
                end
            end

            local bonus_list = {}
            local txt = {}
            local colour = {}

            local nodes_ = {}
            add_node(nodes_, '(If scored: ', G.C.UI.TEXT_INACTIVE)

            for k, v in ipairs(order) do --ipairs(G.hand.highlighted) do
                colour[k] = G.C.RED
                if v.facing == 'back' then
                    txt[k] = "???"
                    colour[k] = G.C.FILTER
                else
                    bonus_list[k] = 0
                    local id = v:get_id()
                    local nominal = v:get_nominal()
                    if id > 0 and not SMODS.has_no_rank(v) then
                        for _, v_ in pairs(G.playing_cards) do
                            if not SMODS.has_no_rank(v_) and id ~= v_:get_id() and nominal > v_:get_nominal() then
                                bonus_list[k] = bonus_list[k] + 1
                            end
                        end
                    end
                    txt[k] = tostring(bonus_list[k])
                    if bonus_list[k] > 0 then
                        colour[k] = G.C.BLUE
                        txt[k] = '+' .. txt[k]
                    end
                end

                if k > 1 then
                    add_node(nodes_, ', ', G.C.UI.TEXT_INACTIVE)
                end
                add_node(nodes_, txt[k], colour[k])
            end

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
end

return {
    key = 'skyscraper',
    config = {},
    rarity = 1,
    pos = {
        x = 0,
        y = 8
    },
    atlas = 'joker_atlas',
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            local card_ = context.other_card
            local id = card_:get_id()
            local nominal = card_:get_nominal()
            local counter = 0
            if id > 0 and not SMODS.has_no_rank(card) then
                for _, v in pairs(G.playing_cards) do
                    if not SMODS.has_no_rank(v) and id ~= v:get_id() and nominal > v:get_nominal() then
                        counter = counter + 1
                    end
                end
            end
            local chips_ = counter -- math.floor(counter)
            if chips_ > 0 then
                return {
                    chips = chips_,
                    card = card
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            main_end = _generate_main_end(card)
        }
    end
}
