return {
    key = 'litter',
    config = { n_discards = 3 },
    atlas = 'tag_atlas',
    pos = {
        x = 3,
        y = 0
    },
    discovered = true,

    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' then
            tag:yep('+', G.C.RED, function()
                return true
            end)
            ease_discard(tag.config.n_discards)
            tag.triggered = true
            return true
        end
    end,

    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.n_discards } }
    end
}
