return {
    key = 'test',
    config = {},
    rarity = 1,
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'test',
    cost = 1,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    draw = function(self, card, scale_mod, rotate_mod)
        local ref = {1., 0.}

        local cursor_pos = {G.CURSOR.T.x, G.CURSOR.T.y}
        local scale = card.T.scale or 1.

        local card_center_pos = {(card.VT.x + (card.VT.w / 2) + G.ROOM.T.x),
                                 (card.VT.y + (card.VT.h / 2) + G.ROOM.T.y)}
        -- {(card.VT.x + (card.VT.w / 2) + G.ROOM.T.x) * G.TILESCALE * G.TILESIZE * G.CANV_SCALE,
        --                          (card.VT.y + (card.VT.h / 2) + G.ROOM.T.y) * G.TILESCALE * G.TILESIZE * G.CANV_SCALE}
        -- {card.T.x + card.VT.w, card.T.y + card.VT.h}

        local angle = 0

        local vec = {cursor_pos[1] - card_center_pos[1], cursor_pos[2] - card_center_pos[2]}
        local length = math.sqrt(vec[1] * vec[1] + vec[2] * vec[2])

        if length < 0.1 then
            angle = 0

        else
            angle = math.acos((vec[1] * ref[1] + vec[2] * ref[2]) / length)
        end

        local sign = 1
        if vec[2] < -0.1 then
            sign = -1
            -- sendDebugMessage('down')
        end

        -- if vec[2] > 0.1 then
        --     sendDebugMessage('up')
        -- end

        -- if vec[1] < -0.1 then
        --     sendDebugMessage('right')
        -- end

        -- if vec[1] > 0.1 then
        --     sendDebugMessage('left')
        -- end

        -- sendDebugMessage(
        --     'w: ' .. tostring(card.T.w) .. ', h: ' .. tostring(card.T.h) .. ', vw: ' .. tostring(card.VT.w) .. ', vh: ' ..
        --         tostring(card.VT.h))

        card.children.center:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, sign * angle, nil, nil,
            nil, 0.6)
    end
}
