
function G_1(L_1_arg1, L_2_arg2)
	if (L_1_arg1 == L_2_arg2 and true) then
		return true
	else
		return false
	end
end
function G_2(L_3_arg1, L_4_arg2)
	if L_3_arg1 == 0 and L_4_arg2 == 0 then
		return 100
	else
		return L_3_arg1 * 10 + L_4_arg2
	end
end
G_3 = true
G_4 = 1
G_5 = 97
G_6 = true
G_7 = true
function G_8(L_5_arg1, L_6_arg2)
	if (L_5_arg1 <= L_6_arg2 or (G_3 and L_5_arg1 <= G_4)) and not (G_3 and L_5_arg1 >= G_5) then
		return true
	else
		return false
	end
end
function G_9(L_7_arg1, L_8_arg2)
	if L_7_arg1 >= L_8_arg2 or L_7_arg1 >= G_5 then
		return true
	else
		return false
	end
end
function G_10(L_9_arg1, L_10_arg2, L_11_arg3)
	if (G_6 and G_1(L_10_arg2, L_11_arg3)) or ((L_9_arg1 ~= "corps-a-corps" or L_9_arg1 ~= "distance") and G_3 and
       (G_2(L_10_arg2, L_11_arg3) <= G_4 or G_2(L_10_arg2, L_11_arg3) >= G_5)) then
		return true
	else
		return false
	end
end
function G_11(L_12_arg1)
	L_12_arg1 = tostring(L_12_arg1) or "I"
	if L_12_arg1 == "TF" then
		return 60
	elseif L_12_arg1 == "F" then
		return 40
	elseif L_12_arg1 == "A" then
		return 20
	elseif L_12_arg1 == "I" then
		return 0
	elseif L_12_arg1 == "C" then
		return -10
	elseif L_12_arg1 == "D" then
		return -20
	elseif L_12_arg1 == "TD" then
		return -30
	end
end
function G_12(L_13_arg1)
	L_13_arg1 = string.lower(L_13_arg1)
	if L_13_arg1 == "tf" or L_13_arg1 == "tresfacile" then
		return "TF"
	elseif L_13_arg1 == "f" or L_13_arg1 == "facile" then
		return "F"
	elseif L_13_arg1 == "a" or L_13_arg1 == "accessible" then
		return "A"
	elseif L_13_arg1 == "i" or L_13_arg1 == "intermediaire" or L_13_arg1 == "intermédiaire" then
		return "I"
	elseif L_13_arg1 == "c" or L_13_arg1 == "complexe" then
		return "C"
	elseif L_13_arg1 == "d" or L_13_arg1 == "difficile" then
		return "D"
	elseif L_13_arg1 == "td" or L_13_arg1 == "tresdifficile" then
		return "TD"
	end
end
function G_13(L_14_arg1)
	L_14_arg1 = string.lower(L_14_arg1)
	if L_14_arg1 == "tf" or L_14_arg1 == "tresfacile" then
		return "Très Facile"
	elseif L_14_arg1 == "f" or L_14_arg1 == "facile" then
		return "Facile"
	elseif L_14_arg1 == "a" or L_14_arg1 == "accessible" then
		return "Accessible"
	elseif L_14_arg1 == "i" or L_14_arg1 == "intermediaire" or L_14_arg1 == "intermédiaire" then
		return "Intermédiaire"
	elseif L_14_arg1 == "c" or L_14_arg1 == "complexe" then
		return "Complexe"
	elseif L_14_arg1 == "d" or L_14_arg1 == "difficile" then
		return "Difficile"
	elseif L_14_arg1 == "td" or L_14_arg1 == "tresdifficile" then
		return "Très Difficile"
	end
end
function G_14(L_15_arg1)
	L_15_arg1 = string.lower(L_15_arg1)
	if L_15_arg1 == "tf" or L_15_arg1 == "tresfacile" then
		return "+60"
	elseif L_15_arg1 == "f" or L_15_arg1 == "facile" then
		return "+40"
	elseif L_15_arg1 == "a" or L_15_arg1 == "accessible" then
		return "+20"
	elseif L_15_arg1 == "i" or L_15_arg1 == "intermediaire" or L_15_arg1 == "intermédiaire" then
		return "0"
	elseif L_15_arg1 == "c" or L_15_arg1 == "complexe" then
		return "-10"
	elseif L_15_arg1 == "d" or L_15_arg1 == "difficile" then
		return "-20"
	elseif L_15_arg1 == "td" or L_15_arg1 == "tresdifficile" then
		return "-30"
	end
end
function G_15(L_16_arg1)
	L_16_arg1 = tonumber(L_16_arg1)
	if L_16_arg1 <= 0 then
		return "+0"
	elseif L_16_arg1 > 0 then
		return "+"..L_16_arg1 * 10
	end
end
function G_16(L_17_arg1, L_18_arg2)
	local L_19_ = L_17_arg1 + L_18_arg2
	if (L_19_ < 1 and true) then
		L_19_ = 1
	end
	return L_19_
end
function G_17(L_20_arg1, L_21_arg2)
	local L_22_ = (L_21_arg2 - L_20_arg1) / 10
	local L_23_ = 0
	if (L_22_ > 0 and true) then
		L_23_ = math.floor(L_22_)
	elseif (L_22_ < 0 and true) then
		L_23_ = math.ceil(L_22_)
	end
	L_23_ = L_23_ + G_18(L_21_arg2)
	return L_23_
end
function G_18(L_24_arg1)
	local L_25_ = 0
	if G_7 then
		if (L_24_arg1 > 100 and true) then
			L_25_ = math.floor((L_24_arg1 - 100) / 10)
		end
	else
		L_25_ = 0
	end
	return L_25_
end
function G_19(L_26_arg1)
	if (L_26_arg1 >= 1 and L_26_arg1 <= 9) then
		return "Tête"
	elseif (L_26_arg1 >= 10 and L_26_arg1 <= 24) then
		return "Bras secondaire"
	elseif (L_26_arg1 >= 25 and L_26_arg1 <= 44) then
		return "Bras principal"
	elseif (L_26_arg1 >= 45 and L_26_arg1 <= 79) then
		return "Corps"
	elseif (L_26_arg1 >= 80 and L_26_arg1 <= 89) then
		return "Jambe gauche"
	elseif (L_26_arg1 >= 90 and L_26_arg1 <= 100) then
		return "Jambe droite"
	end
end
function G_20(L_27_arg1)
	local L_28_ = ""
	if L_27_arg1 == "Tête" then
		L_28_ = "à la Tête"
	elseif L_27_arg1 == "Bras secondaire" then
		L_28_ = "au niveau du Bras gauche (ou du bras secondaire)"
	elseif L_27_arg1 == "Bras principal" then
		L_28_ = "au niveau du Bras droit (ou du bras principal)"
	elseif L_27_arg1 == "Corps" then
		L_28_ = "au niveau du Corps"
	elseif L_27_arg1 == "Jambe gauche" then
		L_28_ = "au niveau de la Jambe gauche"
	elseif L_27_arg1 == "Jambe droite" then
		L_28_ = "au niveau de la Jambe droite"
	end
	return L_28_
end
function G_21(L_29_arg1)
	if L_29_arg1 >= 1 and L_29_arg1 <= 20 then
		return "%s se blesse tout seul en attaquant, et perd un Point de Blessure sans tenir compte du Bonus d'Endurance ou des Points d'Armure."
	elseif L_29_arg1 >= 21 and L_29_arg1 <= 40 then
		return "L'arme de Corps-à-Corps de %s s'ébrèche salement, ou l'arme de tir à distance ne fonctionne pas ou se trouve sur le point de se briser. L'arme subit 1 point de Dégâts. Au prochain Round, %s agira en dernier sans tenir compte de l'ordre d'initiative, des talents ni de toute règle spéciale pendant que le porteur gère la situation."
	elseif L_29_arg1 >= 41 and L_29_arg1 <= 60 then
		return "%s a mal négocié sa manoeuvre, ce qui le met en mauvaise posture. Au cours du prochain round, votre action subira une pénalité de -10."
	elseif L_29_arg1 >= 61 and L_29_arg1 <= 70 then
		return "%s trébuche franchement et peine à se redresser, il perd son prochain Mouvement."
	elseif L_29_arg1 >= 71 and L_29_arg1 <= 80 then
		return "%s ne tient pas son arme correctement ou laisse tomber ses munitions, il perd sa prochaine Action."
	elseif L_29_arg1 >= 81 and L_29_arg1 <= 90 then
		return "%s effectue un mouvement trop ample ou trébuche et se tord la cheville, subissant un traumatisme [i]Déchirure musculaire (Mineure)[/i] comptant comme une Blessure critique."
	elseif L_29_arg1 >= 91 and L_29_arg1 <= 100 then
		return "%s manque complètement son attaque et touche un allié au hasard à distance en utilisant le chiffre des unités du lancer de dés pour déterminer le DR. Si personne n'est à distance, il se blesse tout seul et obtient l'État [i]Sonné[/i]."
	end
