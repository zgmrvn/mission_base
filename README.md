# Framework de mission #
Ce framework vise à offrir des solutions de scripts afin de corriger certains problèmes récurrence rencontrés en mission.

## fonctions ##

### addActionGlobal ###
Cette fonction permet d'ajouter une action chez tous les clients. Elle peut être utilisée depuis le serveur, sur un objet qui vient d'être créer. La problématique de JIP est prise en compte.


```
#!sqf

[
	_ammoBox,				// l'objet sur lequel ajouter l'action
	"<t color='#FF0000'>My action</t>",	// titre de l'action
	"addActionScript.sqf",			// un script qui sera exécuté côté client et serveur
	"actionLabel",				// un label, pour différencier les actions lorsqu'il y en a plusieurs sur le même objet
	false,					// faut-il supprimer l’objet lorsque l'action est déclenchée
	true					// faut-il supprimer l'action lorsqu'elle est déclenchée (pas d'importance si l'objet est supprimé)
] call CRP_fnc_addActionGlobal;
```

## autres fonctionnalités ##

### Gestion de l'intro ###
un fichier pour l'intro est déjà mis en place. Il est possible de jouer l'intro ou non depuis les paramètres de mission. L'intro de sera pas rejouée en cas de reconnexion.