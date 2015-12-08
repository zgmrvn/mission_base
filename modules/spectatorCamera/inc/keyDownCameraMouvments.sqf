#define CAMERA_STEP 0.15

// ne pas écraser le comportement de la touche échappe
if ((_this select 1) == 1) exitWith {false};

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
			_newPos = [];

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
						(_newPos select 0) + ((sin _dir) * CAMERA_STEP * _dY),
						(_newPos select 1) + ((cos _dir) * CAMERA_STEP * _dY),
						(_newPos select 2) + _dZ * CAMERA_STEP
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