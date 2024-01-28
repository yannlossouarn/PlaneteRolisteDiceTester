
-- Script de test pour le système Warhammer Jeu de rôle v4

print("\ndebut caller")

rpg.dicetester.run(
    ":ask simple ID(6885) Competence(Charme) Difficulté(Intermediaire):",
    "Demande de test simple par le MJ, ID, "
)

rpg.dicetester.run(
    ":test simple ID(6885) Competence(Charme) Difficulté(Intermediaire):",
    "Demande de test simple par le MJ, ID, "
)

rpg.dicetester.run(
    ":test simple ID(6885) Competence(Charme) Difficulté(Intermediaire):",
    "Test simple contre Camelia (Charme), Difficulté Intermédiaire : succès forcé",
    {0, 5}
)

rpg.dicetester.run(
    ":test simple ID(6885) Competence(Charme) Difficulté(Intermediaire):",
    "Test simple contre Camelia (Charme), Difficulté Intermédiaire : succès forcé",
    {9, 1}
)

rpg.dicetester.run(
    ":ask spectaculaire ID(6885) Competence(Perception) Difficulté(Intermediaire):",
    "Test spectaculaire par le MJ, ID, "
)

rpg.dicetester.run(
    ":test spectaculaire ID(6885) Competence(Perception) Difficulté(Intermediaire):",
    "Test spectaculaire par le MJ, ID, "
)

rpg.dicetester.run(
    ":test spectaculaire ID(6885) Competence(Perception) Difficulté(Intermediaire):",
    "Test spectaculaire par le MJ, ID, ",
    {4, 5}
)

rpg.dicetester.run(
    ":test spectaculaire ID(6885) Competence(Perception) Difficulté(Intermediaire):",
    "Test spectaculaire par le MJ, ID, ",
    {5, 5}
)

rpg.dicetester.run(
    ":test spectaculaire ID(6885) Competence(Perception) Difficulté(Intermediaire):",
    "Test spectaculaire par le MJ, ID, ",
    {6, 5}
)

rpg.dicetester.run(
    ":test spectaculaire ID(6885) Competence(Perception) Difficulté(Intermediaire):",
    "Test spectaculaire par le MJ, ID, ",
    {7, 5}
)

rpg.dicetester.run(
    ":test spectaculaire ID(6885) Competence(Perception) Difficulté(Intermediaire):",
    "Test spectaculaire par le MJ, ID, ",
    {8, 5}
)

rpg.dicetester.run(
    ":test spectaculaire ID(6885) Competence(Perception) Difficulté(Intermediaire):",
    "Test spectaculaire par le MJ, ID, ",
    {9, 5}
)

rpg.dicetester.run(
    ":ask oppose ID(6885) Competence(Discrétion) Difficulté(Intermediaire) / ID(6885) Competence(Perception) Difficulté(Difficile):",
    "Demande de Test opposé Discrétion / Perception"
)

rpg.dicetester.run(
    ":test oppose ID(6885) Competence(Discrétion) Difficulté(Intermediaire) / ID(6885) Competence(Perception) Difficulté(Difficile):",
    "Test opposé Discrétion / Perception"
)

rpg.dicetester.run(
    ":ask corps-a-corps ID(6885) Competence(Corps à corps) Difficulté(Intermediaire) / ID(6919) Competence(Corps à Corps (Arme d'hast)) Difficulté(Difficile):",
    "Demande de test de corps à corps"
)

rpg.dicetester.run(
    ":test corps-a-corps ID(6885) Competence(Corps à corps) Difficulté(Intermediaire) / ID(6919) Competence(Corps à Corps (Arme d'hast)) Difficulté(Difficile):",
    "Test de corps à corps"
)




-- print("Utilisation partielle de FakeRandom pour alimenter le test sur les deux premiers jets. Joueur 1 fait un échec critique")
-- FakeRandom.randomseed({2, 2})
-- rpg.accel.test("corps-a-corps BorIn 78 D 2A 3BF / Garde2 28 I 0A 2BE")

print("\nfin caller")