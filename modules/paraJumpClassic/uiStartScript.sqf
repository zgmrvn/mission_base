#include "ctrl.hpp"

// déclaration des variables du module
// CRP_var_paraJumpClassic_flag, déclarée dans le code de l'action afin de récupérer l'objet drapeau et ainsi pouvoir récupérer les joueurs à proximité
CRP_var_paraJumpClassic_skyDivers	= [];
CRP_var_paraJumpClassic_coordinates = [];
CRP_var_paraJumpClassic_marker		= "";

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
			// récupération des unités à proximité
			CRP_var_paraJumpClassic_skyDivers = nearestObjects [CRP_var_paraJumpClassic_flag, ["Man"], 25];

			// suppression des IA
			{
				if (!isPlayer _x) then {
					CRP_var_paraJumpClassic_skyDivers set [_forEachIndex, objNull];
				};
			} forEach CRP_var_paraJumpClassic_skyDivers;

			CRP_var_paraJumpClassic_skyDivers = CRP_var_paraJumpClassic_skyDivers - [objNull];

			// on vide la liste
			for [{_i = lbSize PARAJUMP_CLASSIC_LIST_IDC}, {_i >= 0}, {_i = _i - 1}] do {
				lbDelete [PARAJUMP_CLASSIC_LIST_IDC, _i];
			};

			// puis on la remplit de nouveau
			{
				lbAdd [PARAJUMP_CLASSIC_LIST_IDC, name _x];
				lbSetData [PARAJUMP_CLASSIC_LIST_IDC, _forEachIndex, name _x];
			} forEach CRP_var_paraJumpClassic_skyDivers;

			sleep 0.5;
		};
	};

	_altitude ctrlAddEventHandler ["MouseZChanged", {
		_mouseWheel	= if ((_this select 1) > 0) then {1} else {-1};
		_definition	= parseNumber (ctrlText PARAJUMP_CLASSIC_ALTITUDE_IDC);
		_definition	= _definition + _mouseWheel * 100;

		ctrlSetText [PARAJUMP_CLASSIC_ALTITUDE_IDC, str _definition];
	}];

	_map ctrlAddEventHandler ["mouseButtonDblClick", {
		if (CRP_var_paraJumpClassic_marker != "") then {
			deleteMarkerLocal CRP_var_paraJumpClassic_marker;
		};

		CRP_var_paraJumpClassic_coordinates = (_this select 0) ctrlMapScreenToWorld [_this select 2, _this select 3];
		CRP_var_paraJumpClassic_marker = createMarkerLocal ["Marker1", CRP_var_paraJumpClassic_coordinates];
		CRP_var_paraJumpClassic_marker setMarkerShapeLocal "ICON";
		CRP_var_paraJumpClassic_marker setMarkerTypeLocal "respawn_para";
	}];

	_close ctrlAddEventHandler ["MouseButtonDown", {
		closeDialog PARAJUMP_CLASSIC_DIALOG_IDD;
	}];

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