return {
    name = "The Dagger",
    key = "dagger",
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
    }, -- {min = 4, max = 10},
    boss_colour = HEX('F03C3C'),
    discovered = true,
    loc_txt = {},

    debuff_hand = function(self, cards, hand, handname, check)
        for i = 1, #G.playing_cards do
            if G.playing_cards[i] and not G.playing_cards[i].removed then
                G.playing_cards[i].ability.vic_dagger_mark = nil
            end
        end
        if not G.GAME.blind.disabled then
            for k, v in ipairs(cards) do
                if v and not v.removed then
                    v.ability.vic_dagger_mark = true
                end
            end
        end
        return false
    end,

    defeat = function(self)
        sendDebugMessage("Defeated Dagger!")
        if not G.GAME.blind.disabled then
            sendDebugMessage("Stabbing!")
            G.GAME.blind.triggered = true
            for i = 1, #G.playing_cards do
                if G.playing_cards[i] and not G.playing_cards[i].removed then 
                    G.playing_cards[i].ability.vic_dagger_mark = nil
                end
            end
        end
        --[[G.E_MANAGER:add_event(Event({
                trigger = 'before',
                func = function()
                    sendDebugMessage("Trying to draw…")
                    for k, _card in ipairs(G.GAME.VictinsCollection.dagger) do
                        if _card and not _card.removed then
                            sendDebugMessage("Drawn!")
                            draw_card(_card.area or G.discard, G.play, k * 100 / #G.GAME.VictinsCollection.dagger, 'up',
                                nil, _card, 0.005, k % 2 == 0, nil, math.max((21 - k) / 20, 0.7))
                        else
                            sendDebugMessage("Nothing to draw…")
                        end
                    end
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    for j = 1, #G.jokers.cards do
                        eval_card(G.jokers.cards[j], {
                            cardarea = G.jokers,
                            remove_playing_cards = true,
                            removed = G.play.cards
                        })
                    end
                    for i = 1, #G.play.cards do
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                if G.play.cards[i].ability.name == 'Glass Card' then
                                    G.play.cards[i]:shatter()
                                else
                                    G.play.cards[i]:start_dissolve()
                                end
                                return true
                            end
                        }))
                    end
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                G.GAME.VictinsCollection.dagger = false
                G.STATE_COMPLETE = false
                G:update_hand_played(0)
                return true
            end
        }))]]
        return
    end,

    disable = function(self)
        for i = 1, #G.playing_cards do
            if G.playing_cards[i] and not G.playing_cards[i].removed then
                G.playing_cards[i].ability.vic_dagger_mark = nil
            end
        end
    end
}
