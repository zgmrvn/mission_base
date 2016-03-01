#include "ctrl.hpp"

// déclaration des variables du module
CRP_var_spectatorCamera_camera			= objNull;
CRP_var_spectatorCamera_actions			= ["MoveForward", "MoveBack", "TurnLeft", "TurnRight", "LeanLeft", "MoveDown"];
CRP_var_spectatorCamera_actionsKeys		= [actionKeys "MoveForward", actionKeys "MoveBack", actionKeys "TurnLeft", actionKeys "TurnRight", actionKeys "LeanLeft", actionKeys "MoveDown"];
CRP_var_spectatorCamera_cameraKeys		= [];
CRP_var_spectatorCamera_MainClick		= false;
CRP_var_spectatorCamera_mouseDelta		= [];
CRP_var_spectatorCamera_cameraData		= [0, 0];
CRP_var_spectatorCamera_keysLoop		= false;
CRP_var_spectatorCamera_iterationLeft	= 1;
CRP_var_spectatorCamera_specialKeys		= [false, false, false];
CRP_var_spectatorCamera_uiVisible		= true;
CRP_var_spectatorCamera_uiFadeValue		= 1;
CRP_var_spectatorCamera_map				= false;
CRP_var_spectatorCamera_cameraIcon		= gettext (configfile >> "RscDisplayCamera" >> "iconCamera");
CRP_var_spectatorCamera_unitIconDead	= getText (configfile >> "CfgMarkers" >> "KIA" >> "icon");
CRP_var_spectatorCamera_unitIconAlive	= getText (configfile >> "CfgVehicles" >> "B_Soldier_F" >> "icon");
CRP_var_spectatorCamera_cameraNVG		= false;

// contient le chemin de toutes les unités
CRP_var_spectatorCamera_unitsPaths	= [];

