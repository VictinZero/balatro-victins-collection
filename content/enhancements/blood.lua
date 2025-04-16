return {
    key = 'blood',
    atlas = 'enhancement_atlas',
    pos = { x = 0, y = 0 },
    config = { x_mult = 1, extra = { x_mult_mod = 1 }},

    calculate = function(self, card, context, effect)
        if context.end_of_round and G.GAME.blind.boss then
            card.ability.x_mult = card.ability.x_mult + card.ability.extra.x_mult_mod
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = { self.config.extra.x_mult_mod, self.config.x_mult }
        }
    end
}
