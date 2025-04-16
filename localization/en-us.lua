return {
	descriptions = {
		Joker = {
            -- VANILLA
            j_certificate={
                name="Certificate",
                text={
                    "When round begins,",
                    "{C:attention}get{} a {C:attention}playing card",
                    "with a {C:attention}seal",
                },
            },
            j_dna={
                name="DNA",
                text={
                    "If {C:attention}first hand{} of round",
                    "has only {C:attention}1{} card,",
                    "{C:attention}get{} a copy of it"
                },
            },
            -- MODDED
            j_vic_up_your_sleeve = {
				name = "Up Your Sleeve",
	        	text = {
		            "When {C:attention}round starts{},",
		            "{C:attention}get{} a {C:chips}Temporary {C:dark_edition}Negative",
		            "{X:black,C:white}#1#{} of {C:spades}#2#"
		        }
		    },
			j_vic_moody = {
				name = "Moody",
	        	text = {
		            "When {C:attention}Blind is selected{},",
		            "{C:attention}+#1#{} levels to a random poker hand",
		            "and {C:attention}-#2#{} level to another"
		        }
		    },
		    j_vic_growing_tree = {
				name = "Growing Tree",
	        	text = {
		            "When you {C:attention}score{} a",
		            "card with {C:clubs}Club{} suit,",
		            "it and this Joker each",
		            "{C:attention}permanently{} gains {C:chips}+#1#{} Chips",
		            "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
		        }
		    },
			j_vic_champion = {
				name = "Champion",
	        	text = {
		            "When {C:attention}Blind is selected{},",
		            "{X:red,C:white} X#1# {} {C:red,E:2}Blind size",
		            "When {C:attention}defeated{}, earn {C:money}$#2#"
		        }
		    },
		    j_vic_champions_belt = {
				name = "Champion's Belt",
	        	text = {
		            "{X:red,C:white} X#1# {} Mult",
		            "{C:inactive,s:0.33} ",
		            "Each {C:red,E:2}Boss Blind{} is a",
		            "{C:dark_edition,E:2}Showdown Boss Blind!",
		        }
		    },
            j_vic_test = {
				name = "Test",
	        	text = {
		            "Rotation Test"
		        }
		    },
            j_vic_eye_test = {
				name = "Eye Test",
	        	text = {
		            "Rotation Test"
		        }
		    },
		    j_vic_ouroboros = {
				name = "Ouroboros",
	        	text = {
	        		"{C:attention}Sell{} this Joker to",
	        		"refresh {C:blue}Hands{}, {C:red}Discards{},",
					"and the {C:attention}deck",
		        }
		    },
		    j_vic_lvl_death = {
				name = "Lvl. ? Death",
	        	text = {
		            "{X:red,C:white} X#1# {} Mult if",
		            "{C:attention}level{} of played hand is",
		            "a {C:attention}multiple of #2#"
		        }
		    },
		    j_vic_tour_guide = {
				name = "Tour Guide from the Underworld",
	        	text = {
		            "When {C:attention}Blind is selected{}, draw a {C:attention}3{}"
		        }
		    },
		    j_vic_gas_lamp = {
				name = "Gas Lamp",
	        	text = {
	        		"When round starts,",
	        		"draw {C:attention}#1# face-down cards",
		        }
		    },
		    j_vic_the_one = {
				name = "The One",
	        	text = {
		            "{X:mult,C:white} X#1# {} Mult if played",
		            "hand is {C:attention}#2#",
		            "containing a scoring",
		            "{X:black,C:white}#3#{} of {C:spades}#4#"
		        }
		    },
            j_vic_dog = {
                name = "Dog",
                text = {
                    "When you {C:attention}get{} a {C:attention}Joker{},",
                    "this Joker gains",
                    "{C:chips}+#1#{} Chips or {C:mult}+#2#{} Mult",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips",
                    "{C:inactive}and {C:mult}+#4#{C:inactive} Mult)",
                }
            },
            j_vic_hamster = {
                name = "Hamster",
                text = {
                    "After {C:attention}three{} {C:green}rerolls{},",
                    "earn {C:money}$#1#",
                    "{C:inactive}(Once per round)",
                    "{C:inactive}({C:attention}#2#{C:inactive} rerolls left)",
                }
            },
		    j_vic_paradise_parrot = {
				name = "Paradise Parrot",
	        	text = {
		            "Retrigger all",
		            "{C:vic_wild}Wild{} cards",
		        }
		    },
            j_vic_skyscraper = {
				name = "Skyscraper",
	        	text = {
		            "{C:attention}Scoring cards{} give {C:chips}+1{} Chip",
                    "per card of lower rank",
                    "in your {C:attention}full deck"
		        }
		    },
            j_vic_trapezist = {
				name = "Trapezist",
	        	text = {
		            "Played cards with",
                    "{C:attention}#1#",
                    "give {C:chips}+#2#{} Chips when scored",
                    "{C:inactive}(Swaps after each hand)"
		        }
		    },
            j_vic_wrapped_candy = {
                name = "Wrapped Candy",
                text ={
                    "When {C:attention}Blind is selected{},",
                    "gain {C:red}+#1#{} Discards",
                    "{C:inactive}({C:attention}#2#{C:inactive} Rounds left)"
                }
            },
            j_vic_slingshot = {
				name = "Slingshot",
	        	text = {
                    "Destroy your",
                    "{C:attention}leftmost{} Consumable",
                    "to grant {X:mult,C:white} X#1# {} Mult.",
                    "If it's a {C:planet}Planet{} card,",
                    "{X:red,C:white} X#2# {} Mult instead"
		        }
		    },
            j_vic_jar_of_teeth = {
				name = "Jar of Teeth",
	        	text = {
		            "Lose {C:money}$#1#{} per played card",
                    "{s:0.33} ",
                    "Earn {C:money}$#2#{} when round ends"
		        }
		    },
            j_vic_broken_arm = {
				name = "Broken Arm",
	        	text = {
		            "{C:red,E:2}Decrease level{} of",
                    "played poker hand",
		            "to earn {C:money}$#1#{}"
		        }
		    },
            j_vic_flush_spades = {
				name = "Flush Spades",
	        	text = {
		            "If played hand",
                    "contains a Flush and",
                    "a scoring {C:spades}Spades{} card,",
                    "{C:attention}get {C:tarot}The Chariot",
                    "{C:inactive}(Must have room)"
		        }
		    },
            j_vic_flush_hearts = {
				name = "Flush Hearts",
	        	text = {
		            "If played hand",
                    "contains a Flush and",
                    "a scoring {C:hearts}Hearts{} card,",
                    "{C:attention}get{} a {C:tarot}Justice",
                    "{C:inactive}(Must have room)"
		        }
		    },
            j_vic_flush_clubs = {
				name = "Flush Clubs",
	        	text = {
		            "If played hand",
                    "contains a Flush and",
                    "a scoring {C:clubs}Clubs{} card,",
                    "{C:attention}get {C:tarot}The Magician",
                    "{C:inactive}(Must have room)"
		        }
		    },
            j_vic_flush_diamonds = {
				name = "Flush Diamonds",
	        	text = {
		            "If played hand",
                    "contains a Flush and",
                    "a scoring {C:diamonds}Diamonds{} card,",
                    "{C:attention}get {C:tarot}The Devil",
                    "{C:inactive}(Must have room)"
		        }
		    },
		    j_vic_grappling_hook = {
				name = "Grappling Hook",
	        	text = {
		            "Each hand, {C:attention}keep",
		            "the {C:attention}first card played",
		        }
		    },
		    j_vic_h_size_boost = {
				name = "Hand Size Boost (Placeholder)",
	        	text = {
	        		"Before {C:attention}last hand of round{},",
		            "{C:attention}+#1#{} hand size"
		        }
		    },
		    j_vic_tower_into_space = {
				name = "Baby's Building a Tower into Space",
	        	text = {
		            "If {C:attention}played hand{} contains",
                    "a {C:vic_stone}Stone{} card,",
		            "creates its {C:planet}Planet{} card",
		            "{C:inactive}(Must have room)"
		        }
		    },
		    j_vic_stheno = {
				name = "Stheno",
	        	text = {
		            "Each {C:red,E:2}Boss Blind{} is {C:attention}the Rock",
		            "(except {C:dark_edition,E:2}Showdown Boss Blinds{})"
		        }
		    },
		    j_vic_guarantees_enhancements = {
				name = "Guarantees Enhancements (Placeholder)",
	        	text = {
		            "{C:attention}While shuffling{}, put",
		            "{C:attention}1{} card of each",
		            "{C:dark_edition}Enhancement{} type",
		            "on top of your deck"
		        }
		    },
			j_vic_royal_straight_joker = {
				name = "Royal Family",
	        	text = {
		            "Before {C:attention}last hand of round{},",
		            "draw an {C:attention}Ace-High Straight",
					"{C:inactive}(A K Q J 10)",
		        }
		    },
			j_vic_chimera = {
				name = "Chimera",
	        	text = {
		            "If played hand contains",
					"{C:attention}3 or fewer{} cards,",
		            "played cards are considered",
					"{C:attention}Face cards{} and {C:attention}all suits"
		        }
		    },
            j_vic_pippi_panini = {
				name = "Pippi Panini",
	        	text = {
		            "When {C:attention}round ends{},",
                    "{C:green}#1# in #2#{} chance to",
                    "earn {C:money}$#3#{}.",
					"Otherwise, lose {C:money}$#4#"
		        }
		    },
            j_vic_yurika_harako = {
				name = "Yurika Harako",
	        	text = {
		            "If {C:attention}first discard{} of round has",
                    "at least {C:attention}#1# ranks{} and {C:attention}#2# suits{},",
                    "give them random {C:attention}Enhancements"
		        }
		    },
            j_vic_starfish = {
                name = "Starfish",
                text = {
                    "{C:attention}+#1#{} levels to",
                    "{V:1}#2#",
                }
            },
            j_vic_goldfish = {
                name = "Goldfish",
                text = {
                    "When {C:attention}round ends{},",
                    "earn {C:money}$1{} for each",
                    "poker hand of tier",
                    "equal or lesser than",
                    "winning poker hand",
                }
            },
            j_vic_clownfish = {
                name = "Clownfish",
                text = {
                    "{C:mult}+#1#{} Mult per level of all",
                    "poker hands of lower tier",
                    "{C:inactive}(Currently {V:1}+#2#{C:inactive} Mult)",
                }
            },
            j_vic_charon = {
                name = "Charon",
                text = {
                    -- "When you {C:attention}destroy{} a playing card,",
                    -- "this Joker gains {C:money}$#1#{} of sell value",
                    -- "When you {C:attention}destroy",
                    -- "a playing card,",
                    -- "this Joker gains",
                    -- "{C:money}$#1#{} sell value",
                    "When a playing card is {C:attention}destroyed{},",
                    "this Joker gains {C:money}$#1#{} sell value",
                    "{s:0.33} ",
                    -- "This Joker gives {C:chips}+#2#{} Chips",
                    -- "for each {C:money}$1{} of its sell value",
                    "This gives {C:chips}+#2#{} Chips",
                    "per {C:money}$1{} sell value",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)",
                }
            },
            j_vic_wildheart = {
                name = "Wildheart",
                text = {
                    "Each {C:vic_wild}Wild{} card",
                    "is also a",
                    "{C:attention}#1#",
                    "{C:inactive}(Swaps each round)",
                }
            },
            j_vic_terraforming = {
				name = "Terraforming",
	        	text = {
		            "When {C:attention}round ends{},",
                    "transform your",
                    "{C:attention}leftmost{} consumable",
                    "into {C:planet}Earth",
		        }
		    },
            j_vic_red_hand = {
				name = "The Red Hand",
	        	text = {
		            "When {C:attention}Blind{} is selected,",
                    "swap {V:1}Hands{} and {V:2}Discards"
		        }
		    },
            j_vic_editor = {
				name = "Editor",
	        	text = {
		            "When you {C:attention}play a Hand{} and",
                    "you haven't discarded this round,",
                    "reroll the {C:red,E:2}Boss Blind",
					"{C:inactive}(Once per Ante)"
		        }
		    },
            j_vic_double_negative = {
                name = "Double Negative",
                text = {
                    "After {C:attention}#1# rounds{},",
                    "sell this card to create",
                    "{C:attention}2 {C:dark_edition}Negative Tags"
                }
            },
            j_vic_fortune_cookie = {
                name = "Fortune Cookie",
                text = {
                    "{X:green,C:white} X#1# {} Luck {C:inactive}(e.g., {C:green}1 in 3{C:inactive} -> {C:green}#2# in 3{C:inactive}#4#)",
                    "{s:0.33} ",
                    "When {C:attention}round ends{}, {C:green}#2# in #3#{} chance to",
                    "destroy this and create a {C:money}Golden {C:tarot}Tarot{}.",
                    "Otherwise, this gains {X:green,C:white} X#5# {} Luck",
                }
            },
            j_vic_chai_tea = {
                name = "Chai Tea",
                text = {
                    "{C:attention}Retrigger{} the Joker",
                    "to the right",
                    "{s:0.33} ",
                    "Lasts {C:attention}#1#{} round#2#!",
                }
            },
            j_vic_binary_star = {
                name = "Binary Star",
                text = {
                    "{C:planet}Planet{} cards are used",
                    "{C:attention}#1# additional time#2#",
                }
            },
            j_vic_kill_consume_multiply_joker = {
                name = "Kill Consume Multiply Joker",
                text = {
                    "When a playing card {C:red}consumes{},",
                    "{C:attention}get{} a copy of it"
                }
            },
            j_vic_joker_devouring_its_son = {
                name = "Joker Devouring Its Son",
                text = {
                    "If played hand",
                    "contains a {C:attention}Straight{},",
                    "this Joker {C:red}consumes",
                    "your {C:attention}leftmost card",
					"held in hand"
                }
            },
            j_vic_butcher_vanity = {
                name = "Butcher Vanity",
                text = {
                    "When {C:attention}round starts{},",
                    "{C:attention}get{} a {C:attention}Flesh{} card",
                }
            },
            j_vic_copies_commons = {
                name = "Copies Commons",
                text = {
                    "{C:attention}Retrigger{} all",
                    "{X:blue,C:white}Common{} Jokers",
                }
            },
			j_vic_brazilian_miku = {
				name = "Brazilian Miku",
	        	text = {
		            "{E:1}HUEHUEHUE",
		        }
		    },
            j_vic_collared = {
				name = "Collared",
                text ={
                    "Listen to Collared by Vane",
                    "(feat. SAROS)"
                }
		    },
			j_vic_nadia_om = {
				name = "Nadia Om",
	        	text = {
		            "When round starts,",
					"{C:red}destroy{} the Joker {C:attention}to the right",
					"to earn {C:money}$#1#{} and create {C:attention}#2#{} random",
		            "{C:dark_edition,E:1}Negative{C:vic_perishable} Perishable{C:vic_rental} Rental{} Jokers"
		        }
		    },
		    j_vic_mammon = {
				name = "Mammon",
	        	text = {
		            "{C:attention}Retrigger{} each played card {C:attention}#1#{} time#2#",
		            "{s:0.33} ",
		            "Next upgrade after you have {C:money}$#3#",
		        }
		    },
		    j_vic_solomon_david = {
				name = "Solomon David",
	        	text = {
		            "Carry over unused {C:blue}Hands{} and",
		            "{C:attention}lose all Discards"
		        }
		    },
		    j_vic_jagganoth = {
				name = "Jagganoth",
	        	text = {
		            "After you {C:attention}play a Hand{},",
		            "{C:attention,s:1.2}play it{} {C:red,E:2,s:1.2}again",
		            "{s:0.33} ",
		            "If you can't,",
		            "{C:red,E:2,s:1.2}DESTROY IT"
		        }
		    },
		    j_vic_syzygy = {
				name = "Syzygy",
	        	text = {
		            "If {C:attention}3{} different {C:planet}Planet{} cards",
		            "were used {C:attention}this round{},",
		            "balance {C:blue}Chips{} and {C:red}Mult"
		        }
		    },
		    j_vic_makes_black_holes = {
				name = "Makes Black Holes (Placeholder)",
	        	text = {
		            "After you {C:attention}sell",
		            "{C:attention}3{} {C:planet}Planet{} cards,",
		            "create a {C:dark_edition,E:1}Black Hole",
		            "{C:inactive}(Must have room)",
                    "{s:0.33} ",
		            "{C:attention}#1#{C:inactive} left"
		        }
		    },
			j_vic_quantum_joker = {
				name = "Quantum Joker",
	        	text = {
		            "When you sell a",
		            "{C:attention}Base Consumable{},",
		            "create a random",
		            "{C:dark_edition}Negative{} {C:attention}Consumable",
		            "of the same type",
		        }
		    },
		    j_vic_cosmic_egg = {
		    	name = "Cosmic Egg",
		        text = {
		            "When you {C:attention}sell{} a card,",
		            "this Joker gains its {C:attention}sell value",
		        }
		    },
		    j_vic_blue_dwarf = {
		        name = "Blue Dwarf",
		        text = {
		            "When you play your",
		            "{C:attention}final hand of round{},",
		            "create its {C:planet}Planet{} card",
		            "{C:inactive}(Must have room)",
		        }
		    },
            j_vic_aries = {
		        name = "Aries",
		        text = {
		            "If played hand is {C:vic_HighCard,E:1}High Card{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            j_vic_taurus = {
		        name = "Taurus",
		        text = {
		            "If played hand is {C:vic_Pair,E:1}Pair{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
		    j_vic_gemini = {
		        name = "Gemini",
		        text = {
		            "If played hand is {C:vic_TwoPair,E:1}Two Pair{},",
		            "retrigger each played card {C:attention}#1#{} time#2#",
		            "{s:0.33} ",
		            " {C:attention,s:1}+#3#{C:inactive,s:1} time per level",
		        }
		    },
		    j_vic_cancer = {
		        name = "Cancer",
		        text = {
		            "If played hand is {C:vic_3OAK,E:1}Three of a Kind{},",
		            "{C:green}#1# in #2#{} chance for {X:red,C:white} X#3# {} Mult and",
		            "{C:green}#4# in #5#{} chance for {C:money}$#6#{}",
		            "{s:0.33} ",
		            " {X:red,C:white,s:1} +X#7# {C:inactive,s:1} Mult and {C:money,s:1}+$#8#{C:inactive,s:1} per level",
		        }
		    },
            j_vic_leo = {
		        name = "Leo",
		        text = {
		            "If played hand is {C:vic_Straight,E:1}Straight{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            j_vic_virgo = {
		        name = "Virgo",
		        text = {
		            "If played hand is {C:vic_Flush,E:1}Flush{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            j_vic_libra = {
		        name = "Libra",
		        text = {
		            "If played hand is {C:vic_FullHouse,E:1}Full House{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            j_vic_scorpio = {
		        name = "Scorpio",
		        text = {
		            "If played hand is {C:vic_4OAK,E:1}Four of a Kind{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            j_vic_sagittarius = {
		        name = "Sagittarius",
		        text = {
		            "If played hand is {C:vic_StraightFlush,E:1}Straight Flush{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            j_vic_capricorn = {
		        name = "Capricorn",
		        text = {
		            "If played hand is {C:vic_5OAK,E:1}Five of a Kind{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            j_vic_aquarius = {
		        name = "Aquarius",
		        text = {
		            "If played hand is {C:vic_FlushHouse,E:1}Flush House{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            j_vic_pisces = {
		        name = "Pisces",
		        text = {
		            "If played hand is {C:vic_5OAFlush,E:1}Five of a Flush{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
		    j_vic_bone = {
		        name = "Bone Card",
		        text = {
		            "When you discard {C:attention}1{} card,",
		            "{C:attention}destroy it{} and give its {C:blue}Chips",
		            "to cards {C:attention}in your hand",
		        }
		    },
		},
        Edition = {
            e_vic_golden = {
                name = "Golden Edition",
                text = {
                    "How pretty!"
                }
            },
            e_vic_shiny = {
                name = "Shiny Edition",
                text = {
                    "How #1# shiny!"
                }
            },
        },
		Enhanced = {
			m_vic_blood = {
				name = "Blood Card",
				text = {
					"When {c:attention}a Boss Blind is defeated{},",
					"this card gains {X:red,C:white} +X#1# {} Mult"
				}
			},
            m_vic_flesh = {
				name = "Flesh Card",
				text = {
                    "When held in hand",
                    "at the end of round,",
					"{C:red}consume{} the card",
					"to the left"
				}
			},
            m_vic_burning = {
                name = "Burning",
                text = {
                    "When played,",
                    "{C:red}discard{} #1# random card",
                }
            },
            m_vic_paralyzed = {
                name = "Paralyzed",
                text = {
                    "Debuffed each round",
                    "until #1# hand is played",
                }
            },
            m_vic_confused = {
                name = "Confused",
                text = {
                    "When drawn,",
                    "randomize suit and rank",
                }
            }
		},
		Blind = {
			bl_vic_worm = {
				name = "The Worm",
				text = {
					"Base Chips are equal",
					"to X5 Poker Hand's level"
				}
			},
			bl_vic_rock = {
				name = "The Rock",
				text = {
					"Add 7 {C:vic_stone}Stone{} cards",
					"to your deck"
				}
			},
			bl_vic_bell = {
				name = "The Bell",
				text = {
					"Forces 1 Face card to",
					"always be selected"
				}
			},
			bl_vic_spin = {
				name = "The Spin",
				text = {
					"First hand is",
					"discarded face down"
				}
			},
			bl_vic_loop = {
				name = "The Loop",
				text = {
					"When defeated once,",
					"play it again",
					"(no refreshes)"
				}
			},
            bl_vic_bottle = {
				name = "The Bottle",
				text = {
					"Double hand size,",
					"but discard the deck",
					"after first hand drawn"
				}
			},
			bl_vic_chaos = {
				name = "The Chaos",
				text = {
					"Cards are debuffed until",
					"played hand contains",
					"Flush or Straight"
				}
			},
			bl_vic_eclipse = {
				name = "The Eclipse",
				text = {
					"All Hearts and Clubs cards ",
					"are drawn face down"
				}
			},
            bl_vic_trash = {
				name = "The Trash",
				text = {
					"Discard a copy of",
                    "your first discard",
				}
			},
            bl_vic_wind = {
				name = "The Wind",
				text = {
					"After play or discard,",
                    "-1 to the other",
				}
			},
			bl_vic_dagger = {
				name = "The Dagger",
				text = {
					"Destroy your",
					"winning hand",
				}
			},
			bl_vic_final_gold = {
				name = "Black Gold",
				text = {
					"Base Chips can't be greater",
					"than 50% of money"--"$#1#"
				}
			},
			bl_vic_final_prion = {
				name = "Purpura Prion",
				text = {
					"Base Chips are equal to",
					"X5 Poker Hand's level",
					"Base Mult is equal to",
					"Poker Hand's level",
				}
			},
			bl_vic_final_loop = {
				name = "Lavender Loop",
				text = {
					"When defeated,",
					"play the Loop",
					"(no refreshes)"
				}
			},
            bl_vic_final_debuff = {
				name = "Test Debuff",
				text = {
					"Debuffs Jokers",
					"except the",
                    "4 leftmost",
				}
			},
			bl_vic_final_patriarch = {
				name = "Tyrian Patriarch",
				text = {
					"Defeat two Bosses",
					"before playing this",
					"(1 refresh)"
				}
			},
            bl_vic_final_dragon = {
				name = "Golden Dragon",
				text = {
                    --"When selected,",
					"+#1# Blind size",
					"per $1 of",
                    "total sell value",
					"above $10"
				}
			},
            bl_vic_final_king = {
				name = "Red King",
				text = {
					"After you play a hand,",
					"play it again"
				}
			},
		},
		Other = {
			-- Credits
            cr_vic_ouroboros = {
				name = "cr_vic_credits",
				text = {
					"{C:white}Original background by {E:1,C:white,S:1.1}itsmythie",
				}
			},
			cr_vic_the_one = {
				name = "cr_vic_credits",
				text = {
					"{C:white}Original concept by {E:1,C:white,S:1.1}EggSlashEther",
				}
			},
			cr_vic_champions_belt = {
				name = "cr_vic_credits",
				text = {
					"{C:white}Original art by {E:1,C:white,S:1.1}B",
					"{C:white}Joker text art by {E:1,C:white,S:1.1}Victin",
				}
			},
            cr_vic_red_hand = {
				name = "cr_vic_credits",
				text = {
					"{C:white}Background art by {E:1,C:white,S:1.1}Victin",
					"{C:white}Hand art by {E:1,C:white,S:1.1}Gappie",
				}
			},
			cr_vic_quantum_joker = {
				name = "cr_vic_credits",
				text = {
					"{C:white}Original art and concept by {E:1,C:white,S:1.1}Gaziter",
				}
			},
			aux_vic_stheno = {
				name = "aux_vic_stheno",
				text = {
					"test",
				}
			},
			-- Other
            vic_consume = {
                name = "Consume",
                text = {
                    "{C:red,E:2}Destroy{} a card",
                    "to {C:attention}gain its stats"
                }
            },
			vic_perishable = {
				name = "Perishable",
				text = {
					"Debuffed after",
					"{C:attention}#1#{} rounds",
				},
			},
			vic_temporary = {
				name = "Temporary",
				text = {
					"When {C:attention}round ends{},",
					"{C:red,E:2}destroy{} this card",
				}
			}
		},
        Tag = {
            tag_vic_rebate_tag = {
                name = "Rebate Tag",
                text = {
                    -- "When you {C:attention}buy{} a {C:dark_edition}Consumable{},",
                    -- "{C:attention}get a copy{}",
                    "Gives a copy of the",
                    "next {C:dark_edition}Consumable{} you buy",
                    "{C:inactive}(Must have room)",
                }
            },
            tag_vic_liquidation_tag = {
                name = "Liquidation Tag",
                text = {
                    "{C:attention}Next shop{}, whenever you",
                    "{C:attention}buy{} a Joker, Consumable, or",
                    "playing card, {C:attention}get{} another one",
                    "{C:inactive}(Must have room)",
                }
            },
		},
        Zodiac = {
            c_vic_aries = {
		        name = "Aries",
		        text = {
		            "If played hand is {C:vic_HighCard,E:1}High Card{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            c_vic_taurus = {
		        name = "Taurus",
		        text = {
		            "If played hand is {C:vic_Pair,E:1}Pair{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
			c_vic_gemini = {
				name = "Gemini",
				text = {
                    "If played hand is {C:vic_TwoPair,E:1}Two Pair{},",
					"retrigger each scoring card {C:attention}#1#{} time#2#",
		            "{s:0.33} ",
		            " {C:attention,s:1}+#3#{C:inactive,s:1} time per level",
				}
			},
            c_vic_cancer = {
				name = "Cancer",
				text = {
                    "If played hand is {C:vic_3OAK,E:1}Three of a Kind{},",
					"{C:green}#1# in #2#{} chance for {X:red,C:white} X#3# {} Mult and",
		            "{C:green}#4# in #5#{} chance for {C:money}$#6#{}",
		            "{s:0.33} ",
		            " {X:red,C:white,s:1} +X#7# {C:inactive,s:1} Mult and {C:money,s:1}+$#8#{C:inactive,s:1} per level",
				}
			},
            c_vic_leo = {
		        name = "Leo",
		        text = {
		            "If played hand is {C:vic_Straight,E:1}Straight{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            c_vic_virgo = {
		        name = "Virgo",
		        text = {
		            "If played hand is {C:vic_Flush,E:1}Flush{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            c_vic_libra = {
		        name = "Libra",
		        text = {
		            "If played hand is {C:vic_FullHouse,E:1}Full House{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            c_vic_scorpio = {
		        name = "Scorpio",
		        text = {
		            "If played hand is {C:vic_4OAK,E:1}Four of a Kind{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            c_vic_sagittarius = {
		        name = "Sagittarius",
		        text = {
		            "If played hand is {C:vic_StraightFlush,E:1}Straight Flush{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            c_vic_capricorn = {
		        name = "Capricorn",
		        text = {
		            "If played hand is {C:vic_5OAK,E:1}Five of a Kind{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            c_vic_aquarius = {
		        name = "Aquarius",
		        text = {
		            "If played hand is {C:vic_FlushHouse,E:1}Flush House{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            c_vic_pisces = {
		        name = "Pisces",
		        text = {
		            "If played hand is {C:vic_5OAFlush,E:1}Five of a Flush{},",
		            "{C:inactive}DO NOTHING",
		            "{s:0.33} ",
		            " {C:inactive,s:1}+NOTHING{C:inactive,s:1} time per level",
		        }
		    },
            c_vic_ophiucus = {
				name = "Ophiucus",
				text = {
					"Level up all Zodiacs",
				}
			},
		},
		Token = {
			c_vic_short_rest = {
				name = "Short Rest",
				text = {
					"Refreshes {C:blue}Hands{},",
					"{C:red}Discards{},",
					"and the {C:attention}deck"
				}
			}
		}
	},
	misc = {
		dictionary = {
			k_vic_credits = "Credits",
            k_vic_eureka = "Eureka!",
			k_vic_inactive = "inactive",
			k_vic_magnificent = "Magnificent!",
			k_vic_quantum = "Quantum!",
			k_vic_zodiac = "Zodiac",
            k_vic_auxiliary = "Auxiliary",
            k_vic_hold_key_info_1 = "(Hold ",
            k_vic_hold_key_info_2 = " for more info)",
            k_zodiac = "Zodiac",
			k_token = "Token",
            b_zodiac_cards = "Zodiacs",
			b_token_cards = "Tokens",
		},
		labels = {
            k_vic_auxiliary = "Auxiliary",
            zodiac = "Zodiac",
			token = "Token",
			vic_temporary = "Temporary",
		},
		quips = {
			vic_solomon_title_1 = {
				"{C:vic_purple,s:1.35}SOLOMON DAVID",
				"{C:white,s:0.9}GOD-EMPEROR OF THE",
				"{C:white,s:0.9}CELESTIAL EMPIRE AND GRAND",
				"{C:white,s:0.9}MASTER OF KI RATA.",
				"{s:0.33} ",
				"{C:white,s:0.9}BEARER OF THE WORD {C:vic_purple,s:0.9}DIAMOND{C:white,s:0.9}",
				"{C:white,s:0.9}AND GOD OF",
				"{C:white,s:0.9}THE SEVEN-PART WORLD."
			},
			vic_jagganoth_title_1 = {
				"{C:white,s:1.35}CHAKRAVARTIN {C:red,s:1.35}JAGGANOTH",
				"{C:white,s:0.9}WHEEL TURNING KING,",
				"{C:white,s:0.9}RED EYED HEIR,",
				"{C:white,s:0.9}PANKRATOR, THE GOD EATER,",
				"{C:white,s:0.9}BEARER OF THE WORD {C:red,s:0.9}BLADE{C:white,s:0.9},",
				"{C:white,s:0.9}AND DESTROYER OF",
				"{C:white,s:0.9}THE SEVEN-PART WORLD."
			},
			vic_jagganoth_law_1 = {
				"{C:red}THE LAW OF KINGS…",
				"{C:red}IS THE LAW OF THE SWORD!"
			},
			vic_jagganoth_law_2 = {
				"{C:red}THE LORD OF THE WORLD",
				"{C:red}CANNOT RULE!",
			},
			vic_jagganoth_law_3 = {
				"{C:red}HE CANNOT GRASP ANYTHING",
				"{C:red}BUT A HILT!"
			},
			vic_jagganoth_law_4 = {
				"{C:red}HE MUST SUBSUME AND",
				"{C:red}BECOME VIOLENCE ITSELF!",
			},
			vic_jagganoth_law_5 = {
				"{C:red}ALL ELSE IS",
				"{C:red}FRIVOLITY!"
			},
			vic_jagganoth_goal_1 = {
				"{C:red}TO CRUSH THE SCRIBE OF GOD INTO A PULP",
				"{C:red}AND SUCK THE MARROW FROM HIS BONES."
			},
			vic_jagganoth_goal_2 = {
				"{C:red}ONLY THEN I WILL BE ABLE",
				"{C:red}TO FINALLY BURN AWAY",
				"{C:red}THIS MIDDEN HEAP",
				"{C:red}PERMANENTLY."
			},
			vic_jagganoth_goal_3 = {
				"{C:red}ONCE THERE IS NO TRACE OF CORRUPTION",
				"{C:red}I WILL CORRECT GOD'S WORK."
			},
			vic_jagganoth_goal_4 = {
				"{C:red}I WILL REFORGE THE WHEEL",
				"{C:red}FREE OF PAIN, FEAR,",
				"{C:red}AND SUFFERING."
			},
			vic_jagganoth_goal_5 = {
				"{C:red}THEN I WILL ERASE MYSELF,",
				"{C:red}AND THE WORLD WILL FINALLY",
				"{C:red}BE {C:red,s:1.4,E:1}FREE{C:red}."
			},
			vic_jagganoth_belief_1 = {
				"{C:red}IT IS NOT A MATTER OF BELIEF."
			},
			vic_jagganoth_belief_2 = {
				"{C:red}AS ALL SLAVES OF ALL BROKEN SYSTEMS—"
			},
			vic_jagganoth_belief_3 = {
				"{C:red}YOUR MIND IS AS SHACKLED",
				"{C:red}AS YOUR EXISTENCE—",
			},
			vic_jagganoth_belief_4 = {
				"{C:red}UNABLE TO CONCEIVE OF A WORLD",
				"{C:red}BEYOND THE BOUNDARIES OF",
				"{C:red}YOUR PRISON."
			},
			vic_jagganoth_belief_5 = {
				"{C:red,s:1.4,E:1}TIME",
				"{C:red,s:1.4,E:1}ITSELF."
			},
			vic_jagganoth_poem_1 = {
				"{C:red}O TIGER, O LORD OF BEASTS, RAGE!",
				"{C:red}STRAIN EVERY SINEW TILL THE MARROW SHAKES—",
			},
			vic_jagganoth_poem_2 = {
				"{C:red}BEND THY BROW TOWARDS THE HORIZON",
				"{C:red}AND CRY VICTORY!"
			},
			vic_jagganoth_poem_3 = {
				"{C:red}O PITEOUS LORD, E'EN",
				"{C:red}AGAINST THY MOLTEN COMMAND—",
				"{C:red}—STILL!—",
			},
			vic_jagganoth_poem_4 = {
				"{C:red}THE LAST LIGHT'S SLIVER SHALL FALL,",
				"{C:red}TILL DARKNESS QUENCHETH THY FEEBLE CRIES—",
				"{C:red}AND ALL IS SMOTHERED."
			},
			vic_jagganoth_sword_1 = {
				"{C:white,s:0.9}SUPREME DIVINE ART",
				"{C:red,s:1.4}BLOOD-SATED",
				"{C:red,s:1.4}SWORD SOUL"
			},
			vic_jagganoth_sword_2 = {
				"{C:white}80,000 BLOWS ARE",
				"{C:white}STRUCK AT ONCE."
			},
			vic_jagganoth_sword_3 = {
				"{C:white}LEAVING NO SPACE",
				"{C:white}THAT IS NOT A SWORD."
			},
			vic_jagganoth_sword_4 = {
				"{C:white}MEN AND HORSES",
				"{C:white}WILL BE SPLIT IN TWO."
			},
			vic_jagganoth_sword_5 = {
				"{C:white}AND THE LAND WILL",
				"{C:white}BE PUT TO WASTE."
			},
			vic_jagganoth_sword_6 = {
				"{C:white}SINCE THERE IS",
				"{C:white}NOWHERE TO EVADE—"
			},
			vic_jagganoth_sword_7 = {
				"{C:white}BE THEY MAN",
				"{C:white}OR IMMORTAL—"
			},
			vic_jagganoth_sword_8 = {
				"{C:white}ALL WILL BE CUT—",
				"{C:white}AND BE SLAIN INSTANTLY."
			},
		}
	},
}
