-- Script LUA utilisable pour mettre en place des jets de dés au format Warhammer v4 sur le site PlaneteRoliste.com

OptionAutomatiqueDonneCritique = true
SuccesAutomatiqueMax = 1
EchecAutomatiqueMin = 97
OptionDoubleDonneCritique = true
OptionDRSupplementairePourSeuilsSuperieursA100 = true
ModuloBEArmeOffensive = 0.5
SourceStrings = 6921

function IsDouble(d1, d2)
    if (d1 == d2 and true) then
        return true
    else
        return false
    end
end

-- Fonction chainable, avec un appel final vide pour récupérer le résultat
-- local finalBBCode = getBBTag("Contenu intérieur", "b")("i", nil, nil, "color:red")()
local function getBBTag(bbTagContent, bbTagName, bbTagClass, bbTagStyle, bbTagId)
    local function buildBBCode(bbTagContent, bbTagName, bbTagClass, bbTagStyle, bbTagId)
        local bbCode = "[" .. bbTagName
        if bbTagId then
            bbCode = bbCode .. ' id="' .. bbTagId .. '"'
        end
        if bbTagClass then
            bbCode = bbCode .. ' class="' .. bbTagClass .. '"'
        end
        if bbTagStyle then
            bbCode = bbCode .. ' style="' .. bbTagStyle .. '"'
        end
        return bbCode .. "]" .. bbTagContent .. "[/" .. bbTagName .. "]"
    end

    local currentBBCode = buildBBCode(bbTagContent, bbTagName, bbTagClass, bbTagStyle, bbTagId)

    return function(bbTagName, bbTagClass, bbTagStyle, bbTagId)
        if not bbTagName then
            return currentBBCode
        else
            return getBBTag(currentBBCode, bbTagName, bbTagClass, bbTagStyle, bbTagId)
        end
    end
end

-- Define the BBTagBuilder
local function BBTagBuilder(bbTagName, bbTagContent, bbTagId, bbTagClass, bbTagStyle)
    local self = {
        tagName = bbTagName or "",
        children = {},
        isTextNode = false
    }

    local tagAttributes = ""
    if bbTagId then
        tagAttributes = tagAttributes .. ' id="' .. bbTagId .. '"'
    end
    if bbTagClass then
        tagAttributes = tagAttributes .. ' class="' .. bbTagClass .. '"'
    end
    if bbTagStyle then
        tagAttributes = tagAttributes .. ' style="' .. bbTagStyle .. '"'
    end
    self.tagAttributes = tagAttributes

    -- Function to add a child tag or text node
    function self.addChild(bbTagName, bbTagContent, bbTagId, bbTagClass, bbTagStyle)
        local child = BBTagBuilder(bbTagName, bbTagContent, bbTagId, bbTagClass, bbTagStyle)
        table.insert(self.children, child)
        return child
    end

    -- Automatically add the initial content as a text node if provided
    if bbTagContent and bbTagName then
        self.addChild(nil, bbTagContent)
    elseif bbTagContent and not bbTagName then
        self.isTextNode = true
        self.text = bbTagContent
    end

    -- Function to build the BBCode string recursively
    function self.build()
        local bbCode = ""

        if self.isTextNode then
            return self.text
        else
            if self.tagName ~= "" then
                bbCode = "[" .. self.tagName
                if self.tagAttributes ~= "" then
                    bbCode = bbCode .. self.tagAttributes
                end
                bbCode = bbCode .. "]"
            end

            for _, child in ipairs(self.children) do
                bbCode = bbCode .. child.build()
            end

            if self.tagName ~= "" then
                if self.tagName == "hr" then
                    -- bbCode = bbCode .. "[/" .. self.tagName .. "]"
                else
                    bbCode = bbCode .. "[/" .. self.tagName .. "]"
                end
            end
        end

        return bbCode
    end

    return self
end

-- Exemples d'utilisation du BBTagBuilder
-- local root = BBTagBuilder("div", nil, nil, nil, "display: flex; color: white")
-- local column = root.addChild("div", nil, nil, nil, "display: flex; flex-direction: column; width: 100%")
-- column.addChild("span", "Test Opposé", nil, nil, "font-size: 1.2em; font-weight: bold; text-align: center; padding-bottom: 10px")
-- column.addChild(nil, "Autre test", nil, nil, nil)
-- local flexDiv = column.addChild("div", nil, nil, nil, 'style="display: flex; width: 100%"')
-- local columnDiv = flexDiv.addChild("div", nil, nil, nil, 'style="display: flex; flex-direction: column; flex-grow: 1; align-items: center"')
-- local finalBBCode = root.build()
-- print(finalBBCode)

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
    difficulte = string.lower(difficulte) or "I"
    local difficultes, tf, f, a, i, c, d, td = {}, 60, 40, 20, 0, -10, -20, -30
    difficultes["tf"] = tf
    difficultes["f"] = f
    difficultes["a"] = a
    difficultes["i"] = i
    difficultes["c"] = c
    difficultes["d"] = d
    difficultes["td"] = td
    return difficultes[difficulte]
end

function GetCodeDifficulte(difficulte)
    difficulte = string.lower(difficulte)
    local difficultes, tf, f, a, i, c, d, td = {}, "TF", "F", "A", "I", "C", "D", "TD"
    difficultes["tf"] = tf
    difficultes["tresfacile"] = tf
    difficultes["f"] = f
    difficultes["facile"] = f
    difficultes["a"] = a
    difficultes["accessible"] = a
    difficultes["i"] = i
    difficultes["intermediaire"] = i
    difficultes["intermédiaire"] = i
    difficultes["c"] = c
    difficultes["complexe"] = c
    difficultes["d"] = d
    difficultes["difficile"] = d
    difficultes["td"] = td
    difficultes["tresdifficile"] = td
    return difficultes[difficulte]
end

function GetLibelleDifficulte(difficulte)
    difficulte = string.lower(difficulte)
    local difficultes, tf, f, a, i, c, d, td =
        {},
        "Très Facile",
        "Facile",
        "Accessible",
        "Intermédiaire",
        "Complexe",
        "Difficile",
        "Très Difficile"
    difficultes["tf"] = tf
    difficultes["tresfacile"] = tf
    difficultes["f"] = f
    difficultes["facile"] = f
    difficultes["a"] = a
    difficultes["accessible"] = a
    difficultes["i"] = i
    difficultes["intermediaire"] = i
    difficultes["intermédiaire"] = i
    difficultes["c"] = c
    difficultes["complexe"] = c
    difficultes["d"] = d
    difficultes["difficile"] = d
    difficultes["td"] = td
    difficultes["tresdifficile"] = td
    return difficultes[difficulte]
end

