return {
    name = "The Rock",
    key = "rock", 
    pos = { x = 0, y = 2 },
    atlas = "blind_atlas",
    dollars = 5, 
    mult = 2, 
    vars = {}, 
    debuff = {},
    boss = {min = 1, max = 10},
    boss_colour = HEX('D0D2D6'),
    discovered = true,
    loc_txt = {},

    set_blind = function(self, reset, silent)
        for i=1,7 do
            local front = pseudorandom_element(G.P_CARDS, pseudoseed('bl_rock'))
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.m_stone, {playing_card = G.playing_card})
            card:start_materialize({G.C.SECONDARY_SET.Enhanced})
            G.play:emplace(card)
            table.insert(G.playing_cards, card)

            G.deck.config.card_limit = G.deck.config.card_limit + 1

            draw_card(G.play, G.deck, 90,'up', nil)

            playing_card_joker_effects({true})
        end
    end
}
