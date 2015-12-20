#include "..\ctrl.hpp"

#define CAMERA_STEP 0.16
#define CAMERA_SLOW_MULTIPLIER 0.7
#define CAMERA_FAST_MULTIPLIER 12
#define CAMERA_ULTRA_MULTIPLIER 50

// ne pas écraser le comportement de la touche échappe
if ((_this select 1) == 1) exitWith {false};

// mise à jour de l'état des touches spéciales
CRP_var_spectatorCamera_specialKeys set [0, _this select 2];
CRP_var_spectatorCamera_specialKeys set [1, _this select 3];
CRP_var_spectatorCamera_specialKeys set [2, _this select 4];

// est-ce que la touche est une touche de mouvement de la caméra
_isCamKey = false;

{
	if ((_this select 1) in _x) exitWith {_isCamKey = true;};
} forEach CRP_var_spectatorCamera_actionsKeys;

if (_isCamKey) then {
	// mise à jour de l'état des touches de caméra
	{
		if ((_this select 1) in (actionKeys _x)) then {
			[CRP_var_spectatorCamera_cameraKeys, _x, true] call BIS_fnc_setToPairs;
		};
	} forEach CRP_var_spectatorCamera_actions;

	// boucle pour éviter les "lags" de touche sur les mouvements de caméra
	// si une boucle n'est pas déjà en cours
	if (!CRP_var_spectatorCamera_keysLoop) then {
		CRP_var_spectatorCamera_keysLoop = true;

		[] spawn {
			while {CRP_var_spectatorCamera_keysLoop} do {

				if (CRP_var_spectatorCamera_iterationLeft > 0) then {
					CRP_var_spectatorCamera_iterationLeft = 0;
					_newPos = [];
					_multiplier = 1;

					// calcul du multiplicateur de vitesse
					if (CRP_var_spectatorCamera_specialKeys select 0) then {_multiplier = CAMERA_FAST_MULTIPLIER};
					if (CRP_var_spectatorCamera_specialKeys select 1) then {_multiplier = CAMERA_SLOW_MULTIPLIER};
					if (CRP_var_spectatorCamera_specialKeys select 2) then {_multiplier = CAMERA_ULTRA_MULTIPLIER};

					// calcul du multiplicateur final
					_multiplier = CAMERA_STEP * _multiplier;

					{
						_action			= _x select 0;
						_translation	= _x select 1;

						if ([CRP_var_spectatorCamera_cameraKeys, _action] call BIS_fnc_getFromPairs) then {
							_dX = _translation select 0;
							_dY = _translation select 1;
							_dZ	 = _translation select 2;


							if ((count _newPos) == 0) then {
								_newPos = getPosASL CRP_var_spectatorCamera_camera;
							};

							_dir = (direction CRP_var_spectatorCamera_camera) + _dX * 90;
							_newPos = [
								(_newPos select 0) + ((sin _dir) * _multiplier * _dY),
								(_newPos select 1) + ((cos _dir) * _multiplier * _dY),
								(_newPos select 2) + _dZ * _multiplier
							];
						};
					} forEach [
						[CRP_var_spectatorCamera_actions select 0, [0, 1, 0]],
						[CRP_var_spectatorCamera_actions select 1, [0, -1, 0]],
						[CRP_var_spectatorCamera_actions select 2, [-1, 1, 0]],
						[CRP_var_spectatorCamera_actions select 3, [1, 1, 0]],
						[CRP_var_spectatorCamera_actions select 4, [0, 0, 1]],
						[CRP_var_spectatorCamera_actions select 5, [0, 0, -1]]
					];

					if (count _newPos != 0) then {
						_newPos set [2, (_newPos select 2) max (getTerrainHeightASL (_newPos))];
						CRP_var_spectatorCamera_camera setPosASL _newPos;
					};
				};
			};
		};
	};
};

// si c'est la touche H
// pour masque l'ATH
if (keyName (_this select 1) == """H""") then {
	[] spawn {
		disableSerialization;

		_display	= findDisplay SPECTATOR_DIALOG_IDD;
		_list		= _display displayCtrl SPECTATOR_LIST_IDC;

		// on bascule l'état de l'interface
		CRP_var_spectatorCamera_uiVisible = !CRP_var_spectatorCamera_uiVisible;

		// on fade la liste de joueur
		_fade = if (CRP_var_spectatorCamera_uiVisible) then {0} else {1};
		_list ctrlSetFade _fade;
		_list ctrlCommit 0.25;

		// on masque progressivement les chemins et icônes en modifiant un multiplicateur
		// utilisé dans le calcul de l'alpha des lines 3D et icônes
		if (CRP_var_spectatorCamera_uiVisible) then {
			while {(CRP_var_spectatorCamera_uiFadeValue < 1) && CRP_var_spectatorCamera_uiVisible} do {
				CRP_var_spectatorCamera_uiFadeValue = CRP_var_spectatorCamera_uiFadeValue + 0.1;

				sleep 0.025;
			};
		} else {
			while {(CRP_var_spectatorCamera_uiFadeValue > 0) && !CRP_var_spectatorCamera_uiVisible} do {
				CRP_var_spectatorCamera_uiFadeValue = CRP_var_spectatorCamera_uiFadeValue - 0.1;

				sleep 0.025;
			};
		};
	};
};