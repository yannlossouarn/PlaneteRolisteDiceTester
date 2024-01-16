
-- Module permettant de forcer les résultats des dés, afin de tester facilement les variations

OriginalRandom = math.random
FakeRandom = {fakeRandomIndex = nil, fakeRandomSequence = nil}

function FakeRandom.randomseed(sequence)
    if not sequence or sequence == nil or #sequence == 0 or #sequence == nil then
        fakeRandomIndex = nil
        fakeRandomSequence = nil

    else
        fakeRandomSequence = sequence
        fakeRandomIndex = 1
    end
    return true
end


function FakeRandom.random(firstArg, secondArg)
    local result
    print(string.format("FakeRandom.random(%s, %s)", firstArg, secondArg))
    if (fakeRandomSequence ~= nil and fakeRandomIndex ~= nil) then
        if(not firstArg and not secondArg) then
            if fakeRandomSequence[fakeRandomIndex] >= 0 and fakeRandomSequence[fakeRandomIndex] <= 1 then
                print("FakeRandom.random:FakeRandomSequence:valeurOkReal:", fakeRandomSequence[fakeRandomIndex])
                result = fakeRandomSequence[fakeRandomIndex]
            else
                math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
                result = OriginalRandom()
                print("FakeRandom.random:FakeRandomSequence:valeurNonReal, valeurAleatoireUtilisee", fakeRandomSequence[fakeRandomIndex], result)
            end
        elseif (firstArg and not secondArg) then
            if fakeRandomSequence[fakeRandomIndex] >= 1 and fakeRandomSequence[fakeRandomIndex] <= firstArg then
                print("FakeRandom.random:FakeRandomSequence:valeurOk1ToUpper:", fakeRandomSequence[fakeRandomIndex])
                result = fakeRandomSequence[fakeRandomIndex]
            else
                math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
                result = OriginalRandom(firstArg)
                print("FakeRandom.random:FakeRandomSequence:valeurNon1ToUpper, valeurAleatoireUtilisee, upper", fakeRandomSequence[fakeRandomIndex], result, firstArg)
            end
        elseif (firstArg and secondArg) then
            if fakeRandomSequence[fakeRandomIndex] >= firstArg and fakeRandomSequence[fakeRandomIndex] <= secondArg then
                print("FakeRandom.random:FakeRandomSequence:valeurOkLowerToUpper:", fakeRandomSequence[fakeRandomIndex])
                result = fakeRandomSequence[fakeRandomIndex]
            else
                math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
                result = OriginalRandom(firstArg, secondArg)
                print("FakeRandom.random:FakeRandomSequence:valeurNonLowerToUpper, valeurAleatoireUtilisee, lower, upper", fakeRandomSequence[fakeRandomIndex], result, firstArg, secondArg)
            end
        end
        if (fakeRandomIndex+1 <= #fakeRandomSequence) then
            print("FakeRandom:prochaineValeur", fakeRandomSequence[fakeRandomIndex+1])
            fakeRandomIndex = fakeRandomIndex + 1
        else
            print("FakeRandom:sequence épuisée")
            fakeRandomIndex = nil
            fakeRandomSequence = nil
        end
    else

        if(not firstArg and not secondArg) then
            result = OriginalRandom()
            print("FakeRandom:fakeSequence indisponible:math.random()", result)
        elseif (firstArg and not secondArg) then
            result = OriginalRandom(firstArg)
            print(string.format("FakeRandom:fakeSequence indisponible:math.random(%d):%d", firstArg, result))
        elseif (firstArg and secondArg) then
            result = OriginalRandom(firstArg, secondArg)
            print(string.format("FakeRandom:fakeSequence indisponible:math.random(%d, %d):%d", firstArg, secondArg, result))
        end
        
    end
    return result
end


-- Module d'interprétation du BBCode : la fonction ReplaceTags remplace un tag bbcode spécifié par une balise HTML
function ReplaceTags(bbcode, tag, open_tag, close_tag)
    local start_pattern = "%[" .. tag .. "(.-)%]"
    local end_pattern = "%[/" .. tag .. "%]"
    local open_html = "<" .. open_tag .. "%1>"
    local close_html = "</" .. close_tag .. ">"

    local new_bbcode, count
    repeat
        new_bbcode, count = string.gsub(bbcode, start_pattern, open_html)
        new_bbcode, count = string.gsub(new_bbcode, end_pattern, close_html)
        bbcode = new_bbcode
    until count == 0

    return bbcode
end

function BbcodeToHtml(bbcode)
    bbcode = ReplaceTags(bbcode, "div", "div", "div")
    bbcode = ReplaceTags(bbcode, "span", "span", "span")
    bbcode = ReplaceTags(bbcode, "br", "br", "br")
    bbcode = ReplaceTags(bbcode, "hr", "hr", "hr")
    bbcode = ReplaceTags(bbcode, "u", "u", "u")
    bbcode = ReplaceTags(bbcode, "b", "b", "b")
    bbcode = ReplaceTags(bbcode, "i", "i", "i")
    bbcode = ReplaceTags(bbcode, "html", "div", "div")
    return bbcode
end

-- Wrapper simulant l'environnement de PlaneteRoliste : module rpg
rpg = rpg or {}

-- Wrapper simulant l'environnement de PlaneteRoliste : modules roll, smf et accel
rpg.roll = rpg.roll or {}
rpg.smf = rpg.smf or {}
rpg.accel = rpg.accel or {}
rpg.character = rpg.character or {}
rpg.character.characters = rpg.character.characters or {}

pcall(require, "scripts." .. scriptName .. "-characters")

rpg.character.init()

function rpg.character.getfield(charid,field)
    local charid = tonumber(charid)
    if rpg.character.characters[charid][field] then
        return rpg.character.characters[charid][field]
    else
        return nil
    end
end

-- Module additionnel utilisable pour lancer les tests dans le script
rpg.dicetester = rpg.dicetester or {}
rpg.dicetester.title = nil -- variable globale additionnelle, permettant d'afficher le titre du test dans le navigateur
rpg.dicetester.fulltag = nil -- variable globale additionnelle, permettant d'afficher la balise complète dans le navigateur

function rpg.dicetester.run(fulltag, title, fakeRandomSequence)

    print("rpg.dicetester.run:fulltag", fulltag)
    print("rpg.dicetester.run:title", title)


    -- print("rpg.dicetester.run:#fakeRandomSequence", #fakeRandomSequence)

    rpg.dicetester.title = nil
    rpg.dicetester.fulltag = nil
    if fulltag == nil then
            print(string.format("rpg.dicetester.run nécessite au moins un paramètre contenant une chaîne de caractère :balise: ou :balise parametre1 parametre2 ...:\n\n"))
        return
    else
        rpg.dicetester.fulltag = string.format("%s", fulltag)
    end
    if title ~= nil then
        rpg.dicetester.title = string.format("%s", title)
    end

    print(string.format("rpg.dicetester.title:%s", rpg.dicetester.title))
    -- print("avant tagName")
    local tagName = string.match(fulltag, ":(%w+).*:")
    -- print("tagName", tagName)
    local tagArguments = string.match(fulltag, "^:%w+%s*(.*):$")
    local isTagName = tagName ~= nil
    local accelerator = nil

    if fakeRandomSequence and fakeRandomSequence ~= nil then
        print("rpg.dicetester.run:FakeRandom actif")
        FakeRandom.randomseed(fakeRandomSequence)
    else
        print("rpg.dicetester.run:FakeRandom inactif")
        FakeRandom.randomseed({})
    end

    if isTagName then
        local acceleratorLoader = load(string.format("return rpg.accel.%s", tagName))
        if acceleratorLoader ~= nil then
            accelerator = acceleratorLoader()
        end
    end
    if accelerator ~= nil then
        print(string.format("La balise %s est bien gérée par ce script.", tagName))
        local acceleratorResults = accelerator(tagArguments)
        return acceleratorResults
    else
        print(string.format("La balise %s n'est pas gérée par ce script. Implémentez une fonction rpg.accel.%s", tagName, tagName))
        return
    end
    
end

-- Wrapper simulant l'environnement de PlaneteRoliste : fonction dice du module roll
function rpg.roll.dice(numberOfDices, minDiceValue, maxDiceValue)

    local results = {}
    for i = 1, numberOfDices do
        -- Génère un nombre aléatoire entre minDiceValue et maxDiceValue pour chaque dé
        table.insert(results, FakeRandom.random(minDiceValue, maxDiceValue))
    end
    return results
end

-- Wrapper simulant l'environnement de PlaneteRoliste : fonction save du module smf
function rpg.smf.save(myheader, myrolls, myresults, myfooter, class)
        local title
        if rpg.dicetester.title and rpg.dicetester.title ~= nil and rpg.dicetester.title ~= 'nil' then
            title = rpg.dicetester.title
            fulltag = rpg.dicetester.fulltag
        elseif rpg.dicetester.fulltag and rpg.dicetester.fulltag ~= nil and rpg.dicetester.fulltag ~= 'nil' then
            title = rpg.dicetester.fulltag
            fulltag = ""
        end

        BodyResponse = BodyResponse .. '<h1>' .. title  .. '</h1>'
        BodyResponse = BodyResponse .. '<code>' .. fulltag  .. '</code>'
        BodyResponse = BodyResponse .. '<div class="rollgen_block"><div class="rollgentable ' .. class .. '"><div class="empty"><span class="empty"><span class="rollgenheader"><span class="rollgen_what"></span></span></span>'
        BodyResponse = BodyResponse .. BbcodeToHtml(myheader)
        BodyResponse = BodyResponse .. '<span class="rollgen_dice_dc"></span>'
        BodyResponse = BodyResponse .. '</div>'
        BodyResponse = BodyResponse .. '<div class="empty"><div class="empty"><div class="rollgenrolls">'
        BodyResponse = BodyResponse .. BbcodeToHtml(myrolls)
        BodyResponse = BodyResponse .. '</div></div></div>'
        BodyResponse = BodyResponse .. '<div class="empty"><span class="empty"><span class="rollgen_dice_dc"></span></span>'
        BodyResponse = BodyResponse .. BbcodeToHtml(myresults)
        BodyResponse = BodyResponse .. '</div>'
        BodyResponse = BodyResponse .. '<div class="empty">'
        BodyResponse = BodyResponse .. BbcodeToHtml(myfooter)
        BodyResponse = BodyResponse .. '</div></div></div></body></html>'
end

-- Wrapper simulant l'environnement de PlaneteRoliste : fonction striptitle du module smf
function rpg.smf.striptitle(s)
    return s, ''
end
