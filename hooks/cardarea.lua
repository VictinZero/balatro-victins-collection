local shuffle_ref = CardArea.shuffle

function CardArea:shuffle(_seed)
    shuffle_ref(self, _seed)

    if false then
        local idx = #self.cards
        local seen = {}
        for j = #self.cards, 1, -1 do
            local card_j = self.cards[j]
            if card_j.ability.set == 'Enhanced' and not seen[card_j.ability.name] and j ~= idx then
                seen[card_j.ability.name] = true
                self.cards[idx], self.cards[j] = self.cards[j], self.cards[idx]
                idx = idx - 1
            end
        end
        self:set_ranks()
    end
end
