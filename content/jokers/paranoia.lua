return {
    key = 'paranoia',
    config = {},
    rarity = 3,
    pos = { x = 0, y = 8 },
    atlas = 'joker_atlas',
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            if next(context.poker_hands['Pair']) then
                return {
                    message = localize('k_nope_ex'),
                    colour = G.C.PURPLE
                }
            else
                if G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card { set = 'Spectral' }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                return {
                    message = localize('k_plus_spectral'),
                    colour = G.C.SECONDARY_SET.Spectral
                }
            end
        end
    end,
}
