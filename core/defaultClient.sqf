// dégroupage des joueurs pour éviter
// les ordres et communications automatiques
[player] joinSilent grpNull;

// module de téléportation sur le chef d'équipe
// script de création des actions de téléportation sur les drapeaux créés par le module "ActionsFlags"
#include "..\modules\teleportToLeader\script.sqf"

// module de saut en parachute classique
// script de création des actions sur les drapeaux créés par le module "ActionsFlags"
#include "..\modules\paraJumpClassic\script.sqf"

// module de saut en parachute avancé
// script de création des actions sur les drapeaux créés par le module "ActionsFlags"
#include "..\modules\paraJumpAdvanced\script.sqf"

// module de caméra sepctateur
// script de création des actions de caméra spectateur sur les drapeaux créés par le module "ActionsFlags"
#include "..\modules\spectatorCamera\script.sqf"