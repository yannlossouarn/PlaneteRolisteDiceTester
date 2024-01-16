
-- Script de test pour le système Warhammer Jeu de rôle v4

--[[
rpg.dicetester.run(
    ":ask test oppose ID(6885) Competence(Discrétion) Difficulté(Intermediaire) / ID(6885) Competence(Perception) Difficulté(Difficile):",
    "Demande de test simple par le MJ, ID, "
)
]]


rpg.dicetester.run(
    ":ask test simple ID(6885) Competence(Charme) Difficulté(Intermediaire):",
    "Demande de test simple par le MJ, ID, "
)

rpg.dicetester.run(
    ":test simple ID(6885) Competence(Corps à corps) Difficulté(Intermediaire):",
    "Test simple par le MJ, ID, "
)

rpg.dicetester.run(
    ":ask test oppose ID(6885) Competence(Discrétion) Difficulté(Intermediaire) / ID(6919) Competence(Perception) Difficulté(Difficile):",
    "Test opposé de Discrétion/Perception entre Camilia et un garde avec ID fourni "
)

rpg.dicetester.run(
    ":test oppose ID(6885) Competence(Discrétion) Difficulté(Intermediaire) / ID(6919) Competence(Perception) Difficulté(Difficile):",
    "Test opposé de Discrétion/Perception entre Camilia et un garde avec ID fourni "
)

--[[
rpg.dicetester.run(
    ":test corps-a-corps ID6885 / Nal U'Thuil 28 I 0A 2BE Empaleuse:",
    "Test de corps-à-corps, infos de P1 récupérés depuis API, Empaleuse pour P2"
)
]]



--[[


rpg.dicetester.run(
    ":ask test spectaculaire ID(6885) Competence(Corps à corps) Difficulté(Intermediaire):",
    "Demande de test spectaculaire par le MJ, ID, "
)

rpg.dicetester.run(
    ":test spectaculaire ID(6885) Competence(Corps à corps) Difficulté(Intermediaire):",
    "Test spectaculaire par le MJ, ID, "
)
]]

--[[
rpg.dicetester.run(
    ":test corps-a-corps Bor In 77 D 2A 3BF Devastatrice / Nal U'Thuil 28 I 0A 2BE Empaleuse:",
    "Test de corps-à-corps, aléa pour P1 et P2, arme dévastatrice pour P1, Empaleuse pour P2"
)

rpg.dicetester.run(
    ":test corps-a-corps BorIn 77 D 2A 3BF Explosion(5) / Garde 28 I 0A 2BE Inoffensive:",
    "Test de corps-à-corps, succès critique pour P1, aléa pour P2",
    {2, 2}
)

rpg.dicetester.run(
    ":test corps-a-corps BorIn 77 D 2A 3BF Enroulement/ Garde 28 I 0A 2BE:",
    "Test de corps-à-corps, succès critique pour P1, aléa pour P2, arme à enroulement",
    {2, 2}
)

rpg.dicetester.run(
    ":test corps-a-corps BorIn 77 D 2A 3BF / Garde 28 I 0A 2BE:",
    "Test de corps-à-corps, succès critique pour P1, échec pour P2, coup à la tête, fine entaille",
    {2, 2, 8, 0, 5, 0, 9}
)

rpg.dicetester.run(
    ":test corps-a-corps BorIn 77 D 2A 3BF / Garde 28 I 0A 2BE:",
    "Test de corps-à-corps, succès critique pour P1, échec pour P2, coup à la tête, entaille",
    {2, 2, 8, 0, 5, 1, 9}
)

rpg.dicetester.run(
    ":test corps-a-corps BorIn 77 D 2A 3BF / Garde 28 I 0A 2BE:",
    "Test de corps-à-corps, succès critique pour P1, échec pour P2, coup à la tête, Coup à l'oeil",
    {2, 2, 8, 0, 5, 2, 4}
)

rpg.dicetester.run(
    ":test corps-a-corps BorIn 77 D 2A 3BF / Garde 28 I 0A 2BE:",
    "Test de corps-à-corps, succès critique pour P1, échec pour P2, coup à la tête, Frappe à l'oreille",
    {2, 2, 8, 0, 5, 2, 7}
)

rpg.dicetester.run(
    ":test corps-a-corps BorIn 77 D 2A 3BF / Garde 28 I 0A 2BE:",
    "Test de corps-à-corps, succès critique pour P1, échec pour P2, coup à la tête, Coup percutant",
    {2, 2, 8, 0, 5, 3, 4}
)

rpg.dicetester.run(
    ":test simple 77 I:",
    "Test simple contre 77, Difficulté Intermédiaire : succès",
    {0, 5}
)

rpg.dicetester.run(
    ":test simple 77 I:",
    "Test simple contre 77, Difficulté Intermédiaire : échec",
    {9, 1}
)

rpg.dicetester.run(
    ":test simple 77 I:",
    "Test simple contre 77, Difficulté Intermédiaire : aléa complet"
)




rpg.dicetester.run(
    ":ask test corps-a-corps Bor In 77 D 2A 3BF Devastatrice / Nal U'Thuil 28 I 0A 2BE Empaleuse:",
    "Demande de test par le MJ"
)


rpg.dicetester.run(
    ":ask test corps-a-corps Bor In 77 D 2A 3BF Devastatrice / Nal U'Thuil 28 I 0A 2BE Empaleuse:",
    "Demande de test par le MJ"
)





--[[
print("Utilisation partielle de FakeRandom pour contrôler les deux premiers jets. Joueur 1 fait un succès critique")
FakeRandom.randomseed({2, 2})
rpg.accel.test("corps-a-corps BorIn 78 D 2A 3BF / Garde2 28 I 0A 2BE")

print("Utilisation partielle de FakeRandom pour alimenter le test sur les deux premiers jets. Joueur 1 fait un échec critique")
FakeRandom.randomseed({8, 8})
rpg.accel.test("corps-a-corps BorIn 78 D 2A 3BF / Garde2 28 I 0A 2BE")


print("Utilisation complète de FakeRandom pour alimenter le test")
FakeRandom.randomseed({3, 3, 2, 2, 50, 2, 3, 4, 5, 65, 2, 1})
rpg.accel.test("corps-a-corps BorIn 78 D 2A 3BF / Garde4 28 I 0A 2BE")

rpg.accel.test("corps-a-corps BorIn 57 I 1A 5BF Enroulement Assommante Défensive / Garde5 33 I 0A 2BE")
rpg.accel.test("corps-a-corps BorIn 57 I 1A 5BF Poudre Défensive Explosion5 / Garde6 33 I 0A 2BE")
rpg.accel.test("simple 32 D")
rpg.accel.test("spectaculaire 32 D")

rpg.accel.test("simple 57 I")
]]