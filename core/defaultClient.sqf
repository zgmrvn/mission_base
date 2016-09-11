// dégroupage des joueurs pour éviter
// les ordres et communications automatiques
[player] joinSilent grpNull;

// module de briefing
// script de création des "diaries"
#include "..\modules\missionBriefing\content\initScriptClient.sqf"

// module de téléportation sur le chef d'équipe
// script de création des actions de téléportation sur les drapeaux créés par le module "ActionsFlags"
#include "..\modules\teleportToLeader\initScriptClient.sqf"

// module de saut en parachute classique
// script de création des actions sur les drapeaux créés par le module "ActionsFlags"
#include "..\modules\paraJumpClassic\content\initScriptClient.sqf"

// module de saut en parachute avancé
// script de création des actions sur les drapeaux créés par le module "ActionsFlags"
#include "..\modules\paraJumpAdvanced\content\initScriptClient.sqf"

// module de projection en bâteaux
// script de création des actions sur les drapeaux créés par le module "ActionsFlags"
#include "..\modules\boatProjection\content\initScriptClient.sqf"

// module de caméra sepctateur
// script de création des actions de caméra spectateur sur les drapeaux créés par le module "ActionsFlags"
#include "..\modules\spectatorCamera\initScriptClient.sqf"

// module d'effet de particules
// script d'initialisation des boucles de vérification de l'environnement autour du joueur
#include "..\modules\particles\content\initScriptClient.sqf"