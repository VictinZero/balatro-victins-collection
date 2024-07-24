function sendNestedMessage(message, logger)
    -- Edited from: Discord message
    -- By: Kenny Stone
    -- Date: 2024-05-08
    if client then
        level = "INFO "
        logger = logger or "DefaultLogger"
        message = message or "Default log message"
        message = tableToString(message)
        -- naive way to separate the logs if the console receive multiple logs at the same time
        client:send(os.date('%Y-%m-%d %H:%M:%S') .. " :: " .. level .. " :: " .. logger .. " :: " .. message .. "ENDOFLOG")
    end
end

function tableToString(t, seen)
    if type(t) ~= "table" then
        return tostring(t)
    end
    
    seen = seen or {}
    if seen[t] then
        return "..."  -- Handle cyclic references
    end
    seen[t] = true

    local parts = {}
    for key, value in pairs(t) do
        local keyString = tostring(key)
        local valueString
        if type(value) == "table" then
            valueString = tableToString(value, seen)
        else
            valueString = tostring(value)
        end
        table.insert(parts, keyString .. "=" .. valueString)
    end
    return "{" .. table.concat(parts, ", ") .. "}"
end

return {
    name = "The Dagger",
    key = "dagger", 
    pos = { x = 0, y = 0 },
    atlas = "blind_atlas",
    dollars = 5, 
    mult = 2, 
    vars = {}, 
    debuff = {},
    boss = {min = 1, max = 10},--{min = 4, max = 10},
    boss_colour = HEX('F03C3C'),
    discovered = true,
    loc_txt = {},

    --[[modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        G.GAME.VictinsCollection.dagger = cards
        sendNestedMessage(G.GAME.VictinsCollection.dagger)
        sendNestedMessage(hand)
        return mult, hand_chips, false
    end,]]

    debuff_hand = function(self, cards, hand, handname, check)
        G.GAME.VictinsCollection.dagger = cards
        --sendNestedMessage(G.GAME.VictinsCollection.dagger)
        --sendNestedMessage(hand)
        return false
    end,

    defeat = function(self)
        sendDebugMessage("Defeated Dagger!")
        if G.GAME.VictinsCollection.dagger and not G.GAME.blind.disabled then
            sendDebugMessage("Stabbing!")
            G.GAME.blind.triggered = true
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                func = function()
                    sendDebugMessage("Trying to draw…")
                    for k, _card in ipairs(G.GAME.VictinsCollection.dagger) do
                        if _card and not _card.removed then
                            sendDebugMessage("Drawn!")
                            draw_card(_card.area or G.discard, G.play, k*100/#G.GAME.VictinsCollection.dagger, 'up', nil, _card, 0.005, k%2==0, nil, math.max((21-k)/20, 0.7))
                        else sendDebugMessage("Nothing to draw…") end
                    end
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    for j=1, #G.jokers.cards do
                        eval_card(G.jokers.cards[j], {cardarea = G.jokers, remove_playing_cards = true, removed = G.play.cards})
                    end
                    for i=1, #G.play.cards do
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
        }))
        return
    end
}
