local misc = SMODS.load_file("misc_functions.lua")()

return {
    key = 'liquidation',
    config = { vic_active = false },
    atlas = 'tag_atlas',
    pos = {
        x = 2,
        y = 0
    },
    discovered = true,

    apply = function(self, tag, context)
        if context.type == 'shop_start' then
            tag.vic_active = true
            G.E_MANAGER:add_event(Event({
                delay = 0.4,
                trigger = 'after',
                func = (function()
                    attention_text({
                        text = '+',
                        colour = G.C.WHITE,
                        scale = 1,
                        hold = 0.3 / G.SETTINGS.GAMESPEED,
                        cover = tag.HUD_tag,
                        cover_colour = G.C.FILTER,
                        align = 'cm'
                    })
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))

            misc.juice_tag_until(tag, function(tag)
                return tag and not tag.triggered
            end, true, 0.1)
        elseif context.type == 'vic_buying_card' and tag.vic_active then
            local area = context.card.area
            if area == G.jokers or area == G.consumeables then
                local buffer = area == G.jokers and G.GAME.joker_buffer or G.GAME.consumeable_buffer
                if #area.cards + buffer < area.config.card_limit then
                    if area == G.jokers then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    else
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    end
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            SMODS.add_card {
                                set = context.card.ability.set
                            }
                            if area == G.jokers then
                                G.GAME.joker_buffer = 0
                            else
                                G.GAME.consumeable_buffer = 0
                            end
                            return true
                        end)
                    }))
                end
            elseif area == G.deck then
                local _card = create_playing_card({
                    center = G.P_CENTERS[(G.GAME.used_vouchers["v_illusion"] and
                        pseudorandom(pseudoseed('vic_hb_ill_enh_cha')) > 0.6) and SMODS.poll_enhancement {
                        key = 'vic_hb_ill_enh_poll',
                        guaranteed = true
                    } or 'c_base']
                }, G.deck, true, true, nil)
                if G.GAME.used_vouchers["v_illusion"] and pseudorandom(pseudoseed('vic_hb_ill_edi_cha')) > 0.8 then
                    local edition = poll_edition('vic_hb_ill_edi_poll', 1, true, true, nil)
                    _card:set_edition(edition, true, true)
                end
                playing_card_joker_effects({ _card })
            end
        elseif context.type == 'new_blind_choice' and tag.vic_active then
            stop_use()

            G.E_MANAGER:add_event(Event({
                func = (function()
                    tag.HUD_tag.states.visible = false
                    return true
                end)
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7,
                func = (function()
                    tag:remove()
                    return true
                end)
            }))

            tag.triggered = true
        end
    end
}
