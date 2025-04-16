local misc = SMODS.load_file("misc_functions.lua")()

return {
    key = 'royal_straight_joker',
    config = {extra = {ranks = {10, 11, 12, 13, 14}}},
    rarity = 3,
    pos = {
        x = 0,
        y = 8
    },
    atlas = 'joker_atlas',
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.hand_drawn and (G.GAME.current_round.hands_left == 1) and #G.deck.cards > 0 then
            local status = false
            for _, rank in ipairs(card.ability.extra.ranks) do
                local rule = function(c_) return c_:get_id() == rank end
                if #misc.find_playing_cards(rule, nil, true) > 0 then status = true end
                misc.find_and_draw_cards(rule, 'vic_rst_'..tostring(rank), G.hand, {source = G.deck, extra = {sort = true}})
            end
            return {
                message = status and "HAPPY" or "SAD",
                colour = status and G.C.PURPLE or G.C.PURPLE
            }
        end
    end
}
