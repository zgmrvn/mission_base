# Framework de mission #
Ce framework vise à offrir des solutions de scripts afin de corriger certains problèmes récurrents.

## fonctions ##

### addActionGlobal ###
Cette fonction permet d'ajouter une action dans le menu d'action pour tous les clients. Elle peut être utilisée depuis le serveur, sur un objet qui vient d'être créé et permet d'éviter les problèmes de JIP. Un tableau contenant le joueur ayant déclenché l'action est passé au script. S'il n'a pas été supprimé, ce tableau contiendra en plus l'objet sur lequel a été ajouté l'action.
```
#!sqf
[
	_ammoBox,							// l'objet sur lequel ajouter l'action
	"<t color='#FF0000'>My action</t>",	// titre de l'action
	"addActionScript.sqf",				// un script qui sera exécuté côté client et serveur
	"actionLabel",						// un label, pour différencier les actions lorsqu'il y en a plusieurs sur le même objet
	false,								// faut-il supprimer l’objet lorsque l'action est déclenchée
	true								// faut-il supprimer l'action lorsqu'elle est déclenchée (global)
] call CRP_fnc_addActionGlobal;
```

## Modules ##

Ce framework est découpé sous forme de modules, facilement configurables. La majorité des modules ont un fichier de configuration ``` config.hpp ``` depuis lequel ils peuvent être désactivés.

### Gestion de l'intro ###
Afin de faciliter la gestion de l'intro, il est recommandé d'utiliser le fichier "mission\intro\intro.sqf". Ce script fait parti d'une solution de gestion de l'intro qui permet de choisir depuis les paramètres de mission si l'intro doit être joué. Cette solution permet également d'éviter de rejouer l'intro dans le cas d'une reconnexion à la mission. Vous pouvez désactiver l'intro depuis le fichier de configuration du module ``` modules/intro/config.hpp ```.

### Module de création de drapeaux ###
permet de créer simplement des drapeaux qui pourront être utilisés par les différents modules et scripts. Configurez simplement les noms et positions des drapeaux depuis le fichier de configuration ``` modules/actionsFlags/config.hpp ``` et ils seront automatiquement créés.

pour récupérer un drapeau dans l'un de vos scripts vous pouvez utiliser la fonction ``` CRP_fnc_actionsFlags_getFlag ``` qui prend en paramètre le nom d'un des drapeaux, exemple :
```
#!sqf
_drapeauBase = "base" call CRP_fnc_actionsFlags_getFlag;
_drapeauRespawn = "respawn" call CRP_fnc_actionsFlags_getFlag;
```

### Module de téléportation vers un joueur ###
Configurez simplement les noms des drapeaux sur lesquels vous souhaitez ajouter les actions depuis le fichier de configuration ``` modules/teleportToLeader/config.hpp ```. Ce module a une dépendance au module de création de drapeaux.

### Module de caméra spectateur ###
Configurez simplement les noms des drapeaux sur lesquels vous souhaitez ajouter les actions depuis le fichier de configuration ``` modules/SpectatorCamera/config.hpp ```. Ce module a une dépendance au module de création de drapeaux.

### Module de saut de groupe ###
Saut de groupe façon GID Academy. Configurez simplement les noms des drapeaux sur lesquels vous souhaitez ajouter les actions depuis le fichier de configuration ``` modules/paraJumpClassic/config.hpp ```. Ce module a une dépendance au module de création de drapeaux.

### Module de saut de groupe avec C130J ###
Saut de groupe depuis C130. Configurez les sauts depuis le fichier de configuration ``` modules/paraJumpAdvanced/config.hpp ```. Ce module a une dépendance au module de création de drapeaux et une dépendance au mod CUP.

## autres fonctionnalités ##

### Dégroupage auto ###
Le framework embarque déjà la fonctionnalité de dégroupage au démarrage de la mission, ce qui vous permet de grouper vos unités depuis l'éditeur sans risquer d'avoir des communications et autres ordres automatiques.