return {
    key = 'eye_test',
    config = {},
    rarity = 1,
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'eye_test',
    cost = 1,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,

    soul_pos = {
        x = 0,
        y = 2,
        draw = function(card, scale_mod, rotate_mod)
            local ref = {1., 0.}

            local cursor_pos = {G.CURSOR.T.x, G.CURSOR.T.y}

            local card_center_pos = {(card.VT.x + (card.VT.w / 2) + G.ROOM.T.x),
                                     (card.VT.y + (card.VT.h / 2) + G.ROOM.T.y)}

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
            end

            local pixel_scale_h, pixel_scale_v = card.VT.h / 95., card.VT.w / 71.

            card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, nil,
                sign * angle, (0. + 5. * math.cos(sign * angle)) * pixel_scale_h,
                (-6. + 5. * math.sin(sign * angle)) * pixel_scale_v, nil, 0.6)

            card.children.floating_sprite_vic_eye_test:draw_shader('dissolve', nil, nil, nil, card.children.center, nil,
                nil, nil, nil, nil, 0.6)
        end
    },

    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            card.children.floating_sprite_vic_eye_test = Sprite(card.T.x, card.T.y, card.T.w, card.T.h,
                G.ASSET_ATLAS[card.config.center.atlas], {
                    x = 0,
                    y = 1
                })
            card.children.floating_sprite_vic_eye_test.role.draw_major = card
            card.children.floating_sprite_vic_eye_test.states.hover.can = false
            card.children.floating_sprite_vic_eye_test.states.click.can = false
        end
    end
}
