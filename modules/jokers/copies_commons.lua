return {
    key = 'copies_commons',
    config = {},
    rarity = 3,
    pos = { x = 0, y = 0 },
    atlas = 'joker_atlas',
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
			if context.other_card.config.center.rarity == 1 then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			else
				return nil, true
			end
		end
	end,
}
