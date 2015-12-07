#include "ctrl.hpp"

// déclaration des variables du module
CRP_var_spectatorCamera_camera		= objNull;
CRP_var_spectatorCamera_actions		= ["MoveForward", "MoveBack", "TurnLeft", "TurnRight", "LeanLeft", "Prone"];
CRP_var_spectatorCamera_cameraKeys	= [];
CRP_var_spectatorCamera_MainClick	= false;
CRP_var_spectatorCamera_mouseDelta	= [];
CRP_var_spectatorCamera_cameraData	= [0, 0];
CRP_var_spectatorCamera_loop 		= false;

[] spawn {
	waitUntil {!(isNull (findDisplay SPECTATOR_DIALOG_IDD))};

	disableSerialization;

	_dialog	= findDisplay SPECTATOR_DIALOG_IDD;
	_event	= _dialog displayCtrl SPECTATOR_EVENT_IDC;
	_tree	= _dialog displayCtrl SPECTATOR_TREE_IDC;

	// alimentation de l'arbre
	_tree tvAdd [[], "CORP"];

	{
		_tree tvAdd [[0], name _x];
		_tree tvSetData [[0, _forEachIndex], str (getPosASL _x)];
	} forEach allUnits;




	// définition de l'état par défaut des touches
	// de contrôle de la caméra
	{
		[CRP_var_spectatorCamera_cameraKeys, _x, false] call BIS_fnc_setToPairs;
	} forEach CRP_var_spectatorCamera_actions;

	// création de la caméra
	CRP_var_spectatorCamera_camera = "camera" camCreate ((getPos player) vectorAdd [0, 0, 5]);
	CRP_var_spectatorCamera_camera cameraEffect ["internal", "BACK"];
	CRP_var_spectatorCamera_camera camCommit 0;
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











Z_var_paths = [];
Z_var_interval = 2;
Z_var_segments = 75;



{
	_x setVariable ["CRP_var_index", _forEachIndex];
	Z_var_paths set [_forEachIndex, []];
} forEach allunits;



[] spawn {
	while {true} do {
		{
			_index = _x getVariable "CRP_var_index";

			_array = Z_var_paths select _index;
			_c = count _array;

			if (_c > Z_var_segments) then {
				_array deleteAt 0;
			};

			_e = ASLToAGL (eyepos _x);

			switch _c do {
				case 0: {
					_array pushBack _e;
				};

				default {
					if (((_array select (_c - 1)) vectorDistance _e) > Z_var_interval) then {
						_array pushBack _e;
					};
				};
			};
		} forEach allunits;

		sleep 0.5;
	};
};







["spetatorCameraUnitsTraces", "onEachFrame", {
	{
		_r = 0.008;
		_g = 0.29;
		_b = 0.612;

		if (side _x == east) then {
			_r = 0.501;
			_g = 0;
			_b = 0;
		};

		// icon
		if (isPlayer _x) then {
			drawIcon3D [
				getText (configfile >> "CfgVehicles" >> typeOf _x >> "icon"),
				[_r, _g, _b, 1],
				(ASLToAGL (getPosASLVisual _x)) vectorAdd [0, 0, 3],
				0.75,
				0.75,
				([_x, CRP_var_spectatorCamera_camera] call BIS_fnc_relativeDirTo) + 180,
				name _x
			];
		} else {
			drawIcon3D [
				getText (configfile >> "CfgVehicles" >> typeOf _x >> "icon"),
				[_r, _g, _b, 1],
				(ASLToAGL (getPosASLVisual _x)) vectorAdd [0, 0, 3],
				0.75,
				0.75,
				([_x, CRP_var_spectatorCamera_camera] call BIS_fnc_relativeDirTo) + 180
			];
		};

		//path
		_p = Z_var_paths select (_x getVariable "CRP_var_index");

		for [{_i = 0; _c = (count _p) - 1;}, {_i < _c}, {_i = _i + 1}] do {
			drawLine3D [_p select _i, _p select (_i + 1), [_r, _g, _b, (1 / _c) * _i]];
		};

		_c = count _p;

		if (_c > 0) then {
			drawLine3D [(_p select (_c - 1)), ASLToAGL (eyePos _x), [_r, _g, _b, 1]];
		};
	} forEach allunits;
}] call BIS_fnc_addStackedEventHandler;