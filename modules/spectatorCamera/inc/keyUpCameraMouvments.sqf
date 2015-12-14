// mise à jour de l'état des touches spéciales
CRP_var_spectatorCamera_specialKeys set [0, _this select 2];
CRP_var_spectatorCamera_specialKeys set [1, _this select 3];
CRP_var_spectatorCamera_specialKeys set [2, _this select 4];

// mise à jour de l'état des touches de caméra
{
	if ((_this select 1) in (actionKeys _x)) then {
		[CRP_var_spectatorCamera_cameraKeys, _x, false] call BIS_fnc_setToPairs;
	};
} forEach CRP_var_spectatorCamera_actions;

if (({[CRP_var_spectatorCamera_cameraKeys, _x] call BIS_fnc_getFromPairs} count CRP_var_spectatorCamera_actions) == 0) then {
	CRP_var_spectatorCamera_loop = false;
};