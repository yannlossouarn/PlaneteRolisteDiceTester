
-- Script de test pour le système Warhammer Jeu de rôle v4

rpg.dicetester.run(
    ":test corps-a-corps BorIn 77 D 2A 3BF / Garde1 28 I 0A:",
    "Test de corps-à-corps, succès critique pour P1, aléa pour P2",
    {2, 2}
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
    ":test simple 88 I:"
)

--[[
print("Utilisation partielle de FakeRandom pour contrôler les deux premiers jets. Joueur 1 fait un succès critique")
FakeRandom.randomseed({2, 2})
rpg.accel.test("corps-a-corps BorIn 78 D 2A 3BF / Garde2 28 I 0A")

print("Utilisation partielle de FakeRandom pour alimenter le test sur les deux premiers jets. Joueur 1 fait un échec critique")
FakeRandom.randomseed({8, 8})
rpg.accel.test("corps-a-corps BorIn 78 D 2A 3BF / Garde2 28 I 0A")


print("Utilisation complète de FakeRandom pour alimenter le test")
FakeRandom.randomseed({3, 3, 2, 2, 50, 2, 3, 4, 5, 65, 2, 1})
rpg.accel.test("corps-a-corps BorIn 78 D 2A 3BF / Garde4 28 I 0A")

rpg.accel.test("corps-a-corps BorIn 57 I 1A 5BF Enroulement Assommante Défensive / Garde15 33 I 0A")
rpg.accel.test("corps-a-corps BorIn 57 I 1A 5BF Poudre Défensive Explosion5 / Garde16 33 I 0A")
rpg.accel.test("simple 32 D")
rpg.accel.test("spectaculaire 32 D")
rpg.accel.test("oppose BorIn 45 I / Garde17 46 D")
rpg.accel.test("simple 57 I")
]]