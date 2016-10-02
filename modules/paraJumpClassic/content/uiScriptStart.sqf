#include "ctrl.hpp"

// déclaration des variables du module
// CRP_var_paraJumpClassic_flag, déclarée dans le code de l'action afin de récupérer l'objet drapeau et ainsi pouvoir récupérer les joueurs à proximité
CRP_var_paraJumpClassic_skyDivers	= [];
CRP_var_paraJumpClassic_coordinates = [];
CRP_var_paraJumpClassic_marker		= "";
CRP_var_paraJumpClassic_elevation	= "5000";

[] spawn {
	waitUntil {!isNull (findDisplay PARAJUMP_CLASSIC_DIALOG_IDD)};

	disableSerialization;

	_dialog		= findDisplay PARAJUMP_CLASSIC_DIALOG_IDD;
	_altitude	= _dialog displayCtrl PARAJUMP_CLASSIC_ALTITUDE_IDC;
	_map 		= _dialog displayCtrl PARAJUMP_CLASSIC_MAP_IDC;
	_close 		= _dialog displayCtrl PARAJUMP_CLASSIC_CLOSE_IDC;
	_jump		= _dialog displayCtrl PARAJUMP_CLASSIC_JUMP_IDC;

	// alimentation et actualisation de la liste
	[] spawn {
		disableSerialization;

		_dialog	= findDisplay PARAJUMP_CLASSIC_DIALOG_IDD;
		_list	= _dialog displayCtrl PARAJUMP_CLASSIC_LIST_IDC;

		while {!isNull (findDisplay PARAJUMP_CLASSIC_DIALOG_IDD)} do {
			// récupération des joueurs à proximité
			CRP_var_paraJumpClassic_skyDivers = [CRP_var_paraJumpClassic_flag, 25] call CRP_fnc_nearestPlayers;

			// on vide la liste
			lbClear _list;

			// puis on la remplit de nouveau
			{
				lbAdd [PARAJUMP_CLASSIC_LIST_IDC, name _x];
				lbSetData [PARAJUMP_CLASSIC_LIST_IDC, _forEachIndex, name _x];
			} forEach CRP_var_paraJumpClassic_skyDivers;

			sleep 0.5;
		};
	};

	// gestion du changement d'altitude du saut
	// en utilisant la molette de la souris
	_altitude ctrlAddEventHandler ["MouseZChanged", {
		_mouseWheel	= if ((_this select 1) > 0) then {1} else {-1};
		_definition	= parseNumber (ctrlText PARAJUMP_CLASSIC_ALTITUDE_IDC);
		_definition	= _definition + _mouseWheel * 100;

		CRP_var_paraJumpClassic_elevation = str _definition;
		ctrlSetText [PARAJUMP_CLASSIC_ALTITUDE_IDC, str _definition];
	}];

	// gérer l'ajout de lettres
	_altitude ctrlAddEventHandler ["KeyDown", {
		_elevation = ctrlText PARAJUMP_CLASSIC_ALTITUDE_IDC;
		_elevation = toArray _elevation;
		_filter = toArray "0123456789";
		_iterate = true;

		// on boucle sur la chaîne du champs convertie en tableau
		// tant que l'on a pas trouvé de caractère interdit
		for [{_i = 0; _c = count _elevation;}, {_i < _c && _iterate}, {_i = _i + 1}] do {
			// si le caractère ajouté n'est pas un chiffre
			if !((_elevation select _i) in _filter) then {
				// on affecte la dernière valeur d'altiture connue
				// et on arrête la boucle
				_elevation = CRP_var_paraJumpClassic_elevation;
				_iterate = false;
			};
		};

		// si la boucle est arrivée à son terme
		// on a toujours un tableau qu'il vaut repasser en chaîne
		if (_iterate) then {
			_elevation = toString _elevation;
		};

		// on sauvegarde la nouvelle valeur du champ
		// et on le remplis
		CRP_var_paraJumpClassic_altitude = _elevation;
		ctrlSetText [PARAJUMP_CLASSIC_ALTITUDE_IDC, _elevation];
	}];

	// gestion du positionnement du marqueur de saut
	_map ctrlAddEventHandler ["mouseButtonDblClick", {
		if (CRP_var_paraJumpClassic_marker != "") then {
			deleteMarkerLocal CRP_var_paraJumpClassic_marker;
		};

		CRP_var_paraJumpClassic_coordinates = (_this select 0) ctrlMapScreenToWorld [_this select 2, _this select 3];
		CRP_var_paraJumpClassic_marker = createMarkerLocal ["Marker1", CRP_var_paraJumpClassic_coordinates];
		CRP_var_paraJumpClassic_marker setMarkerShapeLocal "ICON";
		CRP_var_paraJumpClassic_marker setMarkerTypeLocal "respawn_para";
	}];

	// annulation du saut
	_close ctrlAddEventHandler ["MouseButtonDown", {
		closeDialog PARAJUMP_CLASSIC_DIALOG_IDD;
	}];

	// gestion du saut
	_jump ctrlAddEventHandler ["MouseButtonDown", {
		if ((count CRP_var_paraJumpClassic_coordinates) > 0) then {
			CRP_var_paraJumpClassic_coordinates set [2, parseNumber (ctrlText PARAJUMP_CLASSIC_ALTITUDE_IDC)];

			{
				[[2 * _forEachIndex, CRP_var_paraJumpClassic_coordinates], {sleep (_this select 0); player setPosASL (_this select 1);}] remoteExec ["BIS_fnc_spawn", _x];
			} forEach CRP_var_paraJumpClassic_skyDivers;

			closeDialog PARAJUMP_CLASSIC_DIALOG_IDD;
		};
	}];
};