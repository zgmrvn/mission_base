/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// pas de propriété "enabled" parce qu'il n'y a pas de démarrage automatique
// il faut utiliser la fonction CRP_fnc_hunters_triggerHunters pour déclencher une chasse

// liste des groupes de chasse
class Hunters {
	// start : point de départ du groupe de chasse, position de spawn aproximative initiale
	// hunterSide : East, West, Indep
	// condition :
	//     expression sous forme de chaîne de caractère
	//     vous devez déclarer cette variable dans l'init ou dans un script
	//     quand l'expression vaut faux, la chasse s'arrête
	// spawnDistance : distance de spawn entre les joueurs et le groupe de chasse
	class Group1: Base {
		start[]			= {7658, 7547, 0};
		hunterSide		= "East";
		condition		= "Z_var_group1";
		spawnDistance	= 50;

		// config des groupes possibles pour la chasse
		// les classnames des groupes se trouvent dans CfgGroups
		hunterGroups[] = {
			{"East", "rhs_faction_vdv", "rhs_group_rus_vdv_infantry", "rhs_group_rus_vdv_infantry_chq"},
			{"West", "Guerilla", "Infantry", "IRG_InfSquad_Weapons"}
		};
	};

	class Group2: Base {
		start[]			= {125, 12, 0};
		hunterSide		= "Indep";
		condition		= "uneVariable >= uneAutreVariable";
		spawnDistance	= 250;

		hunterGroups[] = {
			// groupe personnalisé composé de classnames d'unités
			{"I_soldier_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_1_F", "I_Soldier_AR_F"}
		};

		// (facultatif), pause entre chaque boucle du script de chasse
		// par défaut vaut 30 (hérité de la classe Base)
		pause = 60;
	};
};
