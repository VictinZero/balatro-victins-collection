return {
    key = 'rebate',
    config = {n_copies = 2},
    atlas = 'tag_atlas',
    pos = {
        x = 1,
        y = 0
    },
    discovered = true,
    --min_ante = 6,

    apply = function(self, tag, context)
        if context.type == 'vic_using_consumeable' then
            local n_copies = tag.config.n_copies
            tag:yep('+', G.C.DARK_EDITION, function()
                for _ = 1, n_copies do
                    local card_ = copy_card(context.card)
                    card_:set_edition({ negative = true }, true)
                    SMODS.Stickers.vic_temporary:apply(card_, true)

                    card_:start_materialize()
                    card_:add_to_deck()
                    G.consumeables:emplace(card_)
                end

                return true
            end)
            tag.triggered = true
        end

        --[[if context.type == 'vic_buying_card' then
            local area = context.card.area
            if area == G.consumeables then
                tag:yep('+', G.C.FILTER, function()
                    if (#area.cards + G.GAME.consumeable_buffer < area.config.card_limit) or
                        (context.card.edition and context.card.edition.negative) then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer +
                                                        ((context.card.edition and context.card.edition.negative and 0) or
                                                            1)

                        local card_ = copy_card(context.card)
                        card_:start_materialize()
                        card_:add_to_deck()
                        G.consumeables:emplace(card_)

                        G.E_MANAGER:add_event(Event({
                            trigger = 'immediate',
                            delay = 0.0,
                            func = (function()
                                G.GAME.consumeable_buffer = 0
                                return true
                            end)
                        }))
                    end
                    return true
                end)

                tag.triggered = true
            end
        end]]
    end,

    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = {
            set = 'Other',
            key = 'vic_temporary'
        }
        info_queue[#info_queue + 1] = {
            set = 'Edition',
            key = 'e_negative_consumable',
            config = {
                extra = G.P_CENTERS['e_negative'].config.card_limit
            }
        }

        return { vars = { tag.config.n_copies } }
    end
}
