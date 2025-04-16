local misc = SMODS.load_file("misc_functions.lua")()

return {
    key = 'event_horizon',
    config = { extra = { required = 3, remaining = 3 } },
    rarity = 3,
    pos = { x = 4, y = 2 },
    atlas = 'joker_soul_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = { x = 4, y = 3 },

    calculate = function(self, card, context)
        if context.selling_card and context.card.area == G.consumeables and context.card.ability.set == 'Planet' then
            if card.ability.extra.remaining > 1 and not context.blueprint then
                card.ability.extra.remaining = card.ability.extra.remaining - 1
            elseif card.ability.extra.remaining <= 1 then
                if not context.blueprint then card.ability.extra.remaining = card.ability.extra.required end
                if G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer - (context.card.edition and context.card.edition.negative and 0 or 1) then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{key = 'c_black_hole'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                return {
                    message = localize { type = 'name_text', key = 'c_black_hole', set = 'Spectral' },
                    colour = G.C.PURPLE
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {
            key = "cr_vic_event_horizon",
            set = "Other"
        }
        info_queue[#info_queue + 1] = { key = "c_black_hole", set = "Spectral" }
        return {
            vars = misc.is_in_your_collection(card) and { card.ability.extra.required, '', '', '' } or
                { card.ability.extra.required, '[', card.ability.extra.remaining, '] ' }
        }
    end,
}
