
-- Script LUA utilisable pour mettre en place des jets de dés au format Warhammer v4 sur le site PlaneteRoliste.com


   
   OptionAutomatiqueDonneCritique = true
   SuccesAutomatiqueMax = 1
   EchecAutomatiqueMin = 97
   OptionDoubleDonneCritique = true
   OptionDRSupplementairePourSeuilsSuperieursA100 = true
   ModuloBEArmeOffensive = 0.5
   
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

  function GetDegatsNonCritiques(DRattaquant, BFattaquant, DRattaque, BEattaque, degatsArme, atoutsDefautsArme)

    local degatsEffectifs = 0
    local bilanDR = DRattaquant - DRattaque
    print("bilanDR:", bilanDR)
    print("BFattaquant:", BFattaquant)
    print("BEattaque:", BEattaque)
    local appliqueBF, degatsEffectifsArme = string.match(degatsArme, ".*(%+BF)%s*(%+%d*)")
    appliqueBF = appliqueBF ~= nil
    
    degatsEffectifsArme = tonumber(degatsEffectifsArme)

    print("appliqueBF", appliqueBF)
    print("degatsEffectifsArme", degatsEffectifsArme)

    if appliqueBF then
      print("appliqueBF true")
      degatsEffectifsArme = degatsEffectifsArme + BFattaquant
    else
      print("appliqueBF false")
      degatsEffectifsArme = degatsEffectifsArme
    end

    degatsEffectifs = degatsEffectifsArme + bilanDR
    print("degatsEffectifs:", degatsEffectifs)
    local libelleCalculDegats = string.format("%dDR %s", bilanDR, degatsArme)
    print("libelleCalculDegats:", libelleCalculDegats)
    local libelleBE = ""
    print("atoutsDefautsArme['inoffensive']", atoutsDefautsArme['inoffensive'])
    if (ModuloBEArmeOffensive < 1 and not atoutsDefautsArme['inoffensive'] and true) then
      degatsEffectifs = degatsEffectifs - math.ceil(BEattaque * ModuloBEArmeOffensive)
      libelleBE = string.format( ' - (%dBE * %.1f)', BEattaque, ModuloBEArmeOffensive)
      print("degatsEffectifs", degatsEffectifs)
      print("libelleBE", libelleBE)
    else
      degatsEffectifs = degatsEffectifs - BEattaque
      libelleBE = string.format( ' - %dBE', BEattaque)
      print("degatsEffectifs", degatsEffectifs)
      print("libelleBE", libelleBE)
    end

    libelleCalculDegats = libelleCalculDegats .. libelleBE
    print('libelleCalculDegats', libelleCalculDegats)

    if (degatsEffectifs < 0 and true) then
      degatsEffectifs = 0
    end

    print(libelleCalculDegats .. " = " .. degatsEffectifs)


    return degatsEffectifs, libelleCalculDegats
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
    if localisationDegats == "tête" then
     libelleLocalisationDegats = "à la Tête"
    elseif localisationDegats == "bras secondaire" then
     libelleLocalisationDegats = "au niveau du Bras gauche (ou du bras secondaire)"
    elseif localisationDegats == "bras principal" then
     libelleLocalisationDegats = "au niveau du Bras droit (ou du bras principal)"
    elseif localisationDegats == "corps" then
     libelleLocalisationDegats = "au niveau du Corps"
    elseif localisationDegats == "jambe gauche" then
     libelleLocalisationDegats = "au niveau de la Jambe gauche"
    elseif localisationDegats == "jambe droite" then
     libelleLocalisationDegats = "au niveau de la Jambe droite"
    end
    return libelleLocalisationDegats
   end

   function GetLibelleEffetMaladresse(d100, attaquant)
    if (d100 >= 1 and d100 <= 20 and true) then
     return string.format("%s se blesse tout seul en attaquant, et perd un Point de Blessure sans tenir compte du Bonus d'Endurance ou des Points d'Armure.", attaquant)
    elseif d100 >= 21 and d100 <= 40 then
     return string.format("L'arme de Corps-à-Corps de %s s'ébrèche salement, ou l'arme de tir à distance ne fonctionne pas ou se trouve sur le point de se briser. L'arme subit 1 point de Dégâts. Au prochain Round, %s agira en dernier sans tenir compte de l'ordre d'initiative, des talents ni de toute règle spéciale pendant que le porteur gère la situation.", attaquant)
    elseif d100 >= 41 and d100 <= 60 then
     return string.format("%s a mal négocié sa manoeuvre, ce qui le met en mauvaise posture. Au cours du prochain round, votre action subira une pénalité de -10.", attaquant)
    elseif d100 >= 61 and d100 <= 70 then
     return string.format("%s trébuche franchement et peine à se redresser, il perd son prochain Mouvement.", attaquant)
    elseif d100 >= 71 and d100 <= 80 then
     return string.format("%s ne tient pas son arme correctement ou laisse tomber ses munitions, il perd sa prochaine Action.", attaquant)
    elseif d100 >= 81 and d100 <= 90 then
     return string.format("%s effectue un mouvement trop ample, ou trébuche et se tord la cheville, subissant un traumatisme [i]Déchirure musculaire (Mineure)[/i] comptant comme une Blessure critique.", attaquant)
    elseif d100 >= 91 and d100 <= 100 then
     return string.format("%s manque complètement son attaque et touche un allié au hasard à distance en utilisant le chiffre des unités du lancer de dés pour déterminer le DR. Si personne n'est à distance, il se blesse tout seul et obtient l'État [i]Sonné[/i].", attaquant)
    end
   end

   function GetLibelleEffetCoupCritiques(localisationDegats, attaquant, attaque)
    print("GetLibelleEffetCoupCritiques:", localisationDegats, attaquant, attaque)
    local jet = rpg.roll.dice(2, 0, 9)
    local d1 = jet[1]
    local d2 = jet[2]
    local testVar = "testVar :)"

    local d100 = GetD100(d1, d2)
   
    local description = ""
    local ptsBlessure = 0
    local effetsSupplementaires = ""
   
    if localisationDegats == "Tête" then
     if d100 >= 1 and d100 <= 10 then
      description = "Blessure spectaculaire"
      ptsBlessure = 1
      effetsSupplementaires =
       string.format("l'attaque de %s produit une fine entaille qui va du front de %s jusqu'à la joue. +1 État [i]Hémorragique[/i]. Une fois que la blessure est guérie, l'impressionnante cicatrice permet d'obtenir DR+1 à certains tests sociaux.", attaquant, attaque)
     elseif d100 >= 11 and d100 <= 20 then
      description = "Coupure mineure"
      ptsBlessure = 1
      effetsSupplementaires =
       string.format("le coup de %s entaille la joue de %s et le sang dégouline partout. +1 État [i]Hémorragique[/i].", attaquant, attaque)
     elseif d100 >= 21 and d100 <= 25 then
      description = "Coup à l'oeil"
      ptsBlessure = 1
      effetsSupplementaires = string.format("le coup de %s touche %s à l'orbite de l'oeil. +1 État [i]Aveuglé[/i].", attaquant, attaque)
     elseif d100 >= 26 and d100 <= 30 then
      description = "Frappe à l'oreille"
      ptsBlessure = 1
      effetsSupplementaires =
       string.format("le coup de %s touche à l'orbite de l'oreille et %s perçoit un bourdonnement ignoble. +1 État [i]Assourdi[/i].", attaquant, attaque)
     elseif d100 >= 31 and d100 <= 35 then
      description = "Coup percutant"
      ptsBlessure = 2
      effetsSupplementaires =
       string.format("le sang obsurcit la vision de %s, qui perçoit des points blancs et des flashs de lumière. +1 État [i]Sonné[/i].", attaque)
     elseif d100 >= 36 and d100 <= 40 then
      description = "Oeil au beurre noir"
      ptsBlessure = 2
      effetsSupplementaires =
       string.format("%s assène un coup massif et très douloureux au niveau des yeux de %s. +2 États [i]Aveuglé[/i].", attaquant, attaque)
     elseif d100 >= 41 and d100 <= 45 then
      description = "Oreille tranchée"
      ptsBlessure = 2
      effetsSupplementaires =
       string.format("%s assène un coup très violent sur le côté de la tête de %s, entaillant profondément l'oreille. +2 États [i]Assourdi[/i] et +1 État [i]Hémorragique[/i].", attaquant, attaque)
     elseif d100 >= 46 and d100 <= 50 then
      description = "En plein front"
      ptsBlessure = 2
      effetsSupplementaires =
       string.format("%s assène est un coup percutant en plein front de %s. +2 États [i]Hémorragique[/i] et +1 État [i]Aveuglé[/i] qui ne peut être retiré tant que tous les États [i]Hémorragique[/i] n'ont pas été éliminés.", attaquant, attaque)
     elseif d100 >= 51 and d100 <= 55 then
      description = "Mâchoire fracturée"
      ptsBlessure = 3
      effetsSupplementaires =
       string.format("le coup de %s fracture la mâchoire de %s avec un bruit dégoûtant. Les vagues de douleur déferlent instantanément. +2 États [i]Sonné[/i] et subissez le Traumatisme [i]Fracture (Mineure)[/i].", attaquant, attaque)
     elseif d100 >= 56 and d100 <= 60 then
      description = "Blessure majeure à l'oeil"
      ptsBlessure = 3
      effetsSupplementaires =
       string.format("le coup de %s lézarde l'orbite d'un oeil de %s. +1 État [i]Hémorragique[/i]. +1 État [i]Aveuglé[/i] qui ne pourra être soigné que lorsqu'on vous appliquera Aide Médicale.", attaquant, attaque)
     elseif d100 >= 61 and d100 <= 65 then
      description = "Blessure majeure à l'oreille"
      ptsBlessure = 3
      effetsSupplementaires =
       string.format("le coup de %s endommage l'oreille de %s, lui causant une perte auditive permanente. %s subit désormais une pénalité de -20 à tout Test ayant un rapport avec l'audition. Si %s tombe une seconde fois sur cette blessure, il perd totalement l'audition car votre deuxième oreille devient elle aussi silencieuse. Ne peut être guéri que par la magie.", attaquant, attaque, attaque, attaque)
     elseif d100 >= 66 and d100 <= 70 then
      description = "Nez cassé"
      ptsBlessure = 3
      effetsSupplementaires =
       string.format("%s porte un coup violent au nez de %s, qui déverse instantanément des flots de sang. +2 États [i]Hémorragique[/i]. Réussissez un Test de [b]Résistance Intermédiaire (+0)[/b] ou gagnez l'État [i]Sonné[/i]. Une fois cette blessure guérie, gagnez [b]DR+1/-1[/b] aux Tests Sociaux en fonction du contexte, jusqu'à ce que [b]Chirurgie[/b] soit utilisée sur le nez pour le réparer.", attaquant, attaque)
     elseif d100 >= 71 and d100 <= 75 then
      description = "Mâchoire cassée"
      ptsBlessure = 4
      effetsSupplementaires =
       string.format("le coup de %s brise la mâchoire de %s avec un bruit ignoble. +3 États [i]Sonné[/i]. Réussissez un Test de [b]Résistance Intermédiaire (+0)[/b] ou gagnez l'État [i]Inconscient[/i]. +1 Traumatisme [b]Fracture (Majeure)[/b]", attaquant, attaque)
     elseif d100 >= 76 and d100 <= 80 then
      description = "Commotion cérébrale"
      ptsBlessure = 4
      effetsSupplementaires =
       string.format("le cerveau de %s bouge à l'intérieur de la boîte crânienne, alors que le sang coule à flots du nez et des oreilles. +1 État [i]Assourdi[/i], +2 États [i]Hémorragique[/i] et +1D10 États [i]Sonné[/i]. +1 État [i]Exténué[/i] pour 1D10 jours. Si vous recevez une autre Blessure critique à la tête alors que vous êtes [i]Exténué[/i], réussissez un Test de [b]Résistance Accessible (+20)[/b] ou +1 État [i]Inconscient[/i].", attaque)
     elseif d100 >= 81 and d100 <= 85 then
      description = "Bouche explosée"
      ptsBlessure = 4
      effetsSupplementaires =
       string.format("la bouche de %s se remplit de sang et de dents cassées avec un bruit répugnant. +2 États [i]Hémorragique[/i]. Perdez 1D10 dents — [b]Amputation (Facile)[/b].", attaque)
     elseif d100 >= 86 and d100 <= 90 then
      description = "Oreille mutilée"
      ptsBlessure = 4
      effetsSupplementaires =
       string.format("Il ne reste plus grand-chose de l'oreille de %s après que le coup de %s l'ait déchiquetée. +3 États [i]Assourdi[/i] et +2 États [i]Hémorragique[/i]. L'oreille est perdue — [b]Amputation (Accessible)[/b]", attaque, attaquant)
     elseif d100 >= 91 and d100 <= 93 then
      description = "Œil crevé"
      ptsBlessure = 5
      effetsSupplementaires =
       string.format("le coup de %s crève l'oeil de %s, provoquant une douleur quasi-insoutenable. +3 États [i]Aveuglé[/i], +2 États [i]Hémorragique[/i] et +1 États [i]Sonné[/i]. L'œil est perdu — [b]Amputation (Complexe)[/b]", attaquant, attaque)
     elseif d100 >= 94 and d100 <= 96 then
      description = "Coup défigurant"
      ptsBlessure = 5
      effetsSupplementaires =
       string.format("le coup de %s explose le visage de %s, crevant un œil et brisant le nez. +3 États [i]Hémorragique[/i], +3 États [i]Aveuglé[/i] et +2 États [i]Sonné[/i]. L'œil et le nez sont perdus — [b]Amputation (Difficile)[/b]", attaquant, attaque)
     elseif d100 >= 97 and d100 <= 99 then
      description = "Mâchoire mutilée"
      ptsBlessure = 5
      effetsSupplementaires =
       string.format("le coup de %s arrache presque complètement la mâchoire de %s, détruit la langue et envoie les dents à plusieurs mètres dans une pluie de sang. +4 États [i]Hémorragique[/i], +3 États [i]Sonné[/i]. Réussissez un Test de Résistance Très Difficile (-30) ou +1 État [i]Inconscient[/i]. +1 Traumatisme [b]Fracture (Majeure)[/b], la langue est perdue et 1D10 dents — [b]Amputation (Difficile)[/b]", attaquant, attaque)
     elseif d100 == 100 then
      description = "Mort"
      ptsBlessure = 666
      effetsSupplementaires =
       string.format("%s tranche la tête de %s au niveau du cou, elle part dans les airs, atterrissant à 1D3 mètres du corps dans une direction aléatoire (voir [b]Dispersion[/b]). La mort est instantanée, et le corps s'effondre sans vie.", attaquant, attaque)
     end
    elseif localisationDegats == "Bras secondaire" or localisationDegats == "Bras principal" then
        if d100 >= 1 and d100 <= 10 then
            description = "Choc au bras"
            ptsBlessure = 1
            effetsSupplementaires =
            string.format("le %s de %s prend un choc au cours de l'attaque. %s lâche ce qu'il tenait.", localisationDegats, attaque)
           elseif d100 >= 11 and d100 <= 20 then
            description = "Coupure mineure"
            ptsBlessure = 1
            effetsSupplementaires =
            string.format("%s saigne abondamment au niveau de l'avant-bras. +1 État [i]Hémorragique[/i].", attaque)
           elseif d100 >= 21 and d100 <= 25 then
            description = "Torsion"
            ptsBlessure = 1
            effetsSupplementaires = string.format("%s se tord le bras, occasionnant +1 Traumatisme [i]Déchirure musculaire (Mineure)[/i]", attaque)
           elseif d100 >= 26 and d100 <= 30 then
            description = "Choc violent au bras"
            ptsBlessure = 2
            effetsSupplementaires =
            string.format("%s reçoit un coup particulièrement violent %s et lâche ce qu'il avait dans la main, cette dernière restant inutilisable pendant 1D10 - Bonus d'Endurance Rounds (minimum 1). Pendant ce temps, considérez votre main comme perdue (voir Membres Amputés, p180).", attaque, localisationDegats)
           elseif d100 >= 31 and d100 <= 35 then
            description = "Déchirure musculaire"
            ptsBlessure = 2
            effetsSupplementaires =
            string.format("le coup écrase l'avant-bras (%s) de %s. +1 État [i]Hémorragique[/i] et +1 Traumatisme [i]Déchirure musculaire (Mineure)[/i].", localisationDegats, attaque)
           elseif d100 >= 36 and d100 <= 40 then
            description = "Main ensanglantée"
            ptsBlessure = 2
            effetsSupplementaires =
            string.format("la main (%s) de %s est bien entaillée. Le sang rend la prise glissante avec cette main. +1 État [i]Hémorragique[/i]. Test de [i]Dextérité (Accessible)[/i] pour effectuer toute action avec un objet dans la main, sinon il échappe des mains.", localisationDegats, attaque)
           elseif d100 >= 41 and d100 <= 45 then
            description = "Clef de bras"
            ptsBlessure = 2
            effetsSupplementaires =
            string.format("l'articulation du %s de %s est pratiquement arrachée. La main correspondante lâche ce qu'elle tenait, le bras est inutilisable pendant 1D10 Rounds.", localisationDegats, attaque)
           elseif d100 >= 46 and d100 <= 50 then
            description = "Blessure béante"
            ptsBlessure = 3
            effetsSupplementaires =
            string.format("le coup ouvre une blessure béante. +2 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au %s redonnera +1 État [i]Hémorragique[/i], la blessure s'étant réouverte.", attaque, localisationDegats)
           elseif d100 >= 51 and d100 <= 55 then
            description = "Cassure nette"
            ptsBlessure = 3
            effetsSupplementaires =
            string.format("un craquement significatif se fait entendre au moment où le coup s'abat sur le %s de %s. La main correspondante lâche ce qu'elle tenait. +1 Traumatisme [i]Fracture (Mineure)[/i]. +1 État [i]Sonné[/i] en cas d'échec à un Test de [i]Résistance (Complexe)[/i].", localisationDegats, attaque)
           elseif d100 >= 56 and d100 <= 60 then
            description = "Ligament rompu"
            ptsBlessure = 3
            effetsSupplementaires =
            string.format("%s lâche immédiatement ce qu'il tenait dans la main de son %s. +1 Traumatisme [i]Déchirure musculaire (Majeure)[/i]", attaque, localisationDegats)
           elseif d100 >= 61 and d100 <= 65 then
            description = "Coupure profonde"
            ptsBlessure = 3
            effetsSupplementaires =
            string.format("+2 États [i]Hémorragique[/i] dûs à la forte mutilation du %s de %s. +1 État [i]Sonné[/i], +1 Traumatisme [i]Déchirure musculaire (Mineure)[/i], +1 État [i]Inconscient[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i].", localisationDegats, attaque)
           elseif d100 >= 66 and d100 <= 70 then
            description = "Artère endommagée"
            ptsBlessure = 4
            effetsSupplementaires =
            string.format("+4 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au %s redonnera +2 État [i]Hémorragique[/i], la blessure s'étant réouverte.", attaque, localisationDegats)
           elseif d100 >= 71 and d100 <= 75 then
            description = "Coude fracassé"
            ptsBlessure = 4
            effetsSupplementaires =
            string.format("le coup fracasse le coude du %s de %s, faisant voler en éclats os et cartilage. %s lâche immédiatement ce qu'il tenait dans cette main, et subit +1 Traumatisme [i]Fracture (Majeure)[/i]", localisationDegats, attaque, attaque)
           elseif d100 >= 76 and d100 <= 80 then
            description = "Épaule luxée"
            ptsBlessure = 4
            effetsSupplementaires =
            string.format("le %s de %s est démis de son logement. %s lâche immédiatement ce qu'il tenait dans cette main. +1 État [i]Sonné[/i] et +1 État [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]. +1 État [i]Sonné[/i] conservé jusqu'à bénéficier d'Aide Médicale. Un Test Étendu de Guérison avec 6 DR est nécessaire pour recouvrer l'usage du bras. Les tests utilisant ce bras subissent une pénalité de -10 pendant 1D10 jours.", localisationDegats, attaque, attaque)
           elseif d100 >= 81 and d100 <= 85 then
            description = "Doigt sectionné"
            ptsBlessure = 4
            effetsSupplementaires =
            string.format("%s voit un de ses doigts s'envoler. +1 États [i]Hémorragique[/i]. — [b]Amputation (Accessible)[/b].", attaque)
           elseif d100 >= 86 and d100 <= 90 then
            description = "Main ouverte"
            ptsBlessure = 5
            effetsSupplementaires =
            string.format("la main du %s de %s s'ouvre sous la puissance du coup. Un Doigt est perdu — [b]Amputation (Complexe)[/b]. +2 États [i]Hémorragique[/i] et +1 État [i]Sonné[/i]. Pour chaque Round sans Aide Médicale, un autre Doigt est perdu. Si tous les doigts sont perdus, la main est perdue. — [b]Amputation (Complexe)[/b]", localisationDegats, attaque)
           elseif d100 >= 91 and d100 <= 93 then
            description = "Biceps déchiqueté"
            ptsBlessure = 5
            effetsSupplementaires =
            string.format("le coup sépare presque entièrement le biceps et le tendon de l'os du " .. localisationDegats .. " de %s, laissant une blessure effrayante dont le sang gicle jusque sur son adversaire. %s lâche immédiatement ce qu'il tenait dans cette main. +1 Traumatisme [i]Déchirure musculaire (Majeure)[/i], +2 États [i]Hémorragique[/i] et +1 État [i]Sonné[/i]", attaque)
           elseif d100 >= 94 and d100 <= 96 then
            description = "Main mutilée"
            ptsBlessure = 5
            effetsSupplementaires =
            string.format("la main du " .. localisationDegats .. " de %s n'est plus qu'un tas de chair hémorragique. La main est perdue — [b]Amputation (Difficile)[/b]. +2 États [i]Hémorragique[/i]. +1 État [i]Sonné[/i] et +1 État [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]", attaque)
           elseif d100 >= 97 and d100 <= 99 then
            description = "Tendons coupés"
            ptsBlessure = 5
            effetsSupplementaires =
            string.format("Les tendons sont sectionnés par la force du coup et le %s de %s est inutilisable — [b]Amputation (Difficile)[/b]. +3 États [i]Hémorragique[/i], +1 État [i]À terre[/i], +1 État [i]Sonné[/i]. +1 État [i]Inconscient[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]. ", localisationDegats, attaque)
           elseif d100 == 100 then
            description = "Démembrement fatal"
            ptsBlessure = 666
            effetsSupplementaires =
            string.format("le %s de %s est coupé, faisant gicler le sang des artères jusqu'à 1D3 mètres dans une direction aléatoire (voir [b]Dispersion[/b]). La mort de %s est instantanée, et son corps s'effondre sans vie.", localisationDegats, attaque)
           end
    elseif localisationDegats == "Corps" then
        if d100 >= 1 and d100 <= 10 then
            description = "Rien qu'une égratignure !"
            ptsBlessure = 1
            effetsSupplementaires =
            string.format("+1 État [i]Hémorragique[/i].")
           elseif d100 >= 11 and d100 <= 20 then
            description = "Coup au ventre"
            ptsBlessure = 1
            effetsSupplementaires =
            string.format("+1 État [i]Sonné[/i]. +1 État [i]À terre[/i] et vomissement en cas d'échec à un Test de [i]Résistance (Facile)[/i].")
           elseif d100 >= 21 and d100 <= 25 then
            description = "Coup bas"
            ptsBlessure = 1
            effetsSupplementaires = string.format("+3 États [i]Sonné[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i].")
           elseif d100 >= 26 and d100 <= 30 then
            description = "Torsion du dos"
            ptsBlessure = 1
            effetsSupplementaires =
            string.format("+1 Traumatisme [i]Déchirure musculaire (Mineure)[/i]")
           elseif d100 >= 31 and d100 <= 35 then
            description = "Souffle coupé"
            ptsBlessure = 2
            effetsSupplementaires =
            string.format("+1 État [i]Sonné[/i]. +1 États [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Accessible)[/i]. Le mouvement de %s est réduit de moitié pendant 1D10 rounds, le temps de récupérer son souffle.", attaque)
           elseif d100 >= 36 and d100 <= 40 then
            description = "Bleus aux côtes"
            ptsBlessure = 2
            effetsSupplementaires =
            string.format("Tous les Tests basés sur l'Agilité sont effectués avec une pénalité de -10 pendant 1D10 jours.")
           elseif d100 >= 41 and d100 <= 45 then
            description = "Clavicule tordue"
            ptsBlessure = 2
            effetsSupplementaires =
            string.format("Choisissez un bras au hasard. La main correspondante lâche ce qu'elle tenait, et le bras reste inutilisable pendant 1D10 Rounds.")
           elseif d100 >= 46 and d100 <= 50 then
            description = "Chairs déchirées"
            ptsBlessure = 2
            effetsSupplementaires =
            string.format("+2 États [i]Hémorragique[/i].")
           elseif d100 >= 51 and d100 <= 55 then
            description = "Côtes fracturées"
            ptsBlessure = 3
            effetsSupplementaires =
            string.format("Le coup de %s fracture une ou plusieurs côtes à %s. +1 État [i]Sonné[/i], +1 Traumatisme [i]Fracture (Mineure)[/i].", attaquant, attaque)
           elseif d100 >= 56 and d100 <= 60 then
            description = "Blessure béante"
            ptsBlessure = 3
            effetsSupplementaires =
            string.format("+3 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au %s redonnera +1 État [i]Hémorragique[/i], la blessure s'étant réouverte.", attaque, localisationDegats)
           elseif d100 >= 61 and d100 <= 65 then
            description = "Entaille douloureuse"
            ptsBlessure = 3
            effetsSupplementaires =
            string.format("+2 États [i]Hémorragique[/i] et +1 État [i]Sonné[/i]. +1 États [i]Inconscient[/i] en cas d'échec à un Test Spectaculaire de [i]Résistance (Difficile)[/i], %s s'évanouissant sous l'effet de la douleur. Avec moins de 4DR, %s hurle de douleur.", attaque)
           elseif d100 >= 66 and d100 <= 70 then
            description = "Dégâts artériels"
            ptsBlessure = 3
            effetsSupplementaires =
            string.format("+4 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au %s redonnera +2 États [i]Hémorragique[/i], la blessure s'étant réouverte.", attaque, localisationDegats)
           elseif d100 >= 71 and d100 <= 75 then
            description = "Dos froissé"
            ptsBlessure = 4
            effetsSupplementaires =
            string.format("Une douleur irradiante assaille %s lorsqu'il fait jouer les muscles de son dos. +1 Traumatisme [b]Déchirure musculaire (Majeure)[/b]", attaque)
           elseif d100 >= 76 and d100 <= 80 then
            description = "Hanche fracturée"
            ptsBlessure = 4
            effetsSupplementaires =
            string.format("+1 État [i]Sonné[/i] et +1 Traumatisme [b]Fracture (Mineure)[/b]. +1 États [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Intermédiaire)[/i].")
           elseif d100 >= 81 and d100 <= 85 then
            description = "Blessure majeure au torse"
            ptsBlessure = 4
            effetsSupplementaires =
            string.format("%s reçoit une blessure importante au torse, le coup arrache la peau, les muscles et les tendons. +4 États [i]Hémorragique[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au torse redonnera +2 États [i]Hémorragique[/i], la blessure s'étant réouverte.", attaque)
           elseif d100 >= 86 and d100 <= 90 then
            description = "Blessure au ventre"
            ptsBlessure = 4
            effetsSupplementaires =
            string.format("+2 États [i]Hémorragique[/i], c'est une Blessure Purulente.")
           elseif d100 >= 91 and d100 <= 93 then
            description = "Cage thoracique perforée"
            ptsBlessure = 5
            effetsSupplementaires =
            string.format("+1 État [i]Sonné[/i] jusqu'à réception d'une Aide Médicale. +1 Traumatisme [b]Fracture (Majeure)[/b].")
           elseif d100 >= 94 and d100 <= 96 then
            description = "Clavicule cassée"
            ptsBlessure = 5
            effetsSupplementaires =
            string.format("+1 État [i]Inconscient[/i] jusqu'à réception d'une Aide Médicale. +1 Traumatisme [b]Fracture (Majeure)[/b].")
           elseif d100 >= 97 and d100 <= 99 then
            description = "Hémorragie interne"
            ptsBlessure = 5
            effetsSupplementaires =
            string.format("+1 État [i]Hémorragique[/i] jusqu'à réception d'une Chirurgie. %s contracte en outre une Infection Sanguine.")
           elseif d100 == 100 then
            description = "Éventré"
            ptsBlessure = 666
            effetsSupplementaires =
            string.format("%s est littéralement coupé en deux, tout personnage situé à moins de 2 mètres est recouvert de sang.", attaque)
           end
    elseif localisationDegats == "Jambe gauche" or localisationDegats == "Jambe droite" then
      if d100 >= 1 and d100 <= 10 then
        description = "Orteil contusionné"
        ptsBlessure = 1
        effetsSupplementaires =
        string.format("Dans le feu de la bataille, %s se cogne l'orteil. Pénalité de -10 à tous les Tests d'Agilité en cas d'échec à un Test de [i]Résistance (Accessible)[/i]", attaque)
       elseif d100 >= 11 and d100 <= 20 then
        description = "Cheville tordue"
        ptsBlessure = 1
        effetsSupplementaires =
        string.format("%s se tord la cheville. Tous ses Tests d'Agilité subissent une pénalité de -10 pendant 1D10 Rounds", attaque)
       elseif d100 >= 21 and d100 <= 25 then
        description = "Coupure mineure"
        ptsBlessure = 1
        effetsSupplementaires = string.format("+1 État [i]Hémorragique[/i].")
       elseif d100 >= 26 and d100 <= 30 then
        description = "Perte d'équilibre"
        ptsBlessure = 1
        effetsSupplementaires =
        string.format("Dans le feu du combat, %s perd l'équilibre. +1 États [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Intermédiaire)[/i]", attaque)
       elseif d100 >= 31 and d100 <= 35 then
        description = "Coup à la cuisse"
        ptsBlessure = 2
        effetsSupplementaires =
        string.format("%s reçoit un coup violent sur le haut de la cuisse. +1 État [i]Hémorragique[/i]. +1 États [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Accessible)[/i].", attaque)
       elseif d100 >= 36 and d100 <= 40 then
        description = "Cheville foulée"
        ptsBlessure = 2
        effetsSupplementaires =
        string.format("%s se foule la cheville. +1 Traumatisme [i]Déchirure musculaire (Mineure)[/i]")
       elseif d100 >= 41 and d100 <= 45 then
        description = "Genou tordu"
        ptsBlessure = 2
        effetsSupplementaires =
        string.format("Le genou de %s pivote un peu trop. Tous ses Tests d'Agilité subissent une pénalité de -20 pendant 1D10 Rounds.")
       elseif d100 >= 46 and d100 <= 50 then
        description = "Coupure à l'orteil"
        ptsBlessure = 2
        effetsSupplementaires =
        string.format("+1 États [i]Hémorragique[/i]. Une fois la rencontre terminée, Perte de l'orteil en cas d'échec à un Test de [i]Résistance (Intermédiaire)[/i] — [b]Amputation (Complexe)[/b]")
       elseif d100 >= 51 and d100 <= 55 then
        description = "Mauvaise coupure"
        ptsBlessure = 3
        effetsSupplementaires =
        string.format("+2 États [i]Hémorragique[/i] en raison de la profonde blessure au niveau du tibia de %s. +1 État [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Intermédiaire)[/i].", attaque)
       elseif d100 >= 56 and d100 <= 60 then
        description = "Genou méchamment tordu"
        ptsBlessure = 3
        effetsSupplementaires =
        string.format("%s se tord méchamment le genou. +1 Traumatisme [i]Déchirure musculaire (Mineure)[/i].", attaque)
       elseif d100 >= 61 and d100 <= 65 then
        description = "Jambe charcutée"
        ptsBlessure = 3
        effetsSupplementaires =
        string.format("%s reçoit une blessure profonde au niveau de la hanche. +2 États [i]Hémorragique[/i], +1 État [i]À terre[/i] et +1 Traumatisme [i]Déchirure musculaire (Mineure)[/i]. +1 États [i]Sonné[/i] en cas d'échec à un Test Spectaculaire de [i]Résistance (Difficile)[/i].", attaque)
       elseif d100 >= 66 and d100 <= 70 then
        description = "Cuisse lacérée"
        ptsBlessure = 3
        effetsSupplementaires =
        string.format("L'arme de %s entaille profondément la cuisse de %s. +1 États [i]À terre[/i] en cas d'échec à un Test de [i]Résistance (Intermédiaire)[/i]. Jusqu'à ce que %s soit soigné par Chirurgie afin de recoudre la blessure, tout nouveau Dégât au %s redonnera +1 États [i]Hémorragique[/i], la blessure s'étant réouverte.", attaquant, attaque, attaque, localisationDegats)
       elseif d100 >= 71 and d100 <= 75 then
        description = "Tendon rompu"
        ptsBlessure = 4
        effetsSupplementaires =
        string.format("Le tendon de %s cède. +1 État [i]À terre[/i], +1 État [i]Sonné[/i]. +1 État [i]Inconscient[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i]. La jambe de %s devient inutilisable. +1 Traumatisme [b]Déchirure musculaire (Majeure)[/b]", attaque, attaque)
       elseif d100 >= 76 and d100 <= 80 then
        description = "Entaille au tibia"
        ptsBlessure = 4
        effetsSupplementaires =
        string.format("L'arme de %s traverse littéralement la jambe de %s au niveau du genou. +1 État [i]À terre[/i], +1 État [i]Sonné[/i], +1 Traumatisme [b]Fracture (Mineure)[/b], +1 Traumatisme [b]Déchirure musculaire (Majeure)[/b].", attaquant, attaque)
       elseif d100 >= 81 and d100 <= 85 then
        description = "Genou cassé"
        ptsBlessure = 4
        effetsSupplementaires =
        string.format("Le coup de %s atteint la rotule de %s, qui se brise sous l'impact. +1 État [i]Hémorragique[/i], +1 État [i]À terre[/i], +1 État [i]Sonné[/i], +1 Traumatisme [b]Fracture (Majeure)[/b] tandis que %s s'effondre au sol.", attaquant, attaque, attaque)
       elseif d100 >= 86 and d100 <= 90 then
        description = "Genou démis"
        ptsBlessure = 4
        effetsSupplementaires =
        string.format("Le genou de %s se déboîte de son emplacement. +1 État [i]À terre[/i], +1 États [i]Sonné[/i] en cas d'échec à un Test de [i]Résistance (Difficile)[/i] et Aide Médicale nécessaire pour récupérer. Un Test Étendu de Guérison (Accessible) avec 6 DR est nécessaire pour remettre le genou en place et récupérer l'usage de la jambe. Mouvement réduit de moitié et pénalité de -10 pendant 1D10 jours à tous les tests utilisant cette jambe.", attaque)
       elseif d100 >= 91 and d100 <= 93 then
        description = "Pied écrasé"
        ptsBlessure = 5
        effetsSupplementaires =
        string.format("Le coup de %s explose le pied de %s. +2 États [i]Hémorragique[/i]. +1 État [i]À terre[/i] et perte d'un orteil en cas d'échec à un Test de [i]Résistance (Accessible)[/i], plus un orteil par DR en-dessous de 0 — [b]Amputation (Complexe)[/b]. Perte du pied dans les 1d10 jours à défaut de soin par Chirurgie.", attaquant, attaque)
       elseif d100 >= 94 and d100 <= 96 then
        description = "Pied sectionné"
        ptsBlessure = 5
        effetsSupplementaires =
        string.format("Le pied de %s est sectionné au niveau de la cheville et atterrit 1D3 mètres plus loin dans une direction aléatoire. +3 États [i]Hémorragique[/i], +2 État [i]Sonné[/i], +1 État [i]À terre[/i].", attaque)
       elseif d100 >= 97 and d100 <= 99 then
        description = "Tendon coupé"
        ptsBlessure = 5
        effetsSupplementaires =
        string.format("Un des tendons principaux à l'arrière de la jambe de %s est sectionné, le faisant hurler de douleur alors qu'il s'effondre. +2 États [i]Hémorragique[/i], +2 État [i]Sonné[/i], +1 État [i]À terre[/i]. %s devine avec horreur qu'il vient de perdre l'usage de sa jambe.", attaque, attaque)
       elseif d100 == 100 then
        description = "Bassin fracassé"
        ptsBlessure = 666
        effetsSupplementaires =
        string.format("Le coup de %s fracasse littéralement le bassin de %s, coupant une jambe et atteignant la seconde. %s meurt instananément sous le choc.", attaquant, attaque, attaque)
       end
    end
    return d1, d2, description, ptsBlessure, effetsSupplementaires
   end

