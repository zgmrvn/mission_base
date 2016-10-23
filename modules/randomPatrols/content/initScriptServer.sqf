/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// si le module est activé
if ((getNumber (missionConfigFile >> "RandomPatrols" >> "enabled")) == 1) then {
	// spawn parce que code bloquant
	[] spawn {
		_return	= (getNumber (missionConfigFile >> "RandomPatrols" >> "return")) == 1;
		_pause	= getNumber (missionConfigFile >> "RandomPatrols" >> "pause");

		if (_return) then {
			CPR_var_randomPatrols_patrols	= [];
			CPR_var_randomPatrols_ready		= false;
		};

		{
			_center		= getArray (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "center");
			_radius		= getNumber (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "radius");
			_side		= getText (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "side");
			_groups		= getArray (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "groups");

			// on détermine le side
			_side = toUpper _side;
			_side = switch (_side) do {
				case "EAST": {east};
				case "INDEP": {independent};
				default {west};
			};

			{
				// pause entre chaque groupe
				sleep _pause;

				_group = _x;

				// concaténation des différentes parties qui composent le chemin de la config
				_path = configFile >> "CfgGroups";
				{
					_path = _path >> _x;
				} forEach _group;

				// création de la patrouille
				if (_return) then {
					_patrol = [_center, _radius, _side, _path] call CRP_fnc_randomPatrols_patrols;
					CPR_var_randomPatrols_patrols pushBack _patrol;
				} else {
					[_center, _radius, _side, _path] call CRP_fnc_randomPatrols_patrols;
				};
			} forEach _groups;
		} forEach ((missionConfigFile >> "RandomPatrols" >> "Patrols") call BIS_fnc_getCfgSubClasses);

		// fin
		if (_return) then {
			CPR_var_randomPatrols_ready = true;
		};
	};
};
