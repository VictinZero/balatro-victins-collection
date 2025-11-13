local misc = {}

--- Append a text node to a UI nodes list.
--- @param nodes table List of UI nodes; the function will append a text node to this list
--- @param text string The text content for the new node
--- @param colour table|any Colour entry (usually a G.C.* colour table)
--- @param scale number|nil Optional text scaling factor. Default: 0.3
--- @return nil
misc.add_node = function(nodes, text, colour, scale)
    nodes[#nodes + 1] = {
        n = G.UIT.T,
        config = {
            text = text,
            colour = colour,
            scale = scale or 0.3
        }
    }
end

--- Append a row node to a UI nodes list.
--- @param nodes table List of UI nodes; the function will append a row node with align = 'cm'
--- @return nil
misc.add_row = function(nodes)
    nodes[#nodes + 1] = {
        n = G.UIT.R,
        config = {
            align = "cm"
        }
    }
end

misc.create_blind_tooltip = function(blind_choice, func)
    if not blind_choice.animation.alerted then
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                blind_choice.animation.children.alert = UIBox {
                    definition = create_UIBox_card_alert(),
                    config = {
                        align = "tri",
                        offset = {
                            x = 0.1,
                            y = 0.1
                        },
                        parent = blind_choice.animation
                    }
                }
                blind_choice.animation.children.alert.states.collide.can = false
                return true
            end
        }))
    end

    blind_choice.animation.states.hover.can = true
    blind_choice.animation.states.drag.can = false
    blind_choice.animation.states.collide.can = true
    blind_choice.animation.config = {
        blind = G.GAME.blind.config.blind.key,
        force_focus = true
    }
    blind_choice.animation.hover = function()
        if not G.CONTROLLER.dragging.target or G.CONTROLLER.using_touch then
            if not blind_choice.animation.hovering and blind_choice.animation.states.visible then
                blind_choice.animation.hovering = true
                blind_choice.animation.hover_tilt = 0
                --[[blind_choice.animation.hover_tilt = 3
                blind_choice.animation:juice_up(0.05, 0.02)
                play_sound('chips1', math.random()*0.1 + 0.55, 0.12)]]
                -- blind_choice.animation.config.h_popup = create_UIBox_blind_popup(tooltip_blind, true)

                local final_tooltip = {
                    n = G.UIT.ROOT,
                    config = {
                        align = "cm",
                        colour = G.C.CLEAR,
                        r = 0.1
                    },
                    nodes = {{
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            r = 0.1,
                            minw = 2.5,
                            padding = 0.1,
                            colour = G.C.CLEAR
                        },
                        nodes = func()
                    } -- Credits row goes here
                    --[[{
                            n=G.UIT.R,
                            config={
                                align = "cm",
                                r = 0.1,
                                minw = 2.5,
                                padding = 0.1,
                                colour = G.C.RED
                            },
                        },]] }
                }

                blind_choice.animation.config.h_popup = final_tooltip

                blind_choice.animation.config.h_popup_config = {
                    align = 'cl',
                    offset = {
                        x = -1.25,
                        y = 0
                    },
                    parent = blind_choice.animation
                }
                Node.hover(blind_choice.animation)
                if blind_choice.animation.children.alert then
                    blind_choice.animation.children.alert:remove()
                    blind_choice.animation.children.alert = nil
                    blind_choice.animation.alerted = true
                end
            end
        end
        blind_choice.animation.stop_hover = function()
            blind_choice.animation.hovering = false;
            Node.stop_hover(blind_choice.animation);
            blind_choice.animation.hover_tilt = 0
        end
    end
end

misc.create_UIBox_blind_popup_with_icon = function(blind_key, remove_reward)
    local blind = G.P_BLINDS[blind_key]
    local original_UIBox = create_UIBox_blind_popup(blind, true).nodes
    if remove_reward then
        table.remove(original_UIBox[2].nodes[1].nodes, 3)
    end -- Removes row listing money reward

    local blind_icon = {}
    blind_icon.animation = AnimatedSprite(0, 0, 1.4, 1.4, G.ANIMATION_ATLAS[blind.atlas or 'blind_chips'], blind.pos)
    blind_icon.animation:define_draw_steps({{
        shader = 'dissolve',
        shadow_height = 0.05
    }, {
        shader = 'dissolve'
    }})

    local icon_holder = {
        n = G.UIT.R,
        config = {
            align = "cm",
            minh = 1.50
        },
        nodes = {{
            n = G.UIT.O,
            config = {
                object = blind_icon.animation
            }
        }}
    }
    table.insert(original_UIBox, 2, icon_holder)
    return original_UIBox
end