function GetAtoutDefautArme(atout, atouts)
  if atouts[atout] then
    return atouts[atout]
  else
    return false
  end
end

function GetAtoutsDefautsArme(s)

  local atoutsDefautsArme = {}
  local atoutEnroulement = string.match(s, ".*(Enroulement).*")
  atoutsDefautsArme["enroulement"] = atoutEnroulement ~= nil

  local atoutPoudre = string.match(s, ".*(Poudre).*")
  atoutsDefautsArme["poudre"] = atoutPoudre ~= nil

  local atoutRepetition = string.match(s, ".*Répétition%((%d*)%).*")
  atoutsDefautsArme["repetition"] = atoutRepetition

  local atoutAssommante = string.match(s, ".*(Assommante).*")
  atoutsDefautsArme["assommante"] = atoutAssommante ~= nil

  local atoutDefensive = string.match(s, ".*(Défensive).*")
  atoutsDefautsArme["defensive"] = atoutDefensive ~= nil

  local atoutDevastatrice = string.match(s, ".*(Devastatrice).*")
  atoutsDefautsArme["devastatrice"] = atoutDevastatrice ~= nil

  local atoutEmpaleuse = string.match(s, ".*(Empaleuse).*")
  atoutsDefautsArme["empaleuse"] = atoutEmpaleuse ~= nil

  local atoutExplosion = string.match(s, ".*Explosion%((%d*)%).*")
  atoutsDefautsArme["explosion"] = atoutExplosion

  local atoutImmobilisante = string.match(s, ".*(Immobilisante).*")
  atoutsDefautsArme["immobilisante"] = atoutImmobilisante ~= nil

  local atoutIncassable = string.match(s, ".*(Incassable).*")
  atoutsDefautsArme["incassable"] = atoutIncassable ~= nil

  local atoutPercutante = string.match(s, ".*(Percutante).*")
  atoutsDefautsArme["percutante"] = atoutPercutante ~= nil

  local atoutPerforante = string.match(s, ".*(Perforante).*")
  atoutsDefautsArme["perforante"] = atoutPerforante ~= nil

  local atoutPerturbante = string.match(s, ".*(Perturbante).*")
  atoutsDefautsArme["perturbante"] = atoutPerturbante ~= nil

  local atoutPiegeLame = string.match(s, ".*(Piège-lame).*")
  atoutsDefautsArme["piegeLame"] = atoutPiegeLame ~= nil

  local atoutPistolet = string.match(s, ".*(Pistolet).*")
  atoutsDefautsArme["pistolet"] = atoutPistolet ~= nil

  local atoutPointue = string.match(s, ".*(Pointue).*")
  atoutsDefautsArme["pointue"] = atoutPointue ~= nil

  local atoutPrecise = string.match(s, ".*(Précise).*")
  atoutsDefautsArme["precise"] = atoutPrecise ~= nil

  local atoutProtectrice = string.match(s, ".*Protectrice%((%d*)%).*")
  atoutsDefautsArme["protectrice"] = atoutProtectrice ~= nil

  local atoutRapide = string.match(s, ".*(Rapide).*")
  atoutsDefautsArme["rapide"] = atoutRapide ~= nil

  local atoutTaille = string.match(s, ".*(Taille).*")
  atoutsDefautsArme["taille"] = atoutTaille ~= nil


  local defautDangereuse = string.match(s, ".*(Dangereuse).*")
  atoutsDefautsArme["dangereuse"] = defautDangereuse ~= nil

  local defautEpuisante = string.match(s, ".*(Épuisante).*")
  atoutsDefautsArme["epuisante"] = defautEpuisante ~= nil

  local defautImprecise = string.match(s, ".*(Imprécise).*")
  atoutsDefautsArme["imprecise"] = defautImprecise ~= nil

  local defautInoffensive = string.match(s, ".*(Inoffensive).*")
  atoutsDefautsArme["inoffensive"] = defautInoffensive ~= nil

  local defautInoffensive = string.match(s, ".*(Inoffensive).*")
  atoutsDefautsArme["imprecise"] = defautInoffensive ~= nil

  local defautLente = string.match(s, ".*(Lente).*")
  atoutsDefautsArme["lente"] = defautLente ~= nil

  local defautRecharge = string.match(s, ".*Recharge%((%d*)%).*")
  atoutsDefautsArme["recharge"] = defautRecharge ~= nil

  return atoutsDefautsArme
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

