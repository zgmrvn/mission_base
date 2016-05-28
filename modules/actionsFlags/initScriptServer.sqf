// si le module est activé
if ((getNumber (missionConfigFile >> "ActionsFlags" >> "enabled")) == 1) then {
	CRP_var_actionsFlags_flags = [];

	{
		_name	= _x select 0;
		_pos	= _x select 1;

		_flag = createVehicle ["FlagPole_F", _pos, [], 0, "CAN_COLLIDE"];
		_flag setFlagTexture "data\images\corpFlag.paa";

		[CRP_var_actionsFlags_flags, _name, _flag] call BIS_fnc_setToPairs;
	} forEach (getArray (missionConfigFile >> "ActionsFlags" >> "flags"));

	publicVariable "CRP_var_actionsFlags_flags";

	// le serveur dédié n'a pas besoin de connaître les drapeaux
	// donc on détruit la variable après l'avoir brodcasté
	// en éditeur en revanche on a besoin de la connaître
	if (isDedicated) then {
		CRP_var_actionsFlags_flags = nil;
	};
};