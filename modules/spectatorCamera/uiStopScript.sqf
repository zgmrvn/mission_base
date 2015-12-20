#include "ctrl.hpp"

["spetatorCameraUnitsPaths", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
["spetatorCameraIterationLeft", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

CRP_var_spectatorCamera_camera cameraEffect ["terminate", "back"];
camDestroy CRP_var_spectatorCamera_camera;
showCinemaBorder false;
showHUD true;

waitUntil {isNull (findDisplay SPECTATOR_DIALOG_IDD)};

CRP_var_spectatorCamera_camera			= nil;
CRP_var_spectatorCamera_actions			= nil;
CRP_var_spectatorCamera_actionsKeys		= nil;
CRP_var_spectatorCamera_cameraKeys		= nil;
CRP_var_spectatorCamera_MainClick		= nil;
CRP_var_spectatorCamera_mouseDelta		= nil;
CRP_var_spectatorCamera_cameraData		= nil;
CRP_var_spectatorCamera_keysLoop		= nil;
CRP_var_spectatorCamera_iterationLeft	= nil;
CRP_var_spectatorCamera_specialKeys 	= nil;

CRP_var_spectatorCamera_unitsPaths		= nil;

{
	{
		_x setVariable ["Z_var_spectatorCamera_unitIndex", nil];
	} forEach _x;
} forEach [allDead, allUnits];

