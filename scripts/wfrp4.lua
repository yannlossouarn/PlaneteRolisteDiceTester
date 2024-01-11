
-- Script LUA utilisable pour mettre en place des jets de dés au format Warhammer v4 sur le site PlaneteRoliste.com

function IsDouble(d1, d2)
    if (d1 == d2 and true) then
     return true
    else
     return false
    end
end
   
   function GetD100(d1, d2)
    if d1 == 0 and d2 == 0 then
     return 100
    else
     return d1 * 10 + d2
    end
   end
   
   OptionAutomatiqueDonneCritique = true
   SuccesAutomatiqueMax = 1
   EchecAutomatiqueMin = 97
   OptionDoubleDonneCritique = true
   OptionDRSupplementairePourSeuilsSuperieursA100 = true
   
   function IsSuccess(d100, seuil)
    if
     (d100 <= seuil or (OptionAutomatiqueDonneCritique and d100 <= SuccesAutomatiqueMax)) and
      not (OptionAutomatiqueDonneCritique and d100 >= EchecAutomatiqueMin)
     then
     return true
    else
     return false
    end
   end
   
   function IsFailure(d100, seuil)
    if d100 >= seuil or d100 >= EchecAutomatiqueMin then
     return true
    else
     return false
    end
   end
   
   function IsCritical(typetest, d1, d2)
    if
     (OptionDoubleDonneCritique and IsDouble(d1, d2)) or
      ((typetest ~= "corps-a-corps" or typetest ~= "distance") and OptionAutomatiqueDonneCritique and
       (GetD100(d1, d2) <= SuccesAutomatiqueMax or GetD100(d1, d2) >= EchecAutomatiqueMin))
     then
     return true
    else
     return false
    end
   end
   
   function GetModificateurDifficulte(difficulte)
    difficulte = tostring(difficulte) or "I"
   
    if difficulte == "TF" then
     return 60
    elseif difficulte == "F" then
     return 40
    elseif difficulte == "A" then
     return 20
    elseif difficulte == "I" then
     return 0
    elseif difficulte == "C" then
     return -10
    elseif difficulte == "D" then
     return -20
    elseif difficulte == "TD" then
     return -30
    end
   end
   
   function GetCodeDifficulte(difficulte)
    difficulte = string.lower(difficulte)
    if difficulte == "tf" or difficulte == "tresfacile" then
     return "TF"
    elseif difficulte == "f" or difficulte == "facile" then
     return "F"
    elseif difficulte == "a" or difficulte == "accessible" then
     return "A"
    elseif difficulte == "i" or difficulte == "intermediaire" or difficulte == "intermédiaire" then
     return "I"
    elseif difficulte == "c" or difficulte == "complexe" then
     return "C"
    elseif difficulte == "d" or difficulte == "difficile" then
     return "D"
    elseif difficulte == "td" or difficulte == "tresdifficile" then
     return "TD"
    end
   end
   
   function GetLibelleDifficulte(difficulte)
    difficulte = string.lower(difficulte)
    if difficulte == "tf" or difficulte == "tresfacile" then
     return "Très Facile"
    elseif difficulte == "f" or difficulte == "facile" then
     return "Facile"
    elseif difficulte == "a" or difficulte == "accessible" then
     return "Accessible"
    elseif difficulte == "i" or difficulte == "intermediaire" or difficulte == "intermédiaire" then
     return "Intermédiaire"
    elseif difficulte == "c" or difficulte == "complexe" then
     return "Complexe"
    elseif difficulte == "d" or difficulte == "difficile" then
     return "Difficile"
    elseif difficulte == "td" or difficulte == "tresdifficile" then
     return "Très Difficile"
    end
   end
   
   function GetLibelleModificateurDifficulte(difficulte)
    difficulte = string.lower(difficulte)
    if difficulte == "tf" or difficulte == "tresfacile" then
     return "+60"
    elseif difficulte == "f" or difficulte == "facile" then
     return "+40"
    elseif difficulte == "a" or difficulte == "accessible" then
     return "+20"
    elseif difficulte == "i" or difficulte == "intermediaire" or difficulte == "intermédiaire" then
     return "0"
    elseif difficulte == "c" or difficulte == "complexe" then
     return "-10"
    elseif difficulte == "d" or difficulte == "difficile" then
     return "-20"
    elseif difficulte == "td" or difficulte == "tresdifficile" then
     return "-30"
    end
   end
   
   function GetLibelleModificateurAvantage(avantage)
    avantage = tonumber(avantage)
    if avantage <= 0 then
     return "+0"
    elseif avantage > 0 then
     return "+" .. avantage * 10
    end
   end

   function GetSeuilEffectif(seuil, modificateur)
    local seuilEffectif = seuil + modificateur
    if (seuilEffectif < 1 and true) then
     seuilEffectif = 1
    end
    return seuilEffectif
   end

   function GetDegresReussite(d100, seuil)
    local difference = (seuil - d100) / 10
    local degresReussite = 0
    if (difference > 0 and true) then
     degresReussite = math.floor(difference)
    elseif (difference < 0 and true) then
     degresReussite = math.ceil(difference)
    end
   
    degresReussite = degresReussite + GetExtraDR(seuil)
   
    return degresReussite
   end
   
   function GetExtraDR(seuilDeBase)
    local extraDR = 0
    if OptionDRSupplementairePourSeuilsSuperieursA100 then
     if (seuilDeBase > 100 and true) then
      extraDR = math.floor((seuilDeBase - 100) / 10)
     end
    else
     extraDR = 0
    end
    return extraDR
   end
   
   function GetLocalisationDegats(d100)
    if (d100 >= 1 and d100 <= 9) then
     return "Tête"
    elseif (d100 >= 10 and d100 <= 24) then
     return "Bras secondaire"
    elseif (d100 >= 25 and d100 <= 44) then
     return "Bras principal"
    elseif (d100 >= 45 and d100 <= 79) then
     return "Corps"
    elseif (d100 >= 80 and d100 <= 89) then
     return "Jambe gauche"
    elseif (d100 >= 90 and d100 <= 100) then
     return "Jambe droite"
    end
   end
   
   function GetLibelleLocalisationDegats(localisationDegats)
    local libelleLocalisationDegats = ""
    if localisationDegats == "Tête" then
     libelleLocalisationDegats = "à la Tête"
    elseif localisationDegats == "Bras secondaire" then
     libelleLocalisationDegats = "au niveau du Bras gauche (ou du bras secondaire)"
    elseif localisationDegats == "Bras principal" then
     libelleLocalisationDegats = "au niveau du Bras droit (ou du bras principal)"
    elseif localisationDegats == "Corps" then
     libelleLocalisationDegats = "au niveau du Corps"
    elseif localisationDegats == "Jambe gauche" then
     libelleLocalisationDegats = "au niveau de la Jambe gauche"
    elseif localisationDegats == "Jambe droite" then
     libelleLocalisationDegats = "au niveau de la Jambe droite"
    end
    return libelleLocalisationDegats
   end
   
   function GetLibelleEffetMaladresse(d100)
    if d100 >= 1 and d100 <= 20 then
     return "%s se blesse tout seul en attaquant, et perd un Point de Blessure sans tenir compte du Bonus d'Endurance ou des Points d'Armure."
    elseif d100 >= 21 and d100 <= 40 then
     return "L'arme de Corps-à-Corps de %s s'ébrèche salement, ou l'arme de tir à distance ne fonctionne pas ou se trouve sur le point de se briser. L'arme subit 1 point de Dégâts. Au prochain Round, %s agira en dernier sans tenir compte de l'ordre d'initiative, des talents ni de toute règle spéciale pendant que le porteur gère la situation."
    elseif d100 >= 41 and d100 <= 60 then
     return "%s a mal négocié sa manoeuvre, ce qui le met en mauvaise posture. Au cours du prochain round, votre action subira une pénalité de -10."
    elseif d100 >= 61 and d100 <= 70 then
     return "%s trébuche franchement et peine à se redresser, il perd son prochain Mouvement."
    elseif d100 >= 71 and d100 <= 80 then
     return "%s ne tient pas son arme correctement ou laisse tomber ses munitions, il perd sa prochaine Action."
    elseif d100 >= 81 and d100 <= 90 then
     return "%s effectue un mouvement trop ample ou trébuche et se tord la cheville, subissant un traumatisme [i]Déchirure musculaire (Mineure)[/i] comptant comme une Blessure critique."
    elseif d100 >= 91 and d100 <= 100 then
     return "%s manque complètement son attaque et touche un allié au hasard à distance en utilisant le chiffre des unités du lancer de dés pour déterminer le DR. Si personne n'est à distance, il se blesse tout seul et obtient l'État [i]Sonné[/i]."
    end
   end
   
   function GetLibelleEffetCoupCritiques(localisationDegats)
    local jet = rpg.roll.dice(2, 0, 9)
    local d1 = jet[1]
    local d2 = jet[2]
   
    local d100 = GetD100(d1, d2)
   
    local description = ""
    local ptsBlessure = 0
    local effetsSupplementaires = ""
   
    if localisationDegats == "Tête" then
     if d100 >= 1 and d100 <= 10 then
      description = "Blessure spectaculaire"
      ptsBlessure = 1
      effetsSupplementaires =
       "Une fine entaille qui va du front jusqu'à la joue. +1 État [i]Hémorragique[/i]. Une fois que la blessure est guérie, l'impressionnante cicatrice permet d'obtenir DR+1 à certains tests sociaux."
     elseif d100 >= 11 and d100 <= 20 then
      description = "Coupure mineure"
      ptsBlessure = 1
      effetsSupplementaires =
       "Le coup entaille la joue et le sang dégouline partout. +1 État [i]Hémorragique[/i]."
     elseif d100 >= 21 and d100 <= 25 then
      description = "Coup à l'oeil"
      ptsBlessure = 1
      effetsSupplementaires = "Le coup touche à l'orbite de l'oeil. +1 État [i]Aveuglé[/i]."
     elseif d100 >= 26 and d100 <= 30 then
      description = "Frappe à l'oreille"
      ptsBlessure = 1
      effetsSupplementaires =
       "Le coup touche à l'orbite de l'oreille et le personnage touché perçoit un bourdonnement ignoble. +1 État [i]Assourdi[/i]."
     elseif d100 >= 31 and d100 <= 35 then
      description = "Coup percutant"
      ptsBlessure = 2
      effetsSupplementaires =
       "Le sang obsurcit la vision du personnage touché, qui perçoit des points blancs et des flashs de lumière. +1 État [i]Sonné[/i]."
     elseif d100 >= 36 and d100 <= 40 then
      description = "Oeil au beurre noir"
      ptsBlessure = 2
      effetsSupplementaires =
       "C'est un coup massif au niveau des yeux, très douloureux. +2 États [i]Aveuglé[/i]."
     elseif d100 >= 41 and d100 <= 45 then
      description = "Oreille tranchée"
      ptsBlessure = 2
      effetsSupplementaires =
       "C'est un coup très violent sur le côté de la tête, qui entaille profondément l'oreille. +2 États [i]Assourdi[/i] et +1 État [i]Hémorragique[/i]."
     elseif d100 >= 46 and d100 <= 50 then
      description = "En plein front"
      ptsBlessure = 2
      effetsSupplementaires =
       "C'est un coup percutant en plein front. +2 États [i]Hémorragique[/i] et +1 État [i]Aveuglé[/i] qui ne peut être retiré tant que tous les États [i]Hémorragique[/i] n'ont pas été éliminés."
     elseif d100 >= 51 and d100 <= 55 then
      description = "Mâchoire fracturée"
      ptsBlessure = 3
      effetsSupplementaires =
       "Le coup fracture la mâchoire avec un bruit dégoûtant. Les vagues de douleur déferlent instantanément. +2 États [i]Sonné[/i] et subissez le Traumatisme [i]Fracture (Mineure)[/i]."
     elseif d100 >= 56 and d100 <= 60 then
      description = "Blessure majeure à l'oeil"
      ptsBlessure = 3
      effetsSupplementaires =
       "Le coup lézarde l'orbite. +1 État [i]Hémorragique[/i]. +1 État [i]Aveuglé[/i] qui ne pourra être soigné que lorsqu'on vous appliquera Aide Médicale."
     elseif d100 >= 61 and d100 <= 65 then
      description = "Blessure majeure à l'oreille"
      ptsBlessure = 3
      effetsSupplementaires =
       "Le coup endommage votre oreille, causant une perte auditive permanente. Vous subissez une pénalité de -20 à tout Test ayant un rapport avec l'audition. Si vous tombez une seconde fois sur cette blessure, vous perdez totalement l'audition car votre deuxième oreille devient elle aussi silencieuse. Ne peut être guéri que par la magie."
     elseif d100 >= 66 and d100 <= 70 then
      description = "Nez cassé"
      ptsBlessure = 3
      effetsSupplementaires =
       "Un coup violent porté au centre du visage déverse des flots de sang. +2 États [i]Hémorragique[/i]. Réussissez un Test de [b]Résistance Intermédiaire (+0)[/b] ou gagnez l'État [i]Sonné[/i]. Une fois cette blessure guérie, gagnez [b]DR+1/-1[/b] aux Tests Sociaux en fonction du contexte, jusqu'à ce que [b]Chirurgie[/b] soit utilisée sur le nez pour le réparer."
     elseif d100 >= 71 and d100 <= 75 then
      description = "Mâchoire cassée"
      ptsBlessure = 4
      effetsSupplementaires =
       "Le coup brise la mâchoire avec un bruit ignoble. +3 États [i]Sonné[/i]. Réussissez un Test de [b]Résistance Intermédiaire (+0)[/b] ou gagnez l'État [i]Inconscient[/i]. Subissez le Traumatisme [b]Fracture (Majeure)[/b]"
     elseif d100 >= 76 and d100 <= 80 then
      description = "Commotion cérébrale"
      ptsBlessure = 4
      effetsSupplementaires =
       "Le cerveau bouge à l'intérieur de la boîte crânienne, alors que le sang coule à flots du nez et des oreilles. +1 État [i]Assourdi[/i], +2 États [i]Hémorragique[/i] et +1D10 États [i]Sonné[/i]. +1 État [i]Exténué[/i] pour 1D10 jours. Si vous recevez une autre Blessure critique à la tête alors que vous êtes [i]Exténué[/i], réussissez un Test de [b]Résistance Accessible (+20)[/b] ou +1 État [i]Inconscient[/i]."
     elseif d100 >= 81 and d100 <= 85 then
      description = "Bouche explosée"
      ptsBlessure = 4
      effetsSupplementaires =
       "La bouche se remplit de sang et de dents cassées avec un bruit répugnant. +2 États [i]Hémorragique[/i]. Perdez 1D10 dents — [b]Amputation (Facile)[/b]."
     elseif d100 >= 86 and d100 <= 90 then
      description = "Oreille mutilée"
      ptsBlessure = 4
      effetsSupplementaires =
       "Il ne reste plus grand-chose de l'oreille après que le coup l'ait déchiquetée. +3 États [i]Assourdi[/i] et +2 États [i]Hémorragique[/i]. L'oreille est perdue — [b]Amputation (Accessible)[/b]"
     elseif d100 >= 91 and d100 <= 93 then
      description = "Œil crevé"
      ptsBlessure = 5
      effetsSupplementaires =
       "Le coup porté à l'œil le crève, provoquant une douleur quasi-insoutenable. +3 États [i]Aveuglé[/i], +2 États [i]Hémorragique[/i] et +1 États [i]Sonné[/i]. L'œil est perdu — [b]Amputation (Complexe)[/b]"
     elseif d100 >= 94 and d100 <= 96 then
      description = "Coup défigurant"
      ptsBlessure = 5
      effetsSupplementaires =
       "Le coup explose le visage, crevant un œil et brisant le nez. +3 États [i]Hémorragique[/i], +3 États [i]Aveuglé[/i] et +2 États [i]Sonné[/i]. L'œil et le nez sont perdus — [b]Amputation (Difficile)[/b]"
     elseif d100 >= 97 and d100 <= 99 then
      description = "Mâchoire mutilée"
      ptsBlessure = 5
      effetsSupplementaires =
       "Le coup arrache presque complètement la mâchoire, détruit la langue et envoie les dents à plusieurs mètres dans une pluie de sang. +4 États [i]Hémorragique[/i], +3 États [i]Sonné[/i]. Réussissez un Test de Résistance Très Difficile (-30) ou +1 État [i]Inconscient[/i]. Subissez le Traumatisme [b]Fracture (Majeure)[/b], la langue est perdue et 1D10 dents — [b]Amputation (Difficile)[/b]"
     elseif d100 == 100 then
      description = "Mort"
      ptsBlessure = 666
      effetsSupplementaires =
       "La tête est tranchée au niveau du cou et part dans les airs, atterrissant à 1D3 mètres du corps dans une direction aléatoire (voir [b]Dispersion[/b]). La mort est instantanée, et le corps s'effondre sans vie."
     end
    elseif localisationDegats == "Bras secondaire" or localisationDegats == "Bras principal" then
        if d100 >= 1 and d100 <= 10 then
            description = "Choc au bras"
            ptsBlessure = 1
            effetsSupplementaires =
             "Le bras " .. localisationDegats .. " de %s prend un choc au cours de l'attaque. %s lâche ce qu'il tenait."
           elseif d100 >= 11 and d100 <= 20 then
            description = "Coupure mineure"
            ptsBlessure = 1
            effetsSupplementaires =
             "%s saigne abondamment au niveau de l'avant-bras. +1 État [i]Hémorragique[/i]."
           elseif d100 >= 21 and d100 <= 25 then
            description = "Torsion"
            ptsBlessure = 1
            effetsSupplementaires = "%s se tord le bras, occasionnant +1 Traumatisme [i]Déchirure musculaire (Mineure)[/i]"
           elseif d100 >= 26 and d100 <= 30 then
            description = "Choc violent au bras"
            ptsBlessure = 2
            effetsSupplementaires =
             "%s reçoit un coup particulièrement violent au " .. localisationDegats .. " et lâche ce qu'il avait dans la main, cette dernière restant inutilisable pendant 1D10 - Bonus d'Endurance Rounds (minimum 1). Pendant ce temps, considérez votre main comme perdue (voir Membres Amputés, p180)."
           elseif d100 >= 31 and d100 <= 35 then
            description = "Déchirure musculaire"
            ptsBlessure = 2
            effetsSupplementaires =
             "Le coup écrase l'avant-bras du " .. localisationDegats .. " de %s. +1 État [i]Hémorragique[/i] et +1 Traumatisme [i]Déchirure musculaire (Mineure)[/i]."
           elseif d100 >= 36 and d100 <= 40 then
            description = "Main ensanglantée"
            ptsBlessure = 2
            effetsSupplementaires =
             "La main du " .. localisationDegats .. " de %s est bien entaillée. Le sang rend la prise glissante avec cette main. +1 État [i]Hémorragique[/i]. Test de [i]Dextérité (Accessible)[/i] pour effectuer toute action avec un objet dans la main, sinon il échappe des mains."
           elseif d100 >= 41 and d100 <= 45 then
            description = "Clef de bras"
            ptsBlessure = 2
            effetsSupplementaires =
             "L'articulation du " .. localisationDegats .. " de %s est pratiquement arrachée. La main correspondante lâche ce qu'elle tenait, le bras est inutilisable pendant 1D10 Rounds."
           elseif d100 >= 46 and d100 <= 50 then
            description = "Blessure béante"
            ptsBlessure = 3
            effetsSupplementaires =
             "Le coup ouvre une blessure béante. +2 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au " .. localisationDegats .. " redonnera +1 État [i]Hémorragique[/i], la blessure s'étant réouverte."
           elseif d100 >= 51 and d100 <= 55 then
            description = "Cassure nette"
            ptsBlessure = 3
            effetsSupplementaires =
             "Un craquement significatif se fait entendre au moment où le coup s'abat sur le " ..localisationDegats .. " de %s. La main correspondante lâche ce qu'elle tenait. +1 Traumatisme [i]Fracture (Mineure)[/i]. +1 État [i]Sonné[/i] en cas d'échec à un Test de [i]Résistance (Complexe)[/i]."
           elseif d100 >= 56 and d100 <= 60 then
            description = "Ligament rompu"
            ptsBlessure = 3
            effetsSupplementaires =
             "%s lâche immédiatement ce qu'il tenait dans la main de son " .. localisationDegats .. ". +1 Traumatisme [i]Déchirure musculaire (Majeure)[/i]"
           elseif d100 >= 61 and d100 <= 65 then
            description = "Coupure profonde"
            ptsBlessure = 3
            effetsSupplementaires =
             "+2 États [i]Hémorragique[/i] dûs à la forte mutilation du " .. localisationDegats .. " de %s. +1 État [i]Sonné[/i], +1 Traumatisme [i]Déchirure musculaire (Mineure)[/i], +1 État [i]Inconscient[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]."
           elseif d100 >= 66 and d100 <= 70 then
            description = "Artère endommagée"
            ptsBlessure = 4
            effetsSupplementaires =
             "+4 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au " .. localisationDegats .. " redonnera +2 État [i]Hémorragique[/i], la blessure s'étant réouverte."
           elseif d100 >= 71 and d100 <= 75 then
            description = "Coude fracassé"
            ptsBlessure = 4
            effetsSupplementaires =
             "Le coup fracasse le coude du " .. localisationDegats .. " de %s, faisant voler en éclats os et cartilage. %s lâche immédiatement ce qu'il tenait dans cette main, et subit +1 Traumatisme [i]Fracture (Majeure)[/i]"
           elseif d100 >= 76 and d100 <= 80 then
            description = "Épaule luxée"
            ptsBlessure = 4
            effetsSupplementaires =
             "Le " .. localisationDegats .. " de %s est démis de son logement. %s lâche immédiatement ce qu'il tenait dans cette main. +1 État [i]Sonné[/i] et +1 État [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]. État [i]Sonné[/i] conservé jusqu'à bénéficier d'Aide Médicale. Un Test Étendu de Guérison avec 6 DR est nécessaire pour recouvrer l'usage du bras. Les tests utilisant ce bras subissent une pénalité de -10 pendant 1D10 jours."
           elseif d100 >= 81 and d100 <= 85 then
            description = "Doigt sectionné"
            ptsBlessure = 4
            effetsSupplementaires =
             "%s voit un de ses doigts s'envoler. +1 États [i]Hémorragique[/i]. — [b]Amputation (Accessible)[/b]."
           elseif d100 >= 86 and d100 <= 90 then
            description = "Main ouverte"
            ptsBlessure = 5
            effetsSupplementaires =
             "La main du " .. localisationDegats .. " de %s s'ouvre sous la puissance du coup. Un Doigt est perdu — [b]Amputation (Complexe)[/b]. +2 États [i]Hémorragique[/i] et +1 État [i]Sonné[/i]. Pour chaque Round sans Aide Médicale, un autre Doigt est perdu. Si tous les doigts sont perdus, la main est perdue. — [b]Amputation (Complexe)[/b]"
           elseif d100 >= 91 and d100 <= 93 then
            description = "Biceps déchiqueté"
            ptsBlessure = 5
            effetsSupplementaires =
             "Le coup sépare presque entièrement le biceps et le tendon de l'os du " .. localisationDegats .. " de %s, laissant une blessure effrayante dont le sang gicle jusque sur son adversaire. %s lâche immédiatement ce qu'il tenait dans cette main. +1 Traumatisme [i]Déchirure musculaire (Majeure)[/i], +2 États [i]Hémorragique[/i] et +1 État [i]Sonné[/i]"
           elseif d100 >= 94 and d100 <= 96 then
            description = "Main mutilée"
            ptsBlessure = 5
            effetsSupplementaires =
             "La main du " .. localisationDegats .. " de %s n'est plus qu'un tas de chair hémorragique. La main est perdue — [b]Amputation (Difficile)[/b]. +2 États [i]Hémorragique[/i]. +1 État [i]Sonné[/i] et +1 État [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]"
           elseif d100 >= 97 and d100 <= 99 then
            description = "Tendons coupés"
            ptsBlessure = 5
            effetsSupplementaires =
             "Les tendons sont sectionnés par la force du coup et le ".. localisationDegats .. " de %s est inutilisable — [b]Amputation (Difficile)[/b]. +3 États [i]Hémorragique[/i], +1 État [i]À terre[/i], +1 État [i]Sonné[/i]. +1 État [i]Inconscient[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]. "
           elseif d100 == 100 then
            description = "Démembrement fatal"
            ptsBlessure = 666
            effetsSupplementaires =
             "Le " .. localisationDegats .. " de %s est coupé, faisant gicler le sang des artères jusqu'à 1D3 mètres dans une direction aléatoire (voir [b]Dispersion[/b]). La mort de %s est instantanée, et son corps s'effondre sans vie."
           end
    elseif localisationDegats == "Corps" then
        if d100 >= 1 and d100 <= 10 then
            description = "Rien qu'une égratignure !"
            ptsBlessure = 1
            effetsSupplementaires =
             "+1 État [i]Hémorragique[/i]."
           elseif d100 >= 11 and d100 <= 20 then
            description = "Coup au ventre"
            ptsBlessure = 1
            effetsSupplementaires =
             "+1 État [i]Sonné[/i]. +1 État [i]À terre[/i] et vomissement en cas d'échec à un Test de [i]Résistance (Facile)[/i]."
           elseif d100 >= 21 and d100 <= 25 then
            description = "Coup bas"
            ptsBlessure = 1
            effetsSupplementaires = "+3 États [i]Sonné[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]."
           elseif d100 >= 26 and d100 <= 30 then
            description = "Torsion du dos"
            ptsBlessure = 1
            effetsSupplementaires =
             "+1 Traumatisme [i]Déchirure musculaire (Mineure)[/i]"
           elseif d100 >= 31 and d100 <= 35 then
            description = "Souffle coupé"
            ptsBlessure = 2
            effetsSupplementaires =
             "+1 État [i]Sonné[/i]. +1 États [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Accessible)[/i]. Le mouvement de %s est réduit de moitié pendant 1D10 rounds, le temps de récupérer son souffle."
           elseif d100 >= 36 and d100 <= 40 then
            description = "Bleus aux côtes"
            ptsBlessure = 2
            effetsSupplementaires =
             "Tous les Tests basés sur l'Agilité sont effectués avec une pénalité de -10 pendant 1D10 jours."
           elseif d100 >= 41 and d100 <= 45 then
            description = "Clavicule tordue"
            ptsBlessure = 2
            effetsSupplementaires =
             "Choisissez un bras au hasard. La main correspondante lâche ce qu'elle tenait, et le bras reste inutilisable pendant 1D10 Rounds."
           elseif d100 >= 46 and d100 <= 50 then
            description = "Chairs déchirées"
            ptsBlessure = 2
            effetsSupplementaires =
             "+2 États [i]Hémorragique[/i]."
           elseif d100 >= 51 and d100 <= 55 then
            description = "Côtes fracturées"
            ptsBlessure = 3
            effetsSupplementaires =
             "Le coup fracture une ou plusieurs côtes. +1 État [i]Sonné[/i], +1 Traumatisme [i]Fracture (Mineure)[/i]."
           elseif d100 >= 56 and d100 <= 60 then
            description = "Blessure béante"
            ptsBlessure = 3
            effetsSupplementaires =
             "+3 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au " .. localisationDegats .. " redonnera +1 État [i]Hémorragique[/i], la blessure s'étant réouverte."
           elseif d100 >= 61 and d100 <= 65 then
            description = "Entaille douloureuse"
            ptsBlessure = 3
            effetsSupplementaires =
             "+2 États [i]Hémorragique[/i] et +1 État [i]Sonné[/i]. +1 États [i]Inconscient[/i] en cas d'échec à un Test Spectaculaire de [i]Résistance (Difficile)[/i], %s s'évanouissant sous l'effet de la douleur. Avec moins de 4DR, %s hurle de douleur."
           elseif d100 >= 66 and d100 <= 70 then
            description = "Dégâts artériels"
            ptsBlessure = 3
            effetsSupplementaires =
             "+4 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au " .. localisationDegats .. " redonnera +2 États [i]Hémorragique[/i], la blessure s'étant réouverte."
           elseif d100 >= 71 and d100 <= 75 then
            description = "Dos froissé"
            ptsBlessure = 4
            effetsSupplementaires =
             "Une douleur irradiante assaille %s lorsqu'il fait jouer les muscles de son dos. +1 Traumatisme [b]Déchirure musculaire (Majeure)[/b]"
           elseif d100 >= 76 and d100 <= 80 then
            description = "Hanche fracturée"
            ptsBlessure = 4
            effetsSupplementaires =
             "+1 État [i]Sonné[/i] et +1 Traumatisme [b]Fracture (Mineure)[/b]. +1 États [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Intermédiaire)[/i]."
           elseif d100 >= 81 and d100 <= 85 then
            description = "Blessure majeure au torse"
            ptsBlessure = 4
            effetsSupplementaires =
             "%s reçoit une blessure importante au torse, le coup arrache la peau, les muscles et les tendons. +4 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au torse redonnera +2 États [i]Hémorragique[/i], la blessure s'étant réouverte."
           elseif d100 >= 86 and d100 <= 90 then
            description = "Blessure au ventre"
            ptsBlessure = 4
            effetsSupplementaires =
             "+2 États [i]Hémorragique[/i], c'est une Blessure Purulente."
           elseif d100 >= 91 and d100 <= 93 then
            description = "Cage thoracique perforée"
            ptsBlessure = 5
            effetsSupplementaires =
             "+1 État [i]Sonné[/i] jusqu'à réception d'une Aide Médicale. +1 Traumatisme [b]Fracture (Majeure)[/b]."
           elseif d100 >= 94 and d100 <= 96 then
            description = "Clavicule cassée"
            ptsBlessure = 5
            effetsSupplementaires =
             "+1 État [i]Inconscient[/i] jusqu'à réception d'une Aide Médicale. +1 Traumatisme [b]Fracture (Majeure)[/b]."
           elseif d100 >= 97 and d100 <= 99 then
            description = "Hémorragie interne"
            ptsBlessure = 5
            effetsSupplementaires =
             "+1 État [i]Hémorragique[/i] jusqu'à réception d'une Chirurgie. %s contracte en outre une Infection Sanguine."
           elseif d100 == 100 then
            description = "Éventré"
            ptsBlessure = 666
            effetsSupplementaires =
             "%s est littéralement coupé en deux, tout personnage situé à moins de 2 mètres est recouvert de sang."
           end
    elseif localisationDegats == "Jambe gauche" or localisationDegats == "Jambe droite" then
     description = "Gluglu"
     ptsBlessure = 0
     effetsSupplementaires = "GLUGLU"
    end
   
    return d1, d2, description, ptsBlessure, effetsSupplementaires
   end
   
   function EvaluateTest(typetest, seuilBase, seuilEffectif, difficulte, d1, d2)
    typetest = string.lower(typetest)
    local syntheseResultat = ""
    if typetest == "simple" then
     if seuilEffectif and difficulte then
      local myheader =
       "Test Simple, difficulté " .. GetLibelleDifficulte(difficulte) .. ", maximum de " .. seuilEffectif
   
      local myrolls =
       "[" ..
       'div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]' ..
        d1 .. "[" .. "/div]"
      myrolls =
       myrolls ..
       "[" ..
        'div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]' ..
         d2 .. "[" .. "/div]"
      local d100 = GetD100(d1, d2)
      local succes = IsSuccess(d100, seuilEffectif)
      local critique = IsCritical(typetest, d1, d2)
      local libelleResultat = ""
      if succes == true then
       libelleResultat = "Succès"
      else
       libelleResultat = "Échec"
      end
   
      local libelleCritique = ""
      if critique == true then
       libelleCritique = "Critique"
      else
       libelleCritique = ""
      end
   
      local myresults =
       string.format("%d contre %d est un %s %s", d100, seuilEffectif, libelleResultat, libelleCritique)
      local myfooter = ""
      if succes and not critique then
       myfooter = string.format("L'action du personnage est [u]une réussite[/u].")
      elseif succes and critique then
       myfooter = string.format("L'action du personnage est [u]une réussite stupéfiante !![/u]")
      elseif not succes and not critique then
       myfooter = string.format("L'action du personnage est clairement [u]un échec[/u].")
      elseif not succes and critique then
       myfooter =
        string.format(
        "L'action du personnage est [u]un échec stupéfiant ![/u] Le personnage échoue lamentablement, tout est allé de travers et les conséquences de cet échec sont catastrophiques !"
       )
      end
   
      return rpg.smf.save(myheader, myrolls, myresults, myfooter, "wfrp4")
     end
    elseif typetest == "spectaculaire" then
     if seuilEffectif and difficulte then
      local myheader =
       "Test Spectaculaire, difficulté " ..
       GetLibelleDifficulte(difficulte) .. ", maximum de " .. seuilEffectif
      local myrolls =
       '[div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]' ..
       d1 .. "[/div]"
      myrolls =
       myrolls ..
       '[div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]' ..
        d2 .. "[/div]"
      local d100 = GetD100(d1, d2)
      local succes = IsSuccess(d100, seuilEffectif)
      local critique = IsCritical(typetest, d1, d2)
      local degresReussite = GetDegresReussite(d100, seuilEffectif)
      degresReussite = degresReussite + GetExtraDR(seuilBase)
      local libelleResultat = ""
      local libelleAmpleur = ""
      local libelleAction = ""
      if succes == true then
       if critique then
        syntheseResultat =
         string.format(
         "%d contre %d donne un Succès avec %d Degrés de Réussite, mais c'est surtout un jet Critique, obtenant ainsi un Succès Stupéfiant !",
         d100,
         seuilEffectif,
         degresReussite
        )
        libelleAction =
         "Grâce à ce jet de dés critique, l'action du personnage est un [u]Succès Stupéfiant[/u] ! Les résultats dépassent ce qu'il espérait, on n'aurait pas pu imaginer mieux !"
       else
        if degresReussite >= 6 then
         syntheseResultat =
          string.format(
          "%d contre %d donne un Succès avec %d Degrés de Réussite, ce qui est un [u]Succès Stupéfiant[/u] !",
          d100,
          seuilEffectif,
          degresReussite
         )
         libelleAction =
          "L'action du personnage est une [u]réussite stupéfiante[/u] ! Les résultats dépassent ce qu'il espérait, on n'aurait pas pu imaginer mieux !"
        elseif degresReussite == 4 or degresReussite == 5 then
         syntheseResultat =
          string.format(
          "%d contre %d donne un Succès avec %d Degrés de Réussite, ce qui est un [u]Succès Impressionnant[/u] !",
          d100,
          seuilEffectif,
          degresReussite
         )
         libelleAction =
          "L'action du personnage est [u]réussie avec style[/u] et les résultats sont absolument parfaits."
        elseif degresReussite == 2 or degresReussite == 3 then
         syntheseResultat =
          string.format(
          "%d contre %d donne un Succès avec %d Degrés de Réussite",
          d100,
          seuilEffectif,
          degresReussite
         )
         libelleAction = "L'action du personnage est [u]une réussite[/u]."
        elseif degresReussite == 0 or degresReussite == 1 then
         syntheseResultat =
          string.format(
          "%d contre %d est un Succès mais avec %d Degré de Réussite, c'est un [u]Succès Minime[/u]...",
          d100,
          seuilEffectif,
          degresReussite
         )
         libelleAction =
          "L'action du personnage est [u]plus ou moins réussie[/u], mais ce n'est pas parfait et des effets inattendus sont possibles."
        end
       end
      elseif succes == false then
       if critique then
        syntheseResultat =
         string.format(
         "%d contre %d donne un Échec avec %d Degrés de Réussite, mais c'est surtout un jet Critique, obtenant ainsi un Échec Stupéfiant !",
         d100,
         seuilEffectif,
         degresReussite
        )
        libelleAction =
         "L'action du personnage est [u]un Échec Stupéfiant ![/u] Le personnage échoue lamentablement, tout est allé de travers et les conséquences de cet échec sont catastrophiques !"
       else
        if degresReussite <= -6 then
         syntheseResultat =
          string.format(
          "%d contre %d donne un Échec avec %d Degrés de Réussite, ce qui est un [u]Échec Stupéfiant[/u] !",
          d100,
          seuilEffectif,
          degresReussite
         )
         libelleAction =
          "L'action du personnage est [u]un Échec Stupéfiant ![/u] Le personnage échoue lamentablement, tout est allé de travers et les conséquences de cet échec sont catastrophiques !"
        elseif degresReussite == -4 or degresReussite == -5 then
         syntheseResultat =
          string.format(
          "%d contre %d donne un Échec avec %d Degrés de Réussite, ce qui est un [u]Échec Impressionnant[/u] !",
          d100,
          seuilEffectif,
          degresReussite
         )
         libelleAction =
          "L'action du personnage est un [u]échec complet[/u], amenant même quelques conséquences collatérales négatives."
        elseif degresReussite == -2 or degresReussite == -3 then
         syntheseResultat =
          string.format(
          "%d contre %d donne un Échec avec %d Degrés de Réussite.",
          d100,
          seuilEffectif,
          degresReussite
         )
         libelleAction = "L'action du personnage est clairement [u]un échec[/u]."
        elseif degresReussite == 0 or degresReussite == -1 then
         syntheseResultat =
          string.format(
          "%d contre %d donne un Échec mais avec %d Degrés de Réussite, c'est un [u]Échec Minime[/u]...",
          d100,
          seuilEffectif,
          degresReussite
         )
         libelleAction =
          "L'action du personnage [u]échoue de peu[/u], avec peut-être des progrès mineurs ou la possibilité de retenter sa chance au prochain Round, si la situation s'y prête."
        end
       end
      end
   
      local myresults = syntheseResultat
      local myfooter = libelleAction
   
      return rpg.smf.save(myheader, myrolls, myresults, myfooter, "wfrp4")
     end
    else
     return rpg.smf.save("Type de test inconnu", "myrolls", "myresults", "myfooter", "wfrp4")
    end
   end
   







   function EvaluateTestOppose(
    protagoniste1,
    seuilBase1,
    seuilEffectif1,
    difficulte1,
    d1_1,
    d2_1,
    protagoniste2,
    seuilBase2,
    seuilEffectif2,
    difficulte2,
    d1_2,
    d2_2)
    local myheader = ""
   
    local libelleProtagoniste1 = protagoniste1 or "Protagoniste 1"
    local libelleProtagoniste2 = protagoniste2 or "Protagoniste 2"
   
    myheader = myheader .. '[div style="display: flex; color: white"]'
    myheader = myheader .. '[div style="display: flex; flex-direction: column; width: 100%"]'
    myheader =
     myheader .. '[span style="font-size: 1.2em; font-weight: bold; text-align: center; padding-bottom: 10px"]'
    myheader = myheader .. "Test Opposé"
    myheader = myheader .. "[/span]"
    myheader = myheader .. '[div style="display: flex; width: 100%"]'
    myheader = myheader .. '[div style="display: flex; flex-direction: column; flex-grow: 1; align-items: center"]'
    myheader = myheader .. '[div style="display: flex; font-weight: bold"]'
    myheader = myheader .. libelleProtagoniste1
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader = myheader .. "Seuil de base : " .. seuilBase1
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader =
     myheader ..
     "Difficulté " ..
      GetLibelleDifficulte(difficulte1) .. " (" .. GetLibelleModificateurDifficulte(difficulte1) .. ")"
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader = myheader .. "Maximum : " .. seuilEffectif1
    myheader = myheader .. "[/div]"
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[hr style="border: color; margin: 5px"]'
    myheader = myheader .. '[div style="display: flex; flex-direction: column; flex-grow: 1; align-items: center"]'
    myheader = myheader .. '[div style="display: flex; font-weight: bold"]'
    myheader = myheader .. libelleProtagoniste2
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader = myheader .. "Seuil de base : " .. seuilBase2
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader =
     myheader ..
     "Difficulté " ..
      GetLibelleDifficulte(difficulte2) .. " (" .. GetLibelleModificateurDifficulte(difficulte2) .. ")"
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader = myheader .. "Maximum : " .. seuilEffectif2
    myheader = myheader .. "[/div]"
    myheader = myheader .. "[/div]"
    myheader = myheader .. "[/div]"
    myheader = myheader .. "[/div]"
    myheader = myheader .. "[/div]"
   
    local myrolls = ""
    myrolls = myrolls .. '[div style="display: flex"]'
    myrolls = myrolls .. '[div style="display: flex; flex-grow: 1; justify-content: center"]'
    myrolls =
     myrolls ..
     '[div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
    myrolls = myrolls .. d1_1
    myrolls = myrolls .. "[/div]"
    myrolls =
     myrolls ..
     '[div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
    myrolls = myrolls .. d2_1
    myrolls = myrolls .. "[/div]"
    myrolls = myrolls .. "[/div]"
    myrolls = myrolls .. '[hr style="border: color; margin: 5px"]'
    myrolls = myrolls .. '[div style="display: flex; flex-grow: 1; justify-content: center"]'
    myrolls =
     myrolls ..
     '[div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
    myrolls = myrolls .. d1_2
    myrolls = myrolls .. "[/div]"
    myrolls =
     myrolls ..
     '[div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
    myrolls = myrolls .. d2_2
    myrolls = myrolls .. "[/div]"
    myrolls = myrolls .. "[/div]"
    myrolls = myrolls .. "[/div]"
   
    local d100_1 = GetD100(d1_1, d2_1)
    local d100_2 = GetD100(d1_2, d2_2)
   
    local succes1 = IsSuccess(d100_1, seuilEffectif1)
    local succes2 = IsSuccess(d100_2, seuilEffectif2)
    local critique1 = IsCritical("oppose", d1_1, d2_1)
    local critique2 = IsCritical("oppose", d1_2, d2_2)
    local degresReussite1 = GetDegresReussite(d100_1, seuilEffectif1)
    local degresReussite2 = GetDegresReussite(d100_2, seuilEffectif2)
    local libelleResultat1 = ""
    local libelleResultat2 = ""
    local syntheseResultat1 = ""
    local syntheseResultat2 = ""
    local libelleAmpleur1 = ""
    local libelleAmpleur2 = ""
    local libelleAction1 = ""
    local libelleAction2 = ""
   
    if critique1 then
     libelleAmpleur1 = "Critique"
     if (degresReussite1 >= 0 and degresReussite1 < 6) then
      degresReussite1 = 6
     elseif (degresReussite1 <= 0 and degresReussite1 > -6) then
      degresReussite1 = -6
     end
    end
   
    if critique2 then
     libelleAmpleur2 = "Critique"
     if (degresReussite2 >= 0 and degresReussite2 < 6) then
      degresReussite2 = 6
     elseif (degresReussite2 <= 0 and degresReussite2 > -6) then
      degresReussite2 = -6
     end
    end
   
    degresReussite1 = degresReussite1 + GetExtraDR(seuilBase1)
    degresReussite2 = degresReussite2 + GetExtraDR(seuilBase2)
   
    if succes1 then
     libelleResultat1 = "Succès"
    else
     libelleResultat1 = "Échec"
    end
   
    if succes2 then
     libelleResultat2 = "Succès"
    else
     libelleResultat2 = "Échec"
    end
   
    syntheseResultat1 =
     string.format("%s %s[br/]avec [u]%d Degrés de Réussite[/u]", libelleResultat1, libelleAmpleur1, degresReussite1)
    syntheseResultat2 =
     string.format("%s %s[br/]avec [u]%d Degrés de Réussite[/u]", libelleResultat2, libelleAmpleur2, degresReussite2)
   
    local myresults = ""
   
    myresults = myresults .. '[div style="display: flex"]'
    myresults = myresults .. '[div style="display: flex; flex-grow: 1; justify-content: center"]'
    myresults = myresults .. '[span class="" style="color: white"]'
    myresults = myresults .. syntheseResultat1
    myresults = myresults .. "[/span]"
    myresults = myresults .. "[/div]"
    myresults = myresults .. '[hr style="border: color; margin: 5px"]'
    myresults = myresults .. '[div style="display: flex; flex-grow: 1; justify-content: center"]'
    myresults = myresults .. '[span class="" style="color: white"]'
    myresults = myresults .. syntheseResultat2
    myresults = myresults .. "[/span]"
    myresults = myresults .. "[/div]"
    myresults = myresults .. "[/div]"
   
    local vainqueur = ""
    local perdant = ""
   
    local libelleAction = ""

    if (degresReussite1 > degresReussite2 and true) then
     libelleAction =
      string.format(
      "[u]%s remporte le Test[/u][br/]avec %d Degrés de Réussite d'écart.",
      libelleProtagoniste1,
      degresReussite1 - degresReussite2
     )
     vainqueur = libelleProtagoniste1
     perdant = libelleProtagoniste2
    elseif (degresReussite1 < degresReussite2 and true) then
     libelleAction =
      string.format(
      "[u]%s remporte le Test[/u][br/]avec %d Degrés de Réussite d'écart.",
      libelleProtagoniste2,
      degresReussite2 - degresReussite1
     )
     vainqueur = libelleProtagoniste2
     perdant = libelleProtagoniste1
    elseif (degresReussite1 == degresReussite2 and true) then
     if succes1 and not succes2 then
      libelleAction =
       string.format("[u]%s remporte le Test[/u], départagé par le Succès du lancer", libelleProtagoniste1)
      vainqueur = libelleProtagoniste1
      perdant = libelleProtagoniste2
     elseif succes2 and not succes1 then
      libelleAction =
       string.format("[u]%s remporte le Test[/u], départagé par le Succès du lancer.", libelleProtagoniste2)
      vainqueur = libelleProtagoniste2
      perdant = libelleProtagoniste1
     elseif (succes1 and succes1) or (not succes1 and not succes2) then
      if seuilEffectif1 > seuilEffectif2 then
       libelleAction =
        string.format(
        "[u]%s remporte le Test de peu[/u], départagé par le Seuil du Test.",
        libelleProtagoniste1
       )
       vainqueur = libelleProtagoniste1
       perdant = libelleProtagoniste2
      elseif (seuilEffectif1 < seuilEffectif2 and true) then
       libelleAction =
        string.format("[u]%s remporte le Test[/u], départagé par le Seuil du Test.", libelleProtagoniste2)
       vainqueur = libelleProtagoniste2
       perdant = libelleProtagoniste1
      elseif (seuilEffectif1 == seuilEffectif2 and true) then
       if seuilBase1 > seuilBase2 then
        libelleAction =
         string.format(
         "[u]%s remporte le Test[/u], départagé par le Score de compétence.",
         libelleProtagoniste1
        )
        vainqueur = libelleProtagoniste1
        perdant = libelleProtagoniste2
       elseif (seuilBase1 < seuilBase2 and true) then
        libelleAction =
         string.format(
         "[u]%s remporte le Test[/u], départagé par le Score de compétence.",
         libelleProtagoniste2
        )
        vainqueur = libelleProtagoniste2
        perdant = libelleProtagoniste1
       elseif (seuilBase1 == seuilBase2 and true) then
        if (d100_1 < d100_2 and true) then
         libelleAction =
          string.format(
          "[u]%s remporte le Test[/u], départagé par le Lancer de dé.",
          libelleProtagoniste1
         )
         vainqueur = libelleProtagoniste1
         perdant = libelleProtagoniste2
        elseif (d100_1 > d100_1 and true) then
         libelleAction =
          string.format(
          "[u]%s remporte le Test[/u], départagé par le Lancer de dé.",
          libelleProtagoniste2
         )
         vainqueur = libelleProtagoniste2
         perdant = libelleProtagoniste1
        elseif (d100_1 == d100_2 and true) then
         libelleAction =
          string.format("[u]Aucun protagoniste ne remporte le Test, c'est une égalité parfaite[/u].")
        end
       end
      end
     end
    end
    local libelleActionBis = ""
    if succes1 and succes2 then
     libelleActionBis =
      libelleActionBis ..
      string.format(
       "Les deux protagonistes ont réussi, mais %s a tout de même pris le dessus sur %s.",
       vainqueur,
       perdant
      )
    elseif (succes1 and not succes2) or (succes2 and not succes1) then
     libelleActionBis =
      libelleActionBis ..
      string.format("Le résultat est clair, sans ambigüité : %s a réussi et %s a échoué.", vainqueur, perdant)
    elseif not succes1 and not succes2 then
     libelleActionBis =
      libelleActionBis .. "Toutefois, les deux protagonistes ont échoué, quel duel de bras cassés !"
    end
   
    local myfooter = ""
   
    myfooter = myfooter .. '[hr style="border: color; margin: 5px; "]'
    myfooter = myfooter .. '[div style="display: flex;margin-top: 10px"]'
    myfooter = myfooter .. '[div style="display: flex; flex-grow: 1; justify-content: center"]'
    myfooter = myfooter .. '[div style="color: white"]'
    myfooter =
     myfooter ..
     '[div style="color: white; font-size: 1.2em; font-weight: bold; padding-bottom:5px; line-height: 1.4em"]' ..
      libelleAction .. "[/div]"
    myfooter =
     myfooter .. '[div style="color: white; font-weight: bold; padding-top:5px"]' .. libelleActionBis .. "[/div]"
    myfooter = myfooter .. "[/div]"
    myfooter = myfooter .. "[/div]"
    myfooter = myfooter .. "[/div]"
   
    return rpg.smf.save(myheader, myrolls, myresults, myfooter, "wfrp4")
   end
   
   function EvaluateTestCorpsACorps(
    protagoniste1,
    seuilBase1,
    seuilEffectif1,
    difficulte1,
    avantage1,
    d1_1,
    d2_1,
    bonusForce1,
    protagoniste2,
    seuilBase2,
    seuilEffectif2,
    difficulte2,
    avantage2,
    d1_2,
    d2_2)
    local myheader = ""
    local libelleProtagoniste1 = protagoniste1 or "Protagoniste 1"
    local libelleProtagoniste2 = protagoniste2 or "Protagoniste 2"
    local syntheseResultat = ""
    myheader = myheader .. '[div style="display: flex; color: white"]'
    myheader = myheader .. '[div style="display: flex; flex-direction: column; width: 100%"]'
    myheader =
     myheader .. '[span style="font-size: 1.2em; font-weight: bold; text-align: center; padding-bottom: 10px"]'
    myheader = myheader .. "Attaque au Corps-à-Corps"
    myheader = myheader .. "[/span]"
    myheader = myheader .. '[div style="display: flex; width: 100%"]'
    myheader = myheader .. '[div style="display: flex; flex-direction: column; flex-grow: 1; align-items: center"]'
    myheader = myheader .. '[div style="display: flex; font-weight: bold"]'
    myheader = myheader .. "Attaquant"
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex; font-weight: bold"]'
    myheader = myheader .. libelleProtagoniste1
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader = myheader .. "Seuil de base : " .. seuilBase1
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader =
     myheader ..
     "Difficulté " ..
      GetLibelleDifficulte(difficulte1) .. " (" .. GetLibelleModificateurDifficulte(difficulte1) .. ")"
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader = myheader .. avantage1 .. " Avantages (" .. GetLibelleModificateurAvantage(avantage1) .. ")"
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader = myheader .. "Seuil effectif : " .. seuilEffectif1
    myheader = myheader .. "[/div]"
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[hr style="border: color; margin: 5px"]'
    myheader = myheader .. '[div style="display: flex; flex-direction: column; flex-grow: 1; align-items: center"]'
    myheader = myheader .. '[div style="display: flex; font-weight: bold"]'
    myheader = myheader .. "Défenseur"
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex; font-weight: bold"]'
    myheader = myheader .. libelleProtagoniste2
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader = myheader .. "Seuil de base : " .. seuilBase2
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader =
     myheader ..
     "Difficulté " ..
      GetLibelleDifficulte(difficulte2) .. " (" .. GetLibelleModificateurDifficulte(difficulte2) .. ")"
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader = myheader .. avantage2 .. " Avantages (" .. GetLibelleModificateurAvantage(avantage2) .. ")"
    myheader = myheader .. "[/div]"
    myheader = myheader .. '[div style="display: flex"]'
    myheader = myheader .. "Seuil effectif : " .. seuilEffectif2
    myheader = myheader .. "[/div]"
    myheader = myheader .. "[/div]"
    myheader = myheader .. "[/div]"
    myheader = myheader .. "[/div]"
    myheader = myheader .. "[/div]"
   
    local myrolls = ""
    myrolls = myrolls .. '[div style="display: flex"]'
    myrolls = myrolls .. '[div style="display: flex; flex-grow: 1; justify-content: center"]'
    myrolls =
     myrolls ..
     '[div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
    myrolls = myrolls .. d1_1
    myrolls = myrolls .. "[/div]"
    myrolls =
     myrolls ..
     '[div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
    myrolls = myrolls .. d2_1
    myrolls = myrolls .. "[/div]"
    myrolls = myrolls .. "[/div]"
    myrolls = myrolls .. '[hr style="border: color; margin: 5px"]'
    myrolls = myrolls .. '[div style="display: flex; flex-grow: 1; justify-content: center"]'
    myrolls =
     myrolls ..
     '[div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
    myrolls = myrolls .. d1_2
    myrolls = myrolls .. "[/div]"
    myrolls =
     myrolls ..
     '[div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]'
    myrolls = myrolls .. d2_2
    myrolls = myrolls .. "[/div]"
    myrolls = myrolls .. "[/div]"
    myrolls = myrolls .. "[/div]"
   
    local d100_1 = GetD100(d1_1, d2_1)
    local d100_2 = GetD100(d1_2, d2_2)
   
    local succes1 = IsSuccess(d100_1, seuilEffectif1)
    local succes2 = IsSuccess(d100_2, seuilEffectif2)
    local critique1 = IsCritical("corps-a-corps", d1_1, d2_1)
    local critique2 = IsCritical("corps-a-corps", d1_2, d2_2)
    local degresReussite1 = GetDegresReussite(d100_1, seuilEffectif1)
    local degresReussite2 = GetDegresReussite(d100_2, seuilEffectif2)
   
    local libelleResultat1 = ""
    local libelleResultat2 = ""
   
    local libelleAmpleur1 = ""
    local libelleAmpleur2 = ""
   
    local syntheseResultat1 = ""
    local syntheseResultat2 = ""

    local libelleAction = ""
    local libelleAction1 = ""
    local libelleAction2 = ""
   
    if critique1 then
     libelleAmpleur1 = "Critique"
    end
   
    if critique2 then
     libelleAmpleur2 = "Critique"
    end
   
    degresReussite1 = degresReussite1 + GetExtraDR(seuilBase1)
    degresReussite2 = degresReussite2 + GetExtraDR(seuilBase2)
   
    if succes1 then
     libelleResultat1 = "Succès"
    else
     libelleResultat1 = "Échec"
    end
   
    if succes2 then
     libelleResultat2 = "Succès"
    else
     libelleResultat2 = "Échec"
    end
   
    syntheseResultat1 =
     string.format("%s %s[br/]avec [u]%d Degrés de Réussite[/u]", libelleResultat1, libelleAmpleur1, degresReussite1)
    syntheseResultat2 =
     string.format("%s %s[br/]avec [u]%d Degrés de Réussite[/u]", libelleResultat2, libelleAmpleur2, degresReussite2)
   
    local myresults = ""
   
    myresults = myresults .. '[div style="display: flex"]'
    myresults = myresults .. '[div style="display: flex; flex-grow: 1; justify-content: center"]'
    myresults = myresults .. '[span class="" style="color: white"]'
    myresults = myresults .. syntheseResultat1
    myresults = myresults .. "[/span]"
    myresults = myresults .. "[/div]"
    myresults = myresults .. '[hr style="border: color; margin: 5px"]'
    myresults = myresults .. '[div style="display: flex; flex-grow: 1; justify-content: center"]'
    myresults = myresults .. '[span class="" style="color: white"]'
    myresults = myresults .. syntheseResultat2
    myresults = myresults .. "[/span]"
    myresults = myresults .. "[/div]"
    myresults = myresults .. "[/div]"
   
    local vainqueur = ""
    local perdant = ""
    local localisationDegats1 = ""
    local localisationDegats2 = ""
    local libelleDegats1 = ""
    local libelleDegats2 = ""
   
    local ptsBlessureCritique1 = 0
    local ptsBlessureCritique2 = 0
    local effetsSupplementairesCritique1 = ""
    local effetsSupplementairesCritique2 = ""

    local d1_1_critique = 0
    local d2_1_critique = 0

    local d1_2_critique = 0
    local d2_2_critique = 0

    if critique1 then
     localisationDegats1 = GetLocalisationDegats(rpg.roll.dice(1, 1, 100)[1])
   
     libelleDegats1 = GetLibelleEffetCoupCritiques(localisationDegats1)
     d1_1_critique, d2_1_critique, libelleDegats1, ptsBlessureCritique1, effetsSupplementairesCritique1 =
      GetLibelleEffetCoupCritiques(localisationDegats1)
    else
     localisationDegats1 = GetLocalisationDegats(d100_1)
     libelleDegats1 = GetLibelleLocalisationDegats(localisationDegats1)
    end
    if critique2 then
     localisationDegats2 = GetLocalisationDegats(rpg.roll.dice(1, 1, 100)[1])
     d1_2_critique, d2_2_critique, libelleDegats2, ptsBlessureCritique2, effetsSupplementairesCritique2 =
      GetLibelleEffetCoupCritiques(localisationDegats2)
    end
   
   
    if (succes1 and critique1) then
   
     libelleAction1 = libelleAction1 ..
      string.format(
      "[u]%s porte un Coup Critique[/u] touchant %s avec pour effet [b]%s[/b]. Le coup outrepasse l'armure éventuelle, et occasionne directement %d Dégâts, avec des effets supplémentaires : %s",
      libelleProtagoniste1,
      libelleProtagoniste2,
      libelleDegats1,
      ptsBlessureCritique1,
      effetsSupplementairesCritique1
     )
    end
    if (succes2 and critique2) then
      libelleAction2 = libelleAction2 ..
       string.format(
       "[u]En se défendant de l'attaque de %s, %s réussit un Coup Critique[/u] avec pour effet [b]%s[/b]. Le coup outrepasse l'armure éventuelle, et occasionne directement %d Dégâts, avec des effets supplémentaires : %s",
       libelleProtagoniste1,
       libelleProtagoniste2,
       libelleDegats2,
       ptsBlessureCritique2,
       effetsSupplementairesCritique2
      )
    end
   
    libelleAction = libelleAction1 .. "[br/]" .. libelleAction2 .. "[br/]"
   
    if (degresReussite1 > degresReussite2 and true) then
     libelleAction = libelleAction ..
      string.format(
      "[u]%s attaque avec succès[/u] et touche %s %s. Il occasionne des Dégâts à hauteur de %d DR + %d ",
      libelleProtagoniste1,
      libelleProtagoniste2,
      libelleDegats1,
      degresReussite1 - degresReussite2,
      bonusForce1
     )
     vainqueur = libelleProtagoniste1
     perdant = libelleProtagoniste2
    elseif (degresReussite1 < degresReussite2 and true) then
     libelleAction = libelleAction ..
      string.format(
      "[u]%s remporte le Test[/u][br/]avec %d Degrés de Réussite d'écart.",
      libelleProtagoniste2,
      degresReussite2 - degresReussite1
     )
     vainqueur = libelleProtagoniste2
     perdant = libelleProtagoniste1
    elseif (degresReussite1 == degresReussite2 and true) then
     if succes1 and not succes2 then
      libelleAction = libelleAction ..
       string.format("[u]%s remporte le Test[/u], départagé par le Succès du lancer", libelleProtagoniste1)
      vainqueur = libelleProtagoniste1
      perdant = libelleProtagoniste2
     elseif succes2 and not succes1 then
      libelleAction = libelleAction ..
       string.format("[u]%s remporte le Test[/u], départagé par le Succès du lancer.", libelleProtagoniste2)
      vainqueur = libelleProtagoniste2
      perdant = libelleProtagoniste1
     elseif (succes1 and succes1) or (not succes1 and not succes2) then
      if (seuilEffectif1 > seuilEffectif2 and true) then
       libelleAction = libelleAction ..
        string.format(
        "[u]%s remporte le Test de peu[/u], départagé par le Seuil du Test.",
        libelleProtagoniste1
       )
       vainqueur = libelleProtagoniste1
       perdant = libelleProtagoniste2
      elseif (seuilEffectif1 < seuilEffectif2 and true) then
       libelleAction = libelleAction ..
        string.format("[u]%s remporte le Test[/u], départagé par le Seuil du Test.", libelleProtagoniste2)
       vainqueur = libelleProtagoniste2
       perdant = libelleProtagoniste1
      elseif (seuilEffectif1 == seuilEffectif2 and true) then
       if seuilBase1 > seuilBase2 then
        libelleAction = libelleAction ..
         string.format(
         "[u]%s remporte le Test[/u], départagé par le Score de compétence.",
         libelleProtagoniste1
        )
        vainqueur = libelleProtagoniste1
        perdant = libelleProtagoniste2
       elseif (seuilBase1 < seuilBase2 and true) then
        libelleAction = libelleAction ..
         string.format(
         "[u]%s remporte le Test[/u], départagé par le Score de compétence.",
         libelleProtagoniste2
        )
        vainqueur = libelleProtagoniste2
        perdant = libelleProtagoniste1
       elseif (seuilBase1 == seuilBase2 and true) then
        if (d100_1 < d100_2 and true) then
         libelleAction = libelleAction ..
          string.format(
          "[u]%s remporte le Test[/u], départagé par le Lancer de dé.",
          libelleProtagoniste1
         )
         vainqueur = libelleProtagoniste1
         perdant = libelleProtagoniste2
        elseif (d100_1 > d100_2 and true) then
         libelleAction = libelleAction ..
          string.format(
          "[u]%s remporte le Test[/u], départagé par le Lancer de dé.",
          libelleProtagoniste2
         )
         vainqueur = libelleProtagoniste2
         perdant = libelleProtagoniste1
        elseif (d100_1 == d100_2 and true) then
         libelleAction = libelleAction ..
          string.format("[u]Aucun protagoniste ne remporte le Test, c'est une égalité parfaite[/u].")
        end
       end
      end
     end
    end
    local libelleActionBis = ""
    if succes1 and succes2 then
     libelleActionBis =
      libelleActionBis ..
      string.format(
       "Les deux protagonistes ont réussi, mais %s a tout de même pris le dessus sur %s.",
       vainqueur,
       perdant
      )
    elseif (succes1 and not succes2) or (succes2 and not succes1) then
     libelleActionBis =
      libelleActionBis ..
      string.format("Le résultat est clair, sans ambigüité : %s a réussi et %s a échoué.", vainqueur, perdant)
    elseif not succes1 and not succes2 then
     libelleActionBis =
      libelleActionBis .. "Toutefois, les deux protagonistes ont échoué, quel duel de bras cassés !"
    end
   
    local myfooter = ""
   
    myfooter = myfooter .. '[hr style="border: color; margin: 5px; "]'
    myfooter = myfooter .. '[div style="display: flex;margin-top: 10px"]'
    myfooter = myfooter .. '[div style="display: flex; flex-grow: 1; justify-content: center"]'
    myfooter = myfooter .. '[div style="color: white"]'
    myfooter =
     myfooter ..
     '[div style="color: white; font-size: 1.2em; font-weight: bold; padding-bottom:5px; line-height: 1.4em"]' ..
      libelleAction .. "[/div]"
    myfooter =
     myfooter .. '[div style="color: white; font-weight: bold; padding-top:5px"]' .. libelleActionBis .. "[/div]"
    myfooter = myfooter .. "[/div]"
    myfooter = myfooter .. "[/div]"
    myfooter = myfooter .. "[/div]"
   
    return rpg.smf.save(myheader, myrolls, myresults, myfooter, "wfrp4")
   end
   
   function rpg.accel.test(s)
    local rolls, myheader = rpg.smf.striptitle(s)
    local typetest = string.match(s, "([%w%p]*)[%s]*")
    typetest = tostring(typetest) or ""
    local resultatTest
    if ((typetest == "simple" or typetest == "spectaculaire") and true) then
     local seuilBase, difficulte = string.match(s, "%w*[%s]*(%d*)[%s]*(%w*)[%s]*")
   
     seuilBase = tonumber(seuilBase) or nil
     difficulte = GetCodeDifficulte(tostring(difficulte) or "")
     local modificateurDifficulte = GetModificateurDifficulte(difficulte)
     local seuilEffectif = GetSeuilEffectif(seuilBase, modificateurDifficulte)
     local jets = rpg.roll.dice(2, 0, 9)
     local d1 = jets[1]
     local d2 = jets[2]
     local succes = IsSuccess(GetD100(d1, d2), seuilEffectif)
     local echec = IsFailure(GetD100(d1, d2), seuilEffectif)
     local critique = IsCritical(typetest, d1, d2)
     resultatTest = EvaluateTest(typetest, seuilBase, seuilEffectif, difficulte, d1, d2)
    elseif (typetest == "oppose" and true) then
     local protagoniste1, seuilBase1, difficulte1, protagoniste2, seuilBase2, difficulte2 =
      string.match(s, "%w*[%s]+([%w%p]*)[%s]+(%d+)[%s]+([%w]*)[%s]*/[%s]*([%w%p]+)[%s]*(%d+)[%s]*([%w]*)")
   
     seuilBase1 = tonumber(seuilBase1) or nil
     seuilBase2 = tonumber(seuilBase2) or nil
     if (difficulte1 == "" and true) then
      difficulte1 = "I"
     end
     if (difficulte2 == "" and true) then
      difficulte2 = "I"
     end
   
     difficulte1 = GetCodeDifficulte(difficulte1)
     difficulte2 = GetCodeDifficulte(difficulte2)
   
     local modificateurDifficulte1 = GetModificateurDifficulte(difficulte1)
     local modificateurDifficulte2 = GetModificateurDifficulte(difficulte2)
   
     local seuilEffectif1 = GetSeuilEffectif(seuilBase1, modificateurDifficulte1)
     local seuilEffectif2 = GetSeuilEffectif(seuilBase2, modificateurDifficulte2)
   
     local jets1 = rpg.roll.dice(2, 0, 9)
     local jets2 = rpg.roll.dice(2, 0, 9)
   
     local d1_1 = jets1[1]
     local d1_2 = jets2[1]
   
     local d2_1 = jets1[2]
     local d2_2 = jets2[2]
   
     local succes1 = IsSuccess(GetD100(d1_1, d2_1), seuilEffectif1)
     local succes2 = IsSuccess(GetD100(d1_2, d2_2), seuilEffectif2)
   
     local echec1 = IsFailure(GetD100(d1_1, d2_1), seuilEffectif1)
     local echec2 = IsFailure(GetD100(d1_2, d2_2), seuilEffectif2)
   
     local critique1 = IsCritical(typetest, d1_1, d2_1)
     local critique2 = IsCritical(typetest, d1_2, d2_2)
   
     resultatTest = EvaluateTestOppose(
      protagoniste1,
      seuilBase1,
      seuilEffectif1,
      difficulte1,
      d1_1,
      d2_1,
      protagoniste2,
      seuilBase2,
      seuilEffectif2,
      difficulte2,
      d1_2,
      d2_2
     )
    elseif (typetest == "corps-a-corps" and true) then
   
     local protagoniste1, seuilBase1, difficulte1, avantage1, bonusForce1 =
      string.match(s, "%w*[%s]+([%w%p]*)[%s]+(%d+)[%s]+([%w]*)[%s]*(%d*)A[%s]*(%d*)BF[%s]*.*/.*")
   
     local atoutEnroulement = string.match(s, ".*Enroulement.*/")
     atoutEnroulement = atoutEnroulement ~= nil
   
     local atoutPoudre = string.match(s, ".*(Poudre).*/")
     atoutPoudre = atoutPoudre ~= nil
   
   
     local atoutAssommante = string.match(s, ".*(Assommante).*/")
     atoutAssommante = atoutAssommante ~= nil
     print("atoutAssommante", atoutAssommante)
   
     local atoutDefensive = string.match(s, ".*(Défensive).*/")
     atoutDefensive = atoutDefensive ~= nil
     print("atoutDefensive", atoutDefensive)
   
     local atoutDevastatrice = string.match(s, ".*(Dévastatrice).*/")
     atoutDevastatrice = atoutDevastatrice ~= nil
     print("atoutDevastatrice", atoutDevastatrice)
   
     local atoutEmpaleuse = string.match(s, ".*(Empaleuse).*/")
     atoutEmpaleuse = atoutEmpaleuse ~= nil
     print("atoutEmpaleuse", atoutEmpaleuse)
   
     local atoutExplosion = string.match(s, ".*Explosion.*/")
     atoutExplosion = atoutExplosion ~= nil
     print("atoutExplosion", atoutExplosion)
   
     local indiceAtoutExplosion = string.match(s, ".*Explosion(%d*).*/")
     -- indiceAtoutExplosion = indiceAtoutExplosion
     print("indiceAtoutExplosion", indiceAtoutExplosion)
   
     local atoutImmobilisante = string.match(s, ".*(Immobilisante).*/")
     atoutImmobilisante = atoutImmobilisante ~= nil
     print("atoutImmobilisante", atoutImmobilisante)
   
     local atoutIncassable = string.match(s, ".*(Incassable).*/")
     atoutIncassable = atoutIncassable ~= nil
     print("atoutIncassable", atoutIncassable)
   
     local atoutPercutante = string.match(s, ".*(Percutante).*/")
     atoutPercutante = atoutPercutante ~= nil
     print("atoutPercutante", atoutPercutante)
   
     local atoutPerforante = string.match(s, ".*(Perforante).*/")
     atoutPerforante = atoutPerforante ~= nil
     print("atoutPerforante", atoutPerforante)
   
     local atoutPerturbante = string.match(s, ".*(Perturbante).*/")
     atoutPerturbante = atoutPerturbante ~= nil
     print("atoutPerturbante", atoutPerturbante)
   
     local atoutPiegeLame = string.match(s, ".*(Piège-lame).*/")
     atoutPiegeLame = atoutPiegeLame ~= nil
     print("atoutPiegeLame", atoutPiegeLame)
   
     local atoutPistolet = string.match(s, ".*(Pistolet).*/")
     atoutPistolet = atoutPistolet ~= nil
     print("atoutPistolet", atoutPistolet)
   
     local atoutPointue = string.match(s, ".*(Pointue).*/")
     atoutPointue = atoutPointue ~= nil
     print("atoutPointue", atoutPointue)
   
     local atoutPrecise = string.match(s, ".*(Précise).*/")
     atoutPrecise = atoutPrecise ~= nil
     print("atoutPrecise", atoutPrecise)
   
     local atoutProtectrice = string.match(s, ".*Protectrice.*/")
     atoutProtectrice = atoutProtectrice ~= nil
     print("atoutProtectrice", atoutProtectrice)
   
     local indiceAtoutProtectrice = string.match(s, ".*Protectrice(%d*).*/")
     print("atoutProtectrice(%d)", indiceAtoutProtectrice)
   
     local atoutRapide = string.match(s, ".*(Rapide).*/")
     atoutRapide = atoutRapide ~= nil
     print("atoutRapide", atoutRapide)
   
     local atoutTaille = string.match(s, ".*(Taille).*/")
     atoutTaille = atoutTaille ~= nil
     print("atoutTaille", atoutTaille)
   

   
     -- caracs de base du défenseur
     local protagoniste2, seuilBase2, difficulte2, avantage2 =
      string.match(s, ".*/[%s]*([%w%p]+)[%s]*(%d+)[%s]*([%w]*)[%s]*(%d*)A[%s]*")
   
     -- atouts éventuels du défenseur
     --local protagoniste1, seuilBase1, difficulte1, avantage1, bonusForce1, protagoniste2, seuilBase2, difficulte2, avantage2 = string.match(s, "%w*[%s]+([%w%p]*)[%s]+(%d+)[%s]+([%w]*)[%s]*(%d*)A[%s]*(%d*)BF[%s]*/[%s]*([%w%p]+)[%s]*(%d+)[%s]*([%w]*)[%s]*(%d*)A[%s]*")
   
     seuilBase1 = tonumber(seuilBase1) or nil
     seuilBase2 = tonumber(seuilBase2) or nil
   
     avantage1 = tonumber(avantage1) or 0
     avantage2 = tonumber(avantage2) or 0
   
     bonusForce1 = tonumber(bonusForce1) or 0
   
     print("TestCorpsACorps:avantage1", avantage1)
     print("TestCorpsACorps:avantage2", avantage2)
   
     print("TestCorpsACorps:bonusForce1", bonusForce1)
   
     if (difficulte1 == "" and true) then
      difficulte1 = "I"
     end
     if (difficulte2 == "" and true) then
      difficulte2 = "I"
     end
   
     difficulte1 = GetCodeDifficulte(difficulte1)
     difficulte2 = GetCodeDifficulte(difficulte2)
   
     local modificateurDifficulte1 = GetModificateurDifficulte(difficulte1)
     local modificateurDifficulte2 = GetModificateurDifficulte(difficulte2)
   
     local seuilEffectif1 = GetSeuilEffectif(seuilBase1, modificateurDifficulte1)
     local seuilEffectif2 = GetSeuilEffectif(seuilBase2, modificateurDifficulte2)
   
     seuilEffectif1 = seuilEffectif1 + (avantage1 * 10)
     seuilEffectif2 = seuilEffectif2 + (avantage2 * 10)
   
     local jets1 = rpg.roll.dice(2, 0, 9)
     local jets2 = rpg.roll.dice(2, 0, 9)
   
     local d1_1 = jets1[1]
     local d1_2 = jets2[1]
   
     local d2_1 = jets1[2]
     local d2_2 = jets2[2]

     local succes1 = IsSuccess(GetD100(d1_1, d2_1), seuilEffectif1)
     local succes2 = IsSuccess(GetD100(d1_2, d2_2), seuilEffectif2)

     local echec1 = IsFailure(GetD100(d1_1, d2_1), seuilEffectif1)
     local echec2 = IsFailure(GetD100(d1_2, d2_2), seuilEffectif2)

     local critique1 = IsCritical(typetest, d1_1, d2_1)
     local critique2 = IsCritical(typetest, d1_2, d2_2)

     resultatTest = EvaluateTestCorpsACorps(
      protagoniste1,
      seuilBase1,
      seuilEffectif1,
      difficulte1,
      avantage1,
      d1_1,
      d2_1,
      bonusForce1,
      protagoniste2,
      seuilBase2,
      seuilEffectif2,
      difficulte2,
      avantage2,
      d1_2,
      d2_2
     )
    elseif (typetest == "distance" and true) then
     print("Test d'Attaque à distance:", typetest)
    else
     print("Test de type inconnu:", typetest)
    end
    print("\r\nFin de ce test\r\n\r\n")
    return resultatTest
   end