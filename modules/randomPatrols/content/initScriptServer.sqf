// si le module est activé
if ((getNumber (missionConfigFile >> "RandomPatrols" >> "enabled")) == 1) then {
	// spawn parce que code bloquant
	[] spawn {
		if ((getNumber (missionConfigFile >> "RandomPatrols" >> "return")) == 1) then {
			CPR_var_randomPatrols_patrols = [];

			{
				_center		= getArray (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "center");
				_radius		= getNumber (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "radius");
				_side		= getText (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "side");
				_groups		= getArray (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "groups");

				{
					_handle = [_center, _radius, _side, _x, CPR_var_randomPatrols_patrols] spawn CRP_fnc_randomPatrols_patrols;
					waitUntil {scriptDone _handle};
				} forEach _groups;
			} forEach ((missionConfigFile >> "RandomPatrols" >> "Patrols") call BIS_fnc_getCfgSubClasses);
		} else {
			{
				_center		= getArray (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "center");
				_radius		= getNumber (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "radius");
				_side		= getText (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "side");
				_groups		= getArray (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "groups");

				{
					_handle = [_center, _radius, _side, _x] spawn CRP_fnc_randomPatrols_patrols;
					waitUntil {scriptDone _handle};
				} forEach _groups;
			} forEach ((missionConfigFile >> "RandomPatrols" >> "Patrols") call BIS_fnc_getCfgSubClasses);
		};
	};
};