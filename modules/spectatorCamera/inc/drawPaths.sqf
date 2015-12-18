["spetatorCameraUnitsPaths", "onEachFrame", {
	// icônes pour les morts
	{
		// définition de la couleur
		_r = 0.008; _g = 0.29; _b = 0.612;

		switch ((typeOf _x) select [0, 1]) do {
			case "O": {_r = 0.498; _g = 0; _b = 0;};
			case "I": {_r = 0; _g = 0.498; _b = 0;};
			case "C": {_r = 0.4; _g = 0; _b = 0.498;};
		};

		// affichage du nom si c'était un joueur
		_name = if (isPlayer _x) then {name _x} else {""};

		// dessin de l'icône
		drawIcon3D [
			getText (configfile >> "CfgMarkers" >> "KIA" >> "icon"),
			[_r, _g, _b, 0.5],
			(ASLToAGL (getPosASLVisual _x)) vectorAdd [0, 0, 3],
			0.75,
			0.75,
			0,
			_name
		];
	} forEach allDead;

	// icônes pour les vivants
	{
		// définition de la couleur
		_r = 0.008; _g = 0.29; _b = 0.612;

		switch ((typeOf _x) select [0, 1]) do {
			case "O": {_r = 0.498; _g = 0; _b = 0;};
			case "I": {_r = 0; _g = 0.498; _b = 0;};
			case "C": {_r = 0.4; _g = 0; _b = 0.498;};
		};

		// affichage du nom si c'était un joueur
		_name = if (isPlayer _x) then {name _x} else {""};

		drawIcon3D [
			getText (configfile >> "CfgVehicles" >> typeOf _x >> "icon"),
			[_r, _g, _b, 1],
			(ASLToAGL (getPosASLVisual _x)) vectorAdd [0, 0, 3],
			0.75,
			0.75,
			([_x, CRP_var_spectatorCamera_camera] call BIS_fnc_relativeDirTo) + 180,
			_name
		];
	} forEach allUnits;

	// chemins pour les morts et vivants
	{
		_unit = _x select 0;
		_path = _x select 1;

		// définition de la couleur
		_r = 0.008; _g = 0.29; _b = 0.612;

		switch ((typeOf _unit) select [0, 1]) do {
			case "O": {_r = 0.498; _g = 0; _b = 0;};
			case "I": {_r = 0; _g = 0.498; _b = 0;};
			case "C": {_r = 0.4; _g = 0; _b = 0.498;};
		};

		// chemin
		for [{_i = 0; _c = (count _path) - 1;}, {_i < _c}, {_i = _i + 1}] do {
			drawLine3D [_path select _i, _path select (_i + 1), [_r, _g, _b, (1 / _c) * _i]];
		};

		_c = count _path;

		if (_c > 0) then {
			drawLine3D [(_path select (_c - 1)), ASLToAGL (eyePos _unit), [_r, _g, _b, 1]];
		};
	} forEach Z_var_spectatorCamera_unitsPaths;
}] call BIS_fnc_addStackedEventHandler;