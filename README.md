# Framework de mission #
Ce framework vise à offrir des solutions de scripts afin de corriger certains problèmes récurrents.

## fonctions ##

### addActionGlobal ###
Cette fonction permet d'ajouter une action dans le menu d'action pour tous les clients. Elle peut être utilisée depuis le serveur, sur un objet qui vient d'être créé et permet d'éviter les problèmes de JIP.
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

## autres fonctionnalités ##

### Gestion de l'intro ###
Afin de faciliter la gestion de l'intro, il est recommandé d'utiliser le fichier "mission\intro\intro.sqf". Ce script fait parti d'une solution de gestion de l'intro qui permet de choisir depuis les paramètres de mission si l'intro doit être joué. Cette solution permet également d'éviter de rejouer l'intro dans le cas d'une reconnexion à la mission.

### Dégroupage auto ###
Le framework embarque déjà la fonctionnalité de dégroupage au démarrage de la mission, ce qui vous permet de grouper vos unités depuis l'éditeur sans risquer d'avoir des communications et autres ordres automatiques.