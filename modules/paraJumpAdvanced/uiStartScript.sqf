#include "ctrl.hpp"

// déclaration des variables du module
// CRP_var_paraJumpAdvanced_flag, déclarée dans le code de l'action afin de récupérer l'objet drapeau et ainsi pouvoir récupérer les joueurs à proximité
CRP_var_paraJumpAdvanced_skyDivers			= [];
CRP_var_paraJumpAdvanced_markers			= [];
CRP_var_paraJumpAdvanced_selectedDrop		= "";

[] spawn {
	waitUntil {!isNull (findDisplay PARAJUMP_ADVANCED_DIALOG_IDD)};

	disableSerialization;

	_dialog		= findDisplay PARAJUMP_ADVANCED_DIALOG_IDD;
	_dropList	= _dialog displayCtrl PARAJUMP_ADVANCED_DROPLIST_IDC;
	_map 		= _dialog displayCtrl PARAJUMP_ADVANCED_MAP_IDC;
	_close 		= _dialog displayCtrl PARAJUMP_ADVANCED_CLOSE_IDC;
	_jump		= _dialog displayCtrl PARAJUMP_ADVANCED_JUMP_IDC;

	// alimentation et actualisation de la liste
	[] spawn {
		disableSerialization;

		_dialog	= findDisplay PARAJUMP_ADVANCED_DIALOG_IDD;
		_diverList	= _dialog displayCtrl PARAJUMP_ADVANCED_DIVERLIST_IDC;

		while {!isNull (findDisplay PARAJUMP_ADVANCED_DIALOG_IDD)} do {
			// récupération des unités à proximité
			CRP_var_paraJumpAdvanced_skyDivers = nearestObjects [CRP_var_paraJumpAdvanced_flag, ["Man"], 25];

			// suppression des IA
			{
				if (!isPlayer _x) then {
					CRP_var_paraJumpAdvanced_skyDivers set [_forEachIndex, objNull];
				};
			} forEach CRP_var_paraJumpAdvanced_skyDivers;

			CRP_var_paraJumpAdvanced_skyDivers = CRP_var_paraJumpAdvanced_skyDivers - [objNull];

			// on vide la liste
			lbClear _diverList;

			// puis on la remplit de nouveau
			{
				lbAdd [PARAJUMP_ADVANCED_DIVERLIST_IDC, name _x];
				lbSetData [PARAJUMP_ADVANCED_DIVERLIST_IDC, _forEachIndex, name _x];
			} forEach CRP_var_paraJumpAdvanced_skyDivers;

			sleep 0.5;
		};
	};

	// ajout sur carte des points de saut disponibles
	[] spawn {
		disableSerialization;

		_dialog		= findDisplay PARAJUMP_ADVANCED_DIALOG_IDD;
		_map		= _dialog displayCtrl PARAJUMP_ADVANCED_MAP_IDC;
		_dropList	= _dialog displayCtrl PARAJUMP_ADVANCED_DROPLIST_IDC;

		_drops = (missionConfigFile >> "ParaJumpAdvanced" >> "Drops") call BIS_fnc_getCfgSubClasses;

		{
			_drop = getArray (missionConfigFile >> "ParaJumpAdvanced" >> "Drops" >> _x >> "data");

			_marker = createMarkerLocal [format ["paraJumpAdvancedMarker_%1", _x], _drop select 1];
			_marker setMarkerDirLocal (_drop select 2);
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "mil_arrow2";
			_marker setMarkerSizeLocal [0.9, 0.9];
			CRP_var_paraJumpAdvanced_markers pushBack _marker;

			// on affecte le premier drop comme saut par défaut
			if (_forEachIndex == 0) then {
				CRP_var_paraJumpAdvanced_selectedDrop = _x;
				_map ctrlMapAnimAdd [1, 0.1, _drop select 1];
				ctrlMapAnimCommit _map;
			};

			lbAdd [PARAJUMP_ADVANCED_DROPLIST_IDC, _drop select 0];
			lbSetData [PARAJUMP_ADVANCED_DROPLIST_IDC, _forEachIndex, _x];
		} forEach _drops;

		_marker = createMarkerLocal ["paraJumpAdvancedMarker_selected", getMarkerPos (format ["paraJumpAdvancedMarker_%1", lbData [PARAJUMP_ADVANCED_DROPLIST_IDC, 0]])];
		_marker setMarkerDirLocal 0;
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_circle";
		_marker setMarkerColorLocal "ColorRed";
		_marker setMarkerSizeLocal [1.3, 1.3];
		CRP_var_paraJumpAdvanced_markers pushBack _marker;
	};

	// selection du saut depuis la liste de drops
	_dropList ctrlAddEventHandler ["LBSelChanged", {
		_dialog		= findDisplay PARAJUMP_ADVANCED_DIALOG_IDD;
		_map		= _dialog displayCtrl PARAJUMP_ADVANCED_MAP_IDC;

		// récupération de la donnée dans l'élément de la liste (nom de la classe : "West", "EnemyBase"...)
		_data = lbData [PARAJUMP_ADVANCED_DROPLIST_IDC, _this select 1];
		_dropPos = getMarkerPos (format ["paraJumpAdvancedMarker_%1", _data]);
		CRP_var_paraJumpAdvanced_selectedDrop = _data;

		// repositionnement du marker de séléction et animation de la carte
		"paraJumpAdvancedMarker_selected" setMarkerPosLocal _dropPos;
		_map ctrlMapAnimAdd [1, 0.1, _dropPos];
		ctrlMapAnimCommit _map;
	}];

	// annulation du saut
	_close ctrlAddEventHandler ["MouseButtonDown", {
		closeDialog PARAJUMP_ADVANCED_DIALOG_IDD;
	}];

	// gestion du saut
	_jump ctrlAddEventHandler ["MouseButtonDown", {
		[CRP_var_paraJumpAdvanced_selectedDrop, CRP_var_paraJumpAdvanced_skyDivers] spawn {

			_drop			=  getArray (missionConfigFile >> "ParaJumpAdvanced" >> "Drops" >> _this select 0 >> "data");
			_divers			= _this select 1;
			_coordinates	= _drop select 1;
			_bearing		= _drop select 2;

			[[_coordinates, _bearing], "modules\paraJumpAdvanced\scriptServer.sqf"] remoteExec ["execVM", 2];

			sleep 4;

			{
				[[4 * _forEachIndex, _coordinates, _bearing], "modules\paraJumpAdvanced\scriptClient.sqf"] remoteExec ["execVM", _x];
			} forEach _divers;
		};

		closeDialog PARAJUMP_ADVANCED_DIALOG_IDD;
	}];
};