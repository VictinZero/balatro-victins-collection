return {
    name = "The Trash",
    key = "trash",
    pos = {
        x = 0,
        y = 13
    },
    atlas = "blind_atlas",
    dollars = 5,
    mult = 2,
    vars = {},
    debuff = {},
    boss = {
        min = 1,
        max = 10
    },
    boss_colour = HEX('FE5F55'),
    discovered = true,
    loc_txt = {},

    calculate = function(self, blind, context)
        if context.discard and G.GAME.current_round.discards_used <= 0 and context.other_card:can_calculate(true) and
            not blind.disabled then
            local highlighted_count = #context.full_hand
            local i = highlighted_count
            for i_ = 1, highlighted_count do
                if context.full_hand[i_] == context.other_card then
                    i = i_
                    break
                end
            end

            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local _card = copy_card(context.other_card, nil, nil, G.playing_card)
            _card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, _card)
            G.hand:emplace(_card)
            _card.states.visible = nil

            G.E_MANAGER:add_event(Event({
                func = function()
                    _card:start_materialize()
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    draw_card(G.hand, G.discard, i * 100 / highlighted_count, 'down', false, _card)
                    return true
                end
            }))
        end
    end
}