misc.create_gradient = function(target_color, gradient_colors, speed, ease, alpha, game)
    -- Required:
    -- target_color : G.C.… entry
    -- gradient_colors : table of colors

    -- Optional:
    -- alpha : boolean
    -- speed : strictly positive number (slower when larger, faster when smaller)
    -- ease : function from [0,1] to [0,1]
    -- game : Game object

    local n_colors = #gradient_colors

    local speed = speed or 1.25
    -- local aux = function(x) return (x>0 and math.exp(-1/x)) or 0 end
    -- return x end --return aux(x)/(aux(x)+aux(1-x)) end
    -- ease_in_out
    local ease = ease or function(x)
        return -(math.cos(math.pi * x) - 1) / 2
    end
    local game = game or G

    local anim_timer = game.TIMERS.REAL / speed
    local progress = anim_timer % 1
    local current_color = (anim_timer - progress) % n_colors + 1

    local prev_color = gradient_colors[current_color]
    local new_color = gradient_colors[current_color % n_colors + 1]

    local for_limit = (alpha and 4) or 3

    for i = 1, for_limit do
        target_color[i] = prev_color[i] * (1 - ease(progress)) + new_color[i] * ease(progress)
    end
end

misc.generate_ui_for_zodiac = function(loc_vars)
    local generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        full_UI_table.name = localize {
            type = 'name',
            key = self.key,
            set = self.set,
            name_nodes = {},
            vars = specific_vars or {}
        }
        if specific_vars and specific_vars.debuffed then
            localize {
                type = 'other',
                key = 'debuffed_default',
                nodes = desc_nodes
            }
        else
            localize {
                type = 'descriptions',
                key = self.key,
                set = self.set,
                nodes = desc_nodes,
                vars = loc_vars(self, info_queue, card)
            }
            table.insert(desc_nodes[#desc_nodes], 1, misc.hand_level_for_zodiac(card))
        end
    end
    return generate_ui
end

misc.hand_level_for_zodiac = function(card)
    -- local hand_type = card.ability.extra.hand_type
    local zodiac = card.ability.extra.zodiac
    local level = (G.GAME and G.GAME.VictinsCollection.zodiac[zodiac]) or 1

    local n_colours = #G.C.VictinsCollection.HAND_LEVELS
    local idx = level % n_colours
    idx = (idx == 0) and n_colours or idx
    local colour = G.C.VictinsCollection.HAND_LEVELS[idx]

    local hand_level_UI = -- {
    -- {n=G.UIT.C, config={align = "bm", padding = 0.08, colour = {1., 1., 1., 0.}}, nodes={
    {
        n = G.UIT.C,
        config = {
            align = "m",
            colour = colour,
            r = 0.05,
            padding = 0.05
        },
        minw = 0.6,
        nodes = {{
            n = G.UIT.T,
            config = {
                text = ' ' .. localize('k_level_prefix') .. level .. ' ',
                colour = G.C.UI.TEXT_DARK,
                scale = 0.3,
                shadow = true
            }
        }}
    }
    -- }}
    -- }
    return hand_level_UI
end

misc.is_in_your_collection = function(card)
    if not G.your_collection then
        return false
    end
    -- sendDebugMessage(tprint(card.area.config))
    if card.area and card.area.config.collection then
        return true
    end
    --[[for i = 1, 3 do
        if (G.your_collection[i] and card.area == G.your_collection[i]) then return true end
    end]]
    return false
end

misc.random_showdown_blind = function(seed)
    local eligible_bosses = {}
    for k, v in pairs(G.P_BLINDS) do
        if not v.boss then
        elseif v.boss.showdown then
            eligible_bosses[k] = true
        elseif not v.boss.showdown then
            eligible_bosses[k] = nil
        end
    end
    for k, v in pairs(G.GAME.banned_keys) do
        if eligible_bosses[k] then
            eligible_bosses[k] = nil
        end
    end
    local _, boss = pseudorandom_element(eligible_bosses, pseudoseed(seed or 'seed'))
    return boss
end

misc.destroy_cards = function(cards, instant)
    if instant then
        local cards_
        if not type(cards) == 'table' then
            cards_ = {cards}
        else
            cards_ = cards
        end
        local playing_cards = {}
        for _, card in ipairs(cards_) do
            if card and not card.removed then
                if card.ability.name == 'Glass Card' then
                    card:shatter()
                else
                    card:start_dissolve(nil) -- , i == #G.hand.highlighted)
                end
            end
            if card.playing_card and G.jokers then
                playing_cards[#playing_cards + 1] = card
            end
        end
        if #playing_cards > 0 and G.jokers then
            for j = 1, #G.jokers.cards do
                eval_card(G.jokers.cards[j], {
                    cardarea = G.jokers,
                    remove_playing_cards = true,
                    removed = playing_cards
                })
            end
        end
    else
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                local cards_
                if not type(cards) == 'table' then
                    cards_ = {cards}
                else
                    cards_ = cards
                end
                local playing_cards = {}
                for _, card in ipairs(cards_) do
                    if card and not card.removed then
                        if card.ability.name == 'Glass Card' then
                            card:shatter()
                        else
                            card:start_dissolve(nil) -- , i == #G.hand.highlighted)
                        end
                    end
                    if card.playing_card and G.jokers then
                        playing_cards[#playing_cards + 1] = card
                    end
                end
                if #playing_cards > 0 and G.jokers then
                    for j = 1, #G.jokers.cards do
                        eval_card(G.jokers.cards[j], {
                            cardarea = G.jokers,
                            remove_playing_cards = true,
                            removed = playing_cards
                        })
                    end
                end
                return true
            end
        }))
    end
end

misc.a_consumes_b = function(consuming_card, consumed_card)
    local old_debuff = consumed_card.debuff
    consumed_card.debuff = nil

    consuming_card.ability.perma_bonus = consuming_card.ability.perma_bonus + consumed_card:get_chip_bonus()
    consuming_card.ability.perma_mult = consuming_card.ability.perma_mult + consumed_card:get_chip_mult()
    consuming_card.ability.perma_x_mult = consuming_card.ability.perma_x_mult + consumed_card:get_chip_x_mult()
    consuming_card.ability.perma_h_mult = consuming_card.ability.perma_h_mult + consumed_card:get_chip_h_mult()
    consuming_card.ability.perma_h_x_mult = consuming_card.ability.perma_h_x_mult + consumed_card:get_chip_h_x_mult()
    consuming_card.ability.perma_x_chips = consuming_card.ability.perma_x_chips + consumed_card:get_chip_x_bonus()
    consuming_card.ability.perma_h_chips = consuming_card.ability.perma_h_chips + consumed_card:get_chip_h_bonus()
    consuming_card.ability.perma_h_x_chips = consuming_card.ability.perma_h_x_chips + consumed_card:get_chip_h_x_bonus()
    consuming_card.ability.perma_h_dollars = consuming_card.ability.perma_h_dollars + consumed_card:get_h_dollars()
    consuming_card.ability.perma_p_dollars = consuming_card.ability.perma_p_dollars + consumed_card:get_p_dollars()

    consumed_card.debuff = old_debuff
end

-- Card draw utility

misc.find_playing_cards = function(rule, source_area, stop_on_first)
    local area = source_area or G.deck
    local available_cards = {}
    if area and #area.cards > 0 then
        for i = 1, #area.cards do
            local candidate = area.cards[i]
            if rule(candidate) then
                available_cards[#available_cards + 1] = candidate
                if stop_on_first then
                    break
                end
            end
        end
    end
    return available_cards
end

-- Note: `draw_card` already creates an Event for the card draw
misc.draw_specific_card = function(target_card, source, destination, instant, draw_card_args)
    local extra_args = draw_card_args or {}
    if instant then
        if target_card and not target_card.removed and target_card.area == (source or target_card.area) then
            draw_card(source, destination, extra_args.percent, extra_args.dir or 'up', extra_args.sort, target_card, extra_args.delay, extra_args.mute, extra_args.stay_flipped or false, extra_args.vol, extra_args.discarded_only)
        end
    else
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            func = function()
                misc.draw_specific_card(target_card, source, destination, true, extra_args)
                return true
            end
        }))
    end
