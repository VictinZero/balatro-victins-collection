return {
    name = "The Bell",
    key = "bell", 
    pos = { x = 0, y = 3 },
    atlas = "blind_atlas",
    dollars = 5, 
    mult = 2, 
    vars = {}, 
    debuff = {},
    boss = {min = 4, max = 10},
    boss_colour = HEX('009CFD'),
    discovered = true,
    loc_txt = {},

    drawn_to_hand = function(self)
        if not self.disabled then
            local any_forced = nil
            for k, v in ipairs(G.hand.cards) do
                if v.ability.forced_selection then
                    any_forced = true
                end
            end
            if not any_forced then 
                G.hand:unhighlight_all()
                local face_cards = {}
                for i = 1, #G.hand.cards do
                    if G.hand.cards[i]:is_face(true) then table.insert(face_cards, G.hand.cards[i]) end
                end
                if #face_cards > 0 then
                    local forced_card = pseudorandom_element(face_cards, pseudoseed('bl_vic_bell'))
                    forced_card.ability.forced_selection = true
                    G.hand:add_to_highlighted(forced_card)
                end
            end
        end
    end,

    disable = function(self)
        for k, v in ipairs(G.playing_cards) do
            v.ability.forced_selection = nil
        end
    end
}
