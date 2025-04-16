return {
    key = 'cherry',
    config = {
        extra = {
            last_used_consumeable = false,
            n_cherries = 2
        }
    },
    rarity = 1,
    pos = {
        x = 0,
        y = 8
    },
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.using_consumeable then
            card.ability.extra.last_used_consumeable = context.consumeable.config.center_key
        end
        if context.selling_self and card.ability.extra.last_used_consumeable then
            for _ = 1, card.ability.extra.n_cherries do
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            SMODS.add_card {
                                key = card.ability.extra.last_used_consumeable,
                                area = G.consumeables
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                end
            end
            --[[
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_vic_liquidation_tag'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            ]]
        end
    end,

    loc_vars = function(self, info_queue, card)
        if card.ability.extra.last_used_consumeable then
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.last_used_consumeable] or nil
        end
        -- info_queue[#info_queue + 1] = G.P_TAGS.tag_vic_liquidation_tag
    end
}
