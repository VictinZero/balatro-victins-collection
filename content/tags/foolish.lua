return {
    key = 'foolish',
    config = { foolishness = 2 },
    atlas = 'tag_atlas',
    pos = {
        x = 0,
        y = 1
    },
    discovered = true,
    min_ante = 2,

    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true

            tag:yep('+', G.C.SECONDARY_SET.Tarot, function()
                for _ = 1, tag.config.foolishness do
                    if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
                        SMODS.add_card { key = 'c_fool', area = G.consumeables }
                    end
                end

                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
        end
    end,

    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_fool
        return { vars = { tag.config.foolishness } }
    end
}
