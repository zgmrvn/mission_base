// quitter le script si le module est désactivé
if ((getNumber (missionConfigFile >> "ActionsFlags" >> "enabled")) == 0) exitWith {};

CRP_var_actionsFlags_flags = [];

{
	_name	= _x select 0;
	_pos	= _x select 1;

	_flag = createVehicle ["FlagPole_F", _pos, [], 0, "CAN_COLLIDE"];

	[CRP_var_actionsFlags_flags, _name, _flag] call BIS_fnc_setToPairs;

	publicVariable "CRP_var_actionsFlags_flags";
} forEach (getArray (missionConfigFile >> "ActionsFlags" >> "flags"));

if (isDedicated) then {
	CRP_var_actionsFlags_flags = nil;
};