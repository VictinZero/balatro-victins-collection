local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

local _generate_main_end = function(card)
    local content = {}
    if not misc.is_in_your_collection(card) then
        if #card.ability.extra.alignment == 0 then
            content[1] = {n=G.UIT.R,config={align = "cm"},nodes={}}
            content[1].nodes={
                    {n=G.UIT.T, config={text = "("..localize('k_none')..")", colour = G.C.UI.TEXT_INACTIVE, scale = 0.32}},
                }
        else
            for i=1,#card.ability.extra.alignment do
                content[#content + 1] = {n=G.UIT.R,config={align = "cm"},nodes={
                    {n=G.UIT.T, config={text = card.ability.extra.alignment[i], colour = G.C.SECONDARY_SET.Planet, scale = 0.32}},
                }}
            end
        end
        return {{n=G.UIT.C, config={align = "cm", minh = 0.4}, nodes=content}}
    else
        return nil
    end
end

return {
    key = 'syzygy',
    config = {extra={alignment = {}, syzygy = false}},
    rarity = 3,
    pos = { x = 9, y = 7 },
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and not card.ability.extra.syzygy and context.consumeable.ability.set == 'Planet' then
            local _name = context.consumeable.ability.name
            local _skip = false
            if #card.ability.extra.alignment > 0 then
                for i=1,#card.ability.extra.alignment do
                    if card.ability.extra.alignment[i] == _name then _skip = true; break end
                end
            end
            if not _skip then
                card.ability.extra.alignment = card.ability.extra.alignment or {}
                card.ability.extra.alignment[#card.ability.extra.alignment + 1] = _name
                local _aligned = false

                if #card.ability.extra.alignment == 3 then
                    card.ability.extra.syzygy = true
                    juice_card_until(card, function() return card.ability.extra.syzygy end, true)
                    _aligned = true
                end
                local percent = #card.ability.extra.alignment/3
                local delay = 1.25*0.75
                local volume = 0.8

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({ --Add bonus chips from this card
                            trigger = 'before',
                            delay = delay,
                            func = function()
                                attention_text({
                                    text = _name,
                                    scale = 0.7, 
                                    hold = delay - 0.2,
                                    backdrop_colour = G.C.SECONDARY_SET.Planet,
                                    align = 'bm',
                                    major = card,
                                    offset = {x = 0, y = 0.05*card.T.h}
                                })
                                play_sound('gong', 0.5+0.5*percent, 0.6*volume)
                                play_sound('gong', (0.5+0.5*percent)*1.5, 0.4*volume)
                                card:juice_up(0.6, 0.1)
                                G.ROOM.jiggle = G.ROOM.jiggle + 0.7
                                return true
                            end
                        }))
                        return true
                    end
                }))
                if _aligned then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex')})
                            return true
                        end
                    }))
                end
            end
        end
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then-- and G.GAME.blind.boss then
            if #card.ability.extra.alignment ~= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset')})
                        return true
                    end
                }))
            end
            card.ability.extra.alignment = {}
            card.ability.extra.syzygy = false
        end
    end,

    loc_vars = function(self, info_queue, card)
       return {main_end = _generate_main_end(card)}
    end,
}
