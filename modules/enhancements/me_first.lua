return {
    key = 'me_first',
    atlas = 'enhancement_atlas',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            disenhancement = true
        }
    },
    weight = 0.,

    draw = function(self, card, layer)
        G.VictinsCollection.shared_sprites.me_first_extra.role.draw_major = card
        G.VictinsCollection.shared_sprites.me_first_extra:draw_shader('dissolve', nil, nil, nil, card.children.center,
            nil, nil, (G.CARD_W / 3.) --[[+ (0.5 * 21. * G.CARD_W / 71.)]] , (9. * G.CARD_H / 12.) --[[+ (22. * G.CARD_H / 95.)]] )
    end
}
