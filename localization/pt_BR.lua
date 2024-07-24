return {
	descriptions = {
		Joker = {
		    j_vic_champion = {
				name = "Campeão",
	        	text ={
		            "Quando {C:attention}o Blind é selecionado{},",
		            "{X:red,C:white} X#1# {} {C:red,E:2}tamanho do Blind",
		            "Quando {C:attention}derrotado{}, ganhe {C:money}$#2#"
		        }
		    },
		    j_vic_champions_belt = {
				name = "Cinto do Campeão",
	        	text ={
		            "{X:red,C:white} X#1# {} Multi",
		            "{C:red,E:2}Chefes são mais difíceis!",
		        }
		    },
		    j_vic_lvl_death = {
				name = "Morte Nv. ?",
	        	text ={
		            "{X:red,C:white} X#1# {} Multi se",
		            "o {C:attention}nível{} da mão jogada",
		            "for um {C:attention}múltiplo de #2#"
		        }
		    },
		    j_vic_the_one = {
				name = "O Único",
	        	text ={
		            "{X:mult,C:white} X#1# {} Multi se",
		            "a mão jogada é {C:attention}#2#",
		            "contendo um",
		            "{X:black,C:white}#3#{} de {C:spades}#4#{} pontuado"
		        }
		    },
		    j_vic_syzygy = {
				name = "Sizígia",
	        	text = {
	        		"Se {C:attention}3{} cartas de {C:planet}Planeta{} diferentes",
	        		"foram utilizadas nesta rodada,",
	        		"equilibre {C:blue}Fichas{} e {C:red}Multi"
		        }
		    },
		    j_vic_quantum_joker = {
				name = "Curinga Quântico",
	        	text = {
		            "Quando você vender um",
		            "{C:attention}Consumível Básico{},",
		            "crie um",
		            "{C:attention}Consumível{} {C:dark_edition}Negativo",
		            "aleatório do mesmo tipo",
		        }
		    },
		    j_vic_cosmic_egg = {
		    	name = "Ovo Cósmico",
		        text = {
		            "Quando você {C:attention}vender{} uma carta,",
		            "este Curinga ganha o seu {C:attention}valor de venda",
		        }
		    },
		    j_vic_blue_dwarf = {
		        name = "Anã Azul",
		        text = {
		            "Quando você jogar a",
		            "{C:attention}mão final da rodada{},",
		            "crie sua carta de {C:planet}Planeta",
		            "{C:inactive}(Deve ter espaço)",
		        }
		    },
		},
		Blind = {
			bl_vic_worm = {
				name = "A Minhoca",
				text = {
					"As Fichas base são iguais",
					"a X5 o nível da mão de pôquer"
				}
			},
			bl_vic_rock = {
				name = "A Pedra",
				text = {
					--[["Adicione 7 cartas de Pedra",
					"ao baralho"]]
					"No meio do caminho tinha uma pedra",
					"tinha uma pedra no meio do caminho",
					"tinha uma pedra",
					"no meio do caminho tinha uma pedra.",
					"",
					"Nunca me esquecerei desse acontecimento",
					"na vida de minhas retinas tão fatigadas.",
					"Nunca me esquecerei que no meio do caminho",
					"tinha uma pedra",
					"tinha uma pedra no meio do caminho",
					"no meio do caminho tinha uma pedra."
				}
			},
		},
		Other = {
			cr_vic_the_one = {
				name = "cr_vic_credits",
				text = {
					"{C:white}Conceito original por{} {E:1,C:white,S:1.1}EggSlashEther",
				}
			},
			cr_vic_quantum_joker = {
				name = "cr_vic_credits",
				text = {
					"{C:white}Conceito e arte originais por{} {E:1,C:white,S:1.1}Gaziter",
				}
			},
		},
	},
	misc = {
		dictionary = {
			k_vic_credits = "Créditos",
			k_vic_inactive = "inativo",
			k_vic_quantum = "Quântico!",
		}
	}
}
