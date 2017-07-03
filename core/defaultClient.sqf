/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// dégroupage des joueurs pour éviter
// les ordres et communications automatiques
[player] joinSilent grpNull;

// module de briefing
// script de création des "diaries"
#include "..\modules\missionBriefing\content\initScriptClient.sqf"

// module d'intro
// script de vérification des conditions d'intro et d'exécution de l'intro
#include "..\modules\intro\content\initScriptClient.sqf"

// module de taxi en bateaux
// script de création des actions sur les drapeaux créés par le module "ActionsFlags"
#include "..\modules\taxiBoat\content\initScriptClient.sqf"

// module d'effet de particules
// script d'initialisation des boucles de vérification de l'environnement autour du joueur
#include "..\modules\particles\content\initScriptClient.sqf"
