class BuildingsOccupation {
	// activer ou désactiver le module
	enabled = 1;

	// informations sur les zones d'occupation
	// centre de la zone, rayon, nombre d'unités
	occupations[] = {
		{{7460.1, 7509.3, 0}, 25, 2}, // maison Ouest
		{{7585.2, 7509.5, 0}, 25, 2}, // maison Est
		{{8143.5, 7505.8, 0}, 25, 3} // maison éloignée Est
	};

	// unités à utiliser pour peupler les zones d'occupation
	units[] = {
		"O_G_Soldier_TL_F",
		"O_G_Soldier_SL_F",
		"O_G_Soldier_exp_F",
		"O_G_Soldier_F"
	};

	// bâtiments et positions d'occupation
	class Buildings {
		// bâtiments Arma 3, vanilla
		#include "inc\vanilla.hpp"

		// bâtiments portés d'arma 2
		#include "inc\arma2.hpp"
	};
};