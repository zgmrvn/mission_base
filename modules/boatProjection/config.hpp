class BoatProjection {
	// activer ou désactiver le module
	enabled = 1;

	// liste des noms des drapeaux créés par le module "ActionsFlags" sur lesquels il faut ajouter l'action
	flags[] = {
		/*
		"base",
		"respawn"
		*/
		"para"
	};

	// centre aproximatif des objectifs, utilisé pour l'orientation des bateaux
	center[] = {0, 0, 0};

	// liste des bâteaux disponibles et places disponibles
	boats[] = {
		{"B_G_Boat_Transport_01_F", 5},
		{"C_Boat_Transport_02_F", 8}
	};
};