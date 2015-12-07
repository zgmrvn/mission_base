{
	if ((_this select 1) in (actionKeys _x)) then {
		[CRP_var_spectatorCamera_cameraKeys, _x, false] call BIS_fnc_setToPairs;
	};
} forEach CRP_var_spectatorCamera_actions;

if (({[CRP_var_spectatorCamera_cameraKeys, _x] call BIS_fnc_getFromPairs} count CRP_var_spectatorCamera_actions) == 0) then {
	CRP_var_spectatorCamera_loop = false;
};