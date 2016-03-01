class ParaJumpAdvanced {
	// activer ou désactiver le module
	enabled = 1;

	// liste des nom des drapeaux créés par le module "ActionsFlags" sur lesquels il faut ajouter l'action
	flags[] = {
		/*
		"base",
		"respawn"
		*/
		"para"
	};

	// zones de saut possibles
	// chaque classe représente un saut
	// le tableau data contient les informations du saut
	// format du tableau data :
	// {titre du saut, coordonnées et altitude, azimut}
	class Drops {
		class West {
			data[] = {"Est", {6526.6, 7499.4, 2500}, 279};
		};

		class EnemyBase {
			data[] = {"Base ennemie", {7526.6, 7499.4, 4000}, 136};
		};
	};
};