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

// événements de l'interface
// et gestion de l'alimentation de la liste des joueurs
[] spawn {
	waitUntil {!isNull (findDisplay SPECTATOR_DIALOG_IDD)};

	disableSerialization;

	_dialog	= findDisplay SPECTATOR_DIALOG_IDD;
	_event	= _dialog displayCtrl SPECTATOR_EVENT_IDC;
	_list	= _dialog displayCtrl SPECTATOR_LIST_IDC;

	// alimentation et actualisation de l'arbre
	[] spawn {
		disableSerialization;

		_dialog	= findDisplay SPECTATOR_DIALOG_IDD;
		_list	= _dialog displayCtrl SPECTATOR_LIST_IDC;

		while {!isNull (findDisplay SPECTATOR_DIALOG_IDD)} do {
			// on récupère l'élément séléctionné
			_index = lbCurSel _list;

			// on vide la liste
			for [{_i = lbSize SPECTATOR_LIST_IDC}, {_i >= 0}, {_i = _i - 1}] do {
				lbDelete [SPECTATOR_LIST_IDC, _i];
			};

			// puis on la remplit de nouveau
			{
				lbAdd [SPECTATOR_LIST_IDC, name _x];
				lbSetData [SPECTATOR_LIST_IDC, _forEachIndex, str (getPosASL _x)];
			} forEach allPlayers;

			// on reséléctionnne l'élément
			_list lbSetCurSel _index;

			sleep 1;
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

	// gestion du click sur un élément de la liste
	// téléportation de la caméra sur l'élément
	_list ctrlAddEventHandler ["MouseButtonDown", {
		_dialog	= findDisplay SPECTATOR_DIALOG_IDD;
		_event	= _dialog displayCtrl SPECTATOR_EVENT_IDC;
		_list	= _dialog displayCtrl SPECTATOR_LIST_IDC;

		_pos = call compile (_list lbData (_this select 1));
		_camPos = [_pos, 20, [_pos, CRP_var_spectatorCamera_camera] call BIS_fnc_dirTo] call BIS_fnc_relPos;
		CRP_var_spectatorCamera_camera setPosASL (_camPos vectorAdd [0, 0, 10]);
		CRP_var_spectatorCamera_camera setDir ([CRP_var_spectatorCamera_camera, _pos] call BIS_fnc_dirTo);
		_diff = _pos vectorDiff (getPosASL CRP_var_spectatorCamera_camera);
		_pitch = -(((sqrt (((_diff select 0) ^ 2) + ((_diff select 1) ^ 2))) atan2 (_diff select 2)) - 90);
		[CRP_var_spectatorCamera_camera, _pitch, 0] call bis_fnc_setpitchbank;

		//systemChat str _pitch;

		ctrlSetFocus _event;

		true
	}];
};

// gestion des unités devant être représentés
#include "inc\listUnits.sqf"

// gestion des chemins et icônes
// drawLine3D & drawIcon3D
#include "inc\drawPaths.sqf"