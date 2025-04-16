return {
    key = 'humbleing_bundle',
    config = {},
    rarity = 1,
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'champions_belt',
    cost = 1,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    display_size = {
        w = 87,
        h = 95
    },
    soul_pos = {
        x = 0,
        y = 1,
        draw = function(card, scale_mod, rotate_mod)
            local champions_belt_scale_mod = -0.065 + 0.015 * math.sin(2.0 * G.TIMERS.REAL)
            card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center,
                2 * champions_belt_scale_mod, 2 * rotate_mod, nil, 0.3 + 0.1 * math.sin(0.8 * G.TIMERS.REAL), nil, 0.6)
            card.children.vic_floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, nil,
                rotate_mod, nil, -0.125 + 0.225 * math.sin(1.2 * G.TIMERS.REAL), nil, 0.6)
        end
    },

    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            card.children.vic_floating_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h,
                G.ASSET_ATLAS[card.config.center.atlas], {
                    x = 1,
                    y = 2
                })
            card.children.vic_floating_sprite.role.draw_major = card
            card.children.vic_floating_sprite.states.hover.can = false
            card.children.vic_floating_sprite.states.click.can = false
        end
    end,

    calculate = function(self, card, context)
        if context.buying_card and context.card ~= card then
            local area = context.card.area
            if area == G.jokers or area == G.consumeables then
                local buffer = area == G.jokers and G.GAME.joker_buffer or G.GAME.consumeable_buffer
                if #area.cards + buffer < area.config.card_limit then
                    if area == G.jokers then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    else
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    end
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            SMODS.add_card {
                                set = context.card.ability.set
                            }
                            if area == G.jokers then
                                G.GAME.joker_buffer = 0
                            else
                                G.GAME.consumeable_buffer = 0
                            end
                            return true
                        end)
                    }))
                end
            elseif area == G.deck then
                local _card = create_playing_card({
                    center = G.P_CENTERS[(G.GAME.used_vouchers["v_illusion"] and
                        pseudorandom(pseudoseed('vic_hb_ill_enh_cha')) > 0.6) and SMODS.poll_enhancement {
                        key = 'vic_hb_ill_enh_poll',
                        guaranteed = true
                    } or 'c_base']
                }, G.deck, true, true, nil)
                if G.GAME.used_vouchers["v_illusion"] and pseudorandom(pseudoseed('vic_hb_ill_edi_cha')) > 0.8 then
                    local edition = poll_edition('vic_hb_ill_edi_poll', 1, true, true, nil)
                    _card:set_edition(edition, true, true)
                end
                playing_card_joker_effects({_card})
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {
            key = "cr_vic_champions_belt",
            set = "Other"
        }
    end,
}