end
function G_22(L_30_arg1)
	local L_31_ = G_23.roll.dice(2, 0, 9)
	local L_32_ = L_31_[1]
	local L_33_ = L_31_[2]
	local L_34_ = G_2(L_32_, L_33_)
	local L_35_ = ""
	local L_36_ = 0
	local L_37_ = ""
	if L_30_arg1 == "Tête" then
		if L_34_ >= 1 and L_34_ <= 10 then
			L_35_ = "Blessure spectaculaire"
			L_36_ = 1
			L_37_ = "Une fine entaille qui va du front jusqu'à la joue. +1 État [i]Hémorragique[/i]. Une fois que la blessure est guérie, l'impressionnante cicatrice permet d'obtenir DR+1 à certains tests sociaux."
		elseif L_34_ >= 11 and L_34_ <= 20 then
			L_35_ = "Coupure mineure"
			L_36_ = 1
			L_37_ = "Le coup entaille la joue et le sang dégouline partout. +1 État [i]Hémorragique[/i]."
		elseif L_34_ >= 21 and L_34_ <= 25 then
			L_35_ = "Coup à l'oeil"
			L_36_ = 1
			L_37_ = "Le coup touche à l'orbite de l'oeil. +1 État [i]Aveuglé[/i]."
		elseif L_34_ >= 26 and L_34_ <= 30 then
			L_35_ = "Frappe à l'oreille"
			L_36_ = 1
			L_37_ = "Le coup touche à l'orbite de l'oreille et le personnage touché perçoit un bourdonnement ignoble. +1 État [i]Assourdi[/i]."
		elseif L_34_ >= 31 and L_34_ <= 35 then
			L_35_ = "Coup percutant"
			L_36_ = 2
			L_37_ = "Le sang obsurcit la vision du personnage touché, qui perçoit des points blancs et des flashs de lumière. +1 État [i]Sonné[/i]."
		elseif L_34_ >= 36 and L_34_ <= 40 then
			L_35_ = "Oeil au beurre noir"
			L_36_ = 2
			L_37_ = "C'est un coup massif au niveau des yeux, très douloureux. +2 États [i]Aveuglé[/i]."
		elseif L_34_ >= 41 and L_34_ <= 45 then
			L_35_ = "Oreille tranchée"
			L_36_ = 2
			L_37_ = "C'est un coup très violent sur le côté de la tête, qui entaille profondément l'oreille. +2 États [i]Assourdi[/i] et +1 État [i]Hémorragique[/i]."
		elseif L_34_ >= 46 and L_34_ <= 50 then
			L_35_ = "En plein front"
			L_36_ = 2
			L_37_ = "C'est un coup percutant en plein front. +2 États [i]Hémorragique[/i] et +1 État [i]Aveuglé[/i] qui ne peut être retiré tant que tous les États [i]Hémorragique[/i] n'ont pas été éliminés."
		elseif L_34_ >= 51 and L_34_ <= 55 then
			L_35_ = "Mâchoire fracturée"
			L_36_ = 3
			L_37_ = "Le coup fracture la mâchoire avec un bruit dégoûtant. Les vagues de douleur déferlent instantanément. +2 États [i]Sonné[/i] et subissez le Traumatisme [i]Fracture (Mineure)[/i]."
		elseif L_34_ >= 56 and L_34_ <= 60 then
			L_35_ = "Blessure majeure à l'oeil"
			L_36_ = 3
			L_37_ = "Le coup lézarde l'orbite. +1 État [i]Hémorragique[/i]. +1 État [i]Aveuglé[/i] qui ne pourra être soigné que lorsqu'on vous appliquera Aide Médicale."
		elseif L_34_ >= 61 and L_34_ <= 65 then
			L_35_ = "Blessure majeure à l'oreille"
			L_36_ = 3
			L_37_ = "Le coup endommage votre oreille, causant une perte auditive permanente. Vous subissez une pénalité de -20 à tout Test ayant un rapport avec l'audition. Si vous tombez une seconde fois sur cette blessure, vous perdez totalement l'audition car votre deuxième oreille devient elle aussi silencieuse. Ne peut être guéri que par la magie."
		elseif L_34_ >= 66 and L_34_ <= 70 then
			L_35_ = "Nez cassé"
			L_36_ = 3
			L_37_ = "Un coup violent porté au centre du visage déverse des flots de sang. +2 États [i]Hémorragique[/i]. Réussissez un Test de [b]Résistance Intermédiaire (+0)[/b] ou gagnez l'État [i]Sonné[/i]. Une fois cette blessure guérie, gagnez [b]DR+1/-1[/b] aux Tests Sociaux en fonction du contexte, jusqu'à ce que [b]Chirurgie[/b] soit utilisée sur le nez pour le réparer."
		elseif L_34_ >= 71 and L_34_ <= 75 then
			L_35_ = "Mâchoire cassée"
			L_36_ = 4
			L_37_ = "Le coup brise la mâchoire avec un bruit ignoble. +3 États [i]Sonné[/i]. Réussissez un Test de [b]Résistance Intermédiaire (+0)[/b] ou gagnez l'État [i]Inconscient[/i]. Subissez le Traumatisme [b]Fracture (Majeure)[/b]"
		elseif L_34_ >= 76 and L_34_ <= 80 then
			L_35_ = "Commotion cérébrale"
			L_36_ = 4
			L_37_ = "Le cerveau bouge à l'intérieur de la boîte crânienne, alors que le sang coule à flots du nez et des oreilles. +1 État [i]Assourdi[/i], +2 États [i]Hémorragique[/i] et +1D10 États [i]Sonné[/i]. +1 État [i]Exténué[/i] pour 1D10 jours. Si vous recevez une autre Blessure critique à la tête alors que vous êtes [i]Exténué[/i], réussissez un Test de [b]Résistance Accessible (+20)[/b] ou +1 État [i]Inconscient[/i]."
		elseif L_34_ >= 81 and L_34_ <= 85 then
			L_35_ = "Bouche explosée"
			L_36_ = 4
			L_37_ = "La bouche se remplit de sang et de dents cassées avec un bruit répugnant. +2 États [i]Hémorragique[/i]. Perdez 1D10 dents — [b]Amputation (Facile)[/b]."
		elseif L_34_ >= 86 and L_34_ <= 90 then
			L_35_ = "Oreille mutilée"
			L_36_ = 4
			L_37_ = "Il ne reste plus grand-chose de l'oreille après que le coup l'ait déchiquetée. +3 États [i]Assourdi[/i] et +2 États [i]Hémorragique[/i]. L'oreille est perdue — [b]Amputation (Accessible)[/b]"
		elseif L_34_ >= 91 and L_34_ <= 93 then
			L_35_ = "Œil crevé"
			L_36_ = 5
			L_37_ = "Le coup porté à l'œil le crève, provoquant une douleur quasi-insoutenable. +3 États [i]Aveuglé[/i], +2 États [i]Hémorragique[/i] et +1 États [i]Sonné[/i]. L'œil est perdu — [b]Amputation (Complexe)[/b]"
		elseif L_34_ >= 94 and L_34_ <= 96 then
			L_35_ = "Coup défigurant"
			L_36_ = 5
			L_37_ = "Le coup explose le visage, crevant un œil et brisant le nez. +3 États [i]Hémorragique[/i], +3 États [i]Aveuglé[/i] et +2 États [i]Sonné[/i]. L'œil et le nez sont perdus — [b]Amputation (Difficile)[/b]"
		elseif L_34_ >= 97 and L_34_ <= 99 then
			L_35_ = "Mâchoire mutilée"
			L_36_ = 5
			L_37_ = "Le coup arrache presque complètement la mâchoire, détruit la langue et envoie les dents à plusieurs mètres dans une pluie de sang. +4 États [i]Hémorragique[/i], +3 États [i]Sonné[/i]. Réussissez un Test de Résistance Très Difficile (-30) ou +1 État [i]Inconscient[/i]. Subissez le Traumatisme [b]Fracture (Majeure)[/b], la langue est perdue et 1D10 dents — [b]Amputation (Difficile)[/b]"
		elseif L_34_ == 100 then
			L_35_ = "Mort"
			L_36_ = 666
			L_37_ = "La tête est tranchée au niveau du cou et part dans les airs, atterrissant à 1D3 mètres du corps dans une direction aléatoire (voir [b]Dispersion[/b]). La mort est instantanée, et le corps s'effondre sans vie."
		end
	elseif L_30_arg1 == "Bras secondaire" or L_30_arg1 == "Bras principal" then
		if L_34_ >= 1 and L_34_ <= 10 then
			L_35_ = "Choc au bras"
			L_36_ = 1
			L_37_ =
             "Le bras "..L_30_arg1 .. " de %s prend un choc au cours de l'attaque. %s lâche ce qu'il tenait."
		elseif L_34_ >= 11 and L_34_ <= 20 then
			L_35_ = "Coupure mineure"
			L_36_ = 1
			L_37_ = "%s saigne abondamment au niveau de l'avant-bras. +1 État [i]Hémorragique[/i]."
		elseif L_34_ >= 21 and L_34_ <= 25 then
			L_35_ = "Torsion"
			L_36_ = 1
			L_37_ = "%s se tord le bras, occasionnant +1 Traumatisme [i]Déchirure musculaire (Mineure)[/i]"
		elseif L_34_ >= 26 and L_34_ <= 30 then
			L_35_ = "Choc violent au bras"
			L_36_ = 2
			L_37_ =
             "%s reçoit un coup particulièrement violent au "..L_30_arg1 .. " et lâche ce qu'il avait dans la main, cette dernière restant inutilisable pendant 1D10 - Bonus d'Endurance Rounds (minimum 1). Pendant ce temps, considérez votre main comme perdue (voir Membres Amputés, p180)."
		elseif L_34_ >= 31 and L_34_ <= 35 then
			L_35_ = "Déchirure musculaire"
			L_36_ = 2
			L_37_ =
             "Le coup écrase l'avant-bras du "..L_30_arg1 .. " de %s. +1 État [i]Hémorragique[/i] et +1 Traumatisme [i]Déchirure musculaire (Mineure)[/i]."
		elseif L_34_ >= 36 and L_34_ <= 40 then
			L_35_ = "Main ensanglantée"
			L_36_ = 2
			L_37_ =
             "La main du "..L_30_arg1 .. " de %s est bien entaillée. Le sang rend la prise glissante avec cette main. +1 État [i]Hémorragique[/i]. Test de [i]Dextérité (Accessible)[/i] pour effectuer toute action avec un objet dans la main, sinon il échappe des mains."
		elseif L_34_ >= 41 and L_34_ <= 45 then
			L_35_ = "Clef de bras"
			L_36_ = 2
			L_37_ =
             "L'articulation du "..L_30_arg1 .. " de %s est pratiquement arrachée. La main correspondante lâche ce qu'elle tenait, le bras est inutilisable pendant 1D10 Rounds."
		elseif L_34_ >= 46 and L_34_ <= 50 then
			L_35_ = "Blessure béante"
			L_36_ = 3
			L_37_ =
             "Le coup ouvre une blessure béante. +2 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au "..L_30_arg1 .. " redonnera +1 État [i]Hémorragique[/i], la blessure s'étant réouverte."
		elseif L_34_ >= 51 and L_34_ <= 55 then
			L_35_ = "Cassure nette"
			L_36_ = 3
			L_37_ =
             "Un craquement significatif se fait entendre au moment où le coup s'abat sur le "..L_30_arg1 .. " de %s. La main correspondante lâche ce qu'elle tenait. +1 Traumatisme [i]Fracture (Mineure)[/i]. +1 État [i]Sonné[/i] en cas d'échec à un Test de [i]Résistance (Complexe)[/i]."
		elseif L_34_ >= 56 and L_34_ <= 60 then
			L_35_ = "Ligament rompu"
			L_36_ = 3
			L_37_ =
             "%s lâche immédiatement ce qu'il tenait dans la main de son "..L_30_arg1 .. ". +1 Traumatisme [i]Déchirure musculaire (Majeure)[/i]"
		elseif L_34_ >= 61 and L_34_ <= 65 then
			L_35_ = "Coupure profonde"
			L_36_ = 3
			L_37_ =
             "+2 États [i]Hémorragique[/i] dûs à la forte mutilation du "..L_30_arg1 .. " de %s. +1 État [i]Sonné[/i], +1 Traumatisme [i]Déchirure musculaire (Mineure)[/i], +1 État [i]Inconscient[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]."
		elseif L_34_ >= 66 and L_34_ <= 70 then
			L_35_ = "Artère endommagée"
			L_36_ = 4
			L_37_ =
             "+4 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au "..L_30_arg1 .. " redonnera +2 État [i]Hémorragique[/i], la blessure s'étant réouverte."
		elseif L_34_ >= 71 and L_34_ <= 75 then
			L_35_ = "Coude fracassé"
			L_36_ = 4
			L_37_ =
             "Le coup fracasse le coude du "..L_30_arg1 .. " de %s, faisant voler en éclats os et cartilage. %s lâche immédiatement ce qu'il tenait dans cette main, et subit +1 Traumatisme [i]Fracture (Majeure)[/i]"
		elseif L_34_ >= 76 and L_34_ <= 80 then
			L_35_ = "Épaule luxée"
			L_36_ = 4
			L_37_ =
             "Le "..L_30_arg1 .. " de %s est démis de son logement. %s lâche immédiatement ce qu'il tenait dans cette main. +1 État [i]Sonné[/i] et +1 État [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]. État [i]Sonné[/i] conservé jusqu'à bénéficier d'Aide Médicale. Un Test Étendu de Guérison avec 6 DR est nécessaire pour recouvrer l'usage du bras. Les tests utilisant ce bras subissent une pénalité de -10 pendant 1D10 jours."
		elseif L_34_ >= 81 and L_34_ <= 85 then
			L_35_ = "Doigt sectionné"
			L_36_ = 4
			L_37_ = "%s voit un de ses doigts s'envoler. +1 États [i]Hémorragique[/i]. — [b]Amputation (Accessible)[/b]."
		elseif L_34_ >= 86 and L_34_ <= 90 then
			L_35_ = "Main ouverte"
			L_36_ = 5
			L_37_ =
             "La main du "..L_30_arg1 .. " de %s s'ouvre sous la puissance du coup. Un Doigt est perdu — [b]Amputation (Complexe)[/b]. +2 États [i]Hémorragique[/i] et +1 État [i]Sonné[/i]. Pour chaque Round sans Aide Médicale, un autre Doigt est perdu. Si tous les doigts sont perdus, la main est perdue. — [b]Amputation (Complexe)[/b]"
		elseif L_34_ >= 91 and L_34_ <= 93 then
			L_35_ = "Biceps déchiqueté"
			L_36_ = 5
			L_37_ =
             "Le coup sépare presque entièrement le biceps et le tendon de l'os du "..L_30_arg1 .. " de %s, laissant une blessure effrayante dont le sang gicle jusque sur son adversaire. %s lâche immédiatement ce qu'il tenait dans cette main. +1 Traumatisme [i]Déchirure musculaire (Majeure)[/i], +2 États [i]Hémorragique[/i] et +1 État [i]Sonné[/i]"
		elseif L_34_ >= 94 and L_34_ <= 96 then
			L_35_ = "Main mutilée"
			L_36_ = 5
			L_37_ =
             "La main du "..L_30_arg1 .. " de %s n'est plus qu'un tas de chair hémorragique. La main est perdue — [b]Amputation (Difficile)[/b]. +2 États [i]Hémorragique[/i]. +1 État [i]Sonné[/i] et +1 État [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]"
		elseif L_34_ >= 97 and L_34_ <= 99 then
			L_35_ = "Tendons coupés"
			L_36_ = 5
			L_37_ =
             "Les tendons sont sectionnés par la force du coup et le "..L_30_arg1 .. " de %s est inutilisable — [b]Amputation (Difficile)[/b]. +3 États [i]Hémorragique[/i], +1 État [i]À terre[/i], +1 État [i]Sonné[/i]. +1 État [i]Inconscient[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]. "
		elseif L_34_ == 100 then
			L_35_ = "Démembrement fatal"
			L_36_ = 666
			L_37_ =
             "Le "..L_30_arg1 .. " de %s est coupé, faisant gicler le sang des artères jusqu'à 1D3 mètres dans une direction aléatoire (voir [b]Dispersion[/b]). La mort de %s est instantanée, et son corps s'effondre sans vie."
		end
	elseif L_30_arg1 == "Corps" then
		if L_34_ >= 1 and L_34_ <= 10 then
			L_35_ = "Rien qu'une égratignure !"
			L_36_ = 1
			L_37_ = "+1 État [i]Hémorragique[/i]."
		elseif L_34_ >= 11 and L_34_ <= 20 then
			L_35_ = "Coup au ventre"
			L_36_ = 1
			L_37_ = "+1 État [i]Sonné[/i]. +1 État [i]À terre[/i] et vomissement en cas d'échec à un Test de [i]Résistance (Facile)[/i]."
		elseif L_34_ >= 21 and L_34_ <= 25 then
			L_35_ = "Coup bas"
			L_36_ = 1
			L_37_ = "+3 États [i]Sonné[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]."
		elseif L_34_ >= 26 and L_34_ <= 30 then
			L_35_ = "Torsion du dos"
			L_36_ = 1
			L_37_ = "+1 Traumatisme [i]Déchirure musculaire (Mineure)[/i]"
		elseif L_34_ >= 31 and L_34_ <= 35 then
			L_35_ = "Souffle coupé"
			L_36_ = 2
			L_37_ = "+1 État [i]Sonné[/i]. +1 États [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Accessible)[/i]. Le mouvement de %s est réduit de moitié pendant 1D10 rounds, le temps de récupérer son souffle."
		elseif L_34_ >= 36 and L_34_ <= 40 then
			L_35_ = "Bleus aux côtes"
			L_36_ = 2
			L_37_ = "Tous les Tests basés sur l'Agilité sont effectués avec une pénalité de -10 pendant 1D10 jours."
		elseif L_34_ >= 41 and L_34_ <= 45 then
			L_35_ = "Clavicule tordue"
			L_36_ = 2
			L_37_ = "Choisissez un bras au hasard. La main correspondante lâche ce qu'elle tenait, et le bras reste inutilisable pendant 1D10 Rounds."
		elseif L_34_ >= 46 and L_34_ <= 50 then
			L_35_ = "Chairs déchirées"
			L_36_ = 2
			L_37_ = "+2 États [i]Hémorragique[/i]."
		elseif L_34_ >= 51 and L_34_ <= 55 then
			L_35_ = "Côtes fracturées"
			L_36_ = 3
			L_37_ = "Le coup fracture une ou plusieurs côtes. +1 État [i]Sonné[/i], +1 Traumatisme [i]Fracture (Mineure)[/i]."
		elseif L_34_ >= 56 and L_34_ <= 60 then
			L_35_ = "Blessure béante"
			L_36_ = 3
			L_37_ =
             "+3 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au "..L_30_arg1 .. " redonnera +1 État [i]Hémorragique[/i], la blessure s'étant réouverte."
		elseif L_34_ >= 61 and L_34_ <= 65 then
			L_35_ = "Entaille douloureuse"
			L_36_ = 3
			L_37_ = "+2 États [i]Hémorragique[/i] et +1 État [i]Sonné[/i]. +1 États [i]Inconscient[/i] en cas d'échec à un Test Spectaculaire de [i]Résistance (Difficile)[/i], %s s'évanouissant sous l'effet de la douleur. Avec moins de 4DR, %s hurle de douleur."
		elseif L_34_ >= 66 and L_34_ <= 70 then
			L_35_ = "Dégâts artériels"
			L_36_ = 3
			L_37_ =
             "+4 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au "..L_30_arg1 .. " redonnera +2 États [i]Hémorragique[/i], la blessure s'étant réouverte."
		elseif L_34_ >= 71 and L_34_ <= 75 then
			L_35_ = "Dos froissé"
			L_36_ = 4
			L_37_ = "Une douleur irradiante assaille %s lorsqu'il fait jouer les muscles de son dos. +1 Traumatisme [b]Déchirure musculaire (Majeure)[/b]"
		elseif L_34_ >= 76 and L_34_ <= 80 then
			L_35_ = "Hanche fracturée"
			L_36_ = 4
			L_37_ = "+1 État [i]Sonné[/i] et +1 Traumatisme [b]Fracture (Mineure)[/b]. +1 États [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Intermédiaire)[/i]."
		elseif L_34_ >= 81 and L_34_ <= 85 then
			L_35_ = "Blessure majeure au torse"
			L_36_ = 4
			L_37_ = "%s reçoit une blessure importante au torse, le coup arrache la peau, les muscles et les tendons. +4 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au torse redonnera +2 États [i]Hémorragique[/i], la blessure s'étant réouverte."
		elseif L_34_ >= 86 and L_34_ <= 90 then
			L_35_ = "Blessure au ventre"
			L_36_ = 4
			L_37_ = "+2 États [i]Hémorragique[/i], c'est une Blessure Purulente."
		elseif L_34_ >= 91 and L_34_ <= 93 then
			L_35_ = "Cage thoracique perforée"
			L_36_ = 5
			L_37_ = "+1 État [i]Sonné[/i] jusqu'à réception d'une Aide Médicale. +1 Traumatisme [b]Fracture (Majeure)[/b]."
		elseif L_34_ >= 94 and L_34_ <= 96 then
			L_35_ = "Clavicule cassée"
			L_36_ = 5
			L_37_ = "+1 État [i]Inconscient[/i] jusqu'à réception d'une Aide Médicale. +1 Traumatisme [b]Fracture (Majeure)[/b]."
		elseif L_34_ >= 97 and L_34_ <= 99 then
			L_35_ = "Hémorragie interne"
			L_36_ = 5
			L_37_ = "+1 État [i]Hémorragique[/i] jusqu'à réception d'une Chirurgie. %s contracte en outre une Infection Sanguine."
		elseif L_34_ == 100 then
			L_35_ = "Éventré"
			L_36_ = 666
			L_37_ = "%s est littéralement coupé en deux, tout personnage situé à moins de 2 mètres est recouvert de sang."
		end
	elseif L_30_arg1 == "Jambe gauche" or L_30_arg1 == "Jambe droite" then
		L_35_ = "Gluglu"
		L_36_ = 0
		L_37_ = "GLUGLU"
	end
	return L_32_, L_33_, L_35_, L_36_, L_37_