function GetLibelleModificateurDifficulte(difficulte)
    difficulte = string.lower(difficulte)
    local difficultes, tf, f, a, i, c, d, td = {}, "+60", "+40", "+20", "+0", "-10", "-20", "-30"
    difficultes["tf"] = tf
    difficultes["tresfacile"] = tf
    difficultes["f"] = f
    difficultes["facile"] = f
    difficultes["a"] = a
    difficultes["accessible"] = a
    difficultes["i"] = i
    difficultes["intermediaire"] = i
    difficultes["intermédiaire"] = i
    difficultes["c"] = c
    difficultes["complexe"] = c
    difficultes["d"] = d
    difficultes["difficile"] = d
    difficultes["td"] = td
    difficultes["tresdifficile"] = td
    return difficultes[difficulte]
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
    seuilDeBase = tonumber(seuilDeBase)
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
    local appliqueBF, degatsEffectifsArme = string.match(degatsArme, ".*(%+BF)%s*(%+%d*)")
    appliqueBF = appliqueBF ~= nil
    degatsEffectifsArme = tonumber(degatsEffectifsArme)

    if appliqueBF then
        degatsEffectifsArme = degatsEffectifsArme + BFattaquant
    else
        degatsEffectifsArme = degatsEffectifsArme
    end

    degatsEffectifs = degatsEffectifsArme + bilanDR
    local libelleCalculDegats = string.format("%dDR %s", bilanDR, degatsArme)
    local libelleBE = ""

    if (ModuloBEArmeOffensive < 1 and not atoutsDefautsArme["inoffensive"] and true) then
        degatsEffectifs = degatsEffectifs - math.ceil(BEattaque * ModuloBEArmeOffensive)
        libelleBE = string.format(" - (%dBE * %.1f)", BEattaque, ModuloBEArmeOffensive)
    else
        degatsEffectifs = degatsEffectifs - BEattaque
        libelleBE = string.format(" - %dBE", BEattaque)
    end

    libelleCalculDegats = libelleCalculDegats .. libelleBE

    if (degatsEffectifs < 0 and true) then
        degatsEffectifs = 0
    end
    return degatsEffectifs, libelleCalculDegats
end

function getFromRange(value, range)
    for _, range in ipairs(range) do
        if value >= range[1] and value <= range[2] then
            return range[3]
        end
    end
    return
end

function GetLocalisationDegats(d100)
    d100 = tonumber(d100)
    local ranges = {
        {1, 9, "Tête"},
        {21, 41, "Bras secondaire"},
        {25, 44, "Bras principal"},
        {45, 79, "Corps"},
        {80, 89, "Jambe gauche"},
        {90, 100, "Jambe droite"}
    }
    return getFromRange(d100, ranges)
end

function GetLibelleLocalisationDegats(localisationDegats)
    local libelleLocalisationDegats = {}
    local prefixe = "LibLocDegats"
    localisationDegats["tête"] = GetExternalString(prefixe .. "Tete")
    localisationDegats["bras secondaire"] = GetExternalString(prefixe .. "BrasG")
    localisationDegats["bras principal"] = GetExternalString(prefixe .. "BrasD")
    localisationDegats["corps"] = GetExternalString(prefixe .. "Corps")
    localisationDegats["jambe gauche"] = GetExternalString(prefixe .. "JambeG")
    localisationDegats["jambe droite"] = GetExternalString(prefixe .. "JambeD")
    return localisationDegats[localisationDegats]
end

function GetLibelleEffetMaladresse(d100, attaquant)
    d100 = tonumber(d100)
    local prefixe = "LibLocEffMal"
    local ranges = {
        {1, 20, getExternalFunction(prefixe .. "1")},
        {21, 40, getExternalFunction(prefixe .. "2")},
        {41, 60, getExternalFunction(prefixe .. "3")},
        {61, 70, getExternalFunction(prefixe .. "4")},
        {71, 80, getExternalFunction(prefixe .. "5")},
        {81, 90, getExternalFunction(prefixe .. "6")},
        {91, 100, getExternalFunction(prefixe .. "7")}
    }
    return string.format(getFromRange(d100, ranges), attaquant)
end

