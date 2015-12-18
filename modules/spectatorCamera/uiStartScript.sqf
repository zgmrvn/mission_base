#include "ctrl.hpp"

// déclaration des variables du module
CRP_var_spectatorCamera_camera		= objNull;
CRP_var_spectatorCamera_actions		= ["MoveForward", "MoveBack", "TurnLeft", "TurnRight", "LeanLeft", "MoveDown"];
CRP_var_spectatorCamera_cameraKeys	= [];
CRP_var_spectatorCamera_MainClick	= false;
CRP_var_spectatorCamera_mouseDelta	= [];
CRP_var_spectatorCamera_cameraData	= [0, 0];
CRP_var_spectatorCamera_keysLoop	= false;
CRP_var_spectatorCamera_specialKeys	= [false, false, false];

[] spawn {
	waitUntil {!isNull (findDisplay SPECTATOR_DIALOG_IDD)};

	disableSerialization;

	_dialog	= findDisplay SPECTATOR_DIALOG_IDD;
	_event	= _dialog displayCtrl SPECTATOR_EVENT_IDC;
	_tree	= _dialog displayCtrl SPECTATOR_TREE_IDC;

	// alimentation et actualisation de l'arbre
	[] spawn {
		disableSerialization;

		_dialog	= findDisplay SPECTATOR_DIALOG_IDD;
		_tree	= _dialog displayCtrl SPECTATOR_TREE_IDC;

		_tree tvAdd [[], "BLUFOR"];
		_tree tvAdd [[], "OPFOR"];
		_tree tvAdd [[], "INDE"];
		_tree tvAdd [[], "CIVIL"];

		while {!isNull (findDisplay SPECTATOR_DIALOG_IDD)} do {
			{
				for [{_i = ((_tree tvCount [_x]) - 1)}, {_i >= 0}, {_i = _i - 1}] do {
					_tree tvDelete [_x, _i];
				};
			} forEach [0, 1, 2, 3];

			{
				_units = _x;

				{
					_index = switch ((typeOf _x) select [0, 1]) do {
						case "B": {0};
						case "O": {1};
						case "I": {2};
						case "C": {3};
					};

					_tree tvAdd [[_index], name _x];
					_tree tvSetData [[_index, (_tree tvCount [_index]) - 1], str (getPosASL _x)];
				} forEach _units;
			} forEach [allUnits, allDead];

			sleep 10;
		};
	};

	// définition de l'état par défaut des touches
	// de contrôle de la caméra
	{
		[CRP_var_spectatorCamera_cameraKeys, _x, false] call BIS_fnc_setToPairs;
	} forEach CRP_var_spectatorCamera_actions;

	// création de la caméra
	CRP_var_spectatorCamera_camera = "camera" camCreate ((getPos player) vectorAdd [0, 0, 5]);
	CRP_var_spectatorCamera_camera cameraEffect ["internal", "BACK"];
	CRP_var_spectatorCamera_camera camCommit 0;
	CRP_var_spectatorCamera_camera setDir (getDir player);
	showCinemaBorder false;
	cameraEffectEnableHUD true;
	showHUD true;

	// gestion des pressions sur les touches clavier
	// pour le mouvement de la caméra
	_event ctrlAddEventHandler ["KeyDown", {
		#include "inc\keyDownCameraMouvments.sqf"

		true
	}];

	// gestion du relachement des touches de clavier
	// pour le mouvement de la caméra
	_event ctrlAddEventHandler ["KeyUp", {
		#include "inc\keyUpCameraMouvments.sqf"

		true
	}];

	// gestion des pressions sur les boutons de la souris
	_event ctrlAddEventHandler ["MouseButtonDown", {
		if ((_this select 1) == 1) then {
			CRP_var_spectatorCamera_MainClick = true;
		};

		true
	}];

	// gestion des relachements des boutons de la souris
	_event ctrlAddEventHandler ["MouseButtonUp", {
		if ((_this select 1) == 1) then {
			CRP_var_spectatorCamera_MainClick	= false;
			CRP_var_spectatorCamera_mouseDelta	= [];
		};

		true
	}];

	// gestion des mouvement de la souris
	_event ctrlAddEventHandler ["MouseMoving", {
		if (CRP_var_spectatorCamera_MainClick) then {
			#include "inc\mouseMovingCameraMouvments.sqf"
		};

		true
	}];

	// gestion du click sur un élément de l'arbre
	// téléportation de la caméra sur l'élément
	_tree ctrlAddEventHandler ["TreeLButtonDown", {
		_dialog	= findDisplay SPECTATOR_DIALOG_IDD;
		_tree	= _dialog displayCtrl SPECTATOR_TREE_IDC;

		_pos = call compile (_tree tvData (_this select 1));
		CRP_var_spectatorCamera_camera setPosASL (_pos vectorAdd [0, 0, 5]);

		true
	}];
};

#include "inc\listUnits.sqf"
#include "inc\drawPaths.sqf"