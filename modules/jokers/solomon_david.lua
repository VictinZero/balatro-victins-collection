local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

local _generate_main_end = function(card)
    local main_end = 0
    if not misc.is_in_your_collection(card) then
        local active = (card.ability.extra.ki_rata > 0) or (G.GAME.blind and G.GAME.current_round.hands_left > 0)
        local colour = (active and G.C.BLUE) or G.C.RED
        local txt = (active and '+'..((card.ability.extra.ki_rata > 0 and tostring(card.ability.extra.ki_rata)) or (G.GAME.blind and tostring(G.GAME.current_round.hands_left) or 'ERROR'))) or '0'
        main_end = {
                {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                    {n=G.UIT.C, config={align = "m", colour = colour, r = 0.05, padding = 0.05}, nodes={
                        {n=G.UIT.T, config={text = ' '..txt..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                    }}
                }}
            }
    else
        main_end = nil
    end
    return main_end
end

return {
    key = 'solomon_david',
    config = {extra={ki_rata=0}},
    rarity = 4,
    pos = { x = 0, y = 0 },
    atlas = 'joker_soul_atlas',
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = { x = 0, y = 1 },

    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            local speech_key = 'vic_solomon_title_1'

            local text = {}
            localize{type = 'quips', key = speech_key, vars = {}, nodes = text}
            local current_mod = #text or 1

            card:vic_say_stuff(current_mod)
            card:vic_add_speech_bubble(speech_key, 'bm', nil, {root_colour = G.C.WHITE, bg_colour = HEX('000000'), text_alignment = "cm"})

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
        if context.setting_blind and not card.getting_sliced and card.ability.extra.ki_rata > 0 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_discard(-G.GAME.current_round.discards_left, nil, true)
                    ease_hands_played(card.ability.extra.ki_rata)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_hands', vars = {card.ability.extra.ki_rata}}})
                    card.ability.extra.ki_rata = 0
                    return true
                end
            }))
        elseif context.end_of_round and context.individual and not context.blueprint then
            card.ability.extra.ki_rata = G.GAME.current_round.hands_left
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {main_end = _generate_main_end(card)}
    end,
}
