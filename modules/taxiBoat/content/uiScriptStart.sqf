#include "ctrl.hpp"

// déclaration des variables du module
// CRP_var_taxiBoat_flag, déclarée dans le code de l'action afin de récupérer l'objet drapeau et ainsi pouvoir récupérer les joueurs à proximité
CRP_var_taxiBoat_players			= [];
CRP_var_taxiBoat_coastCoordinates	= [];
CRP_var_taxiBoat_boatCoordinates	= [];
CRP_var_taxiBoat_coastMarker		= "";
CRP_var_taxiBoat_boatMarker			= "";

[] spawn {
	waitUntil {!isNull (findDisplay TAXI_BOAT_DIALOG_IDD)};

	disableSerialization;

	_dialog		= findDisplay TAXI_BOAT_DIALOG_IDD;
	_boatList	= _dialog displayCtrl TAXI_BOAT_BOATLIST_IDC;
	_map 		= _dialog displayCtrl TAXI_BOAT_MAP_IDC;
	_close 		= _dialog displayCtrl TAXI_BOAT_CLOSE_IDC;
	_taxi		= _dialog displayCtrl TAXI_BOAT_TAXI_IDC;

	// alimentation et actualisation de la liste
	[] spawn {
		disableSerialization;

		_dialog	= findDisplay TAXI_BOAT_DIALOG_IDD;
		_list	= _dialog displayCtrl TAXI_BOAT_LIST_IDC;

		while {!isNull (findDisplay TAXI_BOAT_DIALOG_IDD)} do {
			// récupération des joueurs à proximité
			CRP_var_taxiBoat_players = [CRP_var_taxiBoat_flag, 25] call CRP_fnc_nearestPlayers;

			// on vide la liste
			lbClear _list;

			// puis on la remplit de nouveau
			{
				lbAdd [TAXI_BOAT_LIST_IDC, name _x];
				lbSetData [TAXI_BOAT_LIST_IDC, _forEachIndex, name _x];
			} forEach CRP_var_taxiBoat_players;

			sleep 0.5;
		};
	};

	// alimentation de la liste de bateaux disponibles
	{
		lbAdd [TAXI_BOAT_BOATLIST_IDC, getText (configFile >> "CfgVehicles" >> (_x select 0) >> "displayName")];
	} forEach (getArray (missionConfigFile >> "TaxiBoat" >> "boats"));

	_boatList lbSetCurSel 0;

	// gestion du positionnement du marqueur de la côte et du bâteau
	_map ctrlAddEventHandler ["mouseButtonDblClick", {
		// si un marker éxiste déjà, on le supprime
		if (CRP_var_taxiBoat_coastMarker != "") then {
			deleteMarkerLocal CRP_var_taxiBoat_coastMarker;
			deleteMarkerLocal CRP_var_taxiBoat_boatMarker;
		};

		_center = (_this select 0) ctrlMapScreenToWorld [_this select 2, _this select 3];
		_center set [2, 0];

		// on récupère les positions près du curseur du joueur
		// et on les classe par "au dessus de l'eau", "sous l'eau"
		_aboveWater = [];
		_underWater = [];

		for [{_i = 0; _s = 0; _d = 40;}, {_i < _d}, {_i = _i + 1; _s = _s + 10;}] do {
			_pos = [_center, _s,  (45 * _i) mod 360] call BIS_fnc_relPos;

			if (((ATLToASL _pos) select 2) > 0) then {
				_aboveWater pushBack _pos;
			} else {
				_underWater pushBack _pos;
			};
		};

		// si au moins une valeur dans chaque tableaux
		if ((count _aboveWater) > 0 && (count _underWater) > 0) then {
			// on calcule le barycente des valeur hors de l'eau
			_avg = [0, 0, 0];

			{
				_avg = _avg vectorAdd _x;
			} forEach _aboveWater;

			_aboveWater = _avg vectorMultiply (1 / count _aboveWater);
			_aboveWater set [2, 0];

			// de même pour celles sous l'eau
			_avg = [0, 0, 0];

			{
				_avg = _avg vectorAdd _x;
			} forEach _underWater;

			_underWater = _avg vectorMultiply (1 / count _underWater);
			_underWater set [2, 0];

			// on cherche la limite entre terre et mer en suivant l'axe formé par les deux moyennes
			_dir	= [_aboveWater, _underWater] call BIS_fnc_dirTo;
			_i		= 0;

			while {true} do {
				CRP_var_taxiBoat_coastCoordinates = [_aboveWater, _i, _dir] call BIS_fnc_relPos;

				if (((ATLToASL CRP_var_taxiBoat_coastCoordinates) select 2) < 0) exitWith {};

				_i = _i + 1;
			};

			// on ajout les markers
			CRP_var_taxiBoat_coastMarker = createMarkerLocal ["MarkerCoast", CRP_var_taxiBoat_coastCoordinates];
			CRP_var_taxiBoat_coastMarker setMarkerShapeLocal "ICON";
			CRP_var_taxiBoat_coastMarker setMarkerTypeLocal "hd_start";

			CRP_var_taxiBoat_boatCoordinates = [CRP_var_taxiBoat_coastCoordinates, 400, _dir] call BIS_fnc_relPos;
			CRP_var_taxiBoat_boatMarker = createMarkerLocal ["MarkerBoat", CRP_var_taxiBoat_boatCoordinates];
			CRP_var_taxiBoat_boatMarker setMarkerShapeLocal "ICON";
			CRP_var_taxiBoat_boatMarker setMarkerTypeLocal "hd_arrow";
			CRP_var_taxiBoat_boatMarker setMarkerDirLocal (_dir + 180);
		};
	}];

	// annulation
	_close ctrlAddEventHandler ["MouseButtonDown", {
		closeDialog TAXI_BOAT_DIALOG_IDD;
	}];

	// gestion du taxi
	_taxi ctrlAddEventHandler ["MouseButtonDown", {
		if (CRP_var_taxiBoat_coastMarker != "") then {
			// on demande au serveur de créer les bateaux et de faire embarquer les joueurs
			[[CRP_var_taxiBoat_boatCoordinates, CRP_var_taxiBoat_coastCoordinates, CRP_var_taxiBoat_players, lbCurSel TAXI_BOAT_BOATLIST_IDC], "modules\taxiBoat\content\scriptServer.sqf"] remoteExec ["execVM", X_remote_server];

			closeDialog TAXI_BOAT_DIALOG_IDD;
		};
	}];
};