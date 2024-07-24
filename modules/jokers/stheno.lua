return {
    key = 'stheno',
    config = {},
    rarity = 2,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    add_to_deck = function(self, card, from_debuff)
        sendDebugMessage("Adding Stheno")
        G.GAME.VictinsCollection.stheno = true --(next(SMODS.find_card('j_vic_stheno')) and true) or false
        G.GAME.VictinsCollection.adding_stheno = true
        if (not (G.GAME.blind and G.GAME.blind:get_type() == 'Boss')) and (not G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown) and (G.GAME.round_resets.blind_choices.Boss ~= 'bl_vic_rock') and not from_debuff then
            G.FORCE_BOSS = 'bl_vic_rock'
            G.from_boss_tag = true
            G.FUNCS.reroll_boss()
        end
        G.GAME.VictinsCollection.adding_stheno = false
    end,

    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.FORCE_BOSS = nil
            G.GAME.VictinsCollection.champions_belt = (next(SMODS.find_card('j_vic_stheno')) and true) or false
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "aux_vic_stheno", set = "Other"}
    end,
}
