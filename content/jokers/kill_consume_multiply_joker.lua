return {
    key = 'kill_consume_multiply_joker',
    config = {},
    rarity = 1,
    pos = {
        x = 0,
        y = 8
    },
    atlas = 'joker_atlas',
    cost = 1,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.post_trigger and context.other_context.end_of_round then
            sendDebugMessage("KCMJ")
            sendDebugMessage(tprint(context.other_card))
        end
        if context.post_trigger and context.other_card and
            (context.other_card.ability.set == 'Default' or context.other_card.ability.set == 'Enhanced') and
            context.other_ret.vic_consume then
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local _card = copy_card(context.other_card, nil, nil, G.playing_card)
            _card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, _card)
            G.hand:emplace(_card)
            _card:start_materialize()
            _card.states.visible = nil

            G.E_MANAGER:add_event(Event({
                func = function()
                    _card:start_materialize()
                    return true
                end
            }))

            return {
                message = "Multiply!",
                colour = G.C.RED,
                playing_cards_created = {true}
            }
        end
    end
}
