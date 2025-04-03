local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

return {
    key = 'champions_belt',
    config = {
        extra = {
            Xmult = 2.5
        }
    },
    rarity = 2,
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'champions_belt',
    cost = 5,
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
            card.children.floating_sprite_vic_belt:draw_shader('dissolve', nil, nil, nil, card.children.center, nil,
                rotate_mod, nil, -0.125 + 0.225 * math.sin(1.2 * G.TIMERS.REAL), nil, 0.6)
        end
    },

    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            card.children.floating_sprite_vic_belt = Sprite(card.T.x, card.T.y, card.T.w, card.T.h,
                G.ASSET_ATLAS[card.config.center.atlas], {
                    x = 0,
                    y = 2
                })
            card.children.floating_sprite_vic_belt.role.draw_major = card
            card.children.floating_sprite_vic_belt.states.hover.can = false
            card.children.floating_sprite_vic_belt.states.click.can = false
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        sendDebugMessage("Adding Champions' Belt")
        G.GAME.VictinsCollection.champions_belt = true -- (next(SMODS.find_card('j_vic_champions_belt')) and true) or false
        G.GAME.VictinsCollection.adding_champions_belt = true
        if (not (G.GAME.blind and G.GAME.blind:get_type() == 'Boss')) and
            (not G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown) and not from_debuff then
            local boss = misc.random_showdown_blind()
            sendDebugMessage("Boss is " .. tostring(boss))
            if boss then
                G.FORCE_BOSS = boss
            end
            G.from_boss_tag = true
            G.FUNCS.reroll_boss()
        end
        G.GAME.VictinsCollection.adding_champions_belt = false
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize {
                    type = 'variable',
                    key = 'a_xmult',
                    vars = {card.ability.extra.Xmult}
                },
                Xmult_mod = card.ability.extra.Xmult
            }
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.FORCE_BOSS = nil
            G.GAME.VictinsCollection.champions_belt = (next(SMODS.find_card('j_vic_champions_belt')) and true) or false
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {
            key = "cr_vic_champions_belt",
            set = "Other"
        }
        return {
            vars = {card.ability.extra.Xmult}
        }
    end,

    subtitle = "The game just got harder!"
}
