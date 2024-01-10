---
runme:
  id: 01HKQR4ANYYPXQ32HQYM2966C5
  version: v2.2
---

# PlaneteRolisteDiceTester

PlaneteRolisteDiceTester est un environnement permettant de faciliter le développement des scripts de jets de dés spécifiques à un système de jeu, sur le site [PlaneteRoliste.com](https://www.planeteroliste.com).

PlaneteRolisteDiceTester est constitué :
- d'un wrapper qui exécute un script LUA dans un environnement de développement simulant celui du site,
- d'un minifieur permettant de réduire le volume du script, dans l'hypothèse où un script s'avérerait trop volumineux par rapport aux limitations en vigueur sur le site.

PlaneteRolisteDiceTester utilise :
- [lua-minify](https://github.com/stravant/lua-minify) , une librairie de minification/beautification de script LUA, développée en LUA par Mark Langer aka Stravant.
- [pegasus.lua](https://evandrolg.github.io/pegasus.lua/), un serveur HTTP permettant d'exposer une application développée en LUA.

## Installation

- Installer [lua](https://www.lua.org/), de préférence en version 5.4 (non testé dans les versions antérieures)
- Installer [luarocks](https://luarocks.org/)
- Installer [pegasus-lua](https://luarocks.org/)
- Cloner ce dépôt avec Git

## Utilisation

### Pour créer un nouveau script

Vous pouvez vous inspirer des scripts exemple.lua et exemple-caller.lua situés dans le sous-répertoire scripts, en gardant le même schéma de nommage.
Par exemple, si vous développez un script pour un jeu appelé Miaou, dans sa deuxième mouture, vous pouvez par exemple appeler les fichiers miaou2.lua et l'autre miaou2-caller.lua.

Pour le reste... c'est de la programmation LUA ! :)

### Pour lancer un script dans sa version originale (exemples donnés pour le script wfrp4, pour le système Warhammer Fantasy Roleplay v4)

```sh {"id":"01HKSAC89VZV81E81YETQK50RF"}
lua serve.lua wfrp4
```

ou

```sh {"id":"01HKSCJEY3WRZW41HPN3397M0A"}
lua serve.lua wfrp4 original
```

### Pour lancer un script après qu'il a été minifié :

```sh {"id":"01HKS9MGXVD5PM550M2HP3TRE6"}
lua serve.lua wfrp4 minified
```

### Pour générer un script

#### Pour générer une version minifiée d'un script :

```sh {"id":"01HKSCBQJYZS358QXHZM4TS8VN"}
lua minify.lua wfrp4 minify
```

## Licence

Ce code est placé sous licence MIT.

Copyright (c) 2024 Yann Lossouarn

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Support

PlaneteRolisteDiceTester est testé dans un environnement LUA 5.4.

## Auteur

| [![twitter/yannlossouarn](https://2.gravatar.com/avatar/173668a6f42ca67d663b3b292bc5bc12ac845cceb0af938c05933df28ca92ef8?size=64)](https://twitter.com/yannlossouarn) |
|---|
| [https://yann.lossouarn.net](https://yann.lossouarn.net/) |