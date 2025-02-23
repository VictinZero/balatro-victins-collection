return {
    name = "The Bottle",
    key = "bottle",
    pos = {
        x = 0,
        y = 0
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
    boss_colour = HEX('F6C0DC'),
    discovered = true,
    loc_txt = {},

    set_blind = function(self, reset, silent)
        if not reset and not G.GAME.blind.disabled then
            -- G.GAME.blind.hand_size_mod = G.hand.config.card_limit
            local bottle_hand_size = G.hand.config.card_limit

            G.hand:change_size(bottle_hand_size)
            G.GAME.VictinsCollection.bottle_hand_size = bottle_hand_size
            G.GAME.blind.prepped = true
        end
    end,

    drawn_to_hand = function(self)
        if not G.GAME.blind.disabled and G.GAME.blind.prepped then
            local deck_size = #G.deck.cards
            for i = 1, deck_size do
                draw_card(G.deck, G.discard, i * 100 / deck_size, 'down', true)
            end
        end
    end,

    disable = function(self)
        -- G.GAME.blind.disabled = true
        if G.GAME.VictinsCollection.bottle_hand_size and G.GAME.VictinsCollection.bottle_hand_size > 0 then
            G.hand:change_size(-G.GAME.VictinsCollection.bottle_hand_size)
            G.GAME.VictinsCollection.bottle_hand_size = 0
        end
        G.FUNCS.draw_from_discard_to_deck()
    end,

    defeat = function(self)
        if G.GAME.VictinsCollection.bottle_hand_size and G.GAME.VictinsCollection.bottle_hand_size > 0 then
            G.hand:change_size(-G.GAME.VictinsCollection.bottle_hand_size)
            G.GAME.VictinsCollection.bottle_hand_size = 0
        end
    end
}
