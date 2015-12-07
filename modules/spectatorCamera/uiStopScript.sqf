["spetatorCameraUnitsTraces", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

CRP_var_spectatorCamera_camera cameraEffect ["terminate", "back"];
camDestroy CRP_var_spectatorCamera_camera;
showCinemaBorder false;
showHUD true;

CRP_var_spectatorCamera_camera		= nil;
CRP_var_spectatorCamera_actions		= nil;
CRP_var_spectatorCamera_cameraKeys	= nil;
CRP_var_spectatorCamera_MainClick	= nil;
CRP_var_spectatorCamera_mouseDelta	= nil;
CRP_var_spectatorCamera_cameraData	= nil;
CRP_var_spectatorCamera_loop 		= nil;