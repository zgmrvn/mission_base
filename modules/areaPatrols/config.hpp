/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// activer ou désactiver le module
enabled = 1;

// si activé, la variable globale "CPR_var_areaPatrols_patrolAreas" sera créée
// c'est un tableau associatif des zones de patrouille créées par le module
// la variable "CPR_var_areaPatrols_ready" vaut vrai une fois que le module a terminé de créer les patrouilles
return = 0;

// délais en secondes entre la création de deux patrouilles
// permet de réduire la charge serveur momentanée
pause = 5;

// informations sur les zones de patrouilles
// sides possibles : West, East, Indep
// les classnames des groupes se trouvent dans CfgGroups
class Patrols {
	class North {
		center[]	= {7130,7849,0};
		size[]		= {300, 600};
		direction	= 38;
		side		= "East";

		groups[] = {
			{"East", "rhs_faction_vdv", "rhs_group_rus_vdv_infantry", "rhs_group_rus_vdv_infantry_chq"}, // groupe RHS
			{"West", "Guerilla", "Infantry", "IRG_InfSquad_Weapons"} // groupe FIA BLUFOR avec un side OPFOR
		};
	};

	class East {
		center[]	= {7856,7515,0};
		size[]		= {200, 200};
		direction	= 295;
		side		= "Indep";

		groups[] = {
			// groupe personnalisé composé de classnames d'unités
			{"I_soldier_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_1_F", "I_Soldier_AR_F"}
		};

		debug = 1; // paramètre facultatif qui créé un marqueur sur les zones de patrouilles
	};
};
