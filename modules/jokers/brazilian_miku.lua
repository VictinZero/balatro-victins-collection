return {
    key = 'brazilian_miku',
    config = {}, -- extra={}},
    rarity = 3,
    pos = {
        x = 2,
        y = 2
    },
    atlas = 'joker_soul_atlas',
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = {
        x = 2,
        y = 3,
        draw = function(card, scale_mod, rotate_mod)
            card.hover_tilt = card.hover_tilt * 1.5
            card.children.floating_sprite:draw_shader('hologram', nil, card.ARGS.send_to_shader, nil,
                card.children.center, 2 * scale_mod, 2 * rotate_mod)
            card.hover_tilt = card.hover_tilt / 1.5
        end
    }

    --[[calculate = function(self, card, context)

    end,]]
}
