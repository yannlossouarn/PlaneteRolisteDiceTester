
-- Initialisation du générateur de nombres aléatoires pour les jets de dés
-- math.randomseed(os.time())
-- math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
math.randomseed(10) -- Version pseudo aléatoire


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
    return bbcode
end

-- Wrapper simulant l'environnement de PlaneteRoliste : module rpg
rpg = rpg or {}

-- Wrapper simulant l'environnement de PlaneteRoliste : modules roll, smf et accel
rpg.roll = rpg.roll or {}
rpg.smf = rpg.smf or {}
rpg.accel = rpg.accel or {}

-- Wrapper simulant l'environnement de PlaneteRoliste : fonction dice du module roll
function rpg.roll.dice(numberOfDices, minDiceValue, maxDiceValue)

    local results = {}
    for i = 1, numberOfDices do
        -- Génère un nombre aléatoire entre minDiceValue et maxDiceValue pour chaque dé
        table.insert(results, math.random(minDiceValue, maxDiceValue))
    end
    return results
end

-- Wrapper simulant l'environnement de PlaneteRoliste : fonction save du module smf
function rpg.smf.save(myheader, myrolls, myresults, myfooter, class)

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
