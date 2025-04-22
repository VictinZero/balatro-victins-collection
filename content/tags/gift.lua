return {
    key = 'gift',
    config = { bonus_value = 4 },
    atlas = 'tag_atlas',
    pos = {
        x = 5,
        y = 0
    },
    discovered = true,

    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true

            tag:yep('+', G.C.MONEY, function()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)

            for _, v in ipairs(G.jokers.cards) do
                if v.set_cost then
                    v.ability.extra_value = (v.ability.extra_value or 0) + tag.config.bonus_value
                    v:set_cost()
                end
            end
            for _, v in ipairs(G.consumeables.cards) do
                if v.set_cost then
                    v.ability.extra_value = (v.ability.extra_value or 0) + tag.config.bonus_value
                    v:set_cost()
                end
            end

            tag.triggered = true
            return true
        end
    end,

    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.bonus_value } }
    end
}
