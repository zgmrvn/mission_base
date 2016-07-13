#include "ctrl.hpp"

// déclaration des variables du module
// CRP_var_boatProjection_flag, déclarée dans le code de l'action afin de récupérer l'objet drapeau et ainsi pouvoir récupérer les joueurs à proximité
CRP_var_boatProjection_players		= [];
CRP_var_boatProjection_coordinates = [];
CRP_var_boatProjection_marker		= "";

[] spawn {
	waitUntil {!isNull (findDisplay BOAT_PROJECTION_DIALOG_IDD)};

	disableSerialization;

	_dialog		= findDisplay BOAT_PROJECTION_DIALOG_IDD;
	_map 		= _dialog displayCtrl BOAT_PROJECTION_MAP_IDC;
	_close 		= _dialog displayCtrl BOAT_PROJECTION_CLOSE_IDC;
	_projection	= _dialog displayCtrl BOAT_PROJECTION_PROJECTION_IDC;

	// alimentation et actualisation de la liste
	[] spawn {
		disableSerialization;

		_dialog	= findDisplay BOAT_PROJECTION_DIALOG_IDD;
		_list	= _dialog displayCtrl BOAT_PROJECTION_LIST_IDC;

		while {!isNull (findDisplay BOAT_PROJECTION_DIALOG_IDD)} do {
			// récupération des unités à proximité
			CRP_var_boatProjection_players = nearestObjects [CRP_var_boatProjection_flag, ["Man"], 25];

			// suppression des IA
			{
				if (!isPlayer _x) then {
					CRP_var_boatProjection_players set [_forEachIndex, objNull];
				};
			} forEach CRP_var_boatProjection_players;

			CRP_var_boatProjection_players = CRP_var_boatProjection_players - [objNull];

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
				_farEnoughtCost = false
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
			[[CRP_var_boatProjection_coordinates, CRP_var_boatProjection_players], {
				_coordinates	= _this select 0;
				_players		= _this select 1;
				_center			= getArray (missionConfigFile >> "BoatProjection" >> "center");
				_dir			= [_coordinates, _center] call BIS_fnc_dirTo;

				_boat = objNull;

				for [{_i = 0; _c = count _players;}, {_i < _c}, {_i = _i + 1}] do {
					_mod = _i mod 5;

					if (_mod == 0) then {
						_boat = createVehicle ["B_G_Boat_Transport_01_F", [_coordinates, (_i / 5) * 10, _dir + 135] call BIS_fnc_relPos, [], 0, "CAN_COLLIDE"];
						_boat setDir _dir;
					};

					switch (_mod) do {

						case 0: {
							[_boat, {
								cutText ["", "BLACK OUT", 2];
								2 fadeSound 0;
								sleep 2;
								player moveInDriver _this;
								sleep 0.5;
								cutText ["", "BLACK IN", 2];
								2 fadeSound 1;
							}] remoteExec ["BIS_fnc_spawn", _players select _i];
						};

						default {
							[[_boat, _mod], {
								cutText ["", "BLACK OUT", 2];
								2 fadeSound 0;
								sleep 2;
								player moveInCargo [_this select 0, _this select 1];
								sleep 0.5;
								cutText ["", "BLACK IN", 2];
								2 fadeSound 1;
							}] remoteExec ["BIS_fnc_spawn", _players select _i];
						};
					};
				};
			}] remoteExec ["BIS_fnc_spawn", X_remote_server];

			closeDialog BOAT_PROJECTION_DIALOG_IDD;
		};
	}];
};