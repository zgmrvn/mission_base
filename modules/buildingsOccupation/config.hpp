// activer ou désactiver le module
enabled = 1;

// si activé, la variable globale "CPR_var_buildingsOccupation_units" sera créée
// elle contiendra la liste des unités créées par le module
return = 0;

// informations sur les zones d'occupation
class Occupations {
	class WestHouse {
		center[]	= {7460.1, 7509.3, 0};
		radius		= 25;
		unitsCount	= 2;
		side		= 2;

		units[] = {
			"O_G_Soldier_TL_F",
			"O_G_Soldier_SL_F",
			"O_G_Soldier_exp_F",
			"O_G_Soldier_F"
		};
	};

	class EastHouse {
		center[]	= {7585.2, 7509.5, 0};
		radius		= 25;
		unitsCount	= 2;
		side		= 1;

		units[] = {
			"O_G_Soldier_TL_F",
			"O_G_Soldier_SL_F",
			"O_G_Soldier_exp_F",
			"O_G_Soldier_F"
		};
	};
};