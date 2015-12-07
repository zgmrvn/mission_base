#define CAMERA_SENS 100

_x	= _this select 1;
_y	= _this select 2;
_xd	= _this select 1;
_yd	= _this select 2;

// ectraction des coordonnées de la souris lors de la précédente frame
if ((count CRP_var_spectatorCamera_mouseDelta) != 0) then {
	_xd = CRP_var_spectatorCamera_mouseDelta select 0;
	_yd = CRP_var_spectatorCamera_mouseDelta select 1;
};

// enregistrer la position actuelle de la souris
// pour le calcul du delta à la prochain frame
CRP_var_spectatorCamera_mouseDelta = [_x, _y];

// camera direction
_dir = CRP_var_spectatorCamera_cameraData select 0;
_dir = _dir + (_x - _xd) * CAMERA_SENS;
CRP_var_spectatorCamera_camera setDir _dir;
CRP_var_spectatorCamera_cameraData set [0, _dir];

// camera pitch
_pitch = CRP_var_spectatorCamera_cameraData select 1;
_pitch = _pitch - (_y - _yd) * CAMERA_SENS;
_pitch = _pitch max -90 min 90;
[CRP_var_spectatorCamera_camera, _pitch, 0] call bis_fnc_setpitchbank;
CRP_var_spectatorCamera_cameraData set [1, _pitch];