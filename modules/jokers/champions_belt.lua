local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

return {
    key = 'champions_belt',
    config = {extra={Xmult=2.5}},
    rarity = 2,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

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
        return {vars = {card.ability.extra.Xmult}}
    end,
    
    subtitle = {
        text = {"The game just got harder!",}
    }
}
