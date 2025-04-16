local misc
local init, error = SMODS.load_file("misc_functions.lua")
if error then
    sendErrorMessage("VictinsCollection :: Failed to load misc_functions with error " .. error)
else
    misc = init()
end

return {
    key = 'flesh',
    atlas = 'enhancement_atlas',
    pos = {
        x = 0,
        y = 0
    },
    config = {},

    calculate = function(self, card, context, effect)
        if context.end_of_round and context.cardarea == G.hand and context.playing_card_end_of_round then

            local consumed_card

            for i = 2, #G.hand.cards do
                if G.hand.cards[i] == card then
                    for j = 1, i - 1 do
                        local candidate = G.hand.cards[i - j]
                        if candidate:can_calculate(true) then
                            consumed_card = candidate
                            consumed_card.getting_sliced = true
                            break
                        end
                    end
                    if consumed_card then
                        break
                    end
                end
            end

            if consumed_card == nil then
                return
            end

            misc.a_consumes_b(card, consumed_card)

            consumed_card.ability.vic_destroy_this = true

            return {
                message = "CONSUME!",
                colour = G.C.RED,
                message_card = card,
                vic_consume = true
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        if misc.check_hold_key_info() then
            info_queue[#info_queue + 1] = {
                key = "vic_consume",
                set = "Other"
            }
        end

        return {
            main_end = misc.generate_main_end_hold_key_info(card)
        }
    end
}