function GetLibelleEffetCoupCritiques(localisationDegats, attaquant, attaque)
    local jet = rpg.roll.dice(2, 0, 9)
    local d1 = jet[1]
    local d2 = jet[2]
    local testVar = "testVar :)"

    local d100 = GetD100(d1, d2)

    local description = ""
    local ptsBlessure = 0
    local effetsSupplementaires = ""
    local prefixe = "LibEffCrit"
    local j = 1
    if localisationDegats == "Tête" then
        if d100 >= 1 and d100 <= 10 then
            description = "Blessure spectaculaire"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 11 and d100 <= 20 then
            description = "Coupure mineure"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 21 and d100 <= 25 then
            description = "Coup à l'oeil"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 26 and d100 <= 30 then
            description = "Frappe à l'oreille"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 31 and d100 <= 35 then
            description = "Coup percutant"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 36 and d100 <= 40 then
            description = "Oeil au beurre noir"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 41 and d100 <= 45 then
            description = "Oreille tranchée"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 46 and d100 <= 50 then
            description = "En plein front"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 51 and d100 <= 55 then
            description = "Mâchoire fracturée"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 56 and d100 <= 60 then
            description = "Blessure majeure à l'oeil"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 61 and d100 <= 65 then
            description = "Blessure majeure à l'oreille"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque, attaque, attaque)
        elseif d100 >= 66 and d100 <= 70 then
            description = "Nez cassé"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 71 and d100 <= 75 then
            description = "Mâchoire cassée"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 76 and d100 <= 80 then
            description = "Commotion cérébrale"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 81 and d100 <= 85 then
            description = "Bouche explosée"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 86 and d100 <= 90 then
            description = "Oreille mutilée"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque, attaquant)
        elseif d100 >= 91 and d100 <= 93 then
            description = "Œil crevé"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 94 and d100 <= 96 then
            description = "Coup défigurant"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 97 and d100 <= 99 then
            description = "Mâchoire mutilée"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 == 100 then
            description = "Mort"
            ptsBlessure = 666
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        end
    elseif localisationDegats == "Bras secondaire" or localisationDegats == "Bras principal" then
        if d100 >= 1 and d100 <= 10 then
            description = "Choc au bras"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque)
        elseif d100 >= 11 and d100 <= 20 then
            description = "Coupure mineure"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 21 and d100 <= 25 then
            description = "Torsion"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 26 and d100 <= 30 then
            description = "Choc violent au bras"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque, localisationDegats)
        elseif d100 >= 31 and d100 <= 35 then
            description = "Déchirure musculaire"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque)
        elseif d100 >= 36 and d100 <= 40 then
            description = "Main ensanglantée"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque)
        elseif d100 >= 41 and d100 <= 45 then
            description = "Clef de bras"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque)
        elseif d100 >= 46 and d100 <= 50 then
            description = "Blessure béante"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque, localisationDegats)
        elseif d100 >= 51 and d100 <= 55 then
            description = "Cassure nette"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque)
        elseif d100 >= 56 and d100 <= 60 then
            description = "Ligament rompu"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque, localisationDegats)
        elseif d100 >= 61 and d100 <= 65 then
            description = "Coupure profonde"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque)
        elseif d100 >= 66 and d100 <= 70 then
            description = "Artère endommagée"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque, localisationDegats)
        elseif d100 >= 71 and d100 <= 75 then
            description = "Coude fracassé"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque, attaque)
        elseif d100 >= 76 and d100 <= 80 then
            description = "Épaule luxée"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque, attaque)
        elseif d100 >= 81 and d100 <= 85 then
            description = "Doigt sectionné"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 86 and d100 <= 90 then
            description = "Main ouverte"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque)
        elseif d100 >= 91 and d100 <= 93 then
            description = "Biceps déchiqueté"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque)
        elseif d100 >= 94 and d100 <= 96 then
            description = "Main mutilée"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque)
        elseif d100 >= 97 and d100 <= 99 then
            description = "Tendons coupés"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque)
        elseif d100 == 100 then
            description = "Démembrement fatal"
            ptsBlessure = 666
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), localisationDegats, attaque)
        end
    elseif localisationDegats == "Corps" then
        if d100 >= 1 and d100 <= 10 then
            description = "Rien qu'une égratignure !"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 11 and d100 <= 20 then
            description = "Coup au ventre"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 21 and d100 <= 25 then
            description = "Coup bas"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 26 and d100 <= 30 then
            description = "Torsion du dos"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 31 and d100 <= 35 then
            description = "Souffle coupé"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 36 and d100 <= 40 then
            description = "Bleus aux côtes"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 41 and d100 <= 45 then
            description = "Clavicule tordue"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 46 and d100 <= 50 then
            description = "Chairs déchirées"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 51 and d100 <= 55 then
            description = "Côtes fracturées"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 56 and d100 <= 60 then
            description = "Blessure béante"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque, localisationDegats)
        elseif d100 >= 61 and d100 <= 65 then
            description = "Entaille douloureuse"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 66 and d100 <= 70 then
            description = "Dégâts artériels"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque, localisationDegats)
        elseif d100 >= 71 and d100 <= 75 then
            description = "Dos froissé"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 76 and d100 <= 80 then
            description = "Hanche fracturée"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 81 and d100 <= 85 then
            description = "Blessure majeure au torse"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 86 and d100 <= 90 then
            description = "Blessure au ventre"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 91 and d100 <= 93 then
            description = "Cage thoracique perforée"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 94 and d100 <= 96 then
            description = "Clavicule cassée"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 97 and d100 <= 99 then
            description = "Hémorragie interne"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 == 100 then
            description = "Éventré"
            ptsBlessure = 666
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        end
    elseif localisationDegats == "Jambe gauche" or localisationDegats == "Jambe droite" then
        if d100 >= 1 and d100 <= 10 then
            description = "Orteil contusionné"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 11 and d100 <= 20 then
            description = "Cheville tordue"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 21 and d100 <= 25 then
            description = "Coupure mineure"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 26 and d100 <= 30 then
            description = "Perte d'équilibre"
            ptsBlessure = 1
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 31 and d100 <= 35 then
            description = "Coup à la cuisse"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 36 and d100 <= 40 then
            description = "Cheville foulée"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 41 and d100 <= 45 then
            description = "Genou tordu"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 46 and d100 <= 50 then
            description = "Coupure à l'orteil"
            ptsBlessure = 2
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j))
        elseif d100 >= 51 and d100 <= 55 then
            description = "Mauvaise coupure"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 56 and d100 <= 60 then
            description = "Genou méchamment tordu"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 61 and d100 <= 65 then
            description = "Jambe charcutée"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 66 and d100 <= 70 then
            description = "Cuisse lacérée"
            ptsBlessure = 3
            j = j + 1
            effetsSupplementaires =
                string.format(GetExternalString(prefixe .. j), attaquant, attaque, attaque, localisationDegats)
        elseif d100 >= 71 and d100 <= 75 then
            description = "Tendon rompu"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque, attaque)
        elseif d100 >= 76 and d100 <= 80 then
            description = "Entaille au tibia"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 81 and d100 <= 85 then
            description = "Genou cassé"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque, attaque)
        elseif d100 >= 86 and d100 <= 90 then
            description = "Genou démis"
            ptsBlessure = 4
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 91 and d100 <= 93 then
            description = "Pied écrasé"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque)
        elseif d100 >= 94 and d100 <= 96 then
            description = "Pied sectionné"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque)
        elseif d100 >= 97 and d100 <= 99 then
            description = "Tendon coupé"
            ptsBlessure = 5
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaque, attaque)
        elseif d100 == 100 then
            description = "Bassin fracassé"
            ptsBlessure = 666
            j = j + 1
            effetsSupplementaires = string.format(GetExternalString(prefixe .. j), attaquant, attaque, attaque)
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

function GetArmesEnMain(idPersonnage)
    local armeEnMain, deuxiemeArme = {}, {}

    for i = 2, 11, 1 do
        local nomArme = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f1i", i))
        if (rpg.character.getfield(idPersonnage, string.format("b43_l%d_f7c", i)) ~= "" and true) then
            armeEnMain["Nom"] = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f1i", i))
            armeEnMain["Groupe"] = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f2i", i))
            armeEnMain["Encombrement"] = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f3i", i))
            armeEnMain["PorteeAllonge"] = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f4i", i))
            armeEnMain["Degats"] = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f5i", i))
            armeEnMain["AtoutsDefauts"] = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f6i", i))
        end
    end

    for i = 2, 11, 1 do
        local nomArme = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f1i", i))
        if (rpg.character.getfield(idPersonnage, string.format("b43_l%d_f8c", i)) ~= "" and true) then
            deuxiemeArme["Nom"] = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f1i", i))
            deuxiemeArme["Groupe"] = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f2i", i))
            deuxiemeArme["Encombrement"] = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f3i", i))
            deuxiemeArme["PorteeAllonge"] = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f4i", i))
            deuxiemeArme["Degats"] = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f5i", i))
            deuxiemeArme["AtoutsDefauts"] = rpg.character.getfield(idPersonnage, string.format("b43_l%d_f6i", i))
        end
    end
    print("armeEnMain, deuxiemeArme:", armeEnMain, deuxiemeArme)
    return armeEnMain, deuxiemeArme
end

function GetAvantage(idPersonnage)
    -- print("GetAvantage1", rpg.character.getfield(idPersonnage, string.format("b46_l1_f1c")))
    -- print("GetAvantage2", rpg.character.getfield(idPersonnage, string.format("b46_l1_f2c")))
    local valeurAvantage = 0
    for i = 1, 10, 1 do
        if (rpg.character.getfield(idPersonnage, string.format("b46_l1_f%dc", i)) == "on" and true) then
            valeurAvantage = i
        end
    end
    return valeurAvantage
end

