local alert_debuff_ref = Blind.alert_debuff

function Blind.alert_debuff(self, first)
	sendDebugMessage("Trying to alert debuff")
	if G.GAME.blind and G.GAME.blind.vic_patriarch_blinds and #G.GAME.blind.vic_patriarch_blinds == 0 then return end
	alert_debuff_ref(self, first)
end
