Z_var_spectatorCamera_unitsPaths = [];

[] spawn {
	// boucle infinie, vérification des unité toutes les secondes
	while {!isNull (findDisplay SPECTATOR_DIALOG_IDD)} do {
		// on efface progressivement le chemin des morts
		{
			if (count ((Z_var_spectatorCamera_unitsPaths select (_x getVariable "Z_var_spectatorCamera_unitIndex")) select 1) > 0) then {
				((Z_var_spectatorCamera_unitsPaths select (_x getVariable "Z_var_spectatorCamera_unitIndex")) select 1) deleteAt 0;
			};
		} forEach allDead;

		// on boucle sur toutes les unité vivantes
		{
			// si l'unité n'est pas dans le tableau
			if (isNil {(_x getVariable ["Z_var_spectatorCamera_unitIndex", nil])}) then {
				// on l'ajoute
				_index = Z_var_spectatorCamera_unitsPaths pushBack [_x, [ASLToAGL (eyePos _x)]];
				_x setVariable ["Z_var_spectatorCamera_unitIndex", _index];
			} else {
				// sinon, on ajoute une nouvelle position au tableau du chemin de l'unité
				((Z_var_spectatorCamera_unitsPaths select (_x getVariable "Z_var_spectatorCamera_unitIndex")) select 1) pushBack (ASLToAGL (eyePos _x));

				// supression des anciennes positions
				if (count ((Z_var_spectatorCamera_unitsPaths select (_x getVariable "Z_var_spectatorCamera_unitIndex")) select 1) > 60) then {
					((Z_var_spectatorCamera_unitsPaths select (_x getVariable "Z_var_spectatorCamera_unitIndex")) select 1) deleteAt 0;
				};
			};
		} forEach allUnits;

		sleep 1;
	};
};