SMODS.DrawStep {
    key = 'underlayer',
    order = -15,
    func = function(card, layer)
        if card.config.center_key == 'j_vic_paranoia' then
            if card.children.vic_underlayer_01 then
                local tilt = 1.15
                card.children.vic_underlayer_01:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, nil, nil, tilt)

                local cursor_pos = { G.CURSOR.T.x, G.CURSOR.T.y }
                local scale = card.T.scale or 1.

                local card_center_pos = { (card.VT.x + (card.VT.w / 2) + G.ROOM.T.x),
                    (card.VT.y + (card.VT.h / 2) + G.ROOM.T.y) }

                local dx = cursor_pos[1] - card_center_pos[1]
                local length = card.VT.w/71

                dx = math.max(math.min(dx/20, length), -length)

                card.children.vic_underlayer_02:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, dx, nil, nil, tilt)
                card.children.vic_underlayer_03:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, dx, nil, nil, tilt)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}
