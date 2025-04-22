return {
    key = 'satellite',
    config = { money_bonus = 4 },
    atlas = 'tag_atlas',
    pos = {
        x = 4,
        y = 0
    },
    discovered = true,

    in_pool = function()
        local planets_used = false
        for _, v in pairs(G.GAME.consumeable_usage) do
            if v.set == 'Planet' then planets_used = true; break end
        end
        return planets_used
    end,

    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true

            tag:yep('+', G.C.MONEY, function()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)

            local money_bonus = tag.config.money_bonus
            local planets_used = 0
            for _, v in pairs(G.GAME.consumeable_usage) do
                if v.set == 'Planet' then planets_used = planets_used + 1 end
            end

            if planets_used > 0 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        ease_dollars(money_bonus * planets_used, true)
                        return true
                    end
                }))
            end

            tag.triggered = true
            return true
        end
    end,

    loc_vars = function(self, info_queue, tag)
        local money_bonus = tag.config.money_bonus
        local planets_used = 0
        for _, v in pairs(G.GAME.consumeable_usage) do
            if v.set == 'Planet' then planets_used = planets_used + 1 end
        end

        return { vars = { money_bonus, money_bonus * math.max(planets_used, 0) } }
    end
}
