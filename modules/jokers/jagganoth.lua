return {
    key = 'jagganoth',
    config = {
        extra = {
            highlighted_cards = {},
            cycles = 0, -- speech_state = 'law',
            speech_states = {
                law = false,
                goal = false,
                belief = false,
                poem = false,
                sword = false
            },
            speech_length = {
                law = 5,
                goal = 5,
                belief = 5,
                poem = 4,
                sword = 8
            }
            --[[speech_map = {
                law = 'goal',
                goal = 'belief',
                belief = 'poem',
                poem = 'sword',
                sword = 'law',
            }]]
        }
    },
    rarity = 4,
    pos = {
        x = 1,
        y = 0
    },
    atlas = 'joker_soul_atlas',
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = {
        x = 1,
        y = 1
    },

    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            local speech_key = 'vic_jagganoth_title_1'

            local text = {}
            localize {
                type = 'quips',
                key = speech_key,
                vars = {},
                nodes = text
            }
            local current_mod = #text or 1

            card:vic_say_stuff(current_mod)
            card:vic_add_speech_bubble(speech_key, 'bm', nil, {
                root_colour = G.C.WHITE,
                bg_colour = HEX('000000'),
                text_alignment = "cm"
            })

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 12,
                blocking = false,
                func = function()
                    card:vic_remove_speech_bubble()
                    return true
                end
            }))
        end
    end,

    calculate = function(self, card, context)
        -- local jagganoths = next(SMODS.find_card("j_vic_jagganoth"))
        local _jagganoth
        for k, v in ipairs(G.jokers.cards) do
            if v and type(v) == 'table' and v.config.center.key == 'j_vic_jagganoth' and not v.debuff then
                _jagganoth = v
                break
            end
        end
        if context.before and _jagganoth and card == _jagganoth and G.GAME.current_round.hands_played == 0 then
            if G.GAME.blind.boss or pseudorandom('jagganoth_speech') < 1 / 5 then
                local unseen = {}
                for k, v in pairs(card.ability.extra.speech_states) do
                    if not v then
                        table.insert(unseen, k)
                    end
                end
                if #unseen == 0 then
                    for k, v in pairs(card.ability.extra.speech_states) do
                        card.ability.extra.speech_states[k] = false;
                        table.insert(unseen, k)
                    end
                end

                local speech_state = pseudorandom_element(unseen, pseudoseed('jagganoth_state'))
                card.ability.extra.speech_states[speech_state] = true

                -- local speech_state = card.ability.extra.speech_state
                local speech_length = card.ability.extra.speech_length[speech_state]
                local speech_key = 'vic_jagganoth_' .. speech_state

                local make_talk
                make_talk = function(_card, key, n, counter)
                    local counter = counter or 1
                    local text_key = speech_key .. "_" .. tostring(counter)

                    local text = {}
                    localize {
                        type = 'quips',
                        key = text_key,
                        vars = {},
                        nodes = text
                    }
                    local current_mod = #text or 1

                    if n >= counter and _card then
                        _card:vic_say_stuff(current_mod)
                        _card:vic_add_speech_bubble(text_key, 'bm', nil, {
                            root_colour = key == 'vic_jagganoth_sword' and G.C.WHITE or G.C.RED,
                            bg_colour = HEX('000000'),
                            text_alignment = 'cm'
                        })
                    end
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 2.5 * current_mod,
                        blocking = false,
                        func = function()
                            if n >= counter then
                                make_talk(_card, key, n, counter + 1)
                            elseif _card then
                                _card:vic_remove_speech_bubble()
                            end
                            return true
                        end
                    }))
                end

                make_talk(card, speech_key, speech_length)

                -- card.ability.extra.speech_state = card.ability.extra.speech_map[card.ability.extra.speech_state]
            end
        end
        if context.vic_replay_hand then
            G.GAME.VictinsCollection.replay_hand = true
            return {repetitions = 1, message = localize('k_again_ex')}
        end
    end
}