function GetBonusForce(idPersonnage)
    local bonusForce = tonumber(rpg.character.getfield(idPersonnage, "b40_l1_f1i")) or 0

    if (bonusForce > 0) then
        return bonusForce
    else
        return 0
    end
end

function GetBonusEndurance(idPersonnage)
    local bonusEndurance = tonumber(rpg.character.getfield(idPersonnage, "b40_l2_f1i")) or 0

    if (bonusEndurance > 0) then
        return bonusEndurance
    else
        return 0
    end
end

function EvaluateTest(
    typetest,
    nomPersonnage,
    competence,
    seuilBase,
    seuilEffectif,
    difficulte,
    modificateurDifficulte,
    d1,
    d2)
    print("EvaluateTest", typetest, competence, seuilBase, seuilEffectif, difficulte, modificateurDifficulte, d1, d2)
    typetest = string.lower(typetest)
    local syntheseResultat = ""
    local prefixe = "EvaTst"
    if typetest == "simple" then
        if seuilEffectif and difficulte then
            local myHeaderTree = BBTagBuilder("div", nil, nil, nil, "display: flex; color: white")
            local columns1 =
                myHeaderTree.addChild("div", nil, nil, nil, "display: flex; flex-direction: column; width: 100%")

            columns1.addChild(
                "span",
                string.format("Résultat du Test %s", typetest),
                nil,
                nil,
                "font-size: 1.2em; font-weight: bold; text-align: center; padding-bottom: 10px"
            )
            local twocolumns1 = columns1.addChild("div", nil, nil, nil, "display: flex; width: 100%")
            local twocolumns1_1 =
                twocolumns1.addChild(
                "div",
                nil,
                nil,
                nil,
                "display: flex; flex-direction: column; flex-grow: 1; align-items: center"
            )
            twocolumns1_1.addChild("div", nomPersonnage, nil, nil, "display: flex; font-weight: bold")
            twocolumns1_1.addChild("div", competence .. " (" .. seuilBase .. ")", nil, nil, "display: flex")
            twocolumns1_1.addChild(
                "div",
                "Difficulté " ..
                    GetLibelleDifficulte(difficulte) .. " (" .. GetLibelleModificateurDifficulte(difficulte) .. ")",
                nil,
                nil,
                "display: flex"
            )
            twocolumns1_1.addChild("div", "Seuil effectif : " .. seuilEffectif, nil, nil, "display: flex")

            local myheader = myHeaderTree.build()

            local myRollsTree = BBTagBuilder("div", nil, nil, nil, "display: flex; color: white")
            local myRollsColumns1 =
                myRollsTree.addChild("div", nil, nil, nil, "display: flex; flex-direction: row; width: 100%")
            local myRollsTwocolumns1 =
                myRollsColumns1.addChild("div", nil, nil, nil, "display: flex; width: 100%; justify-content: center")
            myRollsTwocolumns1.addChild("div", d1, nil, "yellow_d10", GetExternalString("EvaTst2"))
            myRollsTwocolumns1.addChild("div", d2, nil, "white_d10", GetExternalString("EvaTst2"))

            local myrolls = myRollsTree.build()

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
                string.format(GetExternalString(prefixe .. 3), d100, seuilEffectif, libelleResultat, libelleCritique)
            local myfooter = ""
            if succes and not critique then
                myfooter = string.format(GetExternalString(prefixe .. 4))
            elseif succes and critique then
                myfooter = string.format(GetExternalString(prefixe .. 5))
            elseif not succes and not critique then
                myfooter = string.format(GetExternalString(prefixe .. 6))
            elseif not succes and critique then
                myfooter = string.format(GetExternalString(prefixe .. 7))
            end

            return rpg.smf.save(myheader, myrolls, myresults, myfooter, "wfrp4")
        end
    elseif typetest == "spectaculaire" then
        local myHeaderTree = BBTagBuilder("div", nil, nil, nil, "display: flex; color: white")
        local columns1 =
            myHeaderTree.addChild("div", nil, nil, nil, "display: flex; flex-direction: column; width: 100%")

        columns1.addChild(
            "span",
            string.format("Résultat du Test %s", typetest),
            nil,
            nil,
            "font-size: 1.2em; font-weight: bold; text-align: center; padding-bottom: 10px"
        )
        local twocolumns1 = columns1.addChild("div", nil, nil, nil, "display: flex; width: 100%")
        local twocolumns1_1 =
            twocolumns1.addChild(
            "div",
            nil,
            nil,
            nil,
            "display: flex; flex-direction: column; flex-grow: 1; align-items: center"
        )
        twocolumns1_1.addChild("div", nomPersonnage, nil, nil, "display: flex; font-weight: bold")
        twocolumns1_1.addChild("div", competence .. " (" .. seuilBase .. ")", nil, nil, "display: flex")
        twocolumns1_1.addChild(
            "div",
            "Difficulté " ..
                GetLibelleDifficulte(difficulte) .. " (" .. GetLibelleModificateurDifficulte(difficulte) .. ")",
            nil,
            nil,
            "display: flex"
        )
        twocolumns1_1.addChild("div", "Seuil effectif : " .. seuilEffectif, nil, nil, "display: flex")

        local myheader = myHeaderTree.build()

        local myRollsTree = BBTagBuilder("div", nil, nil, nil, "display: flex; color: white")
        local myRollsColumns1 =
            myRollsTree.addChild("div", nil, nil, nil, "display: flex; flex-direction: row; width: 100%")
        local myRollsTwocolumns1 =
            myRollsColumns1.addChild("div", nil, nil, nil, "display: flex; width: 100%; justify-content: center")
        myRollsTwocolumns1.addChild("div", d1, nil, "yellow_d10", GetExternalString("EvaTst2"))
        myRollsTwocolumns1.addChild("div", d2, nil, "white_d10", GetExternalString("EvaTst2"))

        local myrolls = myRollsTree.build()
        local d100 = GetD100(d1, d2)
        local succes = IsSuccess(d100, seuilEffectif)
        local critique = IsCritical(typetest, d1, d2)
        local degresReussite = GetDegresReussite(d100, seuilEffectif)
        local libelleResultat = ""
        local libelleAmpleur = ""
        local libelleAction = ""
        if succes == true then
            if critique then
                syntheseResultat = string.format(GetExternalString(prefixe .. 9), d100, seuilEffectif, degresReussite)
                libelleAction = string.format(GetExternalString(prefixe .. 10))
            else
                if (degresReussite >= 6 and true) then
                    syntheseResultat =
                        string.format(GetExternalString(prefixe .. 11), d100, seuilEffectif, degresReussite)
                    libelleAction = string.format(GetExternalString(prefixe .. 12))
                elseif (degresReussite == 4 or degresReussite == 5) then
                    syntheseResultat =
                        string.format(GetExternalString(prefixe .. 13), d100, seuilEffectif, degresReussite)
                    libelleAction = string.format(GetExternalString(prefixe .. 14))
                elseif degresReussite == 2 or degresReussite == 3 then
                    syntheseResultat =
                        string.format(GetExternalString(prefixe .. 15), d100, seuilEffectif, degresReussite)
                    libelleAction = string.format(GetExternalString(prefixe .. 16))
                elseif degresReussite == 0 or degresReussite == 1 then
                    syntheseResultat =
                        string.format(GetExternalString(prefixe .. 17), d100, seuilEffectif, degresReussite)
                    libelleAction = string.format(GetExternalString(prefixe .. 18))
                end
            end
        elseif succes == false then
            if critique then
                syntheseResultat = string.format(GetExternalString(prefixe .. 19), d100, seuilEffectif, degresReussite)
                libelleAction = string.format(GetExternalString(prefixe .. 20))
            else
                if degresReussite <= -6 then
                    syntheseResultat =
                        string.format(GetExternalString(prefixe .. 21), d100, seuilEffectif, degresReussite)
                    libelleAction = string.format(GetExternalString(prefixe .. 22))
                elseif degresReussite == -4 or degresReussite == -5 then
                    syntheseResultat =
                        string.format(GetExternalString(prefixe .. 23), d100, seuilEffectif, degresReussite)
                    libelleAction = string.format(GetExternalString(prefixe .. 24))
                elseif degresReussite == -2 or degresReussite == -3 then
                    syntheseResultat =
                        string.format(GetExternalString(prefixe .. 25), d100, seuilEffectif, degresReussite)
                    libelleAction = string.format(GetExternalString(prefixe .. 26))
                elseif degresReussite == 0 or degresReussite == -1 then
                    syntheseResultat =
                        string.format(GetExternalString(prefixe .. 27), d100, seuilEffectif, degresReussite)
                    libelleAction = string.format(GetExternalString(prefixe .. 28))
                end
            end
        end

        local myresults = syntheseResultat
        local myfooter = libelleAction

        return rpg.smf.save(myheader, myrolls, myresults, myfooter, "wfrp4")
    else
        return rpg.smf.save("Type de test inconnu", "myrolls", "myresults", "myfooter", "wfrp4")
    end
