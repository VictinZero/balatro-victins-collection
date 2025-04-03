local misc = SMODS.load_file("misc_functions.lua")()

local _generate_main_end = function(card)
    local main_end = nil
    if not misc.is_in_your_collection(card) then
        local active = card.ability.extra.active

        local colour = (active and G.C.GREEN) or G.C.RED
        local txt = (active and localize('k_active')) or localize('k_vic_inactive')
        main_end = {{
            n = G.UIT.C,
            config = {
                align = "bm",
                padding = 0.02
            },
            nodes = {{
                n = G.UIT.C,
                config = {
                    align = "m",
                    colour = colour,
                    r = 0.05,
                    padding = 0.05
                },
                nodes = {{
                    n = G.UIT.T,
                    config = {
                        text = ' ' .. txt .. ' ',
                        colour = G.C.UI.TEXT_LIGHT,
                        scale = 0.3,
                        shadow = true
                    }
                }}
            }}
        }}
    end
    return main_end
end

return {
    key = 'hamster',
    config = {
        extra = {
            dollars = 20,
            rolls = 3,
            active = true
        }
    },
    rarity = 1,
    pos = {
        x = 1,
        y = 1
    },
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.reroll_shop then
            if card.ability.extra.rolls <= 1 then
                if not context.blueprint then
                    card.ability.extra.rolls = 3
                    card.ability.extra.active = false
                end
                return {
                    dollars = card.ability.extra.dollars
                }
            else
                if card.ability.extra.active then
                    if not context.blueprint then
                        card.ability.extra.rolls = card.ability.extra.rolls - 1
                    end
                    if card.ability.extra.rolls == 1 then
                        local eval = function()
                            return card.ability.extra.rolls == 1
                        end
                        juice_card_until(card, eval, true)
                    end
                end
            end
        end
        if context.setting_blind and card:can_calculate() and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.active = true
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.dollars, card.ability.extra.rolls},
            main_end = _generate_main_end(card)
        }
    end
}