end

misc.find_and_draw_cards = function(rule, seed, destination, draw_card_args)
    local extra_args = draw_card_args or {}

    if not rule or not seed then
        return
    end

    local candidates = misc.find_playing_cards(rule, extra_args.source)

    if not candidates or #candidates <= 0 then
        return
    end

    local target_card = pseudorandom_element(candidates, pseudoseed(seed))

    misc.draw_specific_card(target_card, extra_args.source, destination, extra_args.instant, extra_args.extra)
end

-- Hold key for extra info

misc.check_hold_key_info = function()
    return G and G.CONTROLLER and G.CONTROLLER.held_keys['lalt']
end

misc.generate_main_end_hold_key_info = function(card)
    local add_node = function(nodes, text, colour)
        nodes[#nodes + 1] = {
            n = G.UIT.T,
            config = {
                text = text,
                colour = colour,
                scale = 0.2
            }
        }
    end

    local nodes_ = {}

    add_node(nodes_, localize('k_vic_hold_key_info_1'), G.C.UI.TEXT_INACTIVE)
    nodes_[#nodes_ + 1] = {
        n = G.UIT.C,
        config = {
            align = "m",
            colour = G.C.UI.TEXT_INACTIVE,
            r = 0.05,
            padding = 0.03,
            res = 0.15
        },
        nodes = {{
            n = G.UIT.T,
            config = {
                text = 'ALT',
                colour = G.C.WHITE,
                scale = 0.2
            }
        }}
    }
    add_node(nodes_, localize('k_vic_hold_key_info_2'), G.C.UI.TEXT_INACTIVE)

    return {{
        n = G.UIT.C,
        config = {
            align = "bm",
            padding = 0.02
        },
        nodes = {{
            n = G.UIT.R,
            config = {
                align = "cm"
            },
            nodes = nodes_
        }}
    }}
end

misc.juice_tag_until = function(tag, eval_func, first, delay)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = delay or 0.1,
        blocking = false,
        blockable = false,
        timer = 'REAL',
        func = (function()
            if eval_func(tag) then
                if not first or first then
                    tag:juice_up(0.1, 0.1)
                end
                juice_card_until(tag, eval_func, nil, 0.8)
            end
            return true
        end)
    }))
end

return misc
