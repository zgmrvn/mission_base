/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// activer ou désactiver le module
enabled = 1;

// si activé, la variable globale "CPR_var_buildingsOccupation_occupation" sera créée
// c'est un tableau associatif des unités créées regroupées par zones d'occupation
// la variable "CPR_var_buildingsOccupation_ready" vaut vrai une fois que le module a terminé de créer les unités
return = 0;

// délais en secondes entre la création de deux unités
// permet de réduire la charge serveur momentanée
pause = 4;

// informations sur les zones d'occupation
class Occupations {
	class WestHouse: Base {
		center[]		= {7460.1, 7509.3, 0}; // centre de la zone d'occupation
		radius			= 25; // rayon de la zone
		unitCount		= 2; // nombre d'unités dans la zone
		side			= "Indep"; // sides possibles : West, East, Indep, Civ
		keepPosition	= 0.5; // pourcentage d'ia qui ne quittera pas son poste, facultatif, par défaut 0

		// classnames des unités à utiliser pour occuper la zone
		units[] = {
			"I_Soldier_unarmed_F",
			"I_Soldier_AR_F",
			"I_Soldier_GL_F"
		};
	};

	class EastHouse: Base {
		center[]		= {7585.2, 7509.5, 0};
		radius			= 25;
		unitCount		= 2;
		side			= "East";

		units[] = {
			"O_G_Soldier_TL_F",
			"O_G_Soldier_SL_F",
			"O_G_Soldier_exp_F",
			"O_G_Soldier_F"
		};
	};
};