end
function G_24(L_38_arg1, L_39_arg2, L_40_arg3, L_41_arg4, L_42_arg5, L_43_arg6)
	L_38_arg1 = string.lower(L_38_arg1)
	local L_44_ = ""
	if L_38_arg1 == "simple" then
		if L_40_arg3 and L_41_arg4 then
			local L_45_ =
       "Test Simple, difficulté "..G_13(L_41_arg4) .. ", maximum de " .. L_40_arg3
			local L_46_ =
       "["..'div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]' ..
        L_42_arg5 .. "[" .. "/div]"
			L_46_ =
       L_46_.."[" ..
        'div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]' ..
         L_43_arg6 .. "[" .. "/div]"
			local L_47_ = G_2(L_42_arg5, L_43_arg6)
			local L_48_ = G_8(L_47_, L_40_arg3)
			local L_49_ = G_10(L_38_arg1, L_42_arg5, L_43_arg6)
			local L_50_ = ""
			if L_48_ == true then
				L_50_ = "Succès"
			else
				L_50_ = "Échec"
			end
			local L_51_ = ""
			if L_49_ == true then
				L_51_ = "Critique"
			else
				L_51_ = ""
			end
			local L_52_ = string.format("%d contre %d est un %s %s", L_47_, L_40_arg3, L_50_, L_51_)
			local L_53_ = ""
			if L_48_ and not L_49_ then
				L_53_ = string.format("L'action du personnage est [u]une réussite[/u].")
			elseif L_48_ and L_49_ then
				L_53_ = string.format("L'action du personnage est [u]une réussite stupéfiante !![/u]")
			elseif not L_48_ and not L_49_ then
				L_53_ = string.format("L'action du personnage est clairement [u]un échec[/u].")
			elseif not L_48_ and L_49_ then
				L_53_ = string.format("L'action du personnage est [u]un échec stupéfiant ![/u] Le personnage échoue lamentablement, tout est allé de travers et les conséquences de cet échec sont catastrophiques !")
			end
			return G_23.smf.save(L_45_, L_46_, L_52_, L_53_, "wfrp4")
		end
	elseif L_38_arg1 == "spectaculaire" then
		if L_40_arg3 and L_41_arg4 then
			local L_54_ =
       "Test Spectaculaire, difficulté "..G_13(L_41_arg4) .. ", maximum de " .. L_40_arg3
			local L_55_ =
       '[div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'..L_42_arg5 .. "[/div]"
			L_55_ =
       L_55_..'[div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]' ..
        L_43_arg6 .. "[/div]"
			local L_56_ = G_2(L_42_arg5, L_43_arg6)
			local L_57_ = G_8(L_56_, L_40_arg3)
			local L_58_ = G_10(L_38_arg1, L_42_arg5, L_43_arg6)
			local L_59_ = G_17(L_56_, L_40_arg3)
			L_59_ = L_59_ + G_18(L_39_arg2)
			local L_60_ = ""
			local L_61_ = ""
			local L_62_ = ""
			if L_57_ == true then
				if L_58_ then
					L_44_ = string.format("%d contre %d donne un Succès avec %d Degrés de Réussite, mais c'est surtout un jet Critique, obtenant ainsi un Succès Stupéfiant !", L_56_, L_40_arg3, L_59_)
					L_62_ = "Grâce à ce jet de dés critique, l'action du personnage est un [u]Succès Stupéfiant[/u] ! Les résultats dépassent ce qu'il espérait, on n'aurait pas pu imaginer mieux !"
				else
					if L_59_ >= 6 then
						L_44_ = string.format("%d contre %d donne un Succès avec %d Degrés de Réussite, ce qui est un [u]Succès Stupéfiant[/u] !", L_56_, L_40_arg3, L_59_)
						L_62_ = "L'action du personnage est une [u]réussite stupéfiante[/u] ! Les résultats dépassent ce qu'il espérait, on n'aurait pas pu imaginer mieux !"
					elseif L_59_ == 4 or L_59_ == 5 then
						L_44_ = string.format("%d contre %d donne un Succès avec %d Degrés de Réussite, ce qui est un [u]Succès Impressionnant[/u] !", L_56_, L_40_arg3, L_59_)
						L_62_ = "L'action du personnage est [u]réussie avec style[/u] et les résultats sont absolument parfaits."
					elseif L_59_ == 2 or L_59_ == 3 then
						L_44_ = string.format("%d contre %d donne un Succès avec %d Degrés de Réussite", L_56_, L_40_arg3, L_59_)
						L_62_ = "L'action du personnage est [u]une réussite[/u]."
					elseif L_59_ == 0 or L_59_ == 1 then
						L_44_ = string.format("%d contre %d est un Succès mais avec %d Degré de Réussite, c'est un [u]Succès Minime[/u]...", L_56_, L_40_arg3, L_59_)
						L_62_ = "L'action du personnage est [u]plus ou moins réussie[/u], mais ce n'est pas parfait et des effets inattendus sont possibles."
					end
				end
			elseif L_57_ == false then
				if L_58_ then
					L_44_ = string.format("%d contre %d donne un Échec avec %d Degrés de Réussite, mais c'est surtout un jet Critique, obtenant ainsi un Échec Stupéfiant !", L_56_, L_40_arg3, L_59_)
					L_62_ = "L'action du personnage est [u]un Échec Stupéfiant ![/u] Le personnage échoue lamentablement, tout est allé de travers et les conséquences de cet échec sont catastrophiques !"
				else
					if L_59_ <= -6 then
						L_44_ = string.format("%d contre %d donne un Échec avec %d Degrés de Réussite, ce qui est un [u]Échec Stupéfiant[/u] !", L_56_, L_40_arg3, L_59_)
						L_62_ = "L'action du personnage est [u]un Échec Stupéfiant ![/u] Le personnage échoue lamentablement, tout est allé de travers et les conséquences de cet échec sont catastrophiques !"
					elseif L_59_ == -4 or L_59_ == -5 then
						L_44_ = string.format("%d contre %d donne un Échec avec %d Degrés de Réussite, ce qui est un [u]Échec Impressionnant[/u] !", L_56_, L_40_arg3, L_59_)
						L_62_ = "L'action du personnage est un [u]échec complet[/u], amenant même quelques conséquences collatérales négatives."
					elseif L_59_ == -2 or L_59_ == -3 then
						L_44_ = string.format("%d contre %d donne un Échec avec %d Degrés de Réussite.", L_56_, L_40_arg3, L_59_)
						L_62_ = "L'action du personnage est clairement [u]un échec[/u]."
					elseif L_59_ == 0 or L_59_ == -1 then
						L_44_ = string.format("%d contre %d donne un Échec mais avec %d Degrés de Réussite, c'est un [u]Échec Minime[/u]...", L_56_, L_40_arg3, L_59_)
						L_62_ = "L'action du personnage [u]échoue de peu[/u], avec peut-être des progrès mineurs ou la possibilité de retenter sa chance au prochain Round, si la situation s'y prête."
					end
				end
			end
			local L_63_ = L_44_
			local L_64_ = L_62_
			return G_23.smf.save(L_54_, L_55_, L_63_, L_64_, "wfrp4")
		end
	else
		return G_23.smf.save("Type de test inconnu", "myrolls", "myresults", "myfooter", "wfrp4")
	end
