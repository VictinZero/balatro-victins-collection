local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

local custom_width = 87

return {
    key = 'champions_belt',
    config = {extra={Xmult=2.5}},
    rarity = 2,
    pos = { x = 0, y = 0 },
    atlas = 'champions_belt',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = { x = 0, y = 1 },

    set_ability = function(self, card, initial, delay_sprites)
        if self.discovered or card.bypass_discovery_center then
            card.T.w = card.T.w * (custom_width / 71)
            card.children.floating_sprite.T.w = card.children.floating_sprite.T.w * (custom_width / 71)
        end
    end,

    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            card.children.center.scale.x = card.children.center.scale.x
            card.children.floating_sprite.scale.x = card.children.floating_sprite.scale.x --* (custom_width / 71)
        end
    end,

    load = function(self, card, card_table, other_card)
        if self.discovered or card.bypass_discovery_center then
            card.T.w = card.T.w * (custom_width / 71)
            --card.children.floating_sprite.T.w = card.children.floating_sprite.T.w * (custom_width / 71)
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        sendDebugMessage("Adding Champions' Belt")
        G.GAME.VictinsCollection.champions_belt = true --(next(SMODS.find_card('j_vic_champions_belt')) and true) or false
        G.GAME.VictinsCollection.adding_champions_belt = true
        if (not (G.GAME.blind and G.GAME.blind:get_type() == 'Boss')) and (not G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown) and not from_debuff then
            local boss = misc.random_showdown_blind()
            sendDebugMessage("Boss is "..tostring(boss))
            if boss then G.FORCE_BOSS = boss end
            G.from_boss_tag = true
            G.FUNCS.reroll_boss()
        end
        G.GAME.VictinsCollection.adding_champions_belt = false
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
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
        info_queue[#info_queue+1] = {key = "cr_vic_champions_belt", set = "Other"}
        return {vars = {card.ability.extra.Xmult}}
    end,

    subtitle = {
        text = {"The game just got harder!",}
    }
}
