local misc = SMODS.load_file("misc_functions.lua")()

return {
    key = 'starfish',
    config = {
        extra = {
            poker_hand = 'High Card',
            levels = 3
        }
    },
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

    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.visible then
                _poker_hands[#_poker_hands + 1] = k
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed("vic_starfish"))
    end,

    add_to_deck = function(self, card, from_debuff)
        update_hand_text({
            sound = 'button',
            volume = 0.7,
            pitch = 0.8,
            delay = 0.3
        }, {
            handname = card.ability.extra.poker_hand,
            chips = G.GAME.hands[card.ability.extra.poker_hand].chips,
            mult = G.GAME.hands[card.ability.extra.poker_hand].mult,
            level = G.GAME.hands[card.ability.extra.poker_hand].level
        })
        level_up_hand(card, card.ability.extra.poker_hand, nil, card.ability.extra.levels)
        update_hand_text({
            sound = 'button',
            volume = 0.7,
            pitch = 1.1,
            delay = 0
        }, {
            mult = 0,
            chips = 0,
            handname = '',
            level = ''
        })
        delay(0.1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        local handname = card.ability.extra.poker_hand
        local levels_to_decrease = math.max(1 - G.GAME.hands[handname].level, -card.ability.extra.levels)

        if levels_to_decrease < 0 then
            update_hand_text({
                sound = 'button',
                volume = 0.7,
                pitch = 0.8,
                delay = 0.3
            }, {
                handname = card.ability.extra.poker_hand,
                chips = G.GAME.hands[card.ability.extra.poker_hand].chips,
                mult = G.GAME.hands[card.ability.extra.poker_hand].mult,
                level = G.GAME.hands[card.ability.extra.poker_hand].level
            })
            level_up_hand(card, handname, nil, levels_to_decrease)
            update_hand_text({
                sound = 'button',
                volume = 0.7,
                pitch = 1.1,
                delay = 0
            }, {
                mult = 0,
                chips = 0,
                handname = '',
                level = ''
            })
        end
    end,

    loc_vars = function(self, info_queue, card)
        local main_end = misc.generate_main_end_hold_key_info(card)
        if misc.check_hold_key_info() then
            local nodes = main_end[1].nodes
            nodes[#nodes + 1] = {
                n = G.UIT.R,
                config = {
                    align = "cm"
                },
                nodes = {{
                    n = G.UIT.T,
                    config = {
                        text = "(Poker hand changes",
                        colour = G.C.UI.TEXT_INACTIVE,
                        scale = 0.3
                    }
                }}
            }
            nodes[#nodes + 1] = {
                n = G.UIT.R,
                config = {
                    align = "cm"
                },
                nodes = {{
                    n = G.UIT.T,
                    config = {
                        text = "whenever created)",
                        colour = G.C.UI.TEXT_INACTIVE,
                        scale = 0.3
                    }
                }}
            }
        end
        return {
            vars = {
                card.ability.extra.levels,
                card.ability.extra.poker_hand,
                colours = {G.C.VictinsCollection.POKER_HANDS[card.ability.extra.poker_hand] or G.C.FILTER}
            },
            main_end = main_end
        }
    end
}
