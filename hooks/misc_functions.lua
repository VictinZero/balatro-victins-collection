local loc_colour_ref = loc_colour

function loc_colour(_c, default)
	if not G.ARGS.LOC_COLOURS then
		loc_colour_ref(_c, default)
	elseif not G.ARGS.LOC_COLOURS.vic_colours then
		G.ARGS.LOC_COLOURS.vic_colours = true

		local new_colors = {
			vic_HighCard = G.C.VictinsCollection.POKER_HANDS['High Card'],
			vic_Pair = G.C.VictinsCollection.POKER_HANDS['Pair'],
			vic_TwoPair = G.C.VictinsCollection.POKER_HANDS['Two Pair'],
			vic_3OAK = G.C.VictinsCollection.POKER_HANDS['Three of a Kind'],
			vic_Straight = G.C.VictinsCollection.POKER_HANDS['Straight'],
			vic_Flush = G.C.VictinsCollection.POKER_HANDS['Flush'],
			vic_FullHouse = G.C.VictinsCollection.POKER_HANDS['Full House'],
			vic_4OAK = G.C.VictinsCollection.POKER_HANDS['Four of a Kind'],
			vic_StraightFlush = G.C.VictinsCollection.POKER_HANDS['Straight Flush'],
			vic_5OAK = G.C.VictinsCollection.POKER_HANDS['Five of a Kind'],
			vic_FlushHouse = G.C.VictinsCollection.POKER_HANDS['Flush House'],
			vic_5OAFlush = G.C.VictinsCollection.POKER_HANDS['Five of a Flush'],

			vic_stone = G.C.VictinsCollection.ENHANCEMENTS.Stone,
		}

		for k, v in pairs(new_colors) do
			G.ARGS.LOC_COLOURS[k] = v
		end
	end

	return loc_colour_ref(_c, default)
end