end

function EvaluateTestOppose(
    protagoniste1,
    competence1,
    seuilBase1,
    seuilEffectif1,
    difficulte1,
    d1_1,
    d2_1,
    protagoniste2,
    competence2,
    seuilBase2,
    seuilEffectif2,
    difficulte2,
    d1_2,
    d2_2)
    local myheader = ""

    local libelleProtagoniste1 = protagoniste1 or "Protagoniste 1"
    local libelleProtagoniste2 = protagoniste2 or "Protagoniste 2"

    -- getBBTag(libelleProtagoniste1, "div", nil, "display: flex; font-weight: bold", nil)

    local myHeaderTree = BBTagBuilder("div", nil, nil, nil, "display: flex; color: white")
    local columns1 = myHeaderTree.addChild("div", nil, nil, nil, "display: flex; flex-direction: column; width: 100%")

    columns1.addChild(
        "span",
        "Résultat du Test Opposé",
        nil,
        nil,
        "font-size: 1.2em; font-weight: bold; text-align: center; padding-bottom: 10px"
    )
    local twocolumns1 = columns1.addChild("div", nil, nil, nil, "display: flex; width: 100%")
    local twocolumns1_1 =
        twocolumns1.addChild(
        "div",
        nil,
        nil,
        nil,
        "display: flex; flex-direction: column; flex-grow: 1; align-items: center"
    )
    twocolumns1_1.addChild("div", libelleProtagoniste1, nil, nil, "display: flex; font-weight: bold")
    twocolumns1_1.addChild("div", competence1 .. " (" .. seuilBase1 .. ")", nil, nil, "display: flex")
    twocolumns1_1.addChild(
        "div",
        "Difficulté " ..
            GetLibelleDifficulte(difficulte1) .. " (" .. GetLibelleModificateurDifficulte(difficulte1) .. ")",
        nil,
        nil,
        "display: flex"
    )
    twocolumns1_1.addChild("div", "Seuil effectif : " .. seuilEffectif1, nil, nil, "display: flex")

    twocolumns1.addChild("hr", nil, nil, nil, "border: color; margin: 5px; width: 2px")

    local twocolumns1_2 =
        twocolumns1.addChild(
        "div",
        nil,
        nil,
        nil,
        "display: flex; flex-direction: column; flex-grow: 1; align-items: center"
    )
    twocolumns1_2.addChild("div", libelleProtagoniste2, nil, nil, "display: flex; font-weight: bold")
    twocolumns1_2.addChild("div", competence2 .. " (" .. seuilBase2 .. ")", nil, nil, "display: flex")
    twocolumns1_2.addChild(
        "div",
        "Difficulté " ..
            GetLibelleDifficulte(difficulte2) .. " (" .. GetLibelleModificateurDifficulte(difficulte2) .. ")",
        nil,
        nil,
        "display: flex"
    )
    twocolumns1_2.addChild("div", "Seuil effectif : " .. seuilEffectif2, nil, nil, "display: flex")

    local myheader = myHeaderTree.build()

    local myRollsTree = BBTagBuilder("div", nil, nil, nil, "display: flex; color: white")
    local myRollsColumns1 =
        myRollsTree.addChild("div", nil, nil, nil, "display: flex; flex-direction: row; width: 100%")
    local myRollsTwocolumns1 =
        myRollsColumns1.addChild("div", nil, nil, nil, "display: flex; width: 100%; justify-content: center")
    myRollsTwocolumns1.addChild("div", d1_1, nil, "yellow_d10", GetExternalString("EvaTst2"))
    myRollsTwocolumns1.addChild("div", d2_1, nil, "white_d10", GetExternalString("EvaTst2"))

    myRollsColumns1.addChild("hr", nil, nil, nil, "border: color; margin: 5px; width: 2px;")

    local myRollsTwocolumns2 =
        myRollsColumns1.addChild("div", nil, nil, nil, "display: flex; width: 100%; justify-content: center")
    myRollsTwocolumns2.addChild("div", d1_2, nil, "yellow_d10", GetExternalString("EvaTst2"))
    myRollsTwocolumns2.addChild("div", d2_2, nil, "white_d10", GetExternalString("EvaTst2"))

    local myrolls = myRollsTree.build()

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

    local myResultsTree = BBTagBuilder("div", nil, nil, nil, "display: flex; color: white")
    local myResultsColumns1 =
        myResultsTree.addChild("div", nil, nil, nil, "display: flex; flex-direction: row; width: 100%")
    local myResultsTwocolumns1 =
        myResultsColumns1.addChild("div", nil, nil, nil, "display: flex; width: 100%; justify-content: center")
    myResultsTwocolumns1.addChild("span", syntheseResultat1, nil, nil, "color: white")

    myResultsColumns1.addChild("hr", nil, nil, nil, "border: color; margin: 5px; width: 2px;")

    local myResultsTwocolumns2 =
        myResultsColumns1.addChild("div", nil, nil, nil, "display: flex; width: 100%; justify-content: center")
    myResultsTwocolumns2.addChild("span", syntheseResultat2, nil, nil, "color: white")

    local myresults = myResultsTree.build()

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
    myheader = myheader .. '[div style="display: flex"]'
    myheader = myheader .. "Bonus de Force : " .. bonusForce1
    myheader = myheader .. "[/div]"

    if #atoutsArme1 > 0 then
        myheader = myheader .. '[div style="display: flex"]'
        myheader = myheader .. "[span]Atouts d'Arme : [/span]"
        for clef, valeur in pairs(atoutsArme1) do
            if (valeur) then
                myheader = myheader .. "[span]" .. valeur .. "[/span]"
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
    myheader =
        myheader ..
        "Niveau " .. GetLibelleDifficulte(difficulte2) .. " (" .. GetLibelleModificateurDifficulte(difficulte2) .. ")"
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
        libelleAction1 =
            libelleAction1 ..
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
        libelleAction2 =
            libelleAction2 ..
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

    local degatsEffectifs1, libelleCalculDegats1 =
        GetDegatsNonCritiques(degresReussite1, bonusForce1, degresReussite2, bonusEndurance2, "+BF +3", atoutsArme1) -- Yann
    if (degresReussite1 > degresReussite2 and true) then
        libelleAction =
            libelleAction ..
            string.format(
                "[u]%s attaque avec succès[/u]. Il touche %s %s et occasionne des Dégâts à hauteur de " ..
                    libelleCalculDegats1 .. " = %d Points de Blessure",
                libelleProtagoniste1,
                libelleProtagoniste2,
                localisationDegats2,
                degatsEffectifs1
            )
        vainqueur = libelleProtagoniste1
        perdant = libelleProtagoniste2
    elseif (degresReussite1 < degresReussite2 and true) then
        libelleAction =
            libelleAction ..
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
                libelleAction ..
                string.format(
                    "[u]%s remporte le Test[/u], départagé par le Succès du lancer. Il touche %s %s et occasionne des Dégâts à hauteur de " ..
                        libelleCalculDegats1 .. " = %d Points de Blessure",
                    libelleProtagoniste1,
                    libelleProtagoniste2,
                    localisationDegats2,
                    degatsEffectifs1
                )
            vainqueur = libelleProtagoniste1
            perdant = libelleProtagoniste2
        elseif succes2 and not succes1 then
            libelleAction =
                libelleAction ..
                string.format("[u]%s remporte le Test[/u], départagé par le Succès du lancer.", libelleProtagoniste2)
            vainqueur = libelleProtagoniste2
            perdant = libelleProtagoniste1
        elseif (succes1 and succes1) or (not succes1 and not succes2) then
            if (seuilEffectif1 > seuilEffectif2 and true) then
                libelleAction =
                    libelleAction ..
                    string.format(
                        "[u]%s remporte le Test de peu[/u], départagé par le Seuil du Test. Il touche %s %s et occasionne des Dégâts à hauteur de " ..
                            libelleCalculDegats1 .. " = %d Points de Blessure",
                        libelleProtagoniste1,
                        libelleProtagoniste2,
                        localisationDegats2,
                        degatsEffectifs1
                    )
                vainqueur = libelleProtagoniste1
                perdant = libelleProtagoniste2
            elseif (seuilEffectif1 < seuilEffectif2 and true) then
                libelleAction =
                    libelleAction ..
                    string.format("[u]%s remporte le Test[/u], départagé par le Seuil du Test.", libelleProtagoniste2)
                vainqueur = libelleProtagoniste2
                perdant = libelleProtagoniste1
            elseif (seuilEffectif1 == seuilEffectif2 and true) then
                if seuilBase1 > seuilBase2 then
                    libelleAction =
                        libelleAction ..
                        string.format(
                            "[u]%s remporte le Test[/u], départagé par le Score de compétence. Il touche %s %s et occasionne des Dégâts à hauteur de " ..
                                libelleCalculDegats1 .. " = %d Points de Blessure",
                            libelleProtagoniste1,
                            libelleProtagoniste2,
                            localisationDegats2,
                            degatsEffectifs1
                        )
                    vainqueur = libelleProtagoniste1
                    perdant = libelleProtagoniste2
                elseif (seuilBase1 < seuilBase2 and true) then
                    libelleAction =
                        libelleAction ..
                        string.format(
                            "[u]%s remporte le Test[/u], départagé par le Score de compétence.",
                            libelleProtagoniste2
                        )
                    vainqueur = libelleProtagoniste2
                    perdant = libelleProtagoniste1
                elseif (seuilBase1 == seuilBase2 and true) then
                    if (d100_1 < d100_2 and true) then
                        libelleAction =
                            libelleAction ..
                            string.format(
                                "[u]%s remporte le Test[/u], départagé par le Lancer de dé. Il touche %s %s et occasionne des Dégâts à hauteur de " ..
                                    libelleCalculDegats1 .. " = %d Points de Blessure",
                                libelleProtagoniste1,
                                libelleProtagoniste2,
                                localisationDegats2,
                                degatsEffectifs1
                            )
                        vainqueur = libelleProtagoniste1
                        perdant = libelleProtagoniste2
                    elseif (d100_1 > d100_2 and true) then
                        libelleAction =
                            libelleAction ..
                            string.format(
                                "[u]%s remporte le Test[/u], départagé par le Lancer de dé.",
                                libelleProtagoniste2
                            )
                        vainqueur = libelleProtagoniste2
                        perdant = libelleProtagoniste1
                    elseif (d100_1 == d100_2 and true) then
                        libelleAction =
                            libelleAction ..
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
    elseif (succes1 and not succes2) then
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

    myfooter =
        myfooter ..
        '[hr style="border: color; margin: 5px; "]' ..
            '[div style="display: flex;margin-top: 10px"]' ..
                '[div style="display: flex; flex-grow: 1; justify-content: center"]' ..
                    '[div style="color: white"]' ..
                        '[div style="color: white; font-size: 1.2em; font-weight: bold; padding-bottom:5px; line-height: 1.4em"]' ..
                            libelleAction ..
                                "[/div]" ..
                                    '[div style="color: white; font-weight: bold; padding-top:5px"]' ..
                                        libelleActionBis .. "[/div]" .. "[/div]" .. "[/div]" .. "[/div]"

    return rpg.smf.save(myheader, myrolls, myresults, myfooter, "wfrp4")
