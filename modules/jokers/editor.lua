local misc = NFS.load(SMODS.current_mod.path .. "/misc_functions.lua")()

local _generate_main_end = function(card)
    local main_end = 0
    if not misc.is_in_your_collection(card) then
        local active = card.ability.extra.active

        local colour = (active and G.C.GREEN) or G.C.RED
        local txt = (active and localize('k_active')) or localize('k_vic_inactive')
        main_end = {
            {
                n=G.UIT.C,
                config={
                    align = "bm",
                    padding = 0.02
                },
                nodes={
                    {
                        n=G.UIT.C,
                        config={
                            align = "m",
                            colour = colour,
                            r = 0.05,
                            padding = 0.05
                        },
                        nodes={
                            {
                                n=G.UIT.T, config={text = ' '..txt..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}
                            },
                        }
                    }
                }
            }
        }
    else
        main_end = nil
    end
    return main_end
end

return {
    key = 'terraforming',
    config = { extra = {active = true} },
    rarity = 1,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 1,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if not context.blueprint then
            if context.joker_main and card.ability.extra.active then
                card.ability.extra.active = false
                G.from_boss_tag = true
                G.FUNCS.reroll_boss()
                card:juice_up(1, 0.5)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    delay = 0.0,
                    func = function()
                        local boss_ = G.GAME.round_resets.blind_choices.Boss
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize{type = 'name_text', key = boss_, set = 'Blind'},
                            colour = G.P_BLINDS[boss_].boss_colour or G.C.FILTER
                        })
                        return true
                    end
                }))
            elseif context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss then
                card.ability.extra.active = true
            elseif context.setting_blind and not card.getting_sliced then
                if G.GAME.blind.boss then
                    card.ability.extra.active = false
                else
                    local eval = function() return card.ability.extra.active end
                    juice_card_until(card, eval, true)
                end
            elseif context.discard then
                card.ability.extra.active = false
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { main_end = _generate_main_end(card) }
    end
}
