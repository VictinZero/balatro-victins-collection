
--[[
    local draw_from_play_to_discard_ref = G.FUNCS.draw_from_play_to_discard

    G.FUNCS.draw_from_play_to_discard = function(e)
        draw_from_play_to_discard_ref(e)

        if G.GAME.VictinsCollection.post_discard_draw then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local n = #G.GAME.VictinsCollection.post_discard_draw
                    local it = 1
                    for k, v in ipairs(G.GAME.VictinsCollection.post_discard_draw) do
                        if v and not v.removed then
                            draw_card(v.area, G.hand, it * 100 / n, 'up', true, v)
                            it = it + 1
                        end
                    end
                    G.GAME.VictinsCollection.post_discard_draw = false
                    return true
                end
            }))
        end
    end
]]

return {
    key = 'grappling_hook',
    config = {},
    rarity = 1,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.after then
            if not G.GAME.VictinsCollection.post_discard_draw then G.GAME.VictinsCollection.post_discard_draw = {} end
            G.GAME.VictinsCollection.post_discard_draw[#G.GAME.VictinsCollection.post_discard_draw + 1] = context.full_hand[1]
        end
    end,
}