-- unpack function, compatible avec les versions de LUA 5.1 et ultérieures
-- Note : sur Planète Rôliste, l'interpréteur LUA est en version 5.1
-- Il est toutefois possible d'utiliser un environnement LUA 5.4 pour le développement
function vcUnpack(args)
  if _VERSION == "Lua 5.1" then
      return unpack(args)
  elseif _VERSION == "Lua 5.2" or _VERSION == "Lua 5.3" or _VERSION == "Lua 5.4" then
    return table.unpack(args)
  end
end

   function EvaluateTestCorpsACorps(args)

    print("EvaluateTestCorpsACorps")

    local protagoniste1,
    seuilBase1,
    seuilEffectif1,
    difficulte1,
    avantage1,
    d1_1,
    d2_1,
    bonusForce1,
    atoutsArme1,
    protagoniste2,
    seuilBase2,
    seuilEffectif2,
    difficulte2,
    avantage2,
    d1_2,
    d2_2,
    bonusEndurance2,
    atoutsArme2 = vcUnpack(args)
    local myheader = ""
    local libelleProtagoniste1 = protagoniste1 or "Protagoniste 1"
    local libelleProtagoniste2 = protagoniste2 or "Protagoniste 2"
    local syntheseResultat = ""
    myheader = myheader .. '[div style="display: flex; color: white"]'
      myheader = myheader .. '[div style="display: flex; flex-direction: column; width: 100%"]'
        myheader = myheader .. '[span style="font-size: 1.2em; font-weight: bold; text-align: center; padding-bottom: 10px"]'
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
              myheader = myheader .. "Difficulté " .. GetLibelleDifficulte(difficulte1) .. " (" .. GetLibelleModificateurDifficulte(difficulte1) .. ")"
            myheader = myheader .. "[/div]"
            myheader = myheader .. '[div style="display: flex"]'
              myheader = myheader .. avantage1 .. " Avantages (" .. GetLibelleModificateurAvantage(avantage1) .. ")"
            myheader = myheader .. "[/div]"
            myheader = myheader .. '[div style="display: flex"]'
              myheader = myheader .. "Seuil effectif : " .. seuilEffectif1
            myheader = myheader .. "[/div]"
            myheader = myheader .. '[div style="display: flex"]'
              myheader = myheader .. "Bonus de Force : " .. bonusForce1
            myheader = myheader .. "[/div]"

            if #atoutsArme1 > 0 then
              myheader = myheader .. '[div style="display: flex"]'
                myheader = myheader .. "[span]Atouts d'Arme : [/span]"
                for clef, valeur in pairs(atoutsArme1) do
                  if(valeur) then
                    myheader = myheader .. '[span]' .. valeur .. '[/span]'
                  end
                end
              myheader = myheader .. "[/div]"
            end
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
            myheader = myheader .. "Niveau " .. GetLibelleDifficulte(difficulte2) .. " (" .. GetLibelleModificateurDifficulte(difficulte2) .. ")"
            myheader = myheader .. "[/div]"
            myheader = myheader .. '[div style="display: flex"]'
            myheader = myheader .. avantage2 .. " Avantages (" .. GetLibelleModificateurAvantage(avantage2) .. ")"
            myheader = myheader .. "[/div]"
            myheader = myheader .. '[div style="display: flex"]'
            myheader = myheader .. "Seuil effectif : " .. seuilEffectif2
            myheader = myheader .. "[/div]"
            myheader = myheader .. '[div style="display: flex"]'
              myheader = myheader .. "Bonus d'Endurance : " .. bonusEndurance2
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
     d1_1_critique, d2_1_critique, libelleDegats1, ptsBlessureCritique1, effetsSupplementairesCritique1 =
      GetLibelleEffetCoupCritiques(localisationDegats1, libelleProtagoniste1, libelleProtagoniste2)
    else
     localisationDegats1 = GetLocalisationDegats(d100_1)
     libelleDegats1 = GetLibelleLocalisationDegats(localisationDegats1)
    end
    if critique2 then
     localisationDegats2 = GetLocalisationDegats(rpg.roll.dice(1, 1, 100)[1])
     d1_2_critique, d2_2_critique, libelleDegats2, ptsBlessureCritique2, effetsSupplementairesCritique2 =
      GetLibelleEffetCoupCritiques(localisationDegats2, libelleProtagoniste2, libelleProtagoniste1)
    end
    if (succes1 and critique1) then
     libelleAction1 = libelleAction1 ..
      string.format(
      "[u]%s porte un Coup Critique[/u] touchant %s avec pour effet [b]%s[/b]. Le coup fait perdre directement %d Points de Blessure, avec des effets supplémentaires : %s",
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
       "[u]En se défendant de l'attaque de %s, %s réussit un Coup Critique[/u] avec pour effet [b]%s[/b]. Le coup outrepasse l'armure éventuelle, et occasionne directement %d Dégâts, avec les effets supplémentaires suivants : %s",
       libelleProtagoniste1,
       libelleProtagoniste2,
       libelleDegats2,
       ptsBlessureCritique2,
       effetsSupplementairesCritique2
      )
    end
   
    libelleAction = libelleAction1 .. "[br/]" .. libelleAction2 .. "[br/]"


    local degatsEffectifs1, libelleCalculDegats1 = GetDegatsNonCritiques(degresReussite1, bonusForce1, degresReussite2, bonusEndurance2, "+BF +3", atoutsArme1) -- Yann
    if (degresReussite1 > degresReussite2 and true) then
      
      print(degatsEffectifs1, libelleDegats1)
     libelleAction = libelleAction ..
      string.format(
      "[u]%s attaque avec succès[/u]. Il touche %s %s et occasionne des Dégâts à hauteur de " .. libelleCalculDegats1 .. " = %d Points de Blessure",
      libelleProtagoniste1,
      libelleProtagoniste2,
      localisationDegats2,
      degatsEffectifs1
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
       string.format("[u]%s remporte le Test[/u], départagé par le Succès du lancer. Il touche %s %s et occasionne des Dégâts à hauteur de " .. libelleCalculDegats1 .. " = %d Points de Blessure",
       libelleProtagoniste1,
       libelleProtagoniste2,
       localisationDegats2,
       degatsEffectifs1
      )
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
        "[u]%s remporte le Test de peu[/u], départagé par le Seuil du Test. Il touche %s %s et occasionne des Dégâts à hauteur de " .. libelleCalculDegats1 .. " = %d Points de Blessure",
        libelleProtagoniste1,
        libelleProtagoniste2,
        localisationDegats2,
        degatsEffectifs1
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
         "[u]%s remporte le Test[/u], départagé par le Score de compétence. Il touche %s %s et occasionne des Dégâts à hauteur de " .. libelleCalculDegats1 .. " = %d Points de Blessure",
         libelleProtagoniste1,
         libelleProtagoniste2,
         localisationDegats2,
         degatsEffectifs1
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
          "[u]%s remporte le Test[/u], départagé par le Lancer de dé. Il touche %s %s et occasionne des Dégâts à hauteur de " .. libelleCalculDegats1 .. " = %d Points de Blessure",
          libelleProtagoniste1,
          libelleProtagoniste2,
          localisationDegats2,
          degatsEffectifs1
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
    elseif (succes1 and not succes2)  then
     libelleActionBis =
      libelleActionBis ..
      string.format("Le résultat est clair, sans ambigüité : %s a réussi et %s a échoué.", vainqueur, perdant)
    elseif (succes2 and not succes1) then
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
   
   function getNomDuChampPourValeur(nomDuChamp)
    -- print("getNomDuChampPourValeur:nomDuChamp", nomDuChamp)
    local champs = {}

    champs["Player"] = "Player"
    champs["Name"] = "Name"

    champs["Nom"] = "b2_l1_f1i"

    champs["Art"] = "b12_l2_f5i"
    champs["Athlétisme"] = "b12_l3_f5i"
    champs["Calme"] = "b12_l4_f5i"
    champs["Charme"] = "b12_l5_f5i"
    champs["Chevaucher"] = "b12_l6_f5i"
    champs["Corps à corps (base)"] = "b12_l7_f5i"
    champs["Corps à corps"] = "b12_l8_f5i"
    champs["Commandement"] = "b12_l9_f5i"
    champs["Conduite d'attelage"] = "b12_l10_f5i"
    champs["Discrétion"] = "b12_l11_f5i"
    champs["Divertissement"] = "b12_l12_f5i"
    champs["Emprise sur les animaux"] = "b12_l13_f5i"
    champs["Escalade"] = "b12_l14_f5i"
    champs["Esquive"] = "b13_l2_f5i"
    champs["Intimidation"] = "b13_l3_f5i"
    champs["Intuition"] = "b13_l4_f5i"
    champs["Marchandage"] = "b13_l5_f5i"
    champs["Orientation"] = "b13_l6_f5i"
    champs["Pari"] = "b13_l7_f5i"
    champs["Perception"] = "b13_l8_f5i"
    champs["Ragot"] = "b13_l9_f5i"
    champs["Ramer"] = "b13_l10_f5i"
    champs["Résistance"] = "b13_l11_f5i"
    champs["Résistance à l'alcool"] = "b13_l12_f5i"
    champs["Subornation"] = "b13_l13_f5i"
    champs["Survie en extérieur"] = "b13_l14_f5i"

    

    local resultat = champs[nomDuChamp]
    --print("getNomDuChampPourCompetence:resultat", resultat)
    return champs[nomDuChamp]
   end

   function analyseChaineTest(chaine)
    print("analyseChaineTest(s)", chaine)
    local resultat = {}
    resultat['idPersonnage'] = string.match(chaine, ".*ID%((%d-)%).*")
    resultat['competence'] = string.match(chaine, ".*Competence%((.-)%).*")
    resultat['difficulte'] = string.match(chaine, ".*Difficulté%((.-)%).*")
    return resultat
   end


   function rpg.accel.ask(s)
    print("ask", s)

    local typesTests = {}
    typesTests['simple'] = "Simple"
    typesTests['spectaculaire'] = "Spectaculaire"
    typesTests['oppose'] = "Opposé"
    typesTests['corps-a-corps'] = "Corps à Corps"
    typesTests['distance'] = "Combat à distance"

    local typetest = string.match(s, "test[%s]*([%w%p]*).*")
    local myheader, myfooter, myclass = "[b]Ton Vénéré MJ te demande de réaliser un Test[/b]", ":" .. s .. ":", "wfrp4-ask"
    local myrolls
    local labelTypeTest = typesTests[typetest]
    print(string.format("ask typetest == %s", typetest))
    print(string.format("ask labelTypeTest == %s", labelTypeTest))

    if typetest == "simple" or typetest == "spectaculaire" then

      local resultat = analyseChaineTest(s)

      local idPersonnage = resultat['idPersonnage']
      local competence = resultat['competence']
      local valeurCompetence = rpg.character.getfield(idPersonnage,getNomDuChampPourValeur(competence))
      local difficulte = resultat['difficulte']
      local libelleDifficulte = GetLibelleDifficulte(difficulte)
      local modificateurDifficulte = GetModificateurDifficulte(GetCodeDifficulte(difficulte))
      local nomPersonnage = rpg.character.getfield(idPersonnage,getNomDuChampPourValeur('Nom'))
      local seuil = valeurCompetence + modificateurDifficulte
      local nomJoueur = rpg.character.getfield(idPersonnage,getNomDuChampPourValeur('Player'))
      myrolls = string.format("[br/]C'est un Test %s de %s (%d), Difficulté %s (%d).[br/]Le seuil est donc de %d pour %s ! Fais  chauffer tes dés, %s !", labelTypeTest, competence, valeurCompetence, libelleDifficulte, modificateurDifficulte, seuil, nomPersonnage, nomJoueur)
    elseif typetest == "oppose" then
      local strings = {}
      strings[1] = string.match(s, "(.*)/.*")
      strings[2] = string.match(s, ".*/%s*(.*)%s*")
      local resultatsTests = {}

      for clef, valeur in pairs(strings) do
        if(valeur) then
          table.insert(resultatsTests, analyseChaineTest(valeur))
        end
      end

      local idPersonnage1 = resultatsTests[1]['idPersonnage']
      local idPersonnage2 = resultatsTests[2]['idPersonnage']

      local competence1 = resultatsTests[1]['competence']
      local competence2 = resultatsTests[2]['competence']

      local valeurCompetence1 = rpg.character.getfield(idPersonnage1,getNomDuChampPourValeur(competence1)) or nil
      local valeurCompetence2 = rpg.character.getfield(idPersonnage2,getNomDuChampPourValeur(competence2)) or nil

      local difficulte1 = resultatsTests[1]['difficulte'] or "I"
      local difficulte2 = resultatsTests[2]['difficulte'] or "I"

      local libelleDifficulte1 = GetLibelleDifficulte(difficulte1)
      local libelleDifficulte2 = GetLibelleDifficulte(difficulte2)

      local modificateurDifficulte1 = GetModificateurDifficulte(GetCodeDifficulte(difficulte1))
      local modificateurDifficulte2 = GetModificateurDifficulte(GetCodeDifficulte(difficulte2))

      local nomPersonnage1 = rpg.character.getfield(idPersonnage1,getNomDuChampPourValeur('Nom'))
      local nomPersonnage2 = rpg.character.getfield(idPersonnage2,getNomDuChampPourValeur('Nom'))
      local seuil1 = valeurCompetence1 + modificateurDifficulte1
      local seuil2 = valeurCompetence2 + modificateurDifficulte2

        myrolls = string.format("[br/]C'est un Test Opposé :[br/]%s : %s(%d, %s = %d)[br/]contre[br/]%s : %s(%d, %s = %d)!",  nomPersonnage1, competence1, valeurCompetence1,libelleDifficulte1, seuil1, competence2, nomPersonnage2, valeurCompetence2, libelleDifficulte2, seuil2)
      -- Gestion des tests opposés
    elseif typetest == "corps-a-corps" then
        labelTypeTest = "Corps à corps"
    elseif typetest == "distance" then
      -- Gestion du combat à distance
      labelTypeTest = "Combat à distance"
    else
      return
    end

    local myresults = "[br/]Commande à copier dans un message :"
    return rpg.smf.save(myheader, myrolls, myresults, myfooter, myclass)
   end

   function rpg.accel.test(s)
    print("s", s)
    local rolls, myheader = rpg.smf.striptitle(s)
    local typetest = string.match(s, "^([%w%p]*).*")
    print("typetest", typetest)
    local personnageIdentifie, competence, difficulte = string.match(s, "[%w%p]*[%s]*ID%(([%d]*)%)[%s]*Competence%((.*)%)[%s]*Difficulté%((.*)%)")
    local idPersonnage = personnageIdentifie or false
    local personnageIdentifie = personnageIdentifie ~= nil
    local seuilBase = tonumber(0)

    typetest = tostring(typetest) or ""
    local resultatTest
    if ((typetest == "simple" or typetest == "spectaculaire") and true) then
      if personnageIdentifie then
        local valeurCompetence = rpg.character.getfield(idPersonnage,getNomDuChampPourValeur(competence))
        seuilBase = tonumber(rpg.character.getfield(idPersonnage,getNomDuChampPourValeur(competence)))
        local nomPersonnage = rpg.character.getfield(idPersonnage,getNomDuChampPourValeur('Nom'))
        local libelleDifficulte = GetLibelleDifficulte(difficulte)
        local modificateurDifficulte = GetModificateurDifficulte(GetCodeDifficulte(difficulte))
        local seuil = valeurCompetence + modificateurDifficulte
      else
        local seuilBase, difficulte = string.match(s, "%w*[%s]*(%d*)[%s]*(%w*)[%s]*")
      end
    difficulte = GetCodeDifficulte(tostring(difficulte) or "")
    local modificateurDifficulte = GetModificateurDifficulte(difficulte)
    local seuilEffectif = GetSeuilEffectif(seuilBase, modificateurDifficulte)

    local jets = rpg.roll.dice(2, 0, 9)
    local d1 = jets[1]
    local d2 = jets[2]

    resultatTest = EvaluateTest(typetest, seuilBase, seuilEffectif, difficulte, d1, d2)

    elseif (typetest == "oppose" and true) then

    local personnageIdentifie1, competence1, difficulte1 = string.match(s, "[%w%p]*[%s]*ID%(([%d]*)%)[%s]*Competence%((.*)%)[%s]*Difficulté%((.*)%)")
    local personnageIdentifie2, competence2, difficulte2 = string.match(s, ".*/*[%s]*ID%(([%d]*)%)[%s]*Competence%((.*)%)[%s]*Difficulté%((.*)%)")
    local idPersonnage1 = personnageIdentifie1 or false
    local idPersonnage2 = personnageIdentifie2 or false
    local personnageIdentifie1 = personnageIdentifie1 ~= nil
    local personnageIdentifie2 = personnageIdentifie2 ~= nil

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
      string.match(s, "%w*[%s]+([%a%p%s]*)[%s]+(%d+)[%s]+([%w]*)[%s]*(%d*)A[%s]*(%d*)BF[%s]*.*/.*")

     local atoutsDefautsArme1 = GetAtoutsDefautsArme(string.match(s, "(.*)/"))


   
     -- caracs de base du défenseur
     local protagoniste2S = string.match(s, ".*/%s*(.*)")
     print("protagoniste2S", protagoniste2S)
     local protagoniste2, seuilBase2, difficulte2, avantage2, bonusEndurance2 =
      string.match(protagoniste2S, "([%a%p%s]*)(%d+)[%s]*([%w]*)[%s]*(%d*)A[%s]*(%d*)BE[%s]*")
   print(protagoniste2, seuilBase2, difficulte2, avantage2, bonusEndurance2)
     -- atouts éventuels du défenseur
     --local protagoniste1, seuilBase1, difficulte1, avantage1, bonusForce1, protagoniste2, seuilBase2, difficulte2, avantage2 = string.match(s, "%w*[%s]+([%w%p]*)[%s]+(%d+)[%s]+([%w]*)[%s]*(%d*)A[%s]*(%d*)BF[%s]*/[%s]*([%w%p]+)[%s]*(%d+)[%s]*([%w]*)[%s]*(%d*)A[%s]*")
   
     seuilBase1 = tonumber(seuilBase1) or nil
     seuilBase2 = tonumber(seuilBase2) or nil
   
     avantage1 = tonumber(avantage1) or 0
     avantage2 = tonumber(avantage2) or 0
   
     bonusForce1 = tonumber(bonusForce1) or 0

     bonusEndurance2 = tonumber(bonusEndurance2) or 0

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

     local atoutsDefautsArme2 = GetAtoutsDefautsArme(string.match(s, ".*/(.*)"))

     local succes1 = IsSuccess(GetD100(d1_1, d2_1), seuilEffectif1)
     local succes2 = IsSuccess(GetD100(d1_2, d2_2), seuilEffectif2)

     local echec1 = IsFailure(GetD100(d1_1, d2_1), seuilEffectif1)
     local echec2 = IsFailure(GetD100(d1_2, d2_2), seuilEffectif2)

     local critique1 = IsCritical(typetest, d1_1, d2_1)
     local critique2 = IsCritical(typetest, d1_2, d2_2)

     resultatTest = EvaluateTestCorpsACorps({
      protagoniste1,
      seuilBase1,
      seuilEffectif1,
      difficulte1,
      avantage1,
      d1_1,
      d2_1,
      bonusForce1,
      atoutsDefautsArme1,
      protagoniste2,
      seuilBase2,
      seuilEffectif2,
      difficulte2,
      avantage2,
      d1_2,
      d2_2,
      bonusEndurance2,
      atoutsDefautsArme2}
     )
    elseif (typetest == "distance" and true) then
     print("Test d'Attaque à distance:", typetest)
    else
     print("Test de type inconnu:", typetest)
    end

    return resultatTest
   end