// événements de l'interface
// et gestion de l'alimentation de la liste des joueurs
[] spawn {
	waitUntil {!isNull (findDisplay SPECTATOR_DIALOG_IDD)};

	disableSerialization;

	_dialog	= findDisplay SPECTATOR_DIALOG_IDD;
	_event	= _dialog displayCtrl SPECTATOR_EVENT_IDC;
	_list	= _dialog displayCtrl SPECTATOR_LIST_IDC;

	// pour ne pas avoir la carte pendant un court instant à la création du display
	// on créé la carte dynamiquement
	_map = _dialog ctrlCreate ["RscMapControl", SPECTATOR_MAP_IDC];
	_map ctrlShow false;
	_map ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, safeZoneH];
	_map ctrlCommit 0;
	_map ctrlSetTooltip "Double-cliquez pour déplacer la caméra";

	// alimentation et actualisation de l'arbre
	[] spawn {
		disableSerialization;

		_dialog	= findDisplay SPECTATOR_DIALOG_IDD;
		_list	= _dialog displayCtrl SPECTATOR_LIST_IDC;

		while {!isNull (findDisplay SPECTATOR_DIALOG_IDD)} do {
			// on récupère l'élément séléctionné
			_index = lbCurSel _list;

			// on vide la liste
			lbClear _list;

			// puis on la remplit de nouveau
			{
				_list lbAdd (name _x);
				_list lbSetData [_forEachIndex, str (getPosASL _x)];
			} forEach allPlayers;

			// on reséléctionnne l'élément
			_list lbSetCurSel _index;

			sleep 5;
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
	CRP_var_spectatorCamera_cameraData set [0, getDir player];
	showCinemaBorder false;
	cameraEffectEnableHUD true;
	showHUD true;

	// gestion des pressions sur les touches clavier
	// pour le ctrl d'événements en focus
	_event ctrlAddEventHandler ["KeyDown", {
		#include "inc\keyDownCameraMouvments.sqf"
		#include "inc\keyDownInterface.sqf"

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
	_list ctrlAddEventHandler ["LBDblClick", {
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

		// redéfinition du focus pour conserver le contrôle de la caméra
		ctrlSetFocus _event;

		true
	}];

	// gestion des pression sur la map
	// fermeture de la carte
	_map ctrlAddEventHandler ["KeyDown", {
		// ne pas écraser le comportement de la touche échappe
		if ((_this select 1) == 1) exitWith {false};

		// si c'est la touche pour ouvrir la carte
		// on masque la carte
		if ((_this select 1) in (actionKeys "ShowMap")) then {
			CRP_var_spectatorCamera_map = !CRP_var_spectatorCamera_map;

			_dialog	= findDisplay SPECTATOR_DIALOG_IDD;
			_event	= _dialog displayCtrl SPECTATOR_EVENT_IDC;

			(_this select 0) ctrlShow CRP_var_spectatorCamera_map;
			ctrlSetFocus _event;
		};

		true
	}];

	// gestion du double click sur la map
	_map ctrlAddEventHandler ["MouseButtonDblClick", {
		_newPos = (_this select 0) ctrlMapScreenToWorld [_this select 2, _this select 3];
		_currentPos	= getPosATL CRP_var_spectatorCamera_camera;
		_newPos set [2, _currentPos select 2];

		CRP_var_spectatorCamera_camera setPosATL _newPos;

		true
	}];

	// icône de la caméra sur carte
	_map ctrlAddEventHandler ["Draw", {
		(_this select 0) drawIcon [
			CRP_var_spectatorCamera_cameraIcon,
			[0, 1, 1, 1],
			getPosASL CRP_var_spectatorCamera_camera,
			32,32,
			getDir CRP_var_spectatorCamera_camera,
			"",
			1
		];

		true
	}];
};

// gestion de la boucle de mouvement de la caméra
// limiter à une seule itération par frame
["spetatorCameraIterationLeft", "onEachFrame", {
	CRP_var_spectatorCamera_iterationLeft = 1;
}] call BIS_fnc_addStackedEventHandler;

// gestion des unités devant être représentés
[] spawn {
	// boucle infinie, vérification des unité à interval régulier
	while {!isNull (findDisplay SPECTATOR_DIALOG_IDD)} do {
		// on efface progressivement le chemin des morts
		{
			if (count ((CRP_var_spectatorCamera_unitsPaths select (_x getVariable "Z_var_spectatorCamera_unitIndex")) select 1) > 0) then {
				((CRP_var_spectatorCamera_unitsPaths select (_x getVariable "Z_var_spectatorCamera_unitIndex")) select 1) deleteAt 0;
			};
		} forEach allDead;

		// on boucle sur toutes les unité vivantes
		{
			// si l'unité n'est pas dans le tableau
			if (isNil {(_x getVariable ["Z_var_spectatorCamera_unitIndex", nil])}) then {
				// on l'ajoute
				_index = CRP_var_spectatorCamera_unitsPaths pushBack [_x, [ASLToAGL (eyePos _x)]];
				_x setVariable ["Z_var_spectatorCamera_unitIndex", _index];
			} else {
				// sinon, on ajoute une nouvelle position au tableau du chemin de l'unité
				((CRP_var_spectatorCamera_unitsPaths select (_x getVariable "Z_var_spectatorCamera_unitIndex")) select 1) pushBack (ASLToAGL (eyePos _x));

				// supression des anciennes positions
				if (count ((CRP_var_spectatorCamera_unitsPaths select (_x getVariable "Z_var_spectatorCamera_unitIndex")) select 1) > 20) then {
					((CRP_var_spectatorCamera_unitsPaths select (_x getVariable "Z_var_spectatorCamera_unitIndex")) select 1) deleteAt 0;
				};
			};
		} forEach allUnits;

		sleep 3;
	};
};

// gestion des chemins et icônes
// drawLine3D & drawIcon3D
["spetatorCameraUnitsPaths", "onEachFrame", {
	if (CRP_var_spectatorCamera_uiFadeValue != 0) then {
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
				CRP_var_spectatorCamera_unitIconDead,
				[_r, _g, _b, 0.5 * CRP_var_spectatorCamera_uiFadeValue],
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
				CRP_var_spectatorCamera_unitIconAlive,
				[_r, _g, _b, 1 * CRP_var_spectatorCamera_uiFadeValue],
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
				drawLine3D [_path select _i, _path select (_i + 1), [_r, _g, _b, (1 / _c) * _i * CRP_var_spectatorCamera_uiFadeValue]];
			};

			_c = count _path;

			if (_c > 0) then {
				drawLine3D [(_path select (_c - 1)), ASLToAGL (eyePos _unit), [_r, _g, _b, 1 * CRP_var_spectatorCamera_uiFadeValue]];
			};
		} forEach CRP_var_spectatorCamera_unitsPaths;
	};
}] call BIS_fnc_addStackedEventHandler;