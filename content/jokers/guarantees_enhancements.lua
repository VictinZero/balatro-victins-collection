return {
    key = 'guarantees_enhancements',
    config = {},
    rarity = 3,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.VictinsCollection.guarantee_enhancement = (next(SMODS.find_card('j_vic_guarantees_enhancements')) and true) or false
    end,

    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.VictinsCollection.guarantee_enhancement = (next(SMODS.find_card('j_vic_guarantees_enhancements')) and true) or false
        end
    end,
}
