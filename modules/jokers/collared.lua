return {
    key = 'collared',
    config = {},
    rarity = 2,
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'collared',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    display_size = {
        w = 101,
        h = 95
    },
    soul_pos = {
        x = 0,
        y = 1,
        draw = function(card, scale_mod, rotate_mod)
            -- local champions_belt_scale_mod = -0.065 + 0.015 * math.sin(2.0 * G.TIMERS.REAL)
            card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center,
                (1.025 + 0.05 * math.sin(0.5 * G.TIMERS.REAL)) * scale_mod, (1.00 + 0.05 * math.sin(1.2 * G.TIMERS.REAL)) * rotate_mod, nil,
                -0.025 + 0.05 * math.sin(0.8 * G.TIMERS.REAL), nil, 0.6)
            card.children.floating_sprite_vic_collared:draw_shader('dissolve', nil, nil, nil, card.children.center,
                (1.05 + 0.1 * math.sin(0.8 * G.TIMERS.REAL)) * scale_mod, 2. * rotate_mod, nil, nil, nil, 0.6)
        end
    },

    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            card.children.floating_sprite_vic_collared = Sprite(card.T.x, card.T.y, card.T.w, card.T.h,
                G.ASSET_ATLAS[card.config.center.atlas], {
                    x = 0,
                    y = 2
                })
            card.children.floating_sprite_vic_collared.role.draw_major = card
            card.children.floating_sprite_vic_collared.states.hover.can = false
            card.children.floating_sprite_vic_collared.states.click.can = false
        end
    end
}
