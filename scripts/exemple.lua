-- Une fois ce code copié dans [l'éditeur du site PlaneteRoliste.com](https://www.planeteroliste.com/SMF/index.php?page=page151)
-- il permet d'utiliser des syntaxes de type ":nouveaujet parametres:" et ":autrejet parametres:"
function rpg.accel.nouveaujet(s)
    local rolls, myheader = rpg.smf.striptitle(s)
    print("nouveautjet:s", s)

    -- Appel à une fonction du wrapper, qui gère l'affichage du résultat du lancer de dés.
    return rpg.smf.save(myheader, "Valeur des jets", "Résultats", "Pied-de-page du lancer", "classeHtmlUtiliseePourLeBlocNouveauJet")
end

function rpg.accel.autrejet(s)
    local rolls, myheader = rpg.smf.striptitle(s)
    print("autrejet:s", s)

    -- Analyse de la chaîne de caractères contenant les paramètres pour les récupérer dans des variables
    -- La syntaxe des pattens LUA est proche des expressions régulières, mais PAS IDENTIQUE.
    -- La capture est effectuée par les blocs entre parenthèses.
    -- Référez-vous à https://www.lua.org/manual/5.4/manual.html#6.4.1
    local seuil, competence, difficulte = string.match(s, "^([%d]*)[%s]*([%w]*)[%s]*([%w]*)$")

    -- On peut afficher des traces dans la console
    print("autrejet:seuil", seuil)
    print("autrejet:competence", competence)
    print("autrejet:difficulte", difficulte)

    -- L'appel au wrapper est délégué, cette fonction ne faisant que traiter les paramètres passés dans la balise.
    -- C'est la fonction EvaluateAutreJet() qui est en charge d'appeler rpg.smf.save() ensuite 
    return EvaluateAutreJet(seuil, competence, difficulte)
end

function EvaluateAutreJet(seuil, competence, difficulte)
    print("EvaluateAutreJet")
    print("EvaluateAutreJet:seuil", seuil)
    print("EvaluateAutreJet:competence", competence)
    print("EvaluateAutreJet:difficulte", difficulte)

    local syntheseResultat = ""
    local htmlClass = "classeHtmlAutrejet"
     if seuil and competence and difficulte then

        -- Conversion de la chaîne de caractères "33" en nombre 33
        seuil = tonumber(seuil)

        print("EvaluateAutreJet:", "tous les paramètres nécessaires sont présents")
        -- Constitution du libellé affiché en entête
        local myheader = "Jet de " .. competence .. ", seuil de " .. seuil .. ", difficulté " .. difficulte
        print("myheader", myheader)
        -- Jet de deux D10
        local jets = rpg.roll.dice(2, 0, 9)
        local d1, d2 = jets[1], jets[2]
        print("jets:", d1, d2)
        local myrolls =
        "[" ..
        'div class="yellow_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]' ..
        d1 .. "[" .. "/div]"
        myrolls =
        myrolls ..
        "[" ..
        'div class="white_d10" style="display: inline-table;text-align: center;vertical-align:middle;color: black;height: 24px;background-size: cover;width: 28px;text-shadow: -1px -1px 0px rgba(255, 227, 0, 0.3), 1px 1px 1px rgba(168, 129, 11, 0.8);"]' ..
            d2 .. "[" .. "/div]"
        -- print("myrolls:", myrolls)

        local d100 = GetD100(d1, d2)
        print("d100:", d100)

        local resultat = ""
        local footer = ""

        if d100 <= seuil then
            print("Bravo")
            resultat = string.format('[div style="font-size: 1em"] Bravo, un résultat de %d contre un seuil de %d est une réussite !![/div]', d100, seuil)
            footer = '[div style="font-size: 3em"] 🤩 [/div]'
        else
            print("Perdu")
            resultat = string.format('[div style="font-size: 1em"] Perdu, un jet de %d constitue un échec contre un seuil de %d...[/div]', d100, seuil)
            footer = '[div style="font-size: 1.5em"] 😱 [/div]'
        end
        print(myheader, resultat, footer, htmlClass)
        return rpg.smf.save(myheader, myrolls, resultat, footer, htmlClass)
    end
end

function GetD100(d1, d2)
    print("GetD100", d1, d2)
    if d1 == 0 and d2 == 0 then
        return 100
    else
        return d1 * 10 + d2
    end
end