end
function G_25(L_65_arg1, L_66_arg2, L_67_arg3, L_68_arg4, L_69_arg5, L_70_arg6, L_71_arg7, L_72_arg8, L_73_arg9, L_74_arg10, L_75_arg11, L_76_arg12)
	local L_77_ = ""
	local L_78_ = L_65_arg1 or "Protagoniste 1"
	local L_79_ = L_71_arg7 or "Protagoniste 2"
	L_77_ = L_77_..'[div style="display: flex; color: white"]'
	L_77_ = L_77_..'[div style="display: flex; flex-direction: column; width: 100%"]'
	L_77_ =
     L_77_..'[span style="font-size: 1.2em; font-weight: bold; text-align: center; padding-bottom: 10px"]'
	L_77_ = L_77_.."Test Opposé"
	L_77_ = L_77_.."[/span]"
	L_77_ = L_77_..'[div style="display: flex; width: 100%"]'
	L_77_ = L_77_..'[div style="display: flex; flex-direction: column; flex-grow: 1; align-items: center"]'
	L_77_ = L_77_..'[div style="display: flex; font-weight: bold"]'
	L_77_ = L_77_..L_78_
	L_77_ = L_77_.."[/div]"
	L_77_ = L_77_..'[div style="display: flex"]'
	L_77_ = L_77_.."Seuil de base : " .. L_66_arg2
	L_77_ = L_77_.."[/div]"
	L_77_ = L_77_..'[div style="display: flex"]'
	L_77_ =
     L_77_.."Difficulté " ..
      G_13(L_68_arg4) .. " (" .. G_14(L_68_arg4) .. ")"
	L_77_ = L_77_.."[/div]"
	L_77_ = L_77_..'[div style="display: flex"]'
	L_77_ = L_77_.."Maximum : " .. L_67_arg3
	L_77_ = L_77_.."[/div]"
	L_77_ = L_77_.."[/div]"
	L_77_ = L_77_..'[hr style="border: color; margin: 5px"]'
	L_77_ = L_77_..'[div style="display: flex; flex-direction: column; flex-grow: 1; align-items: center"]'
	L_77_ = L_77_..'[div style="display: flex; font-weight: bold"]'
	L_77_ = L_77_..L_79_
	L_77_ = L_77_.."[/div]"
	L_77_ = L_77_..'[div style="display: flex"]'
	L_77_ = L_77_.."Seuil de base : " .. L_72_arg8
	L_77_ = L_77_.."[/div]"
	L_77_ = L_77_..'[div style="display: flex"]'
	L_77_ =
     L_77_.."Difficulté " ..
      G_13(L_74_arg10) .. " (" .. G_14(L_74_arg10) .. ")"
	L_77_ = L_77_.."[/div]"
	L_77_ = L_77_..'[div style="display: flex"]'
	L_77_ = L_77_.."Maximum : " .. L_73_arg9
	L_77_ = L_77_.."[/div]"
	L_77_ = L_77_.."[/div]"
	L_77_ = L_77_.."[/div]"
	L_77_ = L_77_.."[/div]"
	L_77_ = L_77_.."[/div]"
	local L_80_ = ""
	L_80_ = L_80_..'[div style="display: flex"]'
	L_80_ = L_80_..'[div style="display: flex; flex-grow: 1; justify-content: center"]'
	L_80_ =
     L_80_..'[div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
	L_80_ = L_80_..L_69_arg5
	L_80_ = L_80_.."[/div]"
	L_80_ =
     L_80_..'[div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
	L_80_ = L_80_..L_70_arg6
	L_80_ = L_80_.."[/div]"
	L_80_ = L_80_.."[/div]"
	L_80_ = L_80_..'[hr style="border: color; margin: 5px"]'
	L_80_ = L_80_..'[div style="display: flex; flex-grow: 1; justify-content: center"]'
	L_80_ =
     L_80_..'[div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
	L_80_ = L_80_..L_75_arg11
	L_80_ = L_80_.."[/div]"
	L_80_ =
     L_80_..'[div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
	L_80_ = L_80_..L_76_arg12
	L_80_ = L_80_.."[/div]"
	L_80_ = L_80_.."[/div]"
	L_80_ = L_80_.."[/div]"
	local L_81_ = G_2(L_69_arg5, L_70_arg6)
	local L_82_ = G_2(L_75_arg11, L_76_arg12)
	local L_83_ = G_8(L_81_, L_67_arg3)
	local L_84_ = G_8(L_82_, L_73_arg9)
	local L_85_ = G_10("oppose", L_69_arg5, L_70_arg6)
	local L_86_ = G_10("oppose", L_75_arg11, L_76_arg12)
	local L_87_ = G_17(L_81_, L_67_arg3)
	local L_88_ = G_17(L_82_, L_73_arg9)
	local L_89_ = ""
	local L_90_ = ""
	local L_91_ = ""
	local L_92_ = ""
	local L_93_ = ""
	local L_94_ = ""
	local L_95_ = ""
	local L_96_ = ""
	if L_85_ then
		L_93_ = "Critique"
		if (L_87_ >= 0 and L_87_ < 6) then
			L_87_ = 6
		elseif (L_87_ <= 0 and L_87_ > -6) then
			L_87_ = -6
		end
	end
	if L_86_ then
		L_94_ = "Critique"
		if (L_88_ >= 0 and L_88_ < 6) then
			L_88_ = 6
		elseif (L_88_ <= 0 and L_88_ > -6) then
			L_88_ = -6
		end
	end
	L_87_ = L_87_ + G_18(L_66_arg2)
	L_88_ = L_88_ + G_18(L_72_arg8)
	if L_83_ then
		L_89_ = "Succès"
	else
		L_89_ = "Échec"
	end
	if L_84_ then
		L_90_ = "Succès"
	else
		L_90_ = "Échec"
	end
	L_91_ = string.format("%s %s[br/]avec [u]%d Degrés de Réussite[/u]", L_89_, L_93_, L_87_)
	L_92_ = string.format("%s %s[br/]avec [u]%d Degrés de Réussite[/u]", L_90_, L_94_, L_88_)
	local L_97_ = ""
	L_97_ = L_97_..'[div style="display: flex"]'
	L_97_ = L_97_..'[div style="display: flex; flex-grow: 1; justify-content: center"]'
	L_97_ = L_97_..'[span class="" style="color: white"]'
	L_97_ = L_97_..L_91_
	L_97_ = L_97_.."[/span]"
	L_97_ = L_97_.."[/div]"
	L_97_ = L_97_..'[hr style="border: color; margin: 5px"]'
	L_97_ = L_97_..'[div style="display: flex; flex-grow: 1; justify-content: center"]'
	L_97_ = L_97_..'[span class="" style="color: white"]'
	L_97_ = L_97_..L_92_
	L_97_ = L_97_.."[/span]"
	L_97_ = L_97_.."[/div]"
	L_97_ = L_97_.."[/div]"
	local L_98_ = ""
	local L_99_ = ""
	local L_100_ = ""
	if (L_87_ > L_88_ and true) then
		L_100_ = string.format("[u]%s remporte le Test[/u][br/]avec %d Degrés de Réussite d'écart.", L_78_,
      L_87_ - L_88_)
		L_98_ = L_78_
		L_99_ = L_79_
	elseif (L_87_ < L_88_ and true) then
		L_100_ = string.format("[u]%s remporte le Test[/u][br/]avec %d Degrés de Réussite d'écart.", L_79_,
      L_88_ - L_87_)
		L_98_ = L_79_
		L_99_ = L_78_
	elseif (L_87_ == L_88_ and true) then
		if L_83_ and not L_84_ then
			L_100_ = string.format("[u]%s remporte le Test[/u], départagé par le Succès du lancer", L_78_)
			L_98_ = L_78_
			L_99_ = L_79_
		elseif L_84_ and not L_83_ then
			L_100_ = string.format("[u]%s remporte le Test[/u], départagé par le Succès du lancer.", L_79_)
			L_98_ = L_79_
			L_99_ = L_78_
		elseif (L_83_ and L_83_) or (not L_83_ and not L_84_) then
			if L_67_arg3 > L_73_arg9 then
				L_100_ = string.format("[u]%s remporte le Test de peu[/u], départagé par le Seuil du Test.", L_78_)
				L_98_ = L_78_
				L_99_ = L_79_
			elseif (L_67_arg3 < L_73_arg9 and true) then
				L_100_ = string.format("[u]%s remporte le Test[/u], départagé par le Seuil du Test.", L_79_)
				L_98_ = L_79_
				L_99_ = L_78_
			elseif (L_67_arg3 == L_73_arg9 and true) then
				if L_66_arg2 > L_72_arg8 then
					L_100_ = string.format("[u]%s remporte le Test[/u], départagé par le Score de compétence.", L_78_)
					L_98_ = L_78_
					L_99_ = L_79_
				elseif (L_66_arg2 < L_72_arg8 and true) then
					L_100_ = string.format("[u]%s remporte le Test[/u], départagé par le Score de compétence.", L_79_)
					L_98_ = L_79_
					L_99_ = L_78_
				elseif (L_66_arg2 == L_72_arg8 and true) then
					if (L_81_ < L_82_ and true) then
						L_100_ = string.format("[u]%s remporte le Test[/u], départagé par le Lancer de dé.", L_78_)
						L_98_ = L_78_
						L_99_ = L_79_
					elseif (L_81_ > L_81_ and true) then
						L_100_ = string.format("[u]%s remporte le Test[/u], départagé par le Lancer de dé.", L_79_)
						L_98_ = L_79_
						L_99_ = L_78_
					elseif (L_81_ == L_82_ and true) then
						L_100_ = string.format("[u]Aucun protagoniste ne remporte le Test, c'est une égalité parfaite[/u].")
					end
				end
			end
		end
	end
	local L_101_ = ""
	if L_83_ and L_84_ then
		L_101_ =
      L_101_..string.format(
       "Les deux protagonistes ont réussi, mais %s a tout de même pris le dessus sur %s.",
       L_98_,
       L_99_
      )
	elseif (L_83_ and not L_84_) or (L_84_ and not L_83_) then
		L_101_ =
      L_101_..string.format("Le résultat est clair, sans ambigüité : %s a réussi et %s a échoué.", L_98_, L_99_)
	elseif not L_83_ and not L_84_ then
		L_101_ =
      L_101_.."Toutefois, les deux protagonistes ont échoué, quel duel de bras cassés !"
	end
	local L_102_ = ""
	L_102_ = L_102_..'[hr style="border: color; margin: 5px; "]'
	L_102_ = L_102_..'[div style="display: flex;margin-top: 10px"]'
	L_102_ = L_102_..'[div style="display: flex; flex-grow: 1; justify-content: center"]'
	L_102_ = L_102_..'[div style="color: white"]'
	L_102_ =
     L_102_..'[div style="color: white; font-size: 1.2em; font-weight: bold; padding-bottom:5px; line-height: 1.4em"]' ..
      L_100_ .. "[/div]"
	L_102_ =
     L_102_..'[div style="color: white; font-weight: bold; padding-top:5px"]' .. L_101_ .. "[/div]"
	L_102_ = L_102_.."[/div]"
	L_102_ = L_102_.."[/div]"
	L_102_ = L_102_.."[/div]"
	return G_23.smf.save(L_77_, L_80_, L_97_, L_102_, "wfrp4")
