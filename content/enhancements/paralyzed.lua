return {
    key = 'paralyzed',
    atlas = 'enhancement_atlas',
    pos = { x = 0, y = 0 },
    config = { extra = { hands_required = 1 }},

    calculate = function(self, card, context, effect)
        if context.debuff_card then sendDebugMessage("Current hands: "..tostring(G.GAME.current_round.hands_played)) end
        if context.debuff_card and context.debuff_card == card then
            if G.GAME.current_round.hands_played <= card.ability.extra.hands_required then
                return {debuff = true}
            --[[else
                return {debuff = false}]]
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands_required } }
    end
}
