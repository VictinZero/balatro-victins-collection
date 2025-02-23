local function select_random_enhancement_by_weight(func, key, default)
    local function func_(v)
        return true
    end
    local func__ = func or func_

    local available_enhancements = get_current_pool("Enhanced")
    local options_ = {}
    for k, v in ipairs(available_enhancements) do
        if func__(v) then
            options_[#options_ + 1] = v
        end
    end
    if not #options_ or #options_ == 0 then
        options_[1] = default or 'm_bonus'
    end

    return SMODS.poll_enhancement {
        key = key,
        guaranteed = true,
        options = options_
    }
end

return {
    key = 'wildheart',
    config = {
        extra = {
            current = 'm_bonus'
        }
    },
    rarity = 2,
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    soul_pos = nil,
    enhancement_gate = 'm_wild',

    set_ability = function(self, card, initial, delay_sprites)
        local func = function(v)
            return v ~= 'm_wild' and v ~= 'm_stone' and v ~= card.ability.extra.current and not G.P_CENTERS[v].no_suit
        end

        card.ability.extra.current = select_random_enhancement_by_weight(func, 'vic_wildheart_poll' ..
            ('' or card.area.config.type == 'collection' and '_collection'))
    end,

    calculate = function(self, card, context)
        if context.check_enhancement and context.other_card.ability.name == 'Wild Card' then
            return {
                [card.ability.extra.current] = true
            }
        elseif (context.end_of_round and not context.repetition and not context.individual) then
            local func = function(v)
                return v ~= 'm_wild' and v ~= 'm_stone' and v ~= card.ability.extra.current and
                           not G.P_CENTERS[v].no_suit
            end

            card.ability.extra.current = select_random_enhancement_by_weight(func, 'vic_wildheart_poll')
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.current]
        return {
            vars = {localize {
                type = 'name_text',
                key = card.ability.extra.current,
                set = 'Enhanced'
            }}
        }
    end
}
