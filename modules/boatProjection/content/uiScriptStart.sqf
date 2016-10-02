#include "ctrl.hpp"

// déclaration des variables du module
// CRP_var_boatProjection_flag, déclarée dans le code de l'action afin de récupérer l'objet drapeau et ainsi pouvoir récupérer les joueurs à proximité
CRP_var_boatProjection_players		= [];
CRP_var_boatProjection_coordinates	= [];
CRP_var_boatProjection_marker		= "";

[] spawn {
	waitUntil {!isNull (findDisplay BOAT_PROJECTION_DIALOG_IDD)};

	disableSerialization;

	_dialog		= findDisplay BOAT_PROJECTION_DIALOG_IDD;
	_boatList	= _dialog displayCtrl BOAT_PROJECTION_BOATLIST_IDC;
	_map 		= _dialog displayCtrl BOAT_PROJECTION_MAP_IDC;
	_close 		= _dialog displayCtrl BOAT_PROJECTION_CLOSE_IDC;
	_projection	= _dialog displayCtrl BOAT_PROJECTION_PROJECTION_IDC;

	// alimentation et actualisation de la liste
	[] spawn {
		disableSerialization;

		_dialog	= findDisplay BOAT_PROJECTION_DIALOG_IDD;
		_list	= _dialog displayCtrl BOAT_PROJECTION_LIST_IDC;

		while {!isNull (findDisplay BOAT_PROJECTION_DIALOG_IDD)} do {
			// récupération des joueurs à proximité
			CRP_var_boatProjection_players = [CRP_var_boatProjection_flag, 25] call CRP_fnc_nearestPlayers;

			// on vide la liste
			lbClear _list;

			// puis on la remplit de nouveau
			{
				lbAdd [BOAT_PROJECTION_LIST_IDC, name _x];
				lbSetData [BOAT_PROJECTION_LIST_IDC, _forEachIndex, name _x];
			} forEach CRP_var_boatProjection_players;

			sleep 0.5;
		};
	};

	// alimentation de la liste de bateaux disponibles
	{
		lbAdd [BOAT_PROJECTION_BOATLIST_IDC, getText (configFile >> "CfgVehicles" >> (_x select 0) >> "displayName")];
	} forEach (getArray (missionConfigFile >> "BoatProjection" >> "boats"));

	_boatList lbSetCurSel 0;

	// gestion du positionnement du marqueur de saut
	_map ctrlAddEventHandler ["mouseButtonDblClick", {
		// si un marker éxiste déjà, on le supprime
		if (CRP_var_boatProjection_marker != "") then {
			deleteMarkerLocal CRP_var_boatProjection_marker;
		};

		_center = (_this select 0) ctrlMapScreenToWorld [_this select 2, _this select 3];
		_center set [2, 0];

		_farEnoughtCost = true;

		// on vérifie que la côte la plus proche est suffisament loins
		for [{_i = 0; _d = 200;}, {_i < _d}, {_i = _i + 1}] do {
			_pos = [_center, _i,  (45 * _i) mod 360] call BIS_fnc_relPos;

			if (((ATLToASL _pos) select 2) > 0) exitWith {
				_farEnoughtCost = false;
			};
		};

		// si la côte est assez loins, on créé le marker
		if (_farEnoughtCost) then {
			CRP_var_boatProjection_coordinates = _center;
			CRP_var_boatProjection_marker = createMarkerLocal ["Marker1", CRP_var_boatProjection_coordinates];
			CRP_var_boatProjection_marker setMarkerShapeLocal "ICON";
			CRP_var_boatProjection_marker setMarkerTypeLocal "respawn_para";
		};
	}];

	// annulation du saut
	_close ctrlAddEventHandler ["MouseButtonDown", {
		closeDialog BOAT_PROJECTION_DIALOG_IDD;
	}];

	// gestion de la projection
	_projection ctrlAddEventHandler ["MouseButtonDown", {
		if (CRP_var_boatProjection_marker != "") then {
			// on demande au serveur de créer les bateaux et de faire embarquer les joueurs
			[[CRP_var_boatProjection_coordinates, CRP_var_boatProjection_players, lbCurSel BOAT_PROJECTION_BOATLIST_IDC], "modules\boatProjection\content\scriptServer.sqf"] remoteExec ["execVM", X_remote_server];

			closeDialog BOAT_PROJECTION_DIALOG_IDD;
		};
	}];
};