end

function getNomDuChampPourValeur(nomDuChamp, idPersonnage)
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

    for i = 2, 14, 1 do
        if
            (rpg.character.getfield(idPersonnage, string.format("b14_l%d_f1i", i)) ~= "" and
                rpg.character.getfield(idPersonnage, string.format("b14_l%d_f1i", i)) ~= nil and
                true)
         then
            champs[rpg.character.getfield(idPersonnage, string.format("b14_l%d_f1i", i))] =
                string.format("b14_l%d_f5i", i)
        end
    end

    local resultat = champs[nomDuChamp]

    return resultat
end

function analyseChaineTest(chaine)
    local resultat = {}
    resultat["idPersonnage"] = string.match(chaine, ".*ID%((%d-)%).*")
    resultat["competence"] = string.match(chaine, ".*Competence%((.-)%)%s.*")
    resultat["difficulte"] = string.match(chaine, ".*Difficulté%((.-)%).*")
    return resultat
end

function rpg.accel.ask(s)
    print("ask", s, _VERSION)
    return launch(s, "ask")
end

function rpg.accel.test(s)
    print("test", s, _VERSION)
    return launch(s, "run")
end

function fakelaunch(s, mode)
    print(s, mode)
end

function GetExternalString(cle)
    cle = tostring(cle)

    for i = 2, 500, 1 do
        local currentKey = rpg.character.getfield(SourceStrings, string.format("b1_l%d_f1i", i))
        local currentValue = rpg.character.getfield(SourceStrings, string.format("b1_l%d_f2i", i))
        if (currentKey ~= "" and currentKey ~= nil and cle == currentKey) then
            return currentValue
        end
    end
    return ""