end
function G_26(L_103_arg1, L_104_arg2, L_105_arg3, L_106_arg4, L_107_arg5, L_108_arg6, L_109_arg7, L_110_arg8, L_111_arg9, L_112_arg10, L_113_arg11, L_114_arg12, L_115_arg13, L_116_arg14, L_117_arg15)
	local L_118_ = ""
	local L_119_ = L_103_arg1 or "Protagoniste 1"
	local L_120_ = L_111_arg9 or "Protagoniste 2"
	local L_121_ = ""
	L_118_ = L_118_..'[div style="display: flex; color: white"]'
	L_118_ = L_118_..'[div style="display: flex; flex-direction: column; width: 100%"]'
	L_118_ =
     L_118_..'[span style="font-size: 1.2em; font-weight: bold; text-align: center; padding-bottom: 10px"]'
	L_118_ = L_118_.."Attaque au Corps-à-Corps"
	L_118_ = L_118_.."[/span]"
	L_118_ = L_118_..'[div style="display: flex; width: 100%"]'
	L_118_ = L_118_..'[div style="display: flex; flex-direction: column; flex-grow: 1; align-items: center"]'
	L_118_ = L_118_..'[div style="display: flex; font-weight: bold"]'
	L_118_ = L_118_.."Attaquant"
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_..'[div style="display: flex; font-weight: bold"]'
	L_118_ = L_118_..L_119_
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_..'[div style="display: flex"]'
	L_118_ = L_118_.."Seuil de base : " .. L_104_arg2
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_..'[div style="display: flex"]'
	L_118_ =
     L_118_.."Difficulté " ..
      G_13(L_106_arg4) .. " (" .. G_14(L_106_arg4) .. ")"
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_..'[div style="display: flex"]'
	L_118_ = L_118_..L_107_arg5 .. " Avantages (" .. G_15(L_107_arg5) .. ")"
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_..'[div style="display: flex"]'
	L_118_ = L_118_.."Seuil effectif : " .. L_105_arg3
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_..'[hr style="border: color; margin: 5px"]'
	L_118_ = L_118_..'[div style="display: flex; flex-direction: column; flex-grow: 1; align-items: center"]'
	L_118_ = L_118_..'[div style="display: flex; font-weight: bold"]'
	L_118_ = L_118_.."Défenseur"
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_..'[div style="display: flex; font-weight: bold"]'
	L_118_ = L_118_..L_120_
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_..'[div style="display: flex"]'
	L_118_ = L_118_.."Seuil de base : " .. L_112_arg10
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_..'[div style="display: flex"]'
	L_118_ =
     L_118_.."Difficulté " ..
      G_13(L_114_arg12) .. " (" .. G_14(L_114_arg12) .. ")"
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_..'[div style="display: flex"]'
	L_118_ = L_118_..L_115_arg13 .. " Avantages (" .. G_15(L_115_arg13) .. ")"
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_..'[div style="display: flex"]'
	L_118_ = L_118_.."Seuil effectif : " .. L_113_arg11
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_.."[/div]"
	L_118_ = L_118_.."[/div]"
	local L_122_ = ""
	L_122_ = L_122_..'[div style="display: flex"]'
	L_122_ = L_122_..'[div style="display: flex; flex-grow: 1; justify-content: center"]'
	L_122_ =
     L_122_..'[div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
	L_122_ = L_122_..L_108_arg6
	L_122_ = L_122_.."[/div]"
	L_122_ =
     L_122_..'[div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
	L_122_ = L_122_..L_109_arg7
	L_122_ = L_122_.."[/div]"
	L_122_ = L_122_.."[/div]"
	L_122_ = L_122_..'[hr style="border: color; margin: 5px"]'
	L_122_ = L_122_..'[div style="display: flex; flex-grow: 1; justify-content: center"]'
	L_122_ =
     L_122_..'[div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
	L_122_ = L_122_..L_116_arg14
	L_122_ = L_122_.."[/div]"
	L_122_ =
     L_122_..'[div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
	L_122_ = L_122_..L_117_arg15
	L_122_ = L_122_.."[/div]"
	L_122_ = L_122_.."[/div]"
	L_122_ = L_122_.."[/div]"
	local L_123_ = G_2(L_108_arg6, L_109_arg7)
	local L_124_ = G_2(L_116_arg14, L_117_arg15)
	local L_125_ = G_8(L_123_, L_105_arg3)
	local L_126_ = G_8(L_124_, L_113_arg11)
	local L_127_ = G_10("corps-a-corps", L_108_arg6, L_109_arg7)
	local L_128_ = G_10("corps-a-corps", L_116_arg14, L_117_arg15)
	local L_129_ = G_17(L_123_, L_105_arg3)
	local L_130_ = G_17(L_124_, L_113_arg11)
	local L_131_ = ""
	local L_132_ = ""
	local L_133_ = ""
	local L_134_ = ""
	local L_135_ = ""
	local L_136_ = ""
	local L_137_ = ""
	local L_138_ = ""
	local L_139_ = ""
	if L_127_ then
		L_133_ = "Critique"
	end
	if L_128_ then
		L_134_ = "Critique"
	end
	L_129_ = L_129_ + G_18(L_104_arg2)
	L_130_ = L_130_ + G_18(L_112_arg10)
	if L_125_ then
		L_131_ = "Succès"
	else
		L_131_ = "Échec"
	end
	if L_126_ then
		L_132_ = "Succès"
	else
		L_132_ = "Échec"
	end
	L_135_ = string.format("%s %s[br/]avec [u]%d Degrés de Réussite[/u]", L_131_, L_133_, L_129_)
	L_136_ = string.format("%s %s[br/]avec [u]%d Degrés de Réussite[/u]", L_132_, L_134_, L_130_)
	local L_140_ = ""
	L_140_ = L_140_..'[div style="display: flex"]'
	L_140_ = L_140_..'[div style="display: flex; flex-grow: 1; justify-content: center"]'
	L_140_ = L_140_..'[span class="" style="color: white"]'
	L_140_ = L_140_..L_135_
	L_140_ = L_140_.."[/span]"
	L_140_ = L_140_.."[/div]"
	L_140_ = L_140_..'[hr style="border: color; margin: 5px"]'
	L_140_ = L_140_..'[div style="display: flex; flex-grow: 1; justify-content: center"]'
	L_140_ = L_140_..'[span class="" style="color: white"]'
	L_140_ = L_140_..L_136_
	L_140_ = L_140_.."[/span]"
	L_140_ = L_140_.."[/div]"
	L_140_ = L_140_.."[/div]"
	local L_141_ = ""
	local L_142_ = ""
	local L_143_ = ""
	local L_144_ = ""
	local L_145_ = ""
	local L_146_ = ""
	local L_147_ = 0
	local L_148_ = 0
	local L_149_ = ""
	local L_150_ = ""
	local L_151_ = 0
	local L_152_ = 0
	local L_153_ = 0
	local L_154_ = 0
	if L_127_ then
		L_143_ = G_19(G_23.roll.dice(1, 1, 100)[1])
		L_145_ = G_22(L_143_)
		L_151_, L_152_, L_145_, L_147_, L_149_ = G_22(L_143_)
	else
		L_143_ = G_19(L_123_)
		L_145_ = G_20(L_143_)
	end
	if L_128_ then
		L_144_ = G_19(G_23.roll.dice(1, 1, 100)[1])
		L_153_, L_154_, L_146_, L_148_, L_150_ = G_22(L_144_)
	end
	if (L_125_ and L_127_) then
		L_138_ = L_138_..string.format(
      "[u]%s porte un Coup Critique[/u] touchant %s avec pour effet [b]%s[/b]. Le coup outrepasse l'armure éventuelle, et occasionne directement %d Dégâts, avec des effets supplémentaires : %s",
      L_119_,
      L_120_,
      L_145_,
      L_147_,
      L_149_
     )
	end
	if (L_126_ and L_128_) then
		L_139_ = L_139_..string.format(
       "[u]En se défendant de l'attaque de %s, %s réussit un Coup Critique[/u] avec pour effet [b]%s[/b]. Le coup outrepasse l'armure éventuelle, et occasionne directement %d Dégâts, avec des effets supplémentaires : %s",
       L_119_,
       L_120_,
       L_146_,
       L_148_,
       L_150_
      )
	end
	L_137_ = L_138_.."[br/]" .. L_139_ .. "[br/]"
	if (L_129_ > L_130_ and true) then
		L_137_ = L_137_..string.format(
      "[u]%s attaque avec succès[/u] et touche %s %s. Il occasionne des Dégâts à hauteur de %d DR + %d ",
      L_119_,
      L_120_,
      L_145_,
      L_129_ - L_130_,
      L_110_arg8
     )
		L_141_ = L_119_
		L_142_ = L_120_
	elseif (L_129_ < L_130_ and true) then
		L_137_ = L_137_..string.format(
      "[u]%s remporte le Test[/u][br/]avec %d Degrés de Réussite d'écart.",
      L_120_,
      L_130_ - L_129_
     )
		L_141_ = L_120_
		L_142_ = L_119_
	elseif (L_129_ == L_130_ and true) then
		if L_125_ and not L_126_ then
			L_137_ = L_137_..string.format("[u]%s remporte le Test[/u], départagé par le Succès du lancer", L_119_)
			L_141_ = L_119_
			L_142_ = L_120_
		elseif L_126_ and not L_125_ then
			L_137_ = L_137_..string.format("[u]%s remporte le Test[/u], départagé par le Succès du lancer.", L_120_)
			L_141_ = L_120_
			L_142_ = L_119_
		elseif (L_125_ and L_125_) or (not L_125_ and not L_126_) then
			if (L_105_arg3 > L_113_arg11 and true) then
				L_137_ = L_137_..string.format(
        "[u]%s remporte le Test de peu[/u], départagé par le Seuil du Test.",
        L_119_
       )
				L_141_ = L_119_
				L_142_ = L_120_
			elseif (L_105_arg3 < L_113_arg11 and true) then
				L_137_ = L_137_..string.format("[u]%s remporte le Test[/u], départagé par le Seuil du Test.", L_120_)
				L_141_ = L_120_
				L_142_ = L_119_
			elseif (L_105_arg3 == L_113_arg11 and true) then
				if L_104_arg2 > L_112_arg10 then
					L_137_ = L_137_..string.format(
         "[u]%s remporte le Test[/u], départagé par le Score de compétence.",
         L_119_
        )
					L_141_ = L_119_
					L_142_ = L_120_
				elseif (L_104_arg2 < L_112_arg10 and true) then
					L_137_ = L_137_..string.format(
         "[u]%s remporte le Test[/u], départagé par le Score de compétence.",
         L_120_
        )
					L_141_ = L_120_
					L_142_ = L_119_
				elseif (L_104_arg2 == L_112_arg10 and true) then
					if (L_123_ < L_124_ and true) then
						L_137_ = L_137_..string.format(
          "[u]%s remporte le Test[/u], départagé par le Lancer de dé.",
          L_119_
         )
						L_141_ = L_119_
						L_142_ = L_120_
					elseif (L_123_ > L_124_ and true) then
						L_137_ = L_137_..string.format(
          "[u]%s remporte le Test[/u], départagé par le Lancer de dé.",
          L_120_
         )
						L_141_ = L_120_
						L_142_ = L_119_
					elseif (L_123_ == L_124_ and true) then
						L_137_ = L_137_..string.format("[u]Aucun protagoniste ne remporte le Test, c'est une égalité parfaite[/u].")
					end
				end
			end
		end
	end
	local L_155_ = ""
	if L_125_ and L_126_ then
		L_155_ =
      L_155_..string.format(
       "Les deux protagonistes ont réussi, mais %s a tout de même pris le dessus sur %s.",
       L_141_,
       L_142_
      )
	elseif (L_125_ and not L_126_) or (L_126_ and not L_125_) then
		L_155_ =
      L_155_..string.format("Le résultat est clair, sans ambigüité : %s a réussi et %s a échoué.", L_141_, L_142_)
	elseif not L_125_ and not L_126_ then
		L_155_ =
      L_155_.."Toutefois, les deux protagonistes ont échoué, quel duel de bras cassés !"
	end
	local L_156_ = ""
	L_156_ = L_156_..'[hr style="border: color; margin: 5px; "]'
	L_156_ = L_156_..'[div style="display: flex;margin-top: 10px"]'
	L_156_ = L_156_..'[div style="display: flex; flex-grow: 1; justify-content: center"]'
	L_156_ = L_156_..'[div style="color: white"]'
	L_156_ =
     L_156_..'[div style="color: white; font-size: 1.2em; font-weight: bold; padding-bottom:5px; line-height: 1.4em"]' ..
      L_137_ .. "[/div]"
	L_156_ =
     L_156_..'[div style="color: white; font-weight: bold; padding-top:5px"]' .. L_155_ .. "[/div]"
	L_156_ = L_156_.."[/div]"
	L_156_ = L_156_.."[/div]"
	L_156_ = L_156_.."[/div]"
	return G_23.smf.save(L_118_, L_122_, L_140_, L_156_, "wfrp4")
