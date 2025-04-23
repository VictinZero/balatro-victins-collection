return {
    key = 'paranoia',
    config = {},
    rarity = 3,
    pos = { x = 0, y = 0 },
    atlas = 'paranoia',
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    display_size = {
        w = 71,
        h = 87
    },
    soul_pos = nil,

    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            for i = 1, 3 do
                card.children['vic_underlayer_0'..tostring(i)] = Sprite(card.T.x, card.T.y, card.T.w, card.T.h,
                    G.ASSET_ATLAS[card.config.center.atlas], {
                        x = 0,
                        y = i
                    })
                card.children['vic_underlayer_0'..tostring(i)].role.draw_major = card
                card.children['vic_underlayer_0'..tostring(i)].states.hover.can = false
                card.children['vic_underlayer_0'..tostring(i)].states.click.can = false
            end
        end
    end,

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