end

function getExternalFunction(cle)
    local loadfunc
    for i = 2, 31, 1 do
        local currentKey = rpg.character.getfield(SourceStrings, string.format("b2_l%d_f1i", i))
        local currentValue = rpg.character.getfield(SourceStrings, string.format("b2_l%d_f2t", i))
        if (currentKey ~= "" and currentKey ~= nil and cle == currentKey) then
            if _VERSION == "Lua 5.1" then
                loadfunc, err = loadstring(currentValue)
            elseif _VERSION == "Lua 5.2" or _VERSION == "Lua 5.3" or _VERSION == "Lua 5.4" then
                loadfunc, err = load(currentValue)
            end

            if loadfunc then
                return loadfunc
            else
                print("Compilation error:", err)
            end
            return currentValue
        end
    end
    return false
end

function launch(s, mode)
    print("launch", s, mode)
    -- local testFunc = getExternalFunction("testExternalFunction")
    -- local testString= = GetExternalString("ExempleYann")
    -- local testFormattedString = string.format(GetExternalString("Hey"), 'glandouiller')

    local fulltag = s
    local s2
    local typesTests = {
        ["simple"] = "Simple",
        ["spectaculaire"] = "Spectaculaire",
        ["oppose"] = "Opposé",
        ["corps-a-corps"] = "Corps à Corps",
        ["distance"] = "Combat à distance"
    }
    local testTag = ""

    local typetest, s = string.match(s, "^([%w%p]*)[%s*](.*)$")

    if typetest == "simple" or typetest == "spectaculaire" then
        s = string.match(s, "^.*(ID.*)%s*/?.*$")
    elseif typetest == "oppose" or typetest == "corps-a-corps" or typetest == "distance" then
        s, s2 = string.match(s, "^(.*)%s*/%s*(.*)$")
    end

    local myheader, myrolls, myresults, myfooter
    local myclass = "wfrp4"
    local labelTypeTest = typesTests[typetest]

    local resultatsTests = {}

    table.insert(resultatsTests, analyseChaineTest(s))

    local idPersonnage1 = resultatsTests[1]["idPersonnage"]
    local competence1 = resultatsTests[1]["competence"]
    local seuilBase1 =
        tonumber(rpg.character.getfield(idPersonnage1, getNomDuChampPourValeur(competence1, idPersonnage1)))
    local difficulte1 = resultatsTests[1]["difficulte"]
    local libelleDifficulte1 = GetLibelleDifficulte(difficulte1)
    local modificateurDifficulte1 = GetModificateurDifficulte(GetCodeDifficulte(difficulte1))
    local nomPersonnage1 = rpg.character.getfield(idPersonnage1, getNomDuChampPourValeur("Nom", idPersonnage1))
    local seuilEffectif1 = seuilBase1 + modificateurDifficulte1
    local nomJoueur1 = rpg.character.getfield(idPersonnage1, getNomDuChampPourValeur("Player", idPersonnage1))

    if typetest == "simple" or typetest == "spectaculaire" then
        if mode == "ask" then
            local myHeaderTree = BBTagBuilder("div", nil, nil, nil, "display: flex; color: white")
            local columns1 =
                myHeaderTree.addChild("div", nil, nil, nil, "display: flex; flex-direction: column; width: 100%")

            columns1.addChild(
                "span",
                string.format("[b]%s doit réaliser un Test %s[/b]", nomJoueur1, labelTypeTest),
                nil,
                nil,
                "font-size: 1.2em; font-weight: bold; text-align: center; padding-bottom: 10px"
            )
            local twocolumns1 = columns1.addChild("div", nil, nil, nil, "display: flex; width: 100%")
            local twocolumns1_1 =
                twocolumns1.addChild(
                "div",
                nil,
                nil,
                nil,
                "display: flex; flex-direction: column; flex-grow: 1; align-items: center"
            )
            twocolumns1_1.addChild("div", nomPersonnage1, nil, nil, "display: flex; font-weight: bold")
            twocolumns1_1.addChild("div", competence1 .. " (" .. seuilBase1 .. ")", nil, nil, "display: flex")
            twocolumns1_1.addChild(
                "div",
                "Difficulté " ..
                    GetLibelleDifficulte(difficulte1) .. " (" .. GetLibelleModificateurDifficulte(difficulte1) .. ")",
                nil,
                nil,
                "display: flex"
            )
            twocolumns1_1.addChild(
                "div",
                "Seuil effectif : " .. seuilEffectif1,
                nil,
                nil,
                "display: flex; font-weight: bold"
            )

            myheader = myHeaderTree.build()

            local myFooterTree = BBTagBuilder(nil, string.format(":test %s:", fulltag), nil, nil, nil)

            myrolls = ""

            myfooter = myFooterTree.build()
        elseif mode == "run" then
            local d1_1, d2_1 = rpg.roll.dice(1, 0, 9)[1], rpg.roll.dice(1, 0, 9)[1]
            return EvaluateTest(
                typetest,
                nomPersonnage1,
                competence1,
                seuilBase1,
                seuilEffectif1,
                difficulte1,
                modificateurDifficulte1,
                d1_1,
                d2_1
            )
        end
    elseif typetest == "oppose" or typetest == "corps-a-corps" or typetest == "distance" then
        table.insert(resultatsTests, analyseChaineTest(s2))
        local idPersonnage2 = resultatsTests[2]["idPersonnage"]
        local competence2 = resultatsTests[2]["competence"]
        local seuilBase2 = tonumber(rpg.character.getfield(idPersonnage2, getNomDuChampPourValeur(competence2, idPersonnage2)))
        local difficulte2 = resultatsTests[2]["difficulte"]
        local libelleDifficulte2 = GetLibelleDifficulte(difficulte2)
        local modificateurDifficulte2 = GetModificateurDifficulte(GetCodeDifficulte(difficulte2))
        local nomPersonnage2 = rpg.character.getfield(idPersonnage2, getNomDuChampPourValeur("Nom", idPersonnage2))
        local seuilEffectif2 = seuilBase2 + modificateurDifficulte2
        local nomJoueur2 = rpg.character.getfield(idPersonnage2, getNomDuChampPourValeur("Player", idPersonnage2))

        if mode == "ask" then
            if typetest == "oppose" or typetest == "corps-a-corps" then

              
                local myHeaderTree = BBTagBuilder("div", nil, nil, nil, "display: flex; color: white")
                local columns1 =
                    myHeaderTree.addChild("div", nil, nil, nil, "display: flex; flex-direction: column; width: 100%")

                columns1.addChild(
                    "span",
                    string.format("[b]Votre Vénéré MJ demande un Test de %s[/b]", labelTypeTest),
                    nil,
                    nil,
                    "font-size: 1.2em; font-weight: bold; text-align: center; padding-bottom: 10px"
                )
                local twocolumns1 = columns1.addChild("div", nil, nil, nil, "display: flex; width: 100%")
                local twocolumns1_1 =
                    twocolumns1.addChild(
                    "div",
                    nil,
                    nil,
                    nil,
                    "display: flex; flex-direction: column; flex-grow: 1; align-items: center"
                )
                twocolumns1_1.addChild("div", nomPersonnage1, nil, nil, "display: flex; font-weight: bold")
                twocolumns1_1.addChild("div", competence1 .. " (" .. seuilBase1 .. ")", nil, nil, "display: flex")
                twocolumns1_1.addChild(
                    "div",
                    "Difficulté " ..
                        GetLibelleDifficulte(difficulte1) ..
                            " (" .. GetLibelleModificateurDifficulte(difficulte1) .. ")",
                    nil,
                    nil,
                    "display: flex"
                )
                twocolumns1_1.addChild("div", "Seuil effectif : " .. seuilEffectif1, nil, nil, "display: flex")

                twocolumns1.addChild("hr", nil, nil, nil, "border: color; margin: 5px; width: 2px")

                local twocolumns1_2 =
                    twocolumns1.addChild(
                    "div",
                    nil,
                    nil,
                    nil,
                    "display: flex; flex-direction: column; flex-grow: 1; align-items: center"
                )
                twocolumns1_2.addChild("div", nomPersonnage2, nil, nil, "display: flex; font-weight: bold")
                twocolumns1_2.addChild("div", competence2 .. " (" .. seuilBase2 .. ")", nil, nil, "display: flex")
                twocolumns1_2.addChild(
                    "div",
                    "Difficulté " ..
                        GetLibelleDifficulte(difficulte2) ..
                            " (" .. GetLibelleModificateurDifficulte(difficulte2) .. ")",
                    nil,
                    nil,
                    "display: flex"
                )
                twocolumns1_2.addChild("div", "Seuil effectif : " .. seuilEffectif2, nil, nil, "display: flex")

                myheader = myHeaderTree.build()

                local myFooterTree = BBTagBuilder(nil, string.format(":test %s:", fulltag), nil, nil, nil)

                myrolls = ""

                myfooter = myFooterTree.build()

                print("myheader, myrolls, myresults, myfooter ask oppose ou CC", myheader, myrolls, myresults, myfooter)

            elseif typetest == "distance" then
                print("ask distance")
            end
        elseif mode == "run" then
          print("run", mode, typetest)
            local d1_1, d1_2, d2_1, d2_2 =
                rpg.roll.dice(1, 0, 9)[1],
                rpg.roll.dice(1, 0, 9)[1],
                rpg.roll.dice(1, 0, 9)[1],
                rpg.roll.dice(1, 0, 9)[1]
            print(d1_1, d1_2, d2_1, d2_2)
            -- local succes1, succes2 = IsSuccess(GetD100(d1_1, d2_1), seuilBase1), IsSuccess(GetD100(d1_2, d2_2), seuilBase2)
            -- local echec1, echec2 = IsFailure(GetD100(d1_1, d2_1), seuilEffectif1), IsFailure(GetD100(d1_2, d2_2), seuilEffectif2)
            -- local critique1, critique2 = IsCritical(typetest, d1_1, d2_1), IsCritical(typetest, d1_2, d2_2)


            if typetest == "oppose" then
                return EvaluateTestOppose(
                    nomPersonnage1,
                    competence1,
                    seuilBase1,
                    seuilEffectif1,
                    difficulte1,
                    d1_1,
                    d2_1,
                    nomPersonnage2,
                    competence2,
                    seuilBase2,
                    seuilEffectif2,
                    difficulte2,
                    d1_2,
                    d2_2
                )
            elseif typetest == "corps-a-corps" then
              print("repere run CC")
                print(mode, typetest)
                --local avantage1, avantage2 = GetAvantage(idPersonnage1), GetAvantage(idPersonnage2)
                --local bonusForce1 = GetBonusForce(idPersonnage1)
                --local bonusEndurance2 = GetBonusEndurance(idPersonnage2)
                --local armesEnMain1_1, armesEnMain1_2 = GetArmesEnMain(idPersonnage1)
                --local armesEnMain2_1, armesEnMain2_2 = GetArmesEnMain(idPersonnage2)

                --print("avantage1", avantage1)
                --print("avantage2", avantage2)
                --print("bonusForce1", bonusForce1)
                --print("bonusEndurance2", bonusEndurance2)
                --print("armesEnMain1_1", armesEnMain1_1)
                --[[      print("armesEnMain1[1]", armesEnMain1[1])
      print("armesEnMain1[2]", armesEnMain1[2])
      print("armesEnMain2[1]", armesEnMain2[1])
      print("armesEnMain2[2]", armesEnMain2[2])
      --]]
                --local atoutsDefautsArme1, atoutsDefautsArme2 = {}, {}
                --local atoutsDefautsArme1, atoutsDefautsArme2 = {}, {}

        
                --[[ return EvaluateTestCorpsACorps({
        nomPersonnage1,
        seuilBase1,
        seuilEffectif1,
        difficulte1,
        avantage1,
        d1_1,
        d2_1,
        bonusForce1,
        armesEnMain1,
        armure1,
        nomPersonnage2,
        seuilBase2,
        seuilEffectif2,
        difficulte2,
        avantage2,
        d1_2,
        d2_2,
        bonusEndurance2,
        armesEnMain2, 
        armure2})
        ]]
                --return rpg.smf.save("myheader", "myrolls", "myresults", "myfooter", "myclass")

            end










        end
    else
        return
    end
    local myresults = "[br/]Commande à copier dans un message :"
    return rpg.smf.save(myheader, myrolls, myresults, myfooter, myclass)
end