end
function G_23.accel.test(L_157_arg1)
	local L_158_, L_159_ = G_23.smf.striptitle(L_157_arg1)
	local L_160_ = string.match(L_157_arg1, "([%w%p]*)[%s]*")
	L_160_ = tostring(L_160_) or ""
	if ((L_160_ == "simple" or L_160_ == "spectaculaire") and true) then
		local L_161_, L_162_ = string.match(L_157_arg1, "%w*[%s]*(%d*)[%s]*(%w*)[%s]*")
		L_161_ = tonumber(L_161_) or nil
		L_162_ = G_12(tostring(L_162_) or "")
		local L_163_ = G_11(L_162_)
		local L_164_ = G_16(L_161_, L_163_)
		local L_165_ = G_23.roll.dice(2, 0, 9)
		local L_166_ = L_165_[1]
		local L_167_ = L_165_[2]
		local L_168_ = G_8(G_2(L_166_, L_167_), L_164_)
		local L_169_ = G_9(G_2(L_166_, L_167_), L_164_)
		local L_170_ = G_10(L_160_, L_166_, L_167_)
		return G_24(L_160_, L_161_, L_164_, L_162_, L_166_, L_167_)
	elseif (L_160_ == "oppose" and true) then
		local L_171_, L_172_, L_173_, L_174_, L_175_, L_176_ = string.match(L_157_arg1, "%w*[%s]+([%w%p]*)[%s]+(%d+)[%s]+([%w]*)[%s]*/[%s]*([%w%p]+)[%s]*(%d+)[%s]*([%w]*)")
		L_172_ = tonumber(L_172_) or nil
		L_175_ = tonumber(L_175_) or nil
		if (L_173_ == "" and true) then
			L_173_ = "I"
		end
		if (L_176_ == "" and true) then
			L_176_ = "I"
		end
		L_173_ = G_12(L_173_)
		L_176_ = G_12(L_176_)
		local L_177_ = G_11(L_173_)
		local L_178_ = G_11(L_176_)
		local L_179_ = G_16(L_172_, L_177_)
		local L_180_ = G_16(L_175_, L_178_)
		local L_181_ = G_23.roll.dice(2, 0, 9)
		local L_182_ = G_23.roll.dice(2, 0, 9)
		local L_183_ = L_181_[1]
		local L_184_ = L_182_[1]
		local L_185_ = L_181_[2]
		local L_186_ = L_182_[2]
		local L_187_ = G_8(G_2(L_183_, L_185_), L_179_)
		local L_188_ = G_8(G_2(L_184_, L_186_), L_180_)
		local L_189_ = G_9(G_2(L_183_, L_185_), L_179_)
		local L_190_ = G_9(G_2(L_184_, L_186_), L_180_)
		local L_191_ = G_10(L_160_, L_183_, L_185_)
		local L_192_ = G_10(L_160_, L_184_, L_186_)
		return G_25(L_171_, L_172_, L_179_, L_173_, L_183_, L_185_, L_174_, L_175_, L_180_, L_176_, L_184_, L_186_)
	elseif (L_160_ == "corps-a-corps" and true) then
		local L_193_, L_194_, L_195_, L_196_, L_197_ = string.match(L_157_arg1, "%w*[%s]+([%w%p]*)[%s]+(%d+)[%s]+([%w]*)[%s]*(%d*)A[%s]*(%d*)BF[%s]*.*/.*")
		local L_198_ = string.match(L_157_arg1, ".*Enroulement.*/")
		L_198_ = L_198_ ~= nil
		local L_199_ = string.match(L_157_arg1, ".*(Poudre).*/")
		L_199_ = L_199_ ~= nil
		local L_200_ = string.match(L_157_arg1, ".*(Assommante).*/")
		L_200_ = L_200_ ~= nil
		print("atoutAssommante", L_200_)
		local L_201_ = string.match(L_157_arg1, ".*(Défensive).*/")
		L_201_ = L_201_ ~= nil
		print("atoutDefensive", L_201_)
		local L_202_ = string.match(L_157_arg1, ".*(Dévastatrice).*/")
		L_202_ = L_202_ ~= nil
		print("atoutDevastatrice", L_202_)
		local L_203_ = string.match(L_157_arg1, ".*(Empaleuse).*/")
		L_203_ = L_203_ ~= nil
		print("atoutEmpaleuse", L_203_)
		local L_204_ = string.match(L_157_arg1, ".*Explosion.*/")
		L_204_ = L_204_ ~= nil
		print("atoutExplosion", L_204_)
		local L_205_ = string.match(L_157_arg1, ".*Explosion(%d*).*/")
		print("indiceAtoutExplosion", L_205_)
		local L_206_ = string.match(L_157_arg1, ".*(Immobilisante).*/")
		L_206_ = L_206_ ~= nil
		print("atoutImmobilisante", L_206_)
		local L_207_ = string.match(L_157_arg1, ".*(Incassable).*/")
		L_207_ = L_207_ ~= nil
		print("atoutIncassable", L_207_)
		local L_208_ = string.match(L_157_arg1, ".*(Percutante).*/")
		L_208_ = L_208_ ~= nil
		print("atoutPercutante", L_208_)
		local L_209_ = string.match(L_157_arg1, ".*(Perforante).*/")
		L_209_ = L_209_ ~= nil
		print("atoutPerforante", L_209_)
		local L_210_ = string.match(L_157_arg1, ".*(Perturbante).*/")
		L_210_ = L_210_ ~= nil
		print("atoutPerturbante", L_210_)
		local L_211_ = string.match(L_157_arg1, ".*(Piège-lame).*/")
		L_211_ = L_211_ ~= nil
		print("atoutPiegeLame", L_211_)
		local L_212_ = string.match(L_157_arg1, ".*(Pistolet).*/")
		L_212_ = L_212_ ~= nil
		print("atoutPistolet", L_212_)
		local L_213_ = string.match(L_157_arg1, ".*(Pointue).*/")
		L_213_ = L_213_ ~= nil
		print("atoutPointue", L_213_)
		local L_214_ = string.match(L_157_arg1, ".*(Précise).*/")
		L_214_ = L_214_ ~= nil
		print("atoutPrecise", L_214_)
		local L_215_ = string.match(L_157_arg1, ".*Protectrice.*/")
		L_215_ = L_215_ ~= nil
		print("atoutProtectrice", L_215_)
		local L_216_ = string.match(L_157_arg1, ".*Protectrice(%d*).*/")
		print("atoutProtectrice(%d)", L_216_)
		local L_217_ = string.match(L_157_arg1, ".*(Rapide).*/")
		L_217_ = L_217_ ~= nil
		print("atoutRapide", L_217_)
		local L_218_ = string.match(L_157_arg1, ".*(Taille).*/")
		L_218_ = L_218_ ~= nil
		print("atoutTaille", L_218_)
		local L_219_, L_220_, L_221_, L_222_ = string.match(L_157_arg1, ".*/[%s]*([%w%p]+)[%s]*(%d+)[%s]*([%w]*)[%s]*(%d*)A[%s]*")
		L_194_ = tonumber(L_194_) or nil
		L_220_ = tonumber(L_220_) or nil
		L_196_ = tonumber(L_196_) or 0
		L_222_ = tonumber(L_222_) or 0
		L_197_ = tonumber(L_197_) or 0
		print("TestCorpsACorps:avantage1", L_196_)
		print("TestCorpsACorps:avantage2", L_222_)
		print("TestCorpsACorps:bonusForce1", L_197_)
		if (L_195_ == "" and true) then
			L_195_ = "I"
		end
		if (L_221_ == "" and true) then
			L_221_ = "I"
		end
		L_195_ = G_12(L_195_)
		L_221_ = G_12(L_221_)
		local L_223_ = G_11(L_195_)
		local L_224_ = G_11(L_221_)
		local L_225_ = G_16(L_194_, L_223_)
		local L_226_ = G_16(L_220_, L_224_)
		L_225_ = L_225_ + (L_196_ * 10)
		L_226_ = L_226_ + (L_222_ * 10)
		local L_227_ = G_23.roll.dice(2, 0, 9)
		local L_228_ = G_23.roll.dice(2, 0, 9)
		local L_229_ = L_227_[1]
		local L_230_ = L_228_[1]
		local L_231_ = L_227_[2]
		local L_232_ = L_228_[2]
		local L_233_ = G_8(G_2(L_229_, L_231_), L_225_)
		local L_234_ = G_8(G_2(L_230_, L_232_), L_226_)
		local L_235_ = G_9(G_2(L_229_, L_231_), L_225_)
		local L_236_ = G_9(G_2(L_230_, L_232_), L_226_)
		local L_237_ = G_10(L_160_, L_229_, L_231_)
		local L_238_ = G_10(L_160_, L_230_, L_232_)
		return G_26(L_193_, L_194_, L_225_, L_195_, L_196_, L_229_, L_231_, L_197_, L_219_, L_220_, L_226_, L_221_, L_222_, L_230_, L_232_)
	elseif (L_160_ == "distance" and true) then
		print("Test d'Attaque à distance:", L_160_)
	else
		print("Test de type inconnu:", L_160_)
	end
end