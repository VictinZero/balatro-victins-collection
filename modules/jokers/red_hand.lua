return {
    key = 'red_hand',
    config = {
        extra = {
            active = false
        }
    },
    rarity = 1,
    pos = {
        x = 0, -- 3,
        y = 0 -- 2
    },
    atlas = 'red_hand',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = {
        x = 0, -- 3,
        y = 1, -- 3,
        draw = function(card, scale_mod, rotate_mod)
            local anim_timer = math.abs(((G.TIMERS.REAL / 2 - 1) % 2) - 1)

            local ease_alt = (anim_timer < 0.5 and 2 * anim_timer ^ 2) or (1 - 2 * (1 - anim_timer) ^ 2)
            local ease_num = (anim_timer < 0.5 and 4 * anim_timer ^ 3) or (1 - ((-2 * anim_timer + 2) ^ 3) / 2)

            local _elastic_ease = function(x)
                return 2 ^ (-10 * x) * math.sin((2 * math.pi / 3) * (10 * x - 0.75)) + 1
            end
            local elastic_ease = function(x)
                if ((G.TIMERS.REAL / 2 - 1) % 2) - 1 >= 0 then
                    return _elastic_ease(x) / _elastic_ease(1)
                else
                    return 1 - _elastic_ease(1-x) / _elastic_ease(1)
                end
            end

            local red_hand_scale_alt = -0.4 + 0.75*0.6*ease_num
            local red_hand_rotate_alt = -0.06 + 0.34*(2*ease_alt-1)

            -- local red_hand_scale_alt = -0.4 + 0.75 * 0.6 * ease_num
            -- local red_hand_rotate_alt = -0.06 + 0.34 * 2 * ease_alt - 1

            local red_hand_scale_mod = -0.4 + 0.6 * ease_num
            local red_hand_rotate_mod = -0.06 + 0.34 * (2 * ease_num - 1)

            local interpol = 0.8 * ease_num ^ 2 - 0.6 * ease_num
            local interpol_shadow = -(2 / 15) * ease_num ^ 2 + (13 / 30) * ease_num

            card.children.floating_sprite_vic_red_hand:draw_shader('dissolve', 0, nil, nil, card.children.center,
                red_hand_scale_alt, 1.15 * red_hand_rotate_alt, nil, -0.2 + 0.75 * interpol_shadow, nil, 0.6)
            card.children.floating_sprite_vic_red_hand:draw_shader('dissolve', nil, nil, nil, card.children.center,
                red_hand_scale_alt, 1.15 * red_hand_rotate_alt, nil, -0.2 + interpol, nil, 0.6)

            card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, red_hand_scale_mod,
                red_hand_rotate_mod, nil, -0.2 + interpol_shadow, nil, 0.6)
            card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center,
                red_hand_scale_mod, red_hand_rotate_mod, nil, -0.2 + interpol, nil, 0.6)

            -- local c5 = (2 * math.pi) / 4.5
            -- local ease_elastic = (anim_timer < 0.5 and -(2^(20*anim_timer - 10) * math.sin((20 * anim_timer - 11.125) * c5)) / 2) or (-(2^(-20*anim_timer - 10) * math.sin((20 * anim_timer - 11.125) * c5)) / 2 + 1)
            -- local anim_timer_2 = math.abs(((1.219*G.TIMERS.REAL - 1) % 2) - 1)
            -- local ease_num_2 = (anim_timer_2 < 0.5 and 4*anim_timer_2^3) or (1 - ((-2 * anim_timer_2 + 2)^3) / 2)
        end
    },

    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            card.children.floating_sprite_vic_red_hand = Sprite(card.T.x, card.T.y, card.T.w, card.T.h,
                G.ASSET_ATLAS[card.config.center.atlas], {
                    x = 0,
                    y = 2
                })
            card.children.floating_sprite_vic_red_hand.role.draw_major = card
            card.children.floating_sprite_vic_red_hand.states.hover.can = false
            card.children.floating_sprite_vic_red_hand.states.click.can = false
        end
    end,

    calculate = function(self, card, context)
        if context.setting_blind and card:can_calculate() then
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    local _hands = G.GAME.current_round.hands_left
                    local _discards = G.GAME.current_round.discards_left

                    ease_hands_played(_discards - _hands, true)
                    ease_discard(_hands - _discards, true)

                    local hand_UI = G.HUD:get_UIE_by_ID('hand_UI_count')
                    local discard_UI = G.HUD:get_UIE_by_ID('discard_UI_count')

                    hand_UI.config.object.colours = {G.C.RED}
                    discard_UI.config.object.colours = {G.C.BLUE}

                    hand_UI.config.object:update()
                    discard_UI.config.object:update()

                    card.ability.extra.active = true

                    return true
                end
            }))
        end
    end,

    calc_dollar_bonus = function(self, card)
        local hand_UI = G.HUD:get_UIE_by_ID('hand_UI_count')
        local discard_UI = G.HUD:get_UIE_by_ID('discard_UI_count')

        hand_UI.config.object.colours = {G.C.BLUE}
        discard_UI.config.object.colours = {G.C.RED}

        card.ability.extra.active = false

        return nil
    end,

    remove_from_deck = function(self, card, from_debuff)
        local hand_UI = G.HUD:get_UIE_by_ID('hand_UI_count')
        local discard_UI = G.HUD:get_UIE_by_ID('discard_UI_count')

        hand_UI.config.object.colours = {G.C.BLUE}
        discard_UI.config.object.colours = {G.C.RED}

        card.ability.extra.active = false
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {
            key = "cr_vic_red_hand",
            set = "Other"
        }
        return {
            vars = {
                colours = {(card.ability.extra.active and G.C.RED) or G.C.BLUE,
                           (card.ability.extra.active and G.C.BLUE) or G.C.RED}
            }
        }
    end